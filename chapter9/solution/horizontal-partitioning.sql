CREATE TABLE bug
(
    bug_id        BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    status        VARCHAR(20)     NOT NULL,
    reported_by   BIGINT UNSIGNED NOT NULL,
    date_reported DATETIME CHECK ( YEAR(date_reported) = '2025' ),
    FOREIGN KEY (status) REFERENCES bug_status (status),
    FOREIGN KEY (reported_by) REFERENCES account (account_id)
) PARTITION BY HASH ( YEAR(date_reported) )
    PARTITIONS 4;
