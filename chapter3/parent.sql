CREATE TABLE comment
(
    comment_id BIGINT UNSIGNED PRIMARY KEY,
    parent_id  BIGINT UNSIGNED,
    comment    TEXT NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES comment (comment_id)
);
