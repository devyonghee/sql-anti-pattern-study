CREATE TABLE account
(
    account_id     BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    account_name   VARCHAR(20)     NOT NULL,
    portrait_image BLOB
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


## 외부 이미지 파일 조회

UPDATE screenshot
SET screenshot_image = LOAD_FILE('/images/screenshot1234-1.jpg')
WHERE bug_id = 1
  AND image_id = 1;

## BLOB 컬럼 내용 파일 저장

SELECT screenshot_image
INTO DUMPFILE '/images/screenshot1234-1.jpg'
FROM screenshot
WHERE bug_id = 1
  AND image_id = 1;

