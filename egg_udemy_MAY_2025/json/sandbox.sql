
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
