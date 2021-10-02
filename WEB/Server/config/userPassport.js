const passport = require('passport');
const JWTStrategy = require('passport-jwt').Strategy;
const { ExtractJwt } = require('passport-jwt');
const LocalStrategy = require('passport-local').Strategy;
const { pw2enc } = require(`${process.env.PWD}/middleware/auth`);

const dbModule = require(`${process.env.PWD}/database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const LocalStrategyOption = {
    usernameField: "tag",
    passwordField: "password",
    passReqToCallback : true
};

// 사용자 로그인 요청 시 실행
function localVerify(req, tag, password, done) {
    var sql = 'SELECT * FROM user WHERE tag=?';
    dbConnection.query(sql, [tag], (err, rows) => {
        if(err) // db error
            return done(null, false, req.flash('code', 4));
        
        var userInfo = rows[0];
        if(!userInfo) // tag 불일치
            return done(null, false, req.flash('code', 2));

        // 요청 온 password를 암호화 key(salt)로 암호화 하여 pwEncrypted에 저장 
        var pwEncrypted = pw2enc(password, userInfo.salt).pwEncrypted;

        if(pwEncrypted !== userInfo.enc_pwd) // 암호화 한 요청 password와 db의 암호화된 pw가 불일치하면
            return done(null, false, req.flash('code', 3));
       
        return done(null, userInfo);
    })     
}

const jwtStrategyOption = {
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    secretOrKey: process.env.JWT_SECRET,
};

function jwtVerift(payload, done) {
    var sql = 'SELECT * FROM user WHERE tag=?';
    dbConnection.query(sql, [payload.tag], (err, rows) => {
        if(err) // db error
            return done(null, false, req.flash('code', 4));
        
        var userInfo = rows[0];
        if(!userInfo) // jwt 비유효
            return done(null, false, req.flash('message', 2));
        
        return done(null, userInfo);
    });
}

module.exports = () => {
    passport.use('userLocal', new LocalStrategy(LocalStrategyOption, localVerify));
    passport.use(new JWTStrategy(jwtStrategyOption, jwtVerift));
}