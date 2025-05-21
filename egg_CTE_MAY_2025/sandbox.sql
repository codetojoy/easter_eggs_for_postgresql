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

