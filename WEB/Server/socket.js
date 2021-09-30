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

    function onAuthorizeSuccess(data, accept){
        accept(null, true);
    }
       
    function onAuthorizeFail(data, message, error, accept){
        accept(null, false);
    }

    
    io.on('connection', (socket) => {
        var user, manager;
        
        // 인증 과정
        if(socket.request.user.logged_in) { // session login(관리자 로그인) 성공 시
            var { salt, enc_pwd, ...user } = socket.request.user;
            console.log('manager login', socket.request.user);
        }
        else if(socket.handshake.headers.authorization) { // jwt가 header로 왔는지 확인하여 user인지 판별
            user = decodeToken(socket.handshake.headers.authorization.split('Bearer ')[1]);
            console.log('user login', user);
        }
        else {  // 인증 실패
            socket.disconnect(0);
        }

        // 사용자 이동 요청
        socket.on('move_request', (req) => {
            if(!user) return;
            //req.outside_id
            console.log(req)
        });

        // 사용자 위치 보고
        socket.on('location_report', (req) => {
            if(!user) return;
            //req.beacon_id, req.time
            console.log(req)
        });

        // 사용자 현상태 보고
        socket.on('my_status', (req) => {
            if(!user) return;
            //req.beacon_id, req.time, req.is_moving,
            console.log(req)
        });

        // 사용자 소집 불가 알림
        socket.on('my_status', (req) => {
            if(!user) return;
            //req.description
            console.log(req)
        });









        //test code
        socket.on('chat message', (msg) => {
            io.emit('chat message', msg); 
        });

        socket.on('disconnect', () => {
            console.log('user disconnected');
        });
    });
    
    return io;
};