module.exports = (app, passport) => {
    const router = require('express').Router();


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
    
    router.post('/login', passport.authenticate('local', {failureRedirect: '/login', failureFlash: false}), // 인증 실패 시 401 리턴, {} -> 인증 스트레티지
    function (req, res) {
        console.log("success")
      res.redirect('/welcome');
    }
        // passport.authenticate('local', {
        //     successRedirect: '/welcome',
        //     failureRedirect: '/login',
        //     failureFlash: false
        // })
    );


    return router;
}