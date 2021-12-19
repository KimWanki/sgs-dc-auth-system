const express = require('express')
const app = express()
const port = 8080

app.listen(port, () => {
    console.log(`App listening at http://localhost:${port}`)
});

const mysql = require('mysql');
const dbconfig = require('./api/config/database.js');

const connection = mysql.createConnection(dbconfig);

connection.connect();

connection.query('select * from users', (error, rows, fields) => {
    if (error) throw error;
    console.log('User info is: ', rows);
})

connection.end()


app.get('/register', (req, res) => {
    res.json();
});

app.post('/login', (req, res) => {
    res.json();
    console.log(req);
});
