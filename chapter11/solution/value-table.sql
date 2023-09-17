CREATE TABLE bug_status
(
    status VARCHAR(20) NOT NULL PRIMARY KEY
);

CREATE TABLE bug
(
    bug_id INT         NOT NULL PRIMARY KEY,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (status) REFERENCES bug_status (status)
);

INSERT INTO bug_status(status)
VALUES ('NEW'),
       ('IN PROGRESS'),
       ('FIXED');

## 값의 집합 조회

SELECT status
FROM bug_status
ORDER BY status;

## 사용되지 않는 컬럼 표시

ALTER TABLE bug_status
    ADD COLUMN active
        ENUM ('INACTIVE', 'ACTIVE') NOT NULL DEFAULT 'ACTIVE';

UPDATE bug_status
SET active = 'INACTIVE'
WHERE status = 'DUPLICATE';