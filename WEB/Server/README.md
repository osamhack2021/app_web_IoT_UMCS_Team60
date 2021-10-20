# Local 환경
## Ubuntu
18.04.6 LTS
## Docker
20.10.8
## Docker-compose
2.0.0

# Docker로 MySQL Container 생성 및 구동, 스키마 생성하기
```
$ docker-compose build
$ docker-compose up -d
```

# 서버 구동하기
1. WEB/Server 폴더에 .env파일 생성(보안을 위해서 .env 파일은 github에 원래 commit하지 않지만 해커톤 제출용으로 readme에 작성)

```
$ vi mkdir WEB/Server/.env

PORT=3003
COOKIE_SECRET=secret
JWT_SECRET=secret
DB_PASSWORD=6060
DB_HOST=localhost
DB_PORT=3307
DB_USER=root
DB_NAME=UMCS
SESSION_KEY=express.sid
```

2. Server 모듈 설치
```
$ npm install
```

3. 서버 구동
```
$ npm start
```

4. localhost:3003 포트로 접속