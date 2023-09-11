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


## 모든 객체를 보기가 복잡해짐

CREATE VIEW issue AS
SELECT issue_id,
       reported_by,
       product_id,
       priority,
       version_resolved,
       status,
       severity,
       version_affected,
       NULL  AS sponsor,
       'BUG' AS issue_type
FROM bug
UNION ALL
SELECT issue_id,
       reported_by,
       product_id,
       priority,
       version_resolved,
       status,
       NULL      AS severity,
       NULL      AS version_affected,
       sponsor,
       'FEATURE' AS issue_type
FROM feature_request;