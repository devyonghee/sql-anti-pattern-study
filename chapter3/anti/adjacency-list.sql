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

INSERT INTO sql_anti_pattern.comment (parent_id, bug_id, author, comment_date, comment) VALUES (null, 1, 1, now(), '이 버그의 원인이 뭘까')

INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (1, null, 1, 1, now(), '이 버그의 원인이 뭘까');
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (2, 1, 1, 2, now(), '널 포인터 때문인 것 같아');
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (3, 2, 1, 1, now(), '아니, 그건 확인해봤어');
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (4, 1, 1, 3, now(), '입력 값이 유효한지 확인');
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (5, 4, 1, 2, now(), '그래, 그게 버그야');
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (6, 4, 1, 1, now(), '그래 확인 코드 추가');
INSERT INTO comment (comment_id, parent_id, bug_id, author, comment_date, comment) VALUES (7, 6, 1, 3, now(), '수정했어');


