CREATE TABLE bug
(
    issue_id         BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    reported_by      BIGINT UNSIGNED NOT NULL,
    product_id       BIGINT UNSIGNED NOT NULL,
    priority         VARCHAR(20),
    version_resolved VARCHAR(20),
    status           VARCHAR(20),
    severity         VARCHAR(20) COMMENT 'BUG 에서만 사용',
    version_affected VARCHAR(20) COMMENT 'BUG 에서만 사용',
    FOREIGN KEY (reported_by) REFERENCES account (account_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

CREATE TABLE feature_request
(
    issue_id         BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    reported_by      BIGINT UNSIGNED NOT NULL,
    product_id       BIGINT UNSIGNED NOT NULL,
    priority         VARCHAR(20),
    version_resolved VARCHAR(20),
    status           VARCHAR(20),
    sponsor          VARCHAR(50) COMMENT 'FEATURE 에서만 사용',
    FOREIGN KEY (reported_by) REFERENCES account (account_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

CREATE TABLE comment
(
    comment_id   BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    author       BIGINT UNSIGNED NOT NULL,
    comment_date DATETIME        NOT NULL,
    comment      TEXT            NOT NULL,
    FOREIGN KEY (author) REFERENCES account (account_id)
);

CREATE TABLE bug_comment
(
    issue_id   BIGINT UNSIGNED NOT NULL,
    comment_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (issue_id, comment_id),
    UNIQUE KEY (comment_id),
    FOREIGN KEY (issue_id) REFERENCES bug (issue_id),
    FOREIGN KEY (comment_id) REFERENCES comment (comment_id)
);

CREATE TABLE feature_comment
(
    issue_id   BIGINT UNSIGNED NOT NULL,
    comment_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (issue_id, comment_id),
    UNIQUE KEY (comment_id),
    FOREIGN KEY (issue_id) REFERENCES feature_request (issue_id),
    FOREIGN KEY (comment_id) REFERENCES comment (comment_id)
);

## 조회

SELECT *
FROM bug_comment bc
         JOIN comment c ON bc.comment_id = c.comment_id
WHERE bc.issue_id = 1234;

SELECT *
FROM comment c
         LEFT JOIN bug_comment bc ON bc.comment_id = c.comment_id
         LEFT JOIN feature_comment fc on fc.comment_id = c.comment_id
WHERE c.comment_id = 9876;


## 두 테이블을 하나의 테이블처럼 보여줘야 하는 경우

SELECT b.issue_id, b.severity, b.version_affected, NULL AS sponsor
FROM comment c
         JOIN (bug_comment bc JOIN bug b ON bc.issue_id = b.issue_id)
              ON c.comment_id = bc.comment_id
WHERE c.comment_id = 9876
UNION
SELECT f.issue_id,
       NULL AS severity,
       NULL AS version_affected,
       f.sponsor
FROM comment c
         JOIN
     (feature_comment fc JOIN feature_request f ON fc.issue_id = f.issue_id)
     ON c.comment_id = fc.comment_id
WHERE c.comment_id = 9876;



SELECT c.*,
       COALESCE(b.issue_id, f.issue_id)       AS issue_id,
       COALESCE(b.priority, f.priority)       AS priority,
       COALESCE(b.reported_by, f.reported_by) AS reported_by,
       b.severity,
       b.version_affected,
       f.sponsor
FROM comment c
         LEFT JOIN (bug_comment bc JOIN bug b ON bc.issue_id = b.issue_id) ON bc.comment_id = c.comment_id
         LEFT JOIN (feature_comment fc JOIN feature_request f ON fc.issue_id = f.issue_id)
                   ON fc.comment_id = c.comment_id
WHERE c.comment_id = 9876;



