const router = require('express').Router();
const passport = require('passport');
const { pw2enc } = require('../middleware/auth');
const baseUrl = 'manager';

var dbModule = require('../database')();
var dbConnection = dbModule.init();
dbModule.db_open(dbConnection);


router.get('/', function (req, res) {
    if(!req.user)
        res.redirect(`/${baseUrl}/login`);
    else
        res.redirect(`/${baseUrl}/welcome`);
});

router.get('/login', function(req, res){
    if(!req.user)
        res.render(`${baseUrl}/login`, {message:'input your id and password.'});
    else
        res.redirect(`/${baseUrl}/welcome`);
});

router.get('/welcome', function(req, res){
    if(!req.user)
        return res.redirect(`/${baseUrl}/login`);
    else
        res.render(`${baseUrl}/welcome`, {name:req.user.name});
});

router.get('/logout', function(req, res){
    req.logout();
    res.redirect(`/${baseUrl}`);
});

router.post('/login', 
    passport.authenticate('managerLocal', {
        successRedirect: `/${baseUrl}/welcome`,
        failureRedirect: `/${baseUrl}/login`,
        failureFlash: false
    })
);

router.get('/register', function(req, res){
    if(!req.user)
        res.render(`${baseUrl}/register`);
    else
        res.redirect(`/${baseUrl}/welcome`);
});

router.post('/register',  function(req, res){
    var id = req.body.username;
    var pw = req.body.password;
    var name = req.body.name;
    var sql = 'SELECT * FROM manager WHERE tag=?';
    dbConnection.query(sql, [id], function(err, results){
        if(err)
            console.log(err);
        console.log(results[0])
        if(results[0])
            return res.render('login', {message:'id duplicated'});

        const crypto = pw2enc(pw);
        sql = "INSERT INTO manager VALUES (?, ?, 'king', 1, ?, ?)";
        dbConnection.query(sql, [id, name, crypto.salt, crypto.pwEncrypted], function(err, results){
            if(err)
                console.log(err);
            else
                return res.render(`${baseUrl}/login`, {message:'register success'});          
        });//query
    });//query
});

module.exports = router;