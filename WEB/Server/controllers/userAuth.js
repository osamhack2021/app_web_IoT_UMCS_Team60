const passport = require('passport');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
dotenv.config();

const login =  async (req, res, next) => {
    try {
        passport.authenticate('userLocal', { session: false }, (err, user) => {
            if(err)
                return next(err)
            
            if(!user)
                return res.redirect('/user');
            
            req.login(user, { session: false }, () => {
                const token = jwt.sign(
                    { 
                        tag : user.tag,
                        name : user.name
                    },  // user info
                    process.env.JWT_SECRET, // secret key
                    {
                        expiresIn: "365d"
                    } // option
                );
                req.token = token;
                next();
            });
        })(req, res, next);
    } catch (e) {
        console.error(e);
        return next(e);
    }
};

const check = (req, res) => {
    res.json(req.decoded);
};

module.exports = {
    login,
    check
}