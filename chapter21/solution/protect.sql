UPDATE account
SET password_hash = SHA2(?, 256)
WHERE account_id = ?;


