CREATE TABLE contact
(
    product_id BIGINT UNSIGNED NOT NULL,
    account_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (product_id, account_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id),
    FOREIGN KEY (account_id) REFERENCES account (account_id)
);

## 특정 계정의 제품 조회
SELECT p.*
FROM product p
         JOIN contact c on p.product_id = c.product_id
WHERE c.account_id = 1;

## 제품으로 계정 조회
SELECT a.*
FROM account a
         JOIN contact c ON c.product_id = a.account_id
WHERE c.product_id = 1;

## 계정에 대한 집계 쿼리
SELECT product_id, count(*) accounts_per_product
FROM contact
GROUP BY product_id;


## 가장 많은 담당자의 제품 조회
SELECT c.product_id, c.accounts_per_product
FROM (SELECT product_id, count(*) accounts_per_product
      FROM contact
      GROUP BY product_id) c
ORDER BY c.accounts_per_product DESC
LIMIT 1;

## 특정 제품에 대한 계정 갱신
INSERT INTO contact (product_id, account_id)
VALUES (1, 1);

DELETE
FROM contact
WHERE product_id = 1
  AND account_id = 1;
