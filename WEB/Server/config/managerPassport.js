const crypto = require('crypto');
const passport = require('passport');
const passportJWT = require('passport-jwt');
const LocalStrategy = require('passport-local').Strategy;

var dbModule = require('../database')();
var dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const LocalStrategyOption = {
    usernameField: "tag",
    passwordField: "password"
};
function localVerify(tag, password, done) {
    var sql = 'SELECT * FROM manager WHERE tag=?';
    dbConnection.query(sql, [tag], function(err, rows, fields){
        if(err) // db error
            return done(null, false, {message : 'db connection error'});
        
        var userInfo = rows[0];
        if(!userInfo) // no user 
            return done(null, false, {message : 'please check id'} );

        var pwEncrypted = crypto.pbkdf2Sync(password, userInfo.salt, 100000, 64, 'sha512').toString('hex');

        if(pwEncrypted !== userInfo.enc_pwd) // password incorrent
            return done(null, false, {message : 'please check password'});
       
        return done(null, userInfo);
    });
}

module.exports = () => {
    passport.use('managerLocal', new LocalStrategy(LocalStrategyOption, localVerify));

    passport.serializeUser(function(user, done) {
        done(null, user.tag);
    });

    passport.deserializeUser(function(tag, done) {
        var sql = 'SELECT * FROM manager WHERE tag=?';
        dbConnection.query(sql, [tag], function(err, results){
            if(err)
                return done(err, false);
            if(!results[0])
                return done(err, false);
    
            return done(null, results[0]);
        });
    });
}