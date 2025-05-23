
select director_id, count(*) from movies
group by director_id
order by count(*) desc;

-- e.g. vid 238
select 
director_id,
last_name,
first_name,
(
	select json_agg(x) as all_movies FROM 
	(
		select movie_name from movies where director_id = directors.director_id
	) as x
)
from directors
order by director_id desc;

-- e.g. vid 247

select count(*) from contacts_docs;
select * from contacts_docs limit 5;

-- query
select count(*) from contacts_docs
where body @> '{"first_name":"John"}'

-- explain query
explain analyze select count(*) from contacts_docs
where body @> '{"first_name":"John"}'

-- create index
CREATE INDEX IF NOT EXISTS idx_contacts_docs_body ON contacts_docs USING GIN(body);

-- create index v2
CREATE INDEX IF NOT EXISTS idx_contacts_docs_body_v2 ON contacts_docs USING GIN(body jsonb_path_ops);

-- size
SELECT pg_size_pretty(pg_relation_size('idx_contacts_docs_body'::regclass)) as index_size
SELECT pg_size_pretty(pg_relation_size('idx_contacts_docs_body_v2'::regclass)) as index_size