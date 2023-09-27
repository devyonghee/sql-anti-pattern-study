SELECT *
FROM bug;

INSERT INTO account
VALUES (1, 'Fran', 'image');


SELECT b.*, a.first_name, a.email
FROM bug b
         JOIN account a ON (b.reported_by = a.account_id);

