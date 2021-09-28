const jwt = require('jsonwebtoken');
const crypto = require('crypto');

// 토큰 decode
exports.decodeToken = (token) => {
    try {
        var decode = jwt.verify(token, process.env.JWT_SECRET);
        return decode;
    } catch (err) {
        //err.name == 'TokenExpiredError'
        return err;
    }
}

// 토큰이 유효한지 판별
exports.verifyToken = (req, res, next) => {
    try {
        const token = req.headers.authorization.split('Bearer ')[1];
        req.decoded = jwt.verify(token, process.env.JWT_SECRET);
        next();
    } catch (err) {
        if (err.name == 'TokenExpiredError') {
            req.msg = "token 만료";
        }
        else { 
            req.msg = "유효하지 않은 token";
        }
        next();
    }
}

// pw 암호화
exports.pw2enc = (pw, salt = crypto.randomBytes(64).toString('hex')) => {
    var pwEncrypted = crypto.pbkdf2Sync(pw, salt, 100000, 64, 'sha512').toString('hex');

    return {salt, pwEncrypted};
}
