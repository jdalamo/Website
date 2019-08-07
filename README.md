## My personal website
---
This is the code for my website, which can be found [here](https://jdalamo.com).

## Get it running
---
1. Clone the directory onto your machine
2. Install Node.js, npm, and MySQL
3. In a terminal window, navigate to that directory and run the following commands:
```
> npm install
> mysql -u root -p
mysql> CREATE DATABASE website_db;
mysql> USE website_db
mysql> SOURCE {path_to_website_db_ddl.sql on your machine}
mysql> quit
> node server.js
```
Note: you will have to modify the server.js file to use your password you set for MySQL.

## Backend
---
I used Node.js for my backend as it's both an industry standard and a great way to learn JavaScript (one of my goals for this project).  On top of Node.js I used Express as my web framework.

## HTML
---
I used Handlebars for my HTML templating because I wanted the features of a templating engine while being able to write native HTML.  All the page HTML files are located in the /views/pages/ directory and they extend the base layout (layout.hbs), which can be found in the /views/layouts/ directory.

## CSS
---
All CSS can be found in the /static/css/ directory.  CSS Grid is used extensively in this project to create page layouts.
