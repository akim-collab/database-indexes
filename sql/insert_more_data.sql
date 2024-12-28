INSERT INTO products (name, description, price, category, stock_quantity)
SELECT
    'Product ' || gs.i,
    'Description for product ' || gs.i,
    (random() * 1000)::numeric(10,2),
    CASE
        WHEN gs.i % 4 = 0 THEN 'Electronics'
        WHEN gs.i % 4 = 1 THEN 'Home Appliances'
        WHEN gs.i % 4 = 2 THEN 'Accessories'
        ELSE 'Photography'
    END,
    (random() * 100)::integer
FROM generate_series(11, 10010) as gs(i);

-- Генерация дополнительных клиентов
INSERT INTO customers (first_name, last_name, email, address, signup_date)
SELECT
    'FirstName' || gs.i,
    'LastName' || gs.i,
    'user' || gs.i || '@example.com',
    'Address ' || gs.i,
    CURRENT_DATE - (gs.i % 365)
FROM generate_series(11, 10010) as gs(i);