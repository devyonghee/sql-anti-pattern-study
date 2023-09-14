CREATE TABLE bug_2023
(
    bug_id        BIGINT          NOT NULL PRIMARY KEY,
    status        VARCHAR(20)     NOT NULL,
    reported_by   BIGINT UNSIGNED NOT NULL,
    date_reported DATETIME CHECK ( YEAR(date_reported) = '2023' ),
    FOREIGN KEY (status) REFERENCES bug_status (status),
    FOREIGN KEY (reported_by) REFERENCES account (account_id)
);

CREATE TABLE bug_2024
(
    bug_id        BIGINT          NOT NULL PRIMARY KEY,
    status        VARCHAR(20)     NOT NULL,
    reported_by   BIGINT UNSIGNED NOT NULL,
    date_reported DATETIME CHECK ( YEAR(date_reported) = '2024' ),
    FOREIGN KEY (status) REFERENCES bug_status (status),
    FOREIGN KEY (reported_by) REFERENCES account (account_id)
);

CREATE TABLE bug_2025
(
    bug_id        BIGINT          NOT NULL PRIMARY KEY,
    status        VARCHAR(20)     NOT NULL,
    reported_by   BIGINT UNSIGNED NOT NULL,
    date_reported DATETIME CHECK ( YEAR(date_reported) = '2025' ),
    FOREIGN KEY (status) REFERENCES bug_status (status),
    FOREIGN KEY (reported_by) REFERENCES account (account_id)
);

## 데이터 변경

# UPDATE bug_2023
# SET date_reported = '2024-01-01 00:00:00'
# WHERE bug_id = 1234;

INSERT INTO bug_2024 (bug_id, status, reported_by, date_reported)
VALUES (1234, 'NEW', 1, '2024-01-01 00:00:00');

DELETE
FROM bug_2023
WHERE bug_id = 1234;

## 유일성 보장 테이블 필요

CREATE TABLE bug_id_generator
(
    bug_id BIGINT NOT NULL PRIMARY KEY
);

## 여러 테이블에 걸쳐 조회

SELECT b.status, COUNT(*) AS count_per_status
FROM (SELECT *
      FROM bug_2023
      UNION ALL
      SELECT *
      FROM bug_2024
      UNION ALL
      SELECT *
      FROM bug_2025) b
GROUP BY b.status

## 부모 테이블과 함께 조회

SELECT *
FROM account a
         JOIN (SELECT *
               FROM bug_2023
               UNION ALL
               SELECT *
               FROM bug_2024
               UNION ALL
               SELECT *
               FROM bug_2025) b
              ON a.account_id = b.reported_by;

## 메타데이터 트리블 컬럼

CREATE TABLE project_history
(
    project_history_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    bug_fixed_2023     INT,
    bug_fixed_2024     INT,
    bug_fixed_2025     INT
);

