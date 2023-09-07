## 클로저 테이블 방식

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

CREATE TABLE tree_path
(
    ancestor   BIGINT UNSIGNED NOT NULL,
    descendant BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (ancestor, descendant),
    FOREIGN KEY (ancestor) REFERENCES comment (comment_id),
    FOREIGN KEY (descendant) REFERENCES comment (comment_id)
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

INSERT INTO comment (comment_id, bug_id, author, comment_date, comment)
VALUES (1, 1, 1, now(), '이 버그의 원인이 뭘까'),
       (2, 1, 2, now(), '널 포인터 때문인 것 같아'),
       (3, 1, 1, now(), '아니, 그건 확인해봤어'),
       (4, 1, 3, now(), '입력 값이 유효한지 확인'),
       (5, 1, 2, now(), '그래, 그게 버그야'),
       (6, 1, 1, now(), '그래 확인 코드 추가'),
       (7, 1, 3, now(), '수정했어');

INSERT INTO tree_path (ancestor, descendant)
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (1, 4),
       (1, 5),
       (1, 6),
       (1, 7),
       (2, 2),
       (2, 3),
       (3, 3),
       (4, 4),
       (4, 5),
       (4, 6),
       (4, 7),
       (5, 5),
       (6, 6),
       (6, 7),
       (7, 7);


## 자손 조회

SELECT c.*
FROM comment c
         JOIN tree_path t on c.comment_id = t.descendant
WHERE t.ancestor = 4;

## 조상 조회

SELECT c.*
FROM comment c
         JOIN tree_path t on c.comment_id = t.ancestor
WHERE t.descendant = 6;


## 종말 노드 추가
INSERT INTO tree_path(ancestor, descendant)
    (SELECT t.ancestor, 8
     FROM tree_path t
     WHERE t.descendant = 5)
UNION ALL
SELECT 8, 8;

## 종말 노드 삭제
DELETE
FROM tree_path
WHERE descendant = 7;

## 중간 노드와 그 자손들 삭제
DELETE
FROM tree_path
WHERE descendant IN (SELECT descendant FROM tree_path WHERE ancestor = 4);

## 6 답글에 대해 4의 자식에서 3의 자식으로 서브트리 이동
DELETE
FROM tree_path
WHERE descendant IN (SELECT descendant FROM tree_path WHERE ancestor = 6)
  AND ancestor IN (SELECT ancestor FROM tree_path WHERE descendant = 6 AND ancestor != descendant);

INSERT INTO tree_path(ancestor, descendant)
    (SELECT supertree.ancestor, subtree.descendant
     FROM tree_path supertree
              CROSS JOIN tree_path subtree
     WHERE supertree.descendant = 3
       AND subtree.ancestor = 6);

## path_length 을 추가하여 테이블 개선 가능

ALTER TABLE tree_path
    ADD COLUMN path_length INT UNSIGNED NOT NULL DEFAULT 0;

SELECT *
FROM tree_path
WHERE ancestor = 4
  AND path_length = 1;

