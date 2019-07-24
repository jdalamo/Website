const express = require('express');
const path = require('path');
const hbs = require('express-handlebars');
const bodyParser = require('body-parser');
const mySql = require('mysql');

const app = express();

const defaultAlbum = 'spain_summer_2019';

app.use(bodyParser.urlencoded({
    extended: false // in future, should set to true if I want to parse nested POSTs
}));

const dbConn = mySql.createConnection({
    host: 'localhost',
    user: 'root',
    password: process.env.DB_PASSWORD,
    database: 'website_db'
});
dbConn.connect((err) => {
    if (err) throw err;
    console.log('connected to mysql db');
});

// load view engine
app.engine('hbs', hbs({extname: 'hbs', defaultLayout: 'layout', layoutsDir: path.join(__dirname, '/views/layouts')}));
app.set('views', path.join(__dirname, 'views/pages'));
app.set('view engine', 'hbs');

// set static folder
app.use(express.static(path.join(__dirname, 'static')));

// route for home page
app.get('/', function(req, res) {
    res.render('homeView', {title: 'JD del Alamo'});
});

// route for media
app.get('/media', function(req, res) {
    var album = req.query.album;
    if (album === undefined) {
        album = defaultAlbum;
    } else {
        album = req.query.album;
    }
    getAlbumLinks(album, function(err, videoLinks) { //Because of scope, must pass a callback function into getAlbum to get result value
        if (err) {
            console.log('error occurred');  
        } else {
            console.log(videoLinks);
            res.render('mediaView', {
                title: 'Media',
                videos: videoLinks
            });
        }
    });
});

// post route for getting video album
app.post('/get-album', function(req, res) {
    console.log('got a post request');
    videoAlbum = req.body.album_selector;

    // tracking how many views each album has
    var updateStmt = "UPDATE Albums SET views = views + 1 WHERE album_name = " + "'" + videoAlbum + "'";
    dbConn.query(updateStmt, function (err, result, fields) {
        if (err) {
            console.log('error updating view count');
        }
    });
    res.redirect('/media?album=' + videoAlbum);
});

// route for projects
app.get('/projects', function(req, res) {
    res.render('projectsView', {title: 'Projects'});
});

// route for blog
app.get('/blog', function(req, res) {
    res.render('blogView', {title: 'Blog'});
});

// route for contact
app.get('/contact', function(req, res) {
    res.render('contactView', {title: 'Contact'});
});

app.listen(3000, function() {
    console.log("listening on port 3000");
});

function getAlbumLinks(videoAlbum, callback) { //Because of scope, must pass a callback function into getAlbum to get result value
    var selectStmt = "SELECT link, favorite FROM album_view WHERE album_name = " + "'" + videoAlbum + "'";
    dbConn.query(selectStmt, function (err, result, fields) {
        if (err) 
            callback(err, null);
        else
            callback(null, result);
    });
}