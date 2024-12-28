CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    customer_id INTEGER REFERENCES customers(id),
    order_date DATE DEFAULT CURRENT_DATE,
    quantity INTEGER,
    total_amount NUMERIC(10, 2)
);

CREATE INDEX btree_ind_orders_product_id ON orders USING btree (product_id);
CREATE INDEX btree_ind_orders_customer_id ON orders USING btree (customer_id);
CREATE INDEX brin_ind_orders_order_date ON orders USING brin (order_date);