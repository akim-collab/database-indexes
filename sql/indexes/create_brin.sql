CREATE INDEX brin_ind_products_price ON products USING brin (price);

-- Создание brin индекса на колонке signup_date таблицы customers
CREATE INDEX brin_ind_customers_signup_date ON customers USING brin (signup_date);