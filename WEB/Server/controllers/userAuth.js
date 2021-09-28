const passport = require('passport');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
const { pw2enc } = require(`${process.env.PWD}/middleware/auth`);

dotenv.config();

var dbModule = require(`${process.env.PWD}/database`)();
var dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const register = async (req, res, next) => {
    var msg = {4: 'db_error', 2: 'duplicate_id', 3: 'wrong_facility_ids'};
    var { password, ...data } = req.body;
    req.data = data;

    var sql = 'SELECT * FROM user WHERE tag=?';
    dbConnection.query(sql, [req.body.tag], (err, results) => {
        if(err) {
            req.code = 4;
            req.msg = msg[req.code];
            return next(err)
        }
            
        if(results[0]) {
            req.code = 2;
            req.msg = msg[req.code];
            return next();
        }
            
        const crypto = pw2enc(req.body.password);

        sql = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?)";
        dbConnection.query(sql, [req.body.tag, req.body.name, req.body.rank, req.body.room_id, req.body.doom_id, crypto.salt, crypto.pwEncrypted], (err, results) => {
            if(err) {
                req.code = 3;
                req.msg = msg[req.code];
                return next();
            }
            return next();
        });
    });
};


const login = (req, res, next) => {
    var msg = {4: 'db_error', 2: 'cannot_find_id', 3: 'wrong_password'};
    passport.authenticate('userLocal', { session: false }, (err, user) => {
        if(err) {
            req.code = 4;
            req.msg = msg[req.code];
            return next();
        }
        if(!user) {
            req.code = req.flash('code')[0];
            req.msg = msg[req.code];
            return next();
        }
        else {
            req.login(user, { session: false }, () => {
                var { salt, enc_pwd, ...payload } = user;
                const token = jwt.sign(
                    payload, // user info
                    process.env.JWT_SECRET, // secret key
                    {
                        expiresIn: "365d"
                    } // option
                );
                req.token = token;
                var { salt, enc_pwd, ...data } = req.user;
                req.data = data;
                next();
            });
        }

    })(req, res, next);

};


const check = (req, res) => {
    res.json(req.decoded);
};

module.exports = {
    login,
    check,
    register
}