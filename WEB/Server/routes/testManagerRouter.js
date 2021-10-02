const router = require('express').Router();
const passport = require('passport');
const { pw2enc } = require(`../middleware/auth`);
const baseUrl = 'manager';

var dbModule = require(`../database`)();
var dbConnection = dbModule.init();
dbModule.db_open(dbConnection);


router.get('/', (req, res) => {
    if(!req.user)
        res.redirect(`/${baseUrl}/login`);
    else
        res.redirect(`/${baseUrl}/welcome`);
});

router.get('/login', (req, res) =>{
    if(!req.user)
        res.render(`${baseUrl}/login`, {message: req.flash('message')});
    else
        res.redirect(`/${baseUrl}/welcome`);
});

router.get('/welcome', (req, res) =>{
    if(!req.user)
        res.redirect(`/${baseUrl}/login`);
    else
        res.render(`${baseUrl}/welcome`, {name:req.user.name});
});

router.get('/logout', (req, res) => {
    req.logout();
    res.redirect(`/${baseUrl}`);
});

router.post('/login', 
    passport.authenticate('managerLocal', {
        successRedirect: `/${baseUrl}/welcome`,
        failureRedirect: `/${baseUrl}/login`,
        failureFlash: true
    })
);

router.get('/register', (req, res) => {
    if(!req.user)
        res.render(`${baseUrl}/register`);
    else
        res.redirect(`/${baseUrl}/welcome`);
});

router.post('/register',  (req, res) => {
    var id = req.body.username;
    var pw = req.body.password;
    var name = req.body.name;
    var sql = 'SELECT * FROM manager WHERE tag=?';
    dbConnection.query(sql, [id], (err, results) => {
        if(err)
            console.log(err);

        if(results[0])
            res.render('login', {message:'id duplicated'});

        const crypto = pw2enc(pw);
        sql = "INSERT INTO manager VALUES (?, ?, 'king', 1, ?, ?)";
        dbConnection.query(sql, [id, name, crypto.salt, crypto.pwEncrypted], (err, results) => {
            if(err)
                console.log(err);
            else
                res.render(`${baseUrl}/login`, {message:'register success'});          
        });
    });
});


module.exports = router;