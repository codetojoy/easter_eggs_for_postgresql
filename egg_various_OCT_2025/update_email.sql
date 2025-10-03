
UPDATE teachers
SET email = 'test_' || row_num || '@school.edu'
FROM (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id) as row_num
    FROM teachers
) subquery
WHERE teachers.id = subquery.id;
