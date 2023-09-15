CREATE TABLE project_history
(
    project_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    year       SMALLINT,
    bug_fixed  INT,
    PRIMARY KEY (project_id, year),
    FOREIGN KEY (project_id) REFERENCES project (project_id)
);
