const e = require('express');
const express = require('express');
const { is } = require('express/lib/request');
const router = express.Router();
const crypto = require('crypto');
const jwt = require('jsonwebtoken');

const mysql = require('mysql');
const dbconfig = require('../../config/database.js');
// const req = require('express/lib/request');
const connection = mysql.createConnection(dbconfig);

connection.connect();

// 유저 정보 받아오기
router.get('/', (req, res, next) => {
    connection.query('select * from users', (error, rows, fields) => {
        if (error) throw error;
        
        res.status(200).json(rows);
    });    
});

// 특정 유저 정보 받아오기
router.get('/:email', (req, res, next) => {
    const email = req.params.email
    connection.query(`select * from users where email = '${email}'`, (error, row, fields) => {
        if (error) throw error;
        
        res.status(200).json(row);
    });    
});

// 이메일 중복 여부 판단
router.get('/check/:email',(req, res, next) => {
    const email = req.params.email;
    console.log(`email is ${email}`);
    connection.query(`select count(*) as count from users where email = '${email}'`, (error, result, fields) => {
        if (error) {  
            console.log(error);
            next(error);
        }
        var existence = result[0].count == 1 ? true : false;
        console.log(existence)
        if (existence == false) {
            res.status(200).json({
                "existence": existence
            });
        } else {
            res.status(400).json({
                "existence": existence
            });
        }
    });
});

// 회원가입
router.post('/signup', (req, res, next) => {
    let password = req.body.password;

    const hash = crypto.create
    let salt = Math.round((new Date().valueOf() * Math.random())) + "";
    let hashPassword = crypto.createHash("sha512").update(password + salt).digest("hex");

    const user = {
        email: req.body.email,
        password: hashPassword,
        name: req.body.name,
        nickname: req.body.nickname,
        salt: salt
    };
    
    var query = connection.query('insert into users set ?', user, (error, result, fields) => {
        if (error) throw error;
    });

    res.status(201).json({
        message: 'user created',
        createdUser: user
    });
});

//로그인 POST
router.post('/signin', (req, res, next) => {
    let email = req.body.email;
    let inputPassword = req.body.password;
    connection.query(`select * from users where email = '${email}'`, (error, result, fields) => {
        if (error) throw error;

        if (result.length < 1) {
            res.status(401).json({
                message: "Auth failed"
            });
        } else {
            let dbPassword = result[0].password;
            let salt = result[0].salt;
            let hashPassword = crypto.createHash("sha512").update(inputPassword + salt).digest("hex");

            if (dbPassword === hashPassword) {
                let token = jwt.sign({
                    email: result[0].email
                },
                process.env.JWT_KEY,
                {
                    expiresIn: '12h'
                })
                res.status(200).json({
                    privateInfo: {
                        email: result[0].email,
                        name: result[0].name,
                        nickname: result[0].nickname
                    },
                    access_token: token,
                    expiresIn: '12h'
                });
            } else {
                res.status(404).json({
                state: "비밀번호를 다시 입력해주세요."
                });
            };
        }
    });
});

module.exports = router;