CREATE TABLE bug
(
    bug_id        BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    date_reported DATETIME        NOT NULL,
    summary       VARCHAR(10)     NOT NULL,
    status        VARCHAR(10)     NOT NULL,
    hours         NUMERIC(9, 2),
    INDEX (bug_id),
    INDEX (summary),
    INDEX (hours),
    INDEX (bug_id, date_reported, status)
);


## 인덱스 정의
CREATE INDEX telephone_book ON account(last_name, first_name);

### 복합 인덱스가 도움되지 않는 경우들
SELECT * FROM account ORDER BY first_name, last_name;
