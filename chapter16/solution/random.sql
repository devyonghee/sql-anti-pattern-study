SELECT b1.*
FROM bug b1
         JOIN (SELECT CEIL(RAND() * (SELECT MAX(bug_id) FROM bug)) rand_id) b2
              ON b1.bug_id = b2.rand_id;


###

SELECT b1.*
FROM bug b1
         JOIN (SELECT CEIL(RAND() * (SELECT MAX(bug_id) FROM bug)) rand_id) b2
              ON b1.bug_id >= b2.rand_id
ORDER BY b1.bug_id
LIMIT 1;


###

SELECT bug_id
FROM bug;

SELECT bug_id
FROM bug
WHERE bug_id = ?;

###

SELECT COUNT(*)
FROM bug;

SELECT *
FROM bug
LIMIT 1 OFFSET ?;


