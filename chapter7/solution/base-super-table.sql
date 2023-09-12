CREATE TABLE issue
(
    issue_id         BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    reported_by      BIGINT UNSIGNED NOT NULL,
    product_id       BIGINT UNSIGNED NOT NULL,
    priority         VARCHAR(20),
    version_resolved VARCHAR(20),
    status           VARCHAR(20),
    FOREIGN KEY (reported_by) REFERENCES account (account_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

CREATE TABLE bug
(
    issue_id         BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    severity         VARCHAR(20),
    version_affected VARCHAR(20),
    FOREIGN KEY (issue_id) REFERENCES issue (issue_id)
);

CREATE TABLE feature_request
(
    issue_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    sponsor  VARCHAR(50),
    FOREIGN KEY (issue_id) REFERENCES issue (issue_id)
);

CREATE TABLE comment
(
    comment_id   BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    issue_id     BIGINT UNSIGNED NOT NULL,
    author       BIGINT UNSIGNED NOT NULL,
    comment_date DATETIME        NOT NULL,
    comment      TEXT            NOT NULL,
    FOREIGN KEY (author) REFERENCES account (account_id),
    FOREIGN KEY (issue_id) REFERENCES issue (issue_id)
);

## 조회

SELECT *
FROM comment c
         LEFT JOIN bug b ON b.issue_id = c.issue_id
         LEFT JOIN feature_request f ON f.issue_id = c.issue_id
WHERE c.comment_id = 9876;

SELECT *
FROM bug b
         JOIN comment c ON b.issue_id = c.issue_id
WHERE c.comment_id = 9876;
