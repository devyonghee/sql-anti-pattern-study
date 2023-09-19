## 슬로우 쿼리 실행 시간 확인
SHOW VARIABLES LIKE 'long_query_time';

## 쿼리 실행 계획
EXPLAIN
SELECT bug.*
FROM bug
         JOIN (bug_product JOIN product USING (product_id))
              USING (bug_id)
WHERE summary LIKE '%crash%'
  AND product_name = 'file'
ORDER BY date_reported desc;

## 인덱스를 캐시에 보관
LOAD INDEX INTO CACHE bug;

## 인덱스 재구성
ANALYZE TABLE bug;
OPTIMIZE TABLE bug;