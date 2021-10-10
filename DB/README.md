# MySQL 도커 실행 및 접속 메뉴얼

## 설명
#도커를 통해서 데이터베이스 스키마가 mysql안으로 자동 생성됩니다. 

### 코드스페이스에서 추천하는 도커 관련 프로그램 설치

```bash

$ docker-compose build
$ docker-compose up -d #빌드시간 1분 정도, mysql 도커 생성 및 실행 완료

#참고: mysql 도커 접속 포트 : 3306
#참고: root 계정 비번 6060, 유저 계정 server : 비번 6060

```

### 도커 접속해서 mysql 테이블 확인
    

```bash
#도커 프로세스 번호 확인
$ docker ps  

#docker 내부 접속
$ docker exec -it [도커 프로세스 번호] #option1

$ docker exec -it [도커 프로세스 번호] /bin/bash #option2

#mysql 접속
$ mysql -u root -p

#해당 데이터 베이스 접속
mysql> USE UMCS

```

### 도커 프로세스 종료


``` bash 
#도커 프로세스 번호 확인
$ docker ps

#도커 종료
$ docker rm -f [도커 프로세스 번호]
```
