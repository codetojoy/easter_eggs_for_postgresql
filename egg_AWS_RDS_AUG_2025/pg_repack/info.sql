

SELECT COUNT(*) FROM book;

SELECT
    pg_size_pretty (
        pg_total_relation_size ('book')
    ) size;

SELECT
    pg_size_pretty (
        pg_database_size ('my_sandbox_2025_08_02')
    ) size;

SELECT * FROM pgstattuple('book');
