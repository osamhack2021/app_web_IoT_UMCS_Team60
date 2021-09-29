const passportSocketIo = require("passport.socketio");
const { decodeToken } = require(`${process.env.PWD}/middleware/auth`);

module.exports = (server, session) => {
    const io = require('socket.io')(server); 
    const FileStore = require("session-file-store")(session);
    
    io.use(passportSocketIo.authorize({
        cookieParser: require('cookie-parser'),     
        key: 'express.sid',
        secret: process.env.COOKIE_SECRET, 
        store: new FileStore(),
        success: onAuthorizeSuccess,
        fail: onAuthorizeFail,
    }));

    // session login(관리자 로그인) 성공 시
    function onAuthorizeSuccess(data, accept){
        console.log('manager login', data.user);
        accept(null, true);
    }
       
    function onAuthorizeFail(data, message, error, accept){
        if(error)
            throw new Error(message);
        accept(null, false);
    }

    io.on('connection', (socket) => {
        var user, manager;
        
        if(!socket.request.user.logged_in) { // session login(관리자 로그인) 실패 시
            if(socket.handshake.headers.authorization) { // jwt가 header로 왔는지 확인하여 user인지 판별
                user = decodeToken(socket.handshake.headers.authorization.split('Bearer ')[1]);
                console.log('user login', user);
            }
        }

        socket.on('chat message', (msg) => {
            io.emit('chat message', msg); 
        });

        socket.on('disconnect', () => {
            console.log('user disconnected');
        });

        socket.on('move_request', (req) => {
            var user = decodeToken(req.token);
        });
    });
    
    return io;
};