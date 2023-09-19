## NULL 확인
SELECT *
FROM bug
WHERE assigned_to IS NULL;

SELECT *
FROM bug
WHERE assigned_to IS NOT NULL;

## NULL 확인 조건 포함
SELECT *
FROM bug
WHERE assigned_to <=> 1;


