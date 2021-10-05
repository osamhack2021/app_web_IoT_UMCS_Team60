const passport = require('passport');
const jwt = require('jsonwebtoken');
const { pw2enc } = require(`../middleware/auth`);

const dbModule = require(`../database`)();
const dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const register = (req, res, next) => {
    var msg = {4: 'db_error', 2: 'duplicate_id', 3: 'wrong_facility_ids'};
    var { password, ...data } = req.body; // password를 제외한 req.body를 data로 넘겨줌
    req.data = data;

    var sql = 'SELECT * FROM user WHERE tag=?';
    dbConnection.query(sql, [req.body.tag], (err, rows) => {
        if(err) { // db error
            req.code = 4;
            req.msg = msg[req.code];
            return next(err)
        }
            
        if(rows[0]) { // 신규 가입자 tag 중복
            req.code = 2;
            req.msg = msg[req.code];
            return next();
        }
            
        const crypto = pw2enc(req.body.password);

        sql = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?)";
        dbConnection.query(sql, [req.body.tag, req.body.name, req.body.rank, req.body.room_id, req.body.doom_id, crypto.salt, crypto.pwEncrypted], (err, rows) => {
            if(err) { // room_id, doom_id 등 등록되지 않은 시설 id가 들어옴
                req.code = 3;
                req.msg = msg[req.code];
                return next();
            }

            return next();
        });
    });
};


const login = (req, res, next) => {
    const msg = {4: 'db_error', 5: 'authenticate_error', 2: 'cannot_find_id', 3: 'wrong_password'};

    passport.authenticate('userLocal', { session: false }, (err, user) => {
        if(err) { // 인증 error
            req.code = 4;
            req.msg = msg[req.code];
            return next();
        }
        if(!user) { // 로그인 실패 시 user가 비어있음
            req.code = req.flash('code')[0]; // managerPassport의 localVerify에서 넘겨받은 flash
            req.msg = msg[req.code];
            
            return next();
        }
        else { // 로그인 성공
            req.login(user, { session: false }, () => {
                const { salt, enc_pwd, ...payload } = user; // 비밀번호 관련 정보를 제외하고 payload에 저장

                const token = jwt.sign( // jwt 생성
                    payload, // user info
                    process.env.JWT_SECRET, // secret key
                    {
                        expiresIn: "365d"
                    } // option
                );
                req.token = token;
                req.data = payload;
                
                next();
            });
        }
    })(req, res, next);
};

// jwt로 로그인
const jwtLogin = (req, res, next) => {
    const msg = {2: 'token_error', 4: 'db_error'};

    passport.authenticate("jwt", { session: false }, (err, user) => {
        if(err) { // 인증 error
            req.code = 2;
            req.msg = msg[req.code];
            return next();
        }
        if(!user) { // 로그인 실패 시 user가 비어있음
            req.code = req.flash('code')[0]; // managerPassport의 jwtVerift에서 넘겨받은 flash
            req.msg = msg[req.code];
            return next();
        }
        else { // 로그인 성공
            req.login(user, { session: false }, () => {
                const { salt, enc_pwd, ...payload } = user; // 비밀번호 관련 정보를 제외하고 payload에 저장

                req.data = payload;
                
                next();
            });
        }
    })(req, res, next);
}

const checkJWTValid = (req, res, next) => {
    const msg = {2: 'token_error', 4: 'db_error'};

    passport.authenticate("jwt", { session: false }, (err, user) => {
        if(err || !user) { // 인증 error
            return res.status(400).json({
                code: 9,
                msg: 'not_login',
            });
        }
        else { // 로그인 성공
            req.login(user, { session: false }, () => {
                next();
            });
        }
    })(req, res, next);
}

module.exports = {
    login,
    jwtLogin,
    register,
    checkJWTValid
}