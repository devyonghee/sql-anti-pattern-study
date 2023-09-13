CREATE TABLE bug
(
    bug_id      BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(1000),
);

CREATE TABLE tag
(
    bug_id BIGINT UNSIGNED NOT NULL,
    tag    VARCHAR(20),
    PRIMARY KEY (bug_id, tag),
    FOREIGN KEY (bug_id) REFERENCES bug (bug_id)
);

## data setting

INSERT bug (bug_id, description)
VALUES (1234, '저장 시 죽어버림'),
       (3456, '성능 개선 필요'),
       (5678, 'XML 지원 필요');

INSERT INTO tag(bug_id, tag)
VALUES (1234, 'crash'),
       (3456, 'printing'),
       (3456, 'performance');

## 검색

SELECT *
FROM bug
         JOIN tag USING (bug_id)
WHERE tag = 'performance';

SELECT *
FROM bug
         JOIN tag t1 USING (bug_id)
         JOIN tag t2 USING (bug_id)
WHERE t1.tag = 'performance'
  AND t2.tag = 'printing';

## 값 추가

INSERT INTO tag (bug_id, tag)
VALUES (1234, 'save');

## 값 삭제

DELETE
FROM tag
WHERE bug_id = 1234
  AND tag = 'crash';
