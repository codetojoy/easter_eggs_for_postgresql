
DROP TABLE IF EXISTS account;

CREATE TABLE account( account_id bigint NOT NULL,
username VARCHAR(256) NOT NULL,
status VARCHAR(256)
);

INSERT INTO account (account_id, username, status) VALUES (5150,'Mozart','Legend'); 
