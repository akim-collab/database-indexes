BEGIN;

-- Обновление 100,000 записей
UPDATE orders
SET quantity = quantity + 1, total_amount = total_amount + 10.00
WHERE id <= 100000;

-- Удаление 50,000 записей
DELETE FROM orders
WHERE id > 100000 AND id <= 150000;

COMMIT;