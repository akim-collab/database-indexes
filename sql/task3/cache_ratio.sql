SELECT
    sum(heap_blks_hit) / (sum(heap_blks_hit) + sum(heap_blks_read))::float as ratio
FROM
    pg_statio_user_tables
WHERE
    relname = 'orders';