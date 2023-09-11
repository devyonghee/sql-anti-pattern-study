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

## 단일 테이블에서와 동일한 결과의 쿼리

SELECT i.*, b.*, f.*
FROM issue i
         LEFT JOIN bug b ON i.issue_id = b.issue_id
         LEFT JOIN feature_request f ON i.issue_id = f.issue_id;


