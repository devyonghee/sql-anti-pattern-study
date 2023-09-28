CREATE TABLE account
(
    account_id   BIGINT UNSIGNED PRIMARY KEY,
    account_name VARCHAR(20)  NOT NULL,
    email        VARCHAR(100) NOT NULL,
    password     VARCHAR(30)  NOT NULL
);


INSERT INTO account(account_id, account_name, email, password)
VALUES (123, 'billkarwin', 'bill@example.com', 'xyzzy');


SELECT IF(password = 'opensesame', 1, 0)
           password_matches
FROM account
WHERE account_id = 123;
