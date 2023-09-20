## 주어진 product_id 에 대해 많은 bug_id 값이 존재하면 기대하지 않은 값이 나오지 않을 수 있음

SELECT product_id, MAX(date_reported) AS latest, bug_id
FROM bug
         JOIN bug_product USING (bug_id)
GROUP BY product_id;


