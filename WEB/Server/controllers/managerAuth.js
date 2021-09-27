const passport = require('passport');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
const { pw2enc } = require(`${process.env.PWD}/middleware/auth`);
dotenv.config();

var dbModule = require(`${process.env.PWD}/database`)();
var dbConnection = dbModule.init();
dbModule.db_open(dbConnection);

const login = (req, res, next) => {
    passport.authenticate('managerLocal', {failureFlash: true}, (err, user) => {
        if(err)
            return next(err)
        
        if(!user) {
            req.message = req.flash('message')[0];
            return next();
        }

        req.login(user, () => {
            return next();
        });
    })(req, res, next);
};

const register = (req, res, next) => {
    var id = req.body.tag;
    var pw = req.body.password;
    var name = req.body.name;
    var sql = 'SELECT * FROM manager WHERE tag=?';
    dbConnection.query(sql, [id], (err, results) => {
        if(err)
            return next(err)

        if(results[0]) {
            req.message = 'id duplicate';
            return next();
        }
            
        const crypto = pw2enc(pw);
        sql = "INSERT INTO manager VALUES (?, ?, 'king', 1, ?, ?)";
        dbConnection.query(sql, [id, name, crypto.salt, crypto.pwEncrypted], (err, results) => {
            if(err)
                return next(err)
            console.log(results)
            return next();
        });
    });
};


module.exports = {
    login,
    register
}