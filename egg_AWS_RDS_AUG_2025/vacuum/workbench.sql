
select version();

delete from book;
select count(*) from book;
select * from book limit 10;
select deleted, count(*) from book group by deleted order by count(*) desc;