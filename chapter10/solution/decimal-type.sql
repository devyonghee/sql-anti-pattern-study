CREATE TABLE bug
(
    bug_id        BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_reported DATETIME        NOT NULL,
    summary       VARCHAR(80),
    description   VARCHAR(1000),
    resolution    VARCHAR(1000),
    reported_by   BIGINT UNSIGNED NOT NULL,
    assigned_to   BIGINT UNSIGNED,
    verified_by   BIGINT UNSIGNED,
    status        VARCHAR(20)     NOT NULL DEFAULT 'NEW',
    priority      VARCHAR(20),
    hours         DECIMAL(9, 2),
    FOREIGN KEY (reported_by) REFERENCES account (account_id),
    FOREIGN KEY (assigned_to) REFERENCES account (account_id),
    FOREIGN KEY (verified_by) REFERENCES account (account_id),
    FOREIGN KEY (status) REFERENCES bug_status (status)
);

CREATE TABLE account
(
    account_id     BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    account_name   VARCHAR(20)     NOT NULL,
    first_name     VARCHAR(20)     NOT NULL,
    last_name      VARCHAR(20)     NOT NULL,
    email          VARCHAR(100)    NOT NULL,
    password_hash  CHAR(64)        NOT NULL,
    portrait_image BLOB            NOT NULL,
    hourly_rate    DECIMAL(9, 2)   NOT NULL
);

## 값 조회

SELECT *
FROM account
WHERE hourly_rate = 59.95;