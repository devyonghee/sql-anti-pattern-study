CREATE TABLE account
(
    account_id    BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    account_name  VARCHAR(20)     NOT NULL,
    email         VARCHAR(100)    NOT NULL,
    password_hash CHAR(64)        NOT NULL
);

INSERT INTO account(account_id, account_name, email, password_hash)
VALUES (123, 'billkarwin', 'bill@example.com', SHA2('xyzzy', 256));

SELECT IF(SHA2('xyzzy', 256), 1, 0)
           password_matches
FROM account
WHERE account_id = 123;

## 소금치기

SELECT SHA2(concat('password', '-0xT!sp9'), 256);


## 아이디에 토큰 할당하여 패스워드 재설정
CREATE TABLE password_reset_request
(
    token      CHAR(32) PRIMARY KEY,
    account_id BIGINT UNSIGNED NOT NULL,
    expiration TIMESTAMP       NOT NULL,
    FOREIGN KEY (account_id) REFERENCES account (account_id)
);

SET @token = MD5('billkarwin' || current_timestamp || RAND());

INSERT INTO password_reset_request (token, account_id, expiration)
VALUES (@token, 123, CURRENT_TIMESTAMP + INTERVAL 1 HOUR);

