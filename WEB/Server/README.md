# Usage

1. WEB/Server 폴더에 .env파일 생성

```jsx
// WEB/Server/.env

PORT=3003
COOKIE_SECRET=secret
JWT_SECRET=secret
DB_PASSWORD=6060
```

2. `npm install` 실행
3. `docker ps` 입력하여 현재 실행중인 컨테이너id 확인
4. `docker rm -f 컨테이너id`
5. `docker-compose build`
6. `docker-compose up -d` 
7. `npm start` 실행
8. 3003 포트로 접속
