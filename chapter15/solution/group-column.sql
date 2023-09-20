## bug_id 조회 제거
SELECT product_id, MAX(date_reported) AS latest
FROM bug
         JOIN bug_product USING (bug_id)
GROUP BY product_id;

## 서브 쿼리 사용
SELECT bp1.product_id, b1.date_reported AS latest, b1.bug_id
FROM bug b1
         JOIN bug_product bp1 USING (bug_id)
WHERE NOT EXISTS(SELECT *
                 FROM bug b2
                          JOIN bug_product bp2 USING (bug_id)
                 WHERE bp1.product_id = bp2.product_id
                   AND b1.date_reported < b2.date_reported);


## 유도테이블(인라인 뷰) 사용
SELECT m.product_id, m.latest, MAX(b1.bug_id) AS latest_bug_id
FROM bug b1
         JOIN (SELECT product_id, MAX(date_reported) AS latest
               FROM bug b2
                        JOIN bug_product USING (bug_id)
               GROUP BY product_id) m
              ON (b1.date_reported = m.latest)
GROUP BY m.product_id, m.latest;

## 외부 조인 사용
SELECT bp1.product_id, b1.date_reported AS latest, b1.bug_id
FROM bug b1
         JOIN bug_product bp1 USING (bug_id)
         LEFT JOIN (bug b2 JOIN bug_product bp2 USING (bug_id))
                   ON (bp1.product_id = bp2.product_id AND (b1.date_reported < b2.date_reported OR
                                                            b1.date_reported = b2.date_reported AND
                                                            b1.bug_id < b2.bug_id))
WHERE b2.bug_id IS NULL;


## 집계 함수 사용
SELECT product_id, MAX(date_reported) AS latest, MAX(bug_id) AS latest_bug_id
FROM bug
         JOIN bug_product USING (bug_id)
GROUP BY product_id;

## 값을 연결하여 조회

SELECT product_id, MAX(date_reported) AS latest, GROUP_CONCAT(bug_id) AS bug_id_list
FROM bug
         JOIN bug_product USING (bug_id)
GROUP BY product_id;
