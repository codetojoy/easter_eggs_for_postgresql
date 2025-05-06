

SELECT COUNT(*) FROM book;

SELECT
    pg_size_pretty (
        pg_total_relation_size ('book')
    ) size;

SELECT
    pg_size_pretty (
        pg_database_size ('2025-05-vacuum-sandbox')
    ) size;

