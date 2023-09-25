SELECT p.product_id, COUNT(f.bug_id) count_fixed
FROM bug_product p
         LEFT JOIN bug f ON (p.bug_id = f.bug_id AND f.status = 'FIXED')
WHERE p.product_id = 1
GROUP BY p.product_id;

SELECT p.product_id, COUNT(f.bug_id) count_fixed
FROM bug_product p
         LEFT JOIN bug f ON (p.bug_id = f.bug_id AND f.status = 'OPEN')
WHERE p.product_id = 1
GROUP BY p.product_id;

### UNION

SELECT p.product_id, COUNT(f.bug_id) bug_count
FROM bug_product p
         LEFT JOIN bug f ON (p.bug_id = f.bug_id AND f.status = 'FIXED')
WHERE p.product_id = 1
GROUP BY p.product_id, f.status
UNION ALL
SELECT p.product_id, COUNT(f.bug_id) bug_count
FROM bug_product p
         LEFT JOIN bug f ON (p.bug_id = f.bug_id AND f.status = 'OPEN')
WHERE p.product_id = 1
GROUP BY p.product_id, f.status
ORDER BY bug_count;


## 여러 쿼리로 분리

### 작업하는 제품 개수
SELECT COUNT(*) how_many_products
FROM product;

### 버그를 수정한 개발자 수
SELECT COUNT(DISTINCT assigned_to) how_many_developers
FROM bug
WHERE status = 'FIXED';

### 개발자 당 평균 수정 버그 개수
SELECT AVG(bugs_per_developer) average_bugs_per_developer
FROM (SELECT dev.account_id, COUNT(*) bugs_per_developer
      FROM bug b
               JOIN account dev ON (b.assigned_to = dev.account_id)
      WHERE b.status = 'FIXED'
      GROUP BY dev.account_id) t;

### 수정한 버그 중 고객이 보고한 것의 개수
SELECT COUNT(*) how_many_customer_bugs
FROM bug b
         JOIN account cust ON (b.reported_by = cust.account_id)
WHERE b.status = 'FIXED';

## 코드 생성 쿼리
SELECT CONCAT('UPDATE inventory '
           , 'SET last_used = ''',
              MAX(u.usage_date), '''',
              ' WHERE inventory_id = ',
              u.inventory_id,
              ';') update_statement
FROM computer_usage u
GROUP BY u.inventory_id;

