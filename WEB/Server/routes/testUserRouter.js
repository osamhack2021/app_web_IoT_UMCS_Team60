const router = require('express').Router();
const userAuth = require(`../controllers/userAuth`);
const { pw2enc } = require(`../middleware/auth`);
const request = require('request-promise-native')

const baseUrl = 'user';

var dbModule = require(`../database`)();
var dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

router.get('/', (req, res) => {
    var token = req.cookies["token"];
    var userInfo = req.cookies["userInfo"];
    var message = req.flash('message');
    res.clearCookie("token");
    res.clearCookie("userInfo");
    res.render(`${baseUrl}/index`, {token, message, userInfo});
});

router.post('/login', userAuth.login, (req, res) => {
    res.cookie('token', req.token);
    res.redirect(`.`); 
});

router.get('/register', (req, res) => {
    res.render(`${baseUrl}/register`);
});

router.post('/register', (req, res) => {
    var id = req.body.username;
    var pw = req.body.password;
    var name = req.body.name;
    var sql = 'SELECT * FROM user WHERE tag=?';
    dbConnection.query(sql, [id], (err, results) => {
        if(err)
            console.log(err);

        if(results[0])
            res.status(401).json({success: false, message: 'id 중복'})

        const crypto = pw2enc(pw);
        sql = "INSERT INTO user VALUES (?, ?, 'king', NULL, NULL, ?, ?)";
        dbConnection.query(sql, [id, name, crypto.salt, crypto.pwEncrypted], (err, results) => {
            if(err)
                console.log(err);
            else
                res.redirect(`.`);          
        });
    });
});

router.post('/setHeader', (req, res) => {
    request({
        headers: {
            'Authorization': `Bearer ${req.body.token}`
        },
        url: 'http://127.0.0.1:3003/user/check',
        method: 'GET',
        json: true
    }).then((response) =>{
        res.cookie('userInfo', response);
        res.redirect(`.`); 
    })
});

router.get('/check', userAuth.jwtLogin, (req, res) => {
    res.json(req.data);
});

module.exports = router;