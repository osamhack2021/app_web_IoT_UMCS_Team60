--  테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

-- beacon Table Create SQL
CREATE TABLE beacon
(
    `id`  VARCHAR(45)    NOT NULL, 
    CONSTRAINT PK_beacon PRIMARY KEY (id)
);


-- doom Table Create SQL
CREATE TABLE doom
(
    `id`         INT            NOT NULL    AUTO_INCREMENT, 
    `name`       VARCHAR(45)    NULL, 
    `beacon_id`  VARCHAR(45)            NULL, 
    CONSTRAINT PK_doom PRIMARY KEY (id)
);

ALTER TABLE doom
    ADD CONSTRAINT FK_doom_beacon_id_beacon_id FOREIGN KEY (beacon_id)
        REFERENCES beacon (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- doomroom Table Create SQL
CREATE TABLE doomroom
(
    `id`         INT            NOT NULL    AUTO_INCREMENT, 
    `beacon_id`  VARCHAR(45)            NULL, 
    `doom_id`    INT            NULL, 
    `floor`      INT            NULL, 
    `name`       VARCHAR(45)    NULL, 
    CONSTRAINT PK_doomroom PRIMARY KEY (id)
);

ALTER TABLE doomroom
    ADD CONSTRAINT FK_doomroom_beacon_id_beacon_id FOREIGN KEY (beacon_id)
        REFERENCES beacon (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE doomroom
    ADD CONSTRAINT FK_doomroom_doom_id_doom_id FOREIGN KEY (doom_id)
        REFERENCES doom (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- outside_facility Table Create SQL
CREATE TABLE outside_facility
(
    `id`         INT            NOT NULL    AUTO_INCREMENT, 
    `name`       VARCHAR(45)    NULL, 
    `beacon_id`  VARCHAR(45)            NULL, 
    CONSTRAINT PK_outside_facility PRIMARY KEY (id)
);

ALTER TABLE outside_facility
    ADD CONSTRAINT FK_outside_facility_beacon_id_beacon_id FOREIGN KEY (beacon_id)
        REFERENCES beacon (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- manager Table Create SQL
CREATE TABLE manager
(
    `tag`      VARCHAR(45)    NOT NULL, 
    `name`     VARCHAR(45)    NULL, 
    `rank`     VARCHAR(45)    NULL, 
    `auth`     INT            NULL, 
    `salt`     TEXT           NULL, 
    `enc_pwd`  TEXT           NULL, 
    CONSTRAINT PK_ PRIMARY KEY (tag)
);


-- user Table Create SQL
CREATE TABLE user
(
    `tag`      VARCHAR(45)    NOT NULL, 
    `name`     VARCHAR(45)    NULL, 
    `rank`     VARCHAR(45)    NULL, 
    `room_id`  INT            NULL, 
    `doom_id`  INT            NULL, 
    `salt`     TEXT           NULL, 
    `enc_pwd`  TEXT           NULL, 
    CONSTRAINT PK_USER PRIMARY KEY (tag)
);

ALTER TABLE user
    ADD CONSTRAINT FK_user_doom_id_doom_id FOREIGN KEY (doom_id)
        REFERENCES doom (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE user
    ADD CONSTRAINT FK_user_room_id_doomroom_id FOREIGN KEY (room_id)
        REFERENCES doomroom (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- doomfacility Table Create SQL
CREATE TABLE doomfacility
(
    `id`           INT            NOT NULL    AUTO_INCREMENT, 
    `name`         VARCHAR(45)    NULL, 
    `beacon_id`    VARCHAR(45)            NULL, 
    `doom_id`      INT            NULL, 
    `user_number`  INT            NULL, 
    `floor`        INT            NULL, 
    CONSTRAINT PK_doomfacility PRIMARY KEY (id)
);

ALTER TABLE doomfacility
    ADD CONSTRAINT FK_doomfacility_beacon_id_beacon_id FOREIGN KEY (beacon_id)
        REFERENCES beacon (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE doomfacility
    ADD CONSTRAINT FK_doomfacility_doom_id_doom_id FOREIGN KEY (doom_id)
        REFERENCES doom (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- access_record Table Create SQL
CREATE TABLE access_record
(
    `id`         INT         NOT NULL    AUTO_INCREMENT, 
    `user_tag`   VARCHAR(45)         NOT NULL, 
    `beacon_id`  VARCHAR(45)         NULL, 
    `in_time`    DATETIME    NULL, 
    `out_time`   DATETIME    NULL, 
    CONSTRAINT PK_access_record PRIMARY KEY (id)
);

ALTER TABLE access_record
    ADD CONSTRAINT FK_access_record_user_tag_user_tag FOREIGN KEY (user_tag)
        REFERENCES user (tag) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE access_record
    ADD CONSTRAINT FK_access_record_beacon_id_beacon_id FOREIGN KEY (beacon_id)
        REFERENCES beacon (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- watchman Table Create SQL
CREATE TABLE watchman
(
    `id`                INT     NOT NULL    AUTO_INCREMENT, 
    `manager_tags`      VARCHAR(45)     NULL, 
    `charge_doom`       INT     NULL, 
    `responsible_date`  DATE    NULL, 
    `shift`             TEXT    NULL, 
    CONSTRAINT PK_watchman PRIMARY KEY (id)
);

ALTER TABLE watchman
    ADD CONSTRAINT FK_watchman_manager_tags_manager_tag FOREIGN KEY (manager_tags)
        REFERENCES manager (tag) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE watchman
    ADD CONSTRAINT FK_watchman_charge_doom_doom_id FOREIGN KEY (charge_doom)
        REFERENCES doom (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- facility_request Table Create SQL
CREATE TABLE facility_request
(
    `id`            INT            NOT NULL    AUTO_INCREMENT, 
    `user_tag`       VARCHAR(45)    NOT NULL, 
    `facility_id`   INT            NULL, 
    `request_time`  DATETIME       NULL, 
    `desired_time`  TIME           NULL, 
    `permission`    VARCHAR(45)    NULL, 
    CONSTRAINT PK_facility_request PRIMARY KEY (id)
);

ALTER TABLE facility_request
    ADD CONSTRAINT FK_facility_request_facility_id_doomfacility_id FOREIGN KEY (facility_id)
        REFERENCES doomfacility (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE facility_request
    ADD CONSTRAINT FK_facility_request_user_tag_user_tag FOREIGN KEY (user_tag)
        REFERENCES user (tag) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- anomaly Table Create SQL
CREATE TABLE anomaly
(
    `id`             INT            NOT NULL    AUTO_INCREMENT,  
    `user_tag`       VARCHAR(45)    NOT NULL, 
    `temperature`    FLOAT(7,2)        NULL, 
    `anomaly`        TEXT           NULL, 
    `reported_time`  DATETIME       NULL, 
    CONSTRAINT PK_anomaly PRIMARY KEY (id)
);

ALTER TABLE anomaly
    ADD CONSTRAINT FK_anomaly_user_tag_user_tag FOREIGN KEY (user_tag)
        REFERENCES user (tag) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- timetable Table Create SQL
CREATE TABLE timetable
(
    `id`           INT         NOT NULL    AUTO_INCREMENT, 
    `doom_id`      INT         NULL, 
    `room_id`      INT         NOT NULL, 
    `facility_id`  INT         NULL, 
    `start_time`   DATETIME    NULL, 
    `end_time`     DATETIME    NULL, 
    CONSTRAINT PK_timetable PRIMARY KEY (id)
);

ALTER TABLE timetable
    ADD CONSTRAINT FK_timetable_facility_id_doomfacility_id FOREIGN KEY (facility_id)
        REFERENCES doomfacility (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE timetable
    ADD CONSTRAINT FK_timetable_room_id_doomroom_id FOREIGN KEY (room_id)
        REFERENCES doomroom (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE timetable
    ADD CONSTRAINT FK_timetable_doom_id_doom_id FOREIGN KEY (doom_id)
        REFERENCES doom (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- outside_request Table Create SQL
CREATE TABLE outside_request
(
    `id`            INT            NOT NULL    AUTO_INCREMENT, 
    `user_tag`      VARCHAR(45)    NOT NULL, 
    `outside_id`    INT            NOT NULL, 
    `request_time`  DATETIME       NULL, 
    `permission`    VARCHAR(45)    NULL, 
    `description`   TEXT           NULL, 
    CONSTRAINT PK_outside_request PRIMARY KEY (id)
);

ALTER TABLE outside_request
    ADD CONSTRAINT FK_outside_request_outside_id_outside_facility_id FOREIGN KEY (outside_id)
        REFERENCES outside_facility (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE outside_request
    ADD CONSTRAINT FK_outside_request_user_tag_user_tag FOREIGN KEY (user_tag)
        REFERENCES user (tag) ON DELETE RESTRICT ON UPDATE RESTRICT;
