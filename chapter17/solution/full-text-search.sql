ALTER TABLE bug
    ADD FULLTEXT INDEX bugfts (summary, description);

SELECT *
FROM bug
WHERE MATCH(summary, description) AGAINST('+crash -save' IN BOOLEAN MODE);


## 전치 인덱스 사용

CREATE TABLE keyword
(
    keyword_id BIGINT      NOT NULL PRIMARY KEY,
    keyword    VARCHAR(40) NOT NULL,
    UNIQUE KEY (keyword)
);

CREATE TABLE bug_keyword
(
    bug_id     BIGINT UNSIGNED NOT NULL,
    keyword_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (bug_id, keyword_id),
    FOREIGN KEY (bug_id) REFERENCES bug (bug_id),
    FOREIGN KEY (keyword_id) REFERENCES keyword (keyword_id)
);

CREATE PROCEDURE bug_search(keyword VARCHAR(40))
BEGIN
    SET @keyword = keyword;

    PREPARE s1 FROM 'SELECT MAX(keyword_id) INTO @k FROM keyword WHERE keyword = ?';
    EXECUTE s1 USING @keyword;
    DEALLOCATE PREPARE s1;

    IF (@k IS NULL) THEN
        PREPARE s2 FROM 'INSERT INTO keyword (keyword) VALUES (?)';
        EXECUTE s2 USING @keyword;
        DEALLOCATE PREPARE s2;
        SELECT LAST_INSERT_ID() INTO @k;

        PREPARE s3 FROM '
        INSERT INTO bug_keyword (bug_id, keyword_id)
        SELECT bug_id, ? FROM bug
        WHERE summary REGEXP CONCAT(''[[:<:]]'', ?, ''[[:>:]]'')
            OR description REGEXP CONCAT(''[[:<:]]'', ?, ''[[:>:]]'')
        ';

        EXECUTE s3 USING @k, @keyword, @keyword;
        DEALLOCATE PREPARE s3;

    END IF;

    PREPARE s4 FROM '
    SELECT b.*
    FROM bug b
        JOIN bug_keyword k USING (bug_id)
    WHERE k.keyword_id = ?
    ';
    EXECUTE s4 USING @k;
    DEALLOCATE PREPARE s4;
END;

CREATE TRIGGER bug_insert
    AFTER INSERT
    ON bug
    FOR EACH ROW
BEGIN
    INSERT INTO bug_keyword (bug_id, keyword_id)
    SELECT NEW.bug_id, k.keyword_id
    FROM keyword k
    WHERE NEW.description REGEXP CONCAT('[[:<:]]', k.keyword, '[[:>:]]')
       OR NEW.summary REGEXP CONCAT('[[:<:]]', k.keyword, '[[:>:]]');
END;

CALL bug_search('crash');
