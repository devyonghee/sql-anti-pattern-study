## entity-attribute-value 설계

CREATE TABLE issue
(
    issue_id BIGINT UNSIGNED NOT NULL PRIMARY KEY
);

INSERT INTO issue (issue_id)
VALUES (1234);

CREATE TABLE issue_attribute
(
    issue_id        BIGINT UNSIGNED NOT NULL,
    attribute_name  VARCHAR(100)    NOT NULL,
    attribute_value VARCHAR(100),
    PRIMARY KEY (issue_id, attribute_name),
    FOREIGN KEY (issue_id) REFERENCES issue (issue_id)
);

INSERT INTO issue_attribute (issue_id, attribute_name, attribute_value)
VALUES (1234, 'product', '1'),
       (1234, 'date_reported', '2023-01-01'),
       (1234, 'status', 'NEW'),
       (1234, 'description', 'Saving does not work'),
       (1234, 'reported_by', 'Bill'),
       (1234, 'version_affected', '1.0'),
       (1234, 'serverity', 'loss of functionality'),
       (1234, 'priority', 'high');

## 속성 조회

SELECT issue_id, attribute_value
FROM issue_attribute
WHERE attribute_name = 'date_reported';

## 속성 이름이 다른 경우 날짜별 버그 수 세기

SELECT date_reported, COUNT(*) AS bugs_per_date
FROM (SELECT DISTINCT issue_id, attribute_value AS date_reported
      FROM issue_attribute
      WHERE attribute_name IN ('date_reported', 'report_date')) AS issue_date_reported
GROUP BY date_reported;

## 행 재구성하기 (각 속성이 행 하나로 표현되도록)

SELECT i.issue_id,
       i1.attribute_value AS date_reported,
       i2.attribute_value AS status,
       i3.attribute_value AS priority,
       i4.attribute_value AS description
FROM issue i
         LEFT JOIN issue_attribute i1 ON i.issue_id = i1.issue_id AND i1.attribute_name = 'date_reported'
         LEFT JOIN issue_attribute i2 ON i.issue_id = i2.issue_id AND i2.attribute_name = 'status'
         LEFT JOIN issue_attribute i3 ON i.issue_id = i3.issue_id AND i3.attribute_name = 'priority'
         LEFT JOIN issue_attribute i4 ON i.issue_id = i4.issue_id AND i4.attribute_name = 'description'
WHERE i.issue_id = 1234;


SELECT issue_id, MAX(date_reported), MAX(status), MAX(priority), MAX(description)
FROM (SELECT issue_id,
             CASE WHEN attribute_name = 'date_reported' THEN attribute_value END AS date_reported,
             CASE WHEN attribute_name = 'status' THEN attribute_value END        AS status,
             CASE WHEN attribute_name = 'priority' THEN attribute_value END      AS priority,
             CASE WHEN attribute_name = 'description' THEN attribute_value END   AS description
      FROM issue_attribute
      WHERE issue_id = 1234) AS attribute
GROUP BY issue_id;
