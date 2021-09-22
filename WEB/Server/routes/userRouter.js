module.exports = (app, dbConnection, passport) => {
    const router = require('express').Router();
    const pwCrypto = require('../pwCrypto');

    router.get('/', function (req, res) {
        if(!req.user)
            res.redirect('/login');
        else
            res.redirect('/welcome');
    });

    router.get('/login', function(req, res){
        if(!req.user)
            res.render('login', {message:'input your id and password.'});
        else
            res.redirect('/welcome');
    });

    router.get('/welcome', function(req, res){
        if(!req.user)
            return res.redirect('/login');
        else
          res.render('welcome', {name:req.user.name});
    });
    
    router.get('/logout', function(req, res){
        req.logout();
        res.redirect('/');
    });
    
    router.post('/login', 
        passport.authenticate('local', {
            successRedirect: '/welcome',
            failureRedirect: '/login',
            failureFlash: false
        })
    );

    router.get('/register', function(req, res){
        if(!req.user)
            res.render('register');
        else
            res.redirect('/welcome');
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

            const crypto = pwCrypto(pw);
            sql = "INSERT INTO manager VALUES (?, ?, 'king', 1, ?, ?)";
            dbConnection.query(sql, [id, name, crypto.salt, crypto.pwEncrypted], function(err, results){
                if(err)
                    console.log(err);
                else
                    return res.render('login', {message:'register success'});          
            });//query
        });//query
    });

    return router;
}