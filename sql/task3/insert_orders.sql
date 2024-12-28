INSERT INTO orders (product_id, customer_id, quantity, total_amount)
SELECT
    (SELECT id FROM products ORDER BY random() LIMIT 1),
    (SELECT id FROM customers ORDER BY random() LIMIT 1),
    (random() * 10)::INTEGER + 1,             -- Количество от 1 до 10
    ((random() * 1000)::NUMERIC(10,2))        -- Сумма заказа
FROM generate_series(1, 500000);
