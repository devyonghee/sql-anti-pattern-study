CREATE TABLE comment
(
    comment_id   BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    parent_id    BIGINT UNSIGNED,
    bug_id       BIGINT UNSIGNED NOT NULL,
    author       BIGINT UNSIGNED NOT NULL,
    comment_date DATETIME        NOT NULL,
    comment      TEXT            NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES comment (comment_id),
    FOREIGN KEY (bug_id) REFERENCES bug (bug_id),
    FOREIGN KEY (author) REFERENCES account (account_id)
);


## data setting

INSERT INTO account (account_id, account_name, first_name, last_name, email, password_hash, portrait_image, hourly_rate) VALUES (1, 'Fran', 'Fran', 'Fran', 'Fran', 'Fran', 0x4672616E, 1.00);
INSERT INTO account (account_id, account_name, first_name, last_name, email, password_hash, portrait_image, hourly_rate) VALUES (2, 'Ollie', 'Ollie', 'Ollie', 'Ollie', 'Ollie', 0x4F6C6C6965, 1.00);
INSERT INTO account (account_id, account_name, first_name, last_name, email, password_hash, portrait_image, hourly_rate) VALUES (3, 'Kukla', 'Kukla', 'Kukla', 'Kukla', 'Kukla', 0x4B756B6C61, 1.00);

INSERT INTO bug_status(status) VALUES ('NEW');

INSERT INTO bug (bug_id, date_reported, summary, description, resolution, reported_by, assigned_to, verified_by, status, priority, hours) VALUES (2, now(), null, null, null, 1, null, null, 'NEW', null, null);

INSERT INTO sql_anti_pattern.comment (parent_id, bug_id, author, comment_date, comment) VALUES (null, 1, 1, now(), '이 버그의 원인이 뭘까');

INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (1, null, 1, 1, now(), '이 버그의 원인이 뭘까');
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (2, 1, 1, 2, now(), '널 포인터 때문인 것 같아');
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (3, 2, 1, 1, now(), '아니, 그건 확인해봤어');
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (4, 1, 1, 3, now(), '입력 값이 유효한지 확인');
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (5, 4, 1, 2, now(), '그래, 그게 버그야');
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (6, 4, 1, 1, now(), '그래 확인 코드 추가');
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (7, 6, 1, 3, now(), '수정했어');

## 인접 목록에서 트리 조회하기 (모든 자식 조회)

SELECT c1.*, c2.*
FROM comment c1
         LEFT JOIN comment c2 ON c2.parent_id = c1.comment_id;

### 트리 구조를 모두 조회하여 애플리케이션에서 조합하는 방법도 있음

SELECT *
FROM comment
where bug_id = 123;

## 트리 구조 목록 유지

### 추가
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (8, 7, 1, 3, now(), '고마워');

### 변경
UPDATE comment
SET parent_id = 3
WHERE comment_id = 6;

### 삭제
SELECT comment_id FROM comment WHERE parent_id = 4;
SELECT comment_id FROM comment WHERE parent_id = 5;
SELECT comment_id FROM comment WHERE parent_id = 6;
SELECT comment_id FROM comment WHERE parent_id = 7;

DELETE FROM comment WHERE parent_id IN (7);
DELETE FROM comment WHERE parent_id IN (5, 6);
DELETE FROM comment WHERE parent_id IN (4);

