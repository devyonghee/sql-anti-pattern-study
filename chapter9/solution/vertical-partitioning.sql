CREATE TABLE bug
(
    bug_id        BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    summary       CHAR(80),        # 고정 길이 데이터 타입
    date_reported DATETIME,        # 고정 길이 데이터 타입
    reporter_id   BIGINT UNSIGNED, # 고정 길이 데이터 타입
    FOREIGN KEY (reporter_id) REFERENCES account (account_id)
);

CREATE TABLE bug_description
(
    bug_id      BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    description VARCHAR(1000), # 가변 길이 데이터 타입
    resolution  VARCHAR(1000), # 가변 길이 데이터 타입
    FOREIGN KEY (bug_id) REFERENCES bug (bug_id)
);

