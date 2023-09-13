CREATE TABLE bug
(
    bug_id      BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(1000),
    tag1        VARCHAR(20),
    tag2        VARCHAR(20),
    tag3        VARCHAR(20)
);

## data setting

INSERT bug (bug_id, description, tag1, tag2, tag3)
VALUES (1234, '저장 시 죽어버림', 'crash', NULL, NULL),
       (3456, '성능 개선 필요', 'printing', NULL, NULL),
       (5678, 'XML 지원 필요', NULL, NULL, NULL);

UPDATE bug
SET tag2 ='performance'
WHERE bug_id = 3456;

## 검색

SELECT *
FROM bug
WHERE tag1 = 'performance'
   OR tag2 = 'performance'
   OR tag3 = 'performance';

SELECT *
FROM bug
WHERE 'performance' IN (tag1, tag2, tag3)
  AND 'printing' IN (tag1, tag2, tag3);

## 두 쿼리로 값 추가

SELECT *
FROM bug
WHERE bug_id = 3456;

UPDATE bug
SET tag2 ='performance'
WHERE bug_id = 3456;

## 한 쿼리로 값 삭제

UPDATE bug
SET tag1 = NULLIF(tag1, 'performance'),
    tag2 = NULLIF(tag2, 'performance'),
    tag3 = NULLIF(tag3, 'performance')
WHERE bug_id = 3456;

## 한 쿼리로 값 추가

UPDATE bug
SET tag1 = IF('performance' IN (tag2, tag3), tag1, COALESCE(tag1, 'performance')),
    tag2 = IF('performance' IN (tag1, tag3), tag2, COALESCE(tag2, 'performance')),
    tag3 = IF('performance' IN (tag1, tag2), tag3, COALESCE(tag3, 'performance'))
WHERE bug_id = 3456;


