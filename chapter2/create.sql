CREATE TABLE product
(
    product_id   BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(20)     NOT NULL,
    # 제품과 담장자를 연관시키기 위해 컬럼 추가
    account_id   BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (account_id) REFERENCES account (account_id)
);