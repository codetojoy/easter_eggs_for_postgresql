

-- SELECT 
-- book_id, deleted, author, title,
-- to_char(created_on, 'Mon-DD HH24:MI:SS') as created_on,
-- to_char(updated_on, 'Mon-DD HH24:MI:SS') as updated_on,
-- SUBSTRING(excerpt, 1, 10) as excerpt	 
-- FROM book 
-- ORDER BY book_id asc;

SELECT COUNT(*) FROM book;

SELECT
    pg_size_pretty (
        pg_total_relation_size ('book')
    ) size;

SELECT
    pg_size_pretty (
        pg_database_size ('2025-05-vacuum-sandbox')
    ) size;

