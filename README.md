# database-indexes

В данном проекте проведено исследование различных типов индексов (`btree`, `hash`, `brin`) в PostgreSQL 
на примере базы данных интернет-магазина. Целью было создание индексов, измерение их размеров и анализ эффективности.

### Размеры Индексов

```
         indexname            |  size
--------------------------------+--------
 products_pkey                  | 240 kB
 customers_pkey                 | 456 kB
 customers_email_key            | 1376 kB
 btree_ind_products_name        | 536 kB
 btree_ind_customers_email      | 1376 kB
 hash_ind_customers_email       | 600 kB
 brin_ind_products_price        | 24 kB
 brin_ind_customers_signup_date | 24 kB
(8 rows)
```

## Выводы

1. **B-Tree Индексы:**
   - Универсальные и эффективны для различных типов запросов.
   - Занимают значительный объём памяти при увеличении данных.

2. **Hash Индексы:**
   - Оптимизированы для операций равенства.
   - Занимают больше памяти по сравнению с B-Tree индексами при схожем объёме данных.

3. **BRIN Индексы:**
   - Эффективны для больших таблиц с линейным распределением данных.
   - Занимают минимальный объём памяти, но менее точны.

4. **Bloom-Фильтр (Теоретический Анализ):**
   - При выбранных параметрах вероятность коллизии составляет 1.5%, что является низким показателем.
   - Подходит для быстрого предварительного фильтра поиска с допустимым уровнем ложных срабатываний.