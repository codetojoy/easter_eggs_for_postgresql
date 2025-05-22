-- udemy course: bootcamp

-- e.g. 1
WITH num AS (
	select * from generate_series(1,10)
)
select * from num;

-- e.g. 2
with director_cte as (
select * from movies m
join directors d on d.director_id = m.director_id
where d.director_id = 1
)
select * from director_cte;

-- e.g. 3
with cte_movie_length as (
select 	movie_name, 
		movie_length, 
		(
			CASE
				WHEN movie_length < 100 THEN 'short'
				WHEN movie_length < 120 THEN 'moderate'
				ELSE 'long' 
			END
		) as m_length_desc
from movies 
)
select * from cte_movie_length where m_length_desc = 'long'
order by movie_length desc;

-- e.g. 4.1

WITH my_cte AS (
SELECT 
m.director_id,
(COALESCE(mr.revenues_domestic,0) + COALESCE(mr.revenues_international,0)) AS revenue 
FROM movies_revenues mr
JOIN movies m ON m.movie_id = mr.movie_id
)
select 
d.last_name,
d.first_name,
SUM(my_cte.revenue)
from my_cte 
JOIN directors d on d.director_id = my_cte.director_id
GROUP BY d.last_name, d.first_name
ORDER BY SUM(my_cte.revenue) DESC

-- e.g. 5.1 

WITH RECURSIVE series (list_num) AS
(
	-- non-recursive
	SELECT 10
	UNION ALL
	-- recursive
	SELECT list_num + 5 FROM series
	WHERE list_num + 5 <= 50
)
SELECT list_num from series;

-- e.g. 5.2
-- see https://neon.tech/postgresql/postgresql-tutorial/postgresql-recursive-query

CREATE TABLE items (
	pk SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	parent INT
);

INSERT INTO items (pk, name, parent) VALUES
(1, 'Classical', 0),
(2, 'Romantic', 0),
(3, 'Mozart', 1),
(4, 'Brahms', 2);

select * from items;

WITH RECURSIVE cte_tree AS
(
	-- non-recursive
	SELECT name, pk, 1 as tree_level from items where parent = 0
	UNION ALL
	-- recursive
	SELECT 
	cte.name || ' -> ' || i.name,
	i.pk,
	cte.tree_level + 1
	FROM items i
	JOIN cte_tree cte on cte.pk = i.parent
)
SELECT tree_level, name from cte_tree;
