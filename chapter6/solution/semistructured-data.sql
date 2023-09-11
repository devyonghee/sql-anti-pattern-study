CREATE TABLE issue
(
    issue_id         BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    reported_by      BIGINT UNSIGNED NOT NULL,
    product_id       BIGINT UNSIGNED NOT NULL,
    priority         VARCHAR(20),
    version_resolved VARCHAR(20),
    status           VARCHAR(20),
    issue_type       VARCHAR(10) COMMENT 'BUG 또는 FEATURE',
    attributes       JSON            NOT NULL COMMENT '모든 동적 속성 저장',
    FOREIGN KEY (reported_by) REFERENCES account (account_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);