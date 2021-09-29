const passport = require('passport');
const { pw2enc } = require(`${process.env.PWD}/middleware/auth`);

const dbModule = require(`${process.env.PWD}/database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const login = (req, res, next) => {
    passport.authenticate('managerLocal', {failureFlash: true}, (err, manager) => {
        if(err)
            return next(err)
        
        if(!manager) { // 로그인 실패 시 manager가 비어있음
            req.message = req.flash('message')[0]; // managerPassport의 localVerify에서 넘겨받은 flash
            return next();
        }

        req.login(manager, () => { // 로그인 성공 시
            return next();
        });
    })(req, res, next);
};

const register = (req, res, next) => {
    var sql = 'SELECT * FROM manager WHERE tag=?';
    dbConnection.query(sql, [req.body.tag], (err, rows) => {
        if(err)
            return next(err)

        if(rows[0]) { // 신규 가입 tag 중복 시 
            req.message = 'tag duplicate';
            return next();
        }
            
        const crypto = pw2enc(req.body.password);
        
        sql = "INSERT INTO manager VALUES (?, ?, 'king', 1, ?, ?)";
        dbConnection.query(sql, [req.body.tag, req.body.name, crypto.salt, crypto.pwEncrypted], (err, rows) => {
            if(err)
                return next(err)

            return next();
        });
    });
};


module.exports = {
    login,
    register
}