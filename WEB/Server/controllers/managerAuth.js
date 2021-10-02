const passport = require('passport');
const { pw2enc } = require(`../middleware/auth`);

const dbModule = require(`../database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const login = (req, res, next) => {
    const msg = {4: 'db_error', 5: 'authenticate_error', 2: 'cannot_find_id', 3: 'wrong_password'};

    passport.authenticate('managerLocal', {failureFlash: true}, (err, manager) => {
        if(err) { // db error
            req.code = 4;
            req.msg = msg[req.code];
            return next(err)
        }
        
        if(!manager) { // 로그인 실패 시 manager가 비어있음
            req.code = req.flash('code')[0]; // managerPassport의 localVerify에서 넘겨받은 flash
            req.msg = msg[req.code];
            return next();
        }

        req.login(manager, () => { // 로그인 성공 시
            const { salt, enc_pwd, ...payload } = manager; // 비밀번호 관련 정보를 제외하고 payload에 저장
            req.data = payload;
            return next();
        });
    })(req, res, next);
};

const register = (req, res, next) => {
    var msg = {4: 'db_error', 2: 'duplicate_id'};

    var { password, ...data } = req.body; // password를 제외한 req.body를 data로 넘겨줌
    req.data = data;

    var sql = 'SELECT * FROM manager WHERE tag=?';
    dbConnection.query(sql, [req.body.tag], (err, rows) => {
        if(err) { // db error
            req.code = 4;
            req.msg = msg[req.code];
            return next(err)
        }

        if(rows[0]) { // 신규 가입 tag 중복 시 
            req.code = 2;  
            req.msg = msg[req.code];
            return next();
        }
            
        const crypto = pw2enc(req.body.password);
        
        sql = "INSERT INTO manager VALUES (?, ?, ?, ?, ?, ?)";
        dbConnection.query(sql, [req.body.tag, req.body.name, req.body.rank, req.body.auth, crypto.salt, crypto.pwEncrypted], (err, rows) => {
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