CREATE TABLE bug
(
    bug_id        BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_reported DATETIME        NOT NULL,
    summary       VARCHAR(80),
    description   VARCHAR(1000),
    resolution    VARCHAR(1000),
    status        VARCHAR(20) CHECK ( status IN ('NEW', 'IN PROGRESS', 'FIXED')),
    priority      VARCHAR(20),
    hours         DECIMAL(9, 2)
);

CREATE TABLE bug
(
    bug_id        BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_reported DATETIME        NOT NULL,
    summary       VARCHAR(80),
    description   VARCHAR(1000),
    resolution    VARCHAR(1000),
    status        ENUM ('NEW', 'IN PROGRESS', 'FIXED'),
    priority      VARCHAR(20),
    hours         DECIMAL(9, 2)
);

## 값의 집합 조회

SELECT DISTINCT status
FROM bug;

SELECT COLUMN_TYPE
FROM information_schema.COLUMNS
WHERE TABLE_NAME = 'bug'
  AND COLUMN_NAME = 'status';

## 새로운 값 추가

ALTER TABLE bug
    MODIFY COLUMN status ENUM ('NEW', 'IN PROGRESS', 'FIXED', 'DUPLICATE');

