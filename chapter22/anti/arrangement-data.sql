## 사용하지 않는 첫번째 키 값 구하기
SELECT b1.bug_id + 1
FROM bug b1
         LEFT JOIN bug b2 ON (b1.bug_id + 1 = b2.bug_id)
WHERE b2.bug_id IS NULL
ORDER BY b1.bug_id
LIMIT 1;

## 기존 행의 번호 재할당
UPDATE bug
SET bug_id = 3
WHERE bug_id = 4;

