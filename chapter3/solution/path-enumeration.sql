## 경로 열거 방식

CREATE TABLE comment
(
    comment_id   BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    path         VARCHAR(1000),
    bug_id       BIGINT UNSIGNED NOT NULL,
    author       BIGINT UNSIGNED NOT NULL,
    comment_date DATETIME        NOT NULL,
    comment      TEXT            NOT NULL,
    FOREIGN KEY (bug_id) REFERENCES bug (bug_id),
    FOREIGN KEY (author) REFERENCES account (account_id)
);

## data setting

INSERT INTO account (account_id, account_name, first_name, last_name, email, password_hash, portrait_image, hourly_rate) VALUES (1, 'Fran', 'Fran', 'Fran', 'Fran', 'Fran', 0x4672616E, 1.00);
INSERT INTO account (account_id, account_name, first_name, last_name, email, password_hash, portrait_image, hourly_rate) VALUES (2, 'Ollie', 'Ollie', 'Ollie', 'Ollie', 'Ollie', 0x4F6C6C6965, 1.00);
INSERT INTO account (account_id, account_name, first_name, last_name, email, password_hash, portrait_image, hourly_rate) VALUES (3, 'Kukla', 'Kukla', 'Kukla', 'Kukla', 'Kukla', 0x4B756B6C61, 1.00);

INSERT INTO bug_status(status) VALUES ('NEW');

INSERT INTO bug (date_reported, summary, description, resolution, reported_by, assigned_to, verified_by, status, priority, hours) VALUES (now(), null, null, null, 1, null, null, 'NEW', null, null);

INSERT INTO comment (comment_id, path, bug_id, author, comment_date, comment) VALUES (1, '1/', 1, 1, now(), '이 버그의 원인이 뭘까');
INSERT INTO comment (comment_id, path, bug_id, author, comment_date, comment) VALUES (2, '1/2/', 1, 2, now(), '널 포인터 때문인 것 같아');
INSERT INTO comment (comment_id, path, bug_id, author, comment_date, comment) VALUES (3, '1/2/3/', 1, 1, now(), '아니, 그건 확인해봤어');
INSERT INTO comment (comment_id, path, bug_id, author, comment_date, comment) VALUES (4, '1/4/', 1, 3, now(), '입력 값이 유효한지 확인');
INSERT INTO comment (comment_id, path, bug_id, author, comment_date, comment) VALUES (5, '1/4/5/', 1, 2, now(), '그래, 그게 버그야');
INSERT INTO comment (comment_id, path, bug_id, author, comment_date, comment) VALUES (6, '1/4/6', 1, 1, now(), '그래 확인 코드 추가');
INSERT INTO comment (comment_id, path, bug_id, author, comment_date, comment) VALUES (7, '1/4/6/7/', 1, 3, now(), '수정했어');

### 조상 경로 조회

SELECT * FROM comment WHERE '1/4/6/7' LIKE concat(path, '%');

### 자손 경로 조회

SELECT * FROM comment WHERE path LIKE '1/4/%';

### 글쓴이당 답글 수 세기

SELECT count(*) FROM comment WHERE path LIKE '1/4/%' GROUP BY author;

### 새로운 중간 노드(non-leaf) 삽입

INSERT INTO comment (comment_id, path, bug_id, author, comment_date, comment) VALUES (8, '1/', 1, 3, now(), 'Good job!');

UPDATE comment
SET path = CONCAT((SELECT path FROM comment WHERE comment_id = 7), LAST_INSERT_ID(), '/')
WHERE comment_id = LAST_INSERT_ID();


