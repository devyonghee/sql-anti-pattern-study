SELECT *
FROM bug
WHERE bug_id = 1234;
DELETE FROM bug;

SELECT *
FROM project
WHERE project_name = 'O'Hare'';


UPDATE account SET password_hash = SHA2('xyzzy', 256)
WHERE account_id = 1234 OR TRUE;


