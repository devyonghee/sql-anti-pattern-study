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
    issue_type   VARCHAR(20)     NOT NULL COMMENT 'bug 또는 feature_request',
    issue_id     BIGINT UNSIGNED NOT NULL,
    author       BIGINT UNSIGNED NOT NULL,
    comment_date DATETIME        NOT NULL,
    comment      TEXT            NOT NULL,
    FOREIGN KEY (author) REFERENCES account (account_id)
);

## 조회

SELECT *
FROM bug b
         JOIN comment c ON (b.issue_id = c.issue_id AND c.issue_type = 'bug')
WHERE b.issue_id = 1234;


SELECT *
FROM comment c
         LEFT JOIN bug b ON (c.issue_id = b.issue_id AND c.issue_type = 'bug')
         LEFT JOIN feature_request f ON (c.issue_id = f.issue_id AND c.issue_type = 'feature_request')
WHERE c.issue_id = 1234;