CREATE INDEX btree_ind_products_name ON products USING btree (name);

-- Создание btree индекса на колонке email таблицы customers
CREATE INDEX btree_ind_customers_email ON customers USING btree (email);