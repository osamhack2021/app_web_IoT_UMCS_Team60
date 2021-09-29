const jwt = require('jsonwebtoken');
const crypto = require('crypto');

// 토큰 decode
exports.decodeToken = (token) => {
    try {
        var decode = jwt.verify(token, process.env.JWT_SECRET);
        return decode;
    } catch (err) {
        return err;
    }
}

// pw 암호화
exports.pw2enc = (pw, salt = crypto.randomBytes(64).toString('hex')) => {
    var pwEncrypted = crypto.pbkdf2Sync(pw, salt, 100000, 64, 'sha512').toString('hex');
    return { salt, pwEncrypted };
}
