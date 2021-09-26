const crypto = require('crypto');
const passport = require('passport');
const passportJWT = require('passport-jwt');
const JWTStrategy = passportJWT.Strategy;
const { ExtractJwt } = passportJWT;
const LocalStrategy = require('passport-local').Strategy;
const dotenv = require('dotenv');
dotenv.config();

var dbModule = require('../database')();
var dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const LocalStrategyOption = {
    usernameField: "tag",
    passwordField: "password",
    passReqToCallback : true
};

function localVerify(req, tag, password, done) {
    var sql = 'SELECT * FROM user WHERE tag=?';
    dbConnection.query(sql, [tag], (err, rows, fields) => {
        if(err) // db error
        return done(null, false, req.flash('message', 'db connection error'));
        
        var userInfo = rows[0];
        if(!userInfo) // no user 
            return done(null, false, req.flash('message', 'please check id'));

        var pwEncrypted = crypto.pbkdf2Sync(password, userInfo.salt, 100000, 64, 'sha512').toString('hex');

        if(pwEncrypted !== userInfo.enc_pwd) // password incorrent
            return done(null, false, req.flash('message', 'please check password'));
       
        return done(null, userInfo);
    })     
}

const jwtStrategyOption = {
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    secretOrKey: process.env.JWT_SECRET,
};

function jwtVerift(payload, done) {
    var sql = 'SELECT * FROM user WHERE tag=?';
    dbConnection.query(sql, [payload.tag], (err, rows, fields) => {
        if(err) // db error
            return done(null, false, req.flash('message', 'db connection error'));
        
        var userInfo = rows[0];
        if(!userInfo) // no user 
            return done(null, false, req.flash('message', 'token error'));
        
        return done(null, user);
    });
}

module.exports = () => {
    passport.use('userLocal', new LocalStrategy(LocalStrategyOption, localVerify));
    passport.use(new JWTStrategy(jwtStrategyOption, jwtVerift));
}