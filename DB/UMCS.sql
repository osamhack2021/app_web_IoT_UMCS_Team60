-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

-- 비콘 Table Create SQL
CREATE TABLE 비콘
(
    `id`  INT    NOT NULL    AUTO_INCREMENT, 
    CONSTRAINT PK_비콘 PRIMARY KEY (id)
);


-- 생활관 Table Create SQL
CREATE TABLE 생활관
(
    `id`    INT            NOT NULL    AUTO_INCREMENT, 
    `명칭`    VARCHAR(45)    NULL, 
    `비콘id`  INT            NULL, 
    CONSTRAINT PK_생활관 PRIMARY KEY (id)
);

ALTER TABLE 생활관
    ADD CONSTRAINT FK_생활관_비콘id_비콘_id FOREIGN KEY (비콘id)
        REFERENCES 비콘 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- 생활관호실 Table Create SQL
CREATE TABLE 생활관호실
(
    `id`     INT            NOT NULL    AUTO_INCREMENT, 
    `비콘id`   INT            NULL, 
    `생활관id`  INT            NULL, 
    `층수`     int            NULL, 
    `명칭`     VARCHAR(45)    NULL, 
    CONSTRAINT PK_호실 PRIMARY KEY (id)
);

ALTER TABLE 생활관호실
    ADD CONSTRAINT FK_생활관호실_비콘id_비콘_id FOREIGN KEY (비콘id)
        REFERENCES 비콘 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE 생활관호실
    ADD CONSTRAINT FK_생활관호실_생활관id_생활관_id FOREIGN KEY (생활관id)
        REFERENCES 생활관 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- 관리자 Table Create SQL
CREATE TABLE 관리자
(
    `군번`  INT            NOT NULL    AUTO_INCREMENT, 
    `이름`  VARCHAR(45)    NULL, 
    `계급`  VARCHAR(45)    NULL, 
    `권한`  INT            NULL, 
    CONSTRAINT PK_ PRIMARY KEY (군번)
);


-- 외부시설 Table Create SQL
CREATE TABLE 외부시설
(
    `id`    INT            NOT NULL    AUTO_INCREMENT, 
    `명칭`    VARCHAR(45)    NULL, 
    `비콘id`  INT            NULL, 
    CONSTRAINT PK_영내 시설 PRIMARY KEY (id)
);

ALTER TABLE 외부시설
    ADD CONSTRAINT FK_외부시설_비콘id_비콘_id FOREIGN KEY (비콘id)
        REFERENCES 비콘 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- 생활관공공시설 Table Create SQL
CREATE TABLE 생활관공공시설
(
    `id`     INT            NOT NULL    AUTO_INCREMENT, 
    `명칭`     VARCHAR(45)    NULL, 
    `비콘id`   INT            NULL, 
    `생활관id`  INT            NULL, 
    `현사용인원`  INT            NULL, 
    `층수`     INT            NULL, 
    CONSTRAINT PK_내부시설 PRIMARY KEY (id)
);

ALTER TABLE 생활관공공시설
    ADD CONSTRAINT FK_생활관공공시설_비콘id_비콘_id FOREIGN KEY (비콘id)
        REFERENCES 비콘 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE 생활관공공시설
    ADD CONSTRAINT FK_생활관공공시설_생활관id_생활관_id FOREIGN KEY (생활관id)
        REFERENCES 생활관 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- 사용자 Table Create SQL
CREATE TABLE 사용자
(
    `군번`     INT            NOT NULL    AUTO_INCREMENT, 
    `이름`     VARCHAR(45)    NULL, 
    `계급`     VARCHAR(45)    NULL, 
    `호실id`   INT            NULL, 
    `생활관id`  INT            NULL, 
    CONSTRAINT PK_USER PRIMARY KEY (군번)
);

ALTER TABLE 사용자
    ADD CONSTRAINT FK_사용자_생활관id_생활관_id FOREIGN KEY (생활관id)
        REFERENCES 생활관 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE 사용자
    ADD CONSTRAINT FK_사용자_호실id_생활관호실_id FOREIGN KEY (호실id)
        REFERENCES 생활관호실 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- 출입기록 Table Create SQL
CREATE TABLE 출입기록
(
    `id`     INT         NOT NULL, 
    `사용자군번`  INT         NOT NULL    AUTO_INCREMENT, 
    `비콘id`   INT         NULL, 
    `입장시각`   DATETIME    NULL, 
    `퇴장시각`   DATETIME    NULL, 
    CONSTRAINT PK_사용자_현위치 PRIMARY KEY (id)
);

ALTER TABLE 출입기록
    ADD CONSTRAINT FK_출입기록_사용자군번_사용자_군번 FOREIGN KEY (사용자군번)
        REFERENCES 사용자 (군번) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE 출입기록
    ADD CONSTRAINT FK_출입기록_비콘id_비콘_id FOREIGN KEY (비콘id)
        REFERENCES 비콘 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- 근무자 Table Create SQL
CREATE TABLE 근무자
(
    `id`     INT     NOT NULL    AUTO_INCREMENT, 
    `근무자군번`  INT     NULL, 
    `담당생활관`  INT     NULL, 
    `담당일`    DATE    NULL, 
    `교대사유`   TEXT    NULL, 
    CONSTRAINT PK_이상유무 PRIMARY KEY (id)
);

ALTER TABLE 근무자
    ADD CONSTRAINT FK_근무자_근무자군번_관리자_군번 FOREIGN KEY (근무자군번)
        REFERENCES 관리자 (군번) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE 근무자
    ADD CONSTRAINT FK_근무자_담당생활관_생활관_id FOREIGN KEY (담당생활관)
        REFERENCES 생활관 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- 공공시설사용요청 Table Create SQL
CREATE TABLE 공공시설사용요청
(
    `id`      INT         NOT NULL    AUTO_INCREMENT, 
    `사용자군번`   INT         NULL, 
    `공공시설id`  INT         NULL, 
    `요청시각`    DATETIME    NULL, 
    `희망사용시간`  TIME        NULL, 
    `결재여부`    TEXT        NULL, 
    CONSTRAINT PK_이상유무 PRIMARY KEY (id)
);

ALTER TABLE 공공시설사용요청
    ADD CONSTRAINT FK_공공시설사용요청_공공시설id_생활관공공시설_id FOREIGN KEY (공공시설id)
        REFERENCES 생활관공공시설 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE 공공시설사용요청
    ADD CONSTRAINT FK_공공시설사용요청_사용자군번_사용자_군번 FOREIGN KEY (사용자군번)
        REFERENCES 사용자 (군번) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- 외부시설이동요청 Table Create SQL
CREATE TABLE 외부시설이동요청
(
    `id`      INT         NOT NULL    AUTO_INCREMENT, 
    `사용자군번`   INT         NULL, 
    `외부시설id`  INT         NULL, 
    `요청시각`    DATETIME    NULL, 
    `결재상태`    VARCHAR     NULL, 
    `기각사유`    TEXT        NULL, 
    CONSTRAINT PK_이상유무 PRIMARY KEY (id)
);

ALTER TABLE 외부시설이동요청
    ADD CONSTRAINT FK_외부시설이동요청_사용자군번_사용자_군번 FOREIGN KEY (사용자군번)
        REFERENCES 사용자 (군번) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE 외부시설이동요청
    ADD CONSTRAINT FK_외부시설이동요청_외부시설id_외부시설_id FOREIGN KEY (외부시설id)
        REFERENCES 외부시설 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- 이상유무 Table Create SQL
CREATE TABLE 이상유무
(
    `사용자군번`  INT         NOT NULL    AUTO_INCREMENT, 
    `체온`     DOUBLE      NULL, 
    `이상유무`   TEXT        NULL, 
    `보고일`    DATETIME    NULL, 
    CONSTRAINT PK_이상유무 PRIMARY KEY (사용자군번)
);

ALTER TABLE 이상유무
    ADD CONSTRAINT FK_이상유무_사용자군번_사용자_군번 FOREIGN KEY (사용자군번)
        REFERENCES 사용자 (군번) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- 사용시간표 Table Create SQL
CREATE TABLE 사용시간표
(
    `id`     INT         NULL, 
    `생활관id`  INT         NULL, 
    `호실id`   INT         NOT NULL    AUTO_INCREMENT, 
    `시설id`   INT         NULL, 
    `시작시각`   DATETIME    NULL, 
    `종료시각`   DATETIME    NULL, 
    CONSTRAINT PK_사용시간표 PRIMARY KEY (id)
);

ALTER TABLE 사용시간표
    ADD CONSTRAINT FK_사용시간표_시설id_생활관공공시설_id FOREIGN KEY (시설id)
        REFERENCES 생활관공공시설 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE 사용시간표
    ADD CONSTRAINT FK_사용시간표_호실id_생활관호실_id FOREIGN KEY (호실id)
        REFERENCES 생활관호실 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE 사용시간표
    ADD CONSTRAINT FK_사용시간표_생활관id_생활관_id FOREIGN KEY (생활관id)
        REFERENCES 생활관 (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


