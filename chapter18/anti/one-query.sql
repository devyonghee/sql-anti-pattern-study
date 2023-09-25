# 카테시안 곱 발생
SELECT p.product_id,
       COUNT(f.bug_id) AS count_fixed,
       COUNT(o.bug_id) AS count_open
FROM bug_product p
         LEFT JOIN (bug_product bpf JOIN bug f USING (bug_id)) f
                   ON (p.bug_id = f.bug_id AND f.status = 'FIXED')
         LEFT JOIN(bug_product bpo JOIN bug o USING (bug_id)) o
                  ON (p.bug_id = o.bug_id AND o.status = 'OPEN')
WHERE p.product_id = 1
GROUP BY p.product_id;

### 같은 결과

SELECT p.product_id, f.bug_id fixed, o.bug_id open
FROM bug_product p
         JOIN bug f ON (p.bug_id = f.bug_id AND f.status = 'FIXED')
         JOIN bug_product p2 USING (product_id)
         JOIN bug o ON (p2.bug_id = o.bug_id AND o.status = 'OPEN')
WHERE p.product_id = 1;



