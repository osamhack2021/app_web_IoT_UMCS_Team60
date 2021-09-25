// controllers/authControllers.js
var express = require('express');
const passport = require('passport');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
dotenv.config();

const login =  async (req, res, next) => {
  try {
    passport.authenticate('userLocal', { session: false }, (err, user) => {
      if (err || !user) {
        return res.status(400).json({success : false, message : "로그인 실패"});
      }
      req.login(user, { session: false }, (err) => {
        if (err) 
          return res.send(err);
  
        const token = jwt.sign(
          { tag : user.tag },
          process.env.JWT_SECRET,
          {expiresIn: "7d"}
        );
        
        return res.json({ success : true, message : "로그인 성공", token });
      });
    })(req, res);
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