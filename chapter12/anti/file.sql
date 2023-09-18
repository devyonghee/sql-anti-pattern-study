CREATE TABLE account
(
    account_id     BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    account_name   VARCHAR(20)     NOT NULL,
    portrait_image BLOB
);

CREATE TABLE screenshot
(
    bug_id          BIGINT UNSIGNED NOT NULL,
    image_id        BIGINT UNSIGNED NOT NULL,
    screenshot_path VARCHAR(100),
    caption         VARCHAR(100),
    PRIMARY KEY (bug_id, image_id),
    FOREIGN KEY (bug_id) REFERENCES bug (bug_id)
);

