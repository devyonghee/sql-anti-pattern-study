## 행 번호 매기기
SELECT t1.*
FROM (SELECT a.account_name, b.bug_id, b.summary, ROW_NUMBER() over (ORDER BY a.account_name, b.date_reported) rn
      FROM account a
               JOIN bug b ON (a.account_id = b.reported_by)) t1
WHERE t1.rn BETWEEN 51 AND 100;
