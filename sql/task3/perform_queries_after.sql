EXPLAIN ANALYZE
SELECT
    p.name,
    COUNT(o.id) AS total_orders,
    SUM(o.total_amount) AS total_revenue
FROM
    products p
JOIN
    orders o ON p.id = o.product_id
WHERE
    p.category = 'Electronics' AND
    o.order_date > '2023-01-01'
GROUP BY
    p.name
ORDER BY
    total_revenue DESC
LIMIT 10;