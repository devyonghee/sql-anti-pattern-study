CREATE TABLE product
(
    product_id   BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(20)     NOT NULL,
    # 담장자 여러 명과 연관짓기 위해 쉼표로 구분
    account_id   VARCHAR(100)    NOT NULL
);

INSERT INTO account (account_id, account_name, first_name, last_name, email, password_hash, portrait_image, hourly_rate)
values (12, 'account', 'first', 'last', 'email@email.com', 'password', 'image', 100),
       (34, 'account', 'first', 'last', 'email@email.com', 'password', 'image', 100);

INSERT INTO product (product_name, account_id)
VALUES ('TurboBuilder', '12,34');

## 특정 계정의 제품 조회
SELECT *
FROM product
WHERE account_id REGEXP '12';

## 제품에 대한 계정 정보 조회
SELECT *
FROM product p
         JOIN account a ON p.account_id REGEXP a.account_id
WHERE p.product_id = 1;

## 계정에 대한 집계 쿼리
SELECT product_id, LENGTH(account_id) - LENGTH(REPLACE(account_id, ',', '')) + 1 AS account_count
FROM product;

### 제품에 대한 계정 추가
UPDATE product
SET account_id = CONCAT(account_id, ',56')
WHERE product_id = 1;