const passport = require('passport');
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

// 관리자 로그인 요청 시 실행
function localVerify(req, tag, password, done) {
    var sql = 'SELECT * FROM manager WHERE tag=?';
    dbConnection.query(sql, [tag], (err, rows) => {
        if(err) // db error
            return done(null, false, req.flash('code', 4));
        
        var managerInfo = rows[0];
        if(!managerInfo) // tag 불일치
            return done(null, false, req.flash('code', 2));

        // 요청 온 password를 암호화 key(salt)로 암호화 하여 pwEncrypted에 저장 
        var pwEncrypted = pw2enc(password, managerInfo.salt).pwEncrypted;

        if(pwEncrypted !== managerInfo.enc_pwd) // 암호화 한 요청 password와 db의 암호화된 pw가 불일치하면
            return done(null, false, req.flash('code', 3));
       
        return done(null, managerInfo);
    });
}

module.exports = () => {
    passport.use('managerLocal', new LocalStrategy(LocalStrategyOption, localVerify));

    passport.serializeUser((user, done) => {
        done(null, user.tag);
    });

    passport.deserializeUser((tag, done) => {
        var sql = 'SELECT * FROM manager WHERE tag=?';
        dbConnection.query(sql, [tag], (err, rows) => {
            if(err) // db error
                return done(null, false, req.flash('code', 4));
            if(!rows[0]) // tag 불일치
                return done(null, false, req.flash('code', 2));
    
            return done(null, rows[0]);
        });
    });
}