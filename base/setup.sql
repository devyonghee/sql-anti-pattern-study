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

CREATE TABLE bug_status
(
    status VARCHAR(20) NOT NULL PRIMARY KEY
);

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

CREATE TABLE comment
(
    comment_id   BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    bug_id       BIGINT UNSIGNED NOT NULL,
    author       BIGINT UNSIGNED NOT NULL,
    comment_date DATETIME        NOT NULL,
    comment      TEXT            NOT NULL,
    FOREIGN KEY (bug_id) REFERENCES bug (bug_id),
    FOREIGN KEY (author) REFERENCES account (account_id)
);

CREATE TABLE screenshot
(
    bug_id           BIGINT UNSIGNED NOT NULL,
    image_id         BIGINT UNSIGNED NOT NULL,
    screenshot_image BLOB,
    caption          VARCHAR(100),
    PRIMARY KEY (bug_id, image_id),
    FOREIGN KEY (bug_id) REFERENCES bug (bug_id)
);

CREATE TABLE tag
(
    bug_id BIGINT UNSIGNED NOT NULL,
    tag    VARCHAR(20)     NOT NULL,
    primary key (bug_id, tag),
    FOREIGN KEY (bug_id) REFERENCES bug (bug_id)
);

CREATE TABLE product
(
    product_id   BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(20)     NOT NULL
);

CREATE TABLE bug_product
(
    bug_id     BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (bug_id, product_id),
    FOREIGN KEY (bug_id) REFERENCES bug (bug_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);