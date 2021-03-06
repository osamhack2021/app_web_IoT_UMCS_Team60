const express = require('express');
const app = express();
const server = require('http').createServer(app);
const path = require('path');
const morgan = require('morgan');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const session = require('express-session');
const cors = require('cors');
const passport = require('passport');
const flash = require('connect-flash');
const FileStore = require("session-file-store")(session);
require('dotenv').config();

app.set('port', process.env.PORT);

app.use(morgan('dev'));
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser(process.env.COOKIE_SECRET));
app.use(bodyParser.urlencoded({ extended: true }) );
app.use(session({
    key: process.env.SESSION_KEY,
    secret: process.env.COOKIE_SECRET,
    saveUninitialized: true,
    resave: true,
    cookie: {
        httpOnly: true,
        secure: false
    },
    store: new FileStore({logFn: function(){}}),
}));
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());

// socket connection
const io = require('./socket')(server, session); 

// passport
const userPassportConfig = require('./config/userPassport');
const managerPassportConfig = require('./config/managerPassport');

userPassportConfig();
managerPassportConfig();

// router
const apiRouter = require('./routes/apiRouter');
app.use('/api', apiRouter); 

//setting cors 
app.all('/*', (req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "X-Requested-With");
    next(); 
}); 

app.get('/', (req, res) => {
    res.sendFile(path.resolve(__dirname+'/public/index_build.html'));
})

server.listen(app.get('port'), ()=>{
    console.log(`server port: ${app.get('port')}`)
});