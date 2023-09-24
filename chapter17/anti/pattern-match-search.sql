SELECT *
FROM bug
WHERE description LIKE '%crash%';

###

SELECT *
FROM bug
WHERE description REGEXP 'crash';


###

SELECT *
FROM bug
WHERE description LIKE '%one%';
# money, prone, lonely 도 검색됨

