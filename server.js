const express = require('express');
const path = require('path');
const hbs = require('express-handlebars');
const bodyParser = require('body-parser');
const mySql = require('mysql');
const frameguard = require('frameguard');

const app = express();

const defaultDroneAlbum = 'la_winter_2019/2020';
const defaultMusicAlbum = 'ukulele'

app.use(bodyParser.urlencoded({
    extended: false // in future, should set to true if I want to parse nested POSTs
}));

app.use(frameguard({ action: 'SAMEORIGIN' })) // Prevents the "Blocked by X-Frame-Options Policy" error

const dbConn = mySql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'password',
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


// get route for home page
app.get('/', function(req, res) {
    res.render('homeView', {title: 'JD del Alamo'});
});


// get route for media
app.get('/media', function(req, res) {
    var album = req.query.album;
    if (album === undefined) {
        album = defaultDroneAlbum;
    }
    getAlbumLinks("drone_album_view", album, function(err, videoLinks) { //Because of scope, must pass a callback function into getAlbum to get result value
        if (err) {
            console.log('error occurred');  
        } else {
            res.render('mediaView', {
                title: 'Media',
                videos: videoLinks
            });
        }
    });
});

// post route for getting drone video album
app.post('/get-drone-album', function(req, res) {
    videoAlbum = req.body.album_selector;

    res.redirect('/media?album=' + videoAlbum);
});


// get route for music
app.get('/music', function(req, res) {
    var album = req.query.album;
    if (album === undefined) {
        album = defaultMusicAlbum;
    }
    getAlbumLinks("music_album_view", album, function(err, videoLinks) { //Because of scope, must pass a callback function into getAlbum to get result value
        if (err) {
            console.log('error occurred');
        } else {
            res.render('musicView', {
                title: 'Music',
                videos: videoLinks
            });
        }
    });
});

// post route for getting music video album
app.post('/get-music-album', function(req, res) {
    videoAlbum = req.body.album_selector;
    
    res.redirect('/music?album=' + videoAlbum);
});


// get route for projects
app.get('/projects', function(req, res) {
    res.render('projectsView', {title: 'Projects'});
});


// get route for contact
app.get('/contact', function(req, res) {
    res.render('contactView', {title: 'Contact'});
});


app.listen(3000, function() {
    console.log("listening on port 3000");
});


function getAlbumLinks(view, videoAlbum, callback) { //Because of scope, must pass a callback function into getAlbum to get result value
    var selectStmt = "SELECT link, favorite FROM " + view + " WHERE album_name = ?";
    dbConn.query(selectStmt,
        [
            videoAlbum
        ],
        function (err, result, fields) {
        if (err) 
            callback(err, null);
        else
            callback(null, result);
    });
}