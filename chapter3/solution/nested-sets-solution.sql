## 중첩 집합 방식
## nsleft 는 자식의 nsleft 보다 작고, nsright 는 자식의 nsright 보다 큼

CREATE TABLE comment
(
    comment_id   BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nsleft       INTEGER         NOT NULL,
    nsright      INTEGER         NOT NULL,
    bug_id       BIGINT UNSIGNED NOT NULL,
    author       BIGINT UNSIGNED NOT NULL,
    comment_date DATETIME        NOT NULL,
    comment      TEXT            NOT NULL,
    FOREIGN KEY (bug_id) REFERENCES bug (bug_id),
    FOREIGN KEY (author) REFERENCES account (account_id)
);

## data setting

INSERT INTO account (account_id, account_name, first_name, last_name, email, password_hash, portrait_image, hourly_rate)
VALUES (1, 'Fran', 'Fran', 'Fran', 'Fran', 'Fran', 0x4672616E, 1.00),
       (2, 'Ollie', 'Ollie', 'Ollie', 'Ollie', 'Ollie', 0x4F6C6C6965, 1.00),
       (3, 'Kukla', 'Kukla', 'Kukla', 'Kukla', 'Kukla', 0x4B756B6C61, 1.00);

INSERT INTO bug_status(status)
VALUES ('NEW');

INSERT INTO bug (date_reported, summary, description, resolution, reported_by, assigned_to, verified_by, status,
                 priority, hours)
VALUES (now(), null, null, null, 1, null, null, 'NEW', null, null);

INSERT INTO comment (comment_id, nsleft, nsright, bug_id, author, comment_date, comment)
VALUES (1, 1, 14, 1, 1, now(), '이 버그의 원인이 뭘까'),
       (2, 2, 5, 1, 2, now(), '널 포인터 때문인 것 같아'),
       (3, 3, 4, 1, 1, now(), '아니, 그건 확인해봤어'),
       (4, 6, 13, 1, 3, now(), '입력 값이 유효한지 확인'),
       (5, 7, 8, 1, 2, now(), '그래, 그게 버그야'),
       (6, 9, 12, 1, 1, now(), '그래 확인 코드 추가'),
       (7, 10, 11, 1, 3, now(), '수정했어');

## 자손 조회

SELECT c2.*
FROM comment c1
         JOIN comment c2 ON c2.nsleft BETWEEN c1.nsleft AND c1.nsright
WHERE c1.comment_id = 4;

## 조상 조회

SELECT c2.*
FROM comment c1
         JOIN comment c2 ON c1.nsleft BETWEEN c2.nsleft AND c2.nsright
WHERE c1.comment_id = 6;


## 노드 삭제 후 깊이를 조회해도 문제없이 계산되어 나옴

### depth = 3 나온 상태에서
SELECT c1.comment_id, COUNT(c2.comment_id) depth
FROM comment c1
         JOIN comment c2 ON c1.nsleft BETWEEN c2.nsleft AND c2.nsright
WHERE c1.comment_id = 7
GROUP BY c1.comment_id;

### 조상 삭제만 해도
DELETE
FROM comment
WHERE comment_id = 6;

### 정상적으로 깊이가 depth 2 로 나옴
SELECT c1.comment_id, COUNT(c2.comment_id) depth
FROM comment c1
         JOIN comment c2 ON c1.nsleft BETWEEN c2.nsleft AND c2.nsright
WHERE c1.comment_id = 7
GROUP BY c1.comment_id;


## 직접적인 부모 찾기

SELECT parent.*
FROM comment c
         JOIN comment parent ON c.nsleft BETWEEN parent.nsleft AND parent.nsright
         LEFT JOIN comment in_between
                   ON c.nsleft BETWEEN in_between.nsleft AND in_between.nsright
                       AND in_between.nsleft BETWEEN parent.nsleft AND parent.nsright
WHERE c.comment_id = 6
  AND in_between.comment_id IS NULL;

## 새로운 노드 추가

### 8과 9 공간 확보
UPDATE comment
SET nsleft  = IF(nsleft >= 8, nsleft + 2, nsleft),
    nsright = nsright + 2
WHERE nsright >= 7;

INSERT INTO comment(nsleft, nsright, bug_id, author, comment_date, comment)
VALUES (8, 9, 1, 1, now(), 'Me too!');

