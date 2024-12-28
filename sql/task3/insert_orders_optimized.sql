WITH product_ids AS (
    SELECT ARRAY_AGG(id) AS ids FROM products
),
customer_ids AS (
    SELECT ARRAY_AGG(id) AS ids FROM customers
),
data AS (
    SELECT
        product_ids.ids AS p_ids,
        customer_ids.ids AS c_ids
    FROM product_ids, customer_ids
)
INSERT INTO orders (product_id, customer_id, quantity, total_amount)
SELECT
    p_ids[ceil(random() * array_length(p_ids, 1))::INTEGER],
    c_ids[ceil(random() * array_length(c_ids, 1))::INTEGER],
    (random() * 10)::INTEGER + 1,
    ((random() * 1000)::NUMERIC(10,2))
FROM data, generate_series(1, 500000);