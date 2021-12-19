// handling requests a bit easier for us
const express = require('express');
const app = express();
const morgan = require('morgan');
const bodyParser = require('body-parser');
const mysql = require('mysql')

const userRoutes = require('./api/routes/users');
const orderRoutes = require('./api/routes/test_api');

const dbconfig = require('./config/database.js');

const connection = mysql.createConnection(dbconfig);

// logging
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({ extended: false}));
app.use(bodyParser.json());

app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header(
        'Access-Control-Allow-Headers',
        'Origin, X-Requestec-With, Content-Type, Accpet, Authrizaiton'
    );
    if (req.method === 'OPTIONS') {
        res.header('Access-Control-Allow-Methods', 'PUT, POST, PATCH, DELETE, GET');
        return res.status(200).json({});
    }
    next();
});
// Routes which should handle requests
app.use('/users', userRoutes);
app.use('/test_api', orderRoutes);

app.use((req,res,next) => {
    const error = new Error('Not founds');
    error.status = 404;
    next(error);
});

app.use((error, req, res, next) => {
    res.status(error.status || 500);
    res.json({
        error: {
            message: error.message
        }
    });
});

// app.js
module.exports = app;