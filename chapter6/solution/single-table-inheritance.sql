CREATE TABLE issue
(
    issue_id         BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    reported_by      BIGINT UNSIGNED NOT NULL,
    product_id       BIGINT UNSIGNED NOT NULL,
    priority         VARCHAR(20),
    version_resolved VARCHAR(20),
    status           VARCHAR(20),
    issue_type       VARCHAR(10) COMMENT 'BUG 또는 FEATURE',
    severity         VARCHAR(20) COMMENT 'BUG 에서만 사용',
    version_affected VARCHAR(20) COMMENT 'BUG 에서만 사용',
    sponsor          VARCHAR(50) COMMENT 'FEATURE 에서만 사용',
    FOREIGN KEY (reported_by) REFERENCES account (account_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);