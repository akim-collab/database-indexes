# database-indexes

## Task 2

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


## Task 3

В третьем задании исследуется влияние настройки `autovacuum` на производительность запросов и целостность данных в базе данных PostgreSQL. 
Целью было определить, как отключение автоматической уборки мертвых строк влияет на выполнение запросов.

## Полученные Результаты

### Выполнение Запросов

**До Отключения `autovacuum`:**

```
 Limit  (cost=9168.15..9168.18 rows=10 width=52) (actual time=525.538..525.634 rows=10 loops=1)
   ->  Sort  (cost=9168.15..9174.41 rows=2504 width=52) (actual time=525.536..525.630 rows=10 loops=1)
         Sort Key: (sum(o.total_amount)) DESC
         Sort Method: top-N heapsort  Memory: 26kB
         ->  Finalize HashAggregate  (cost=9082.74..9114.04 rows=2504 width=52) (actual time=514.666..523.436 rows=2504 loops=1)
               Group Key: p.name
               Batches: 1  Memory Usage: 1649kB
               ->  Gather  (cost=8500.56..9032.66 rows=5008 width=52) (actual time=483.252..500.397 rows=7512 loops=1)
                     Workers Planned: 2
                     Workers Launched: 2
                     ->  Partial HashAggregate  (cost=7500.56..7531.86 rows=2504 width=52) (actual time=473.329..478.710 rows=2504 loops=3)
                           Group Key: p.name
                           Batches: 1  Memory Usage: 1393kB
                           Worker 0:  Batches: 1  Memory Usage: 1393kB
```

**После Отключения `autovacuum`:**
```
 Limit  (cost=9168.15..9168.18 rows=10 width=52) (actual time=9332.568..9333.002 rows=10 loops=1)
   ->  Sort  (cost=9168.15..9174.41 rows=2504 width=52) (actual time=9332.487..9332.775 rows=10 loops=1)
         Sort Key: (sum(o.total_amount)) DESC
         Sort Method: top-N heapsort  Memory: 26kB
         ->  Finalize HashAggregate  (cost=9082.74..9114.04 rows=2504 width=52) (actual time=9285.428..9309.530 rows=2504 loops=1)
               Group Key: p.name
               Batches: 1  Memory Usage: 1649kB
               ->  Gather  (cost=8500.56..9032.66 rows=5008 width=52) (actual time=9086.486..9199.871 rows=7512 loops=1)
                     Workers Planned: 2
                     Workers Launched: 2
                     ->  Partial HashAggregate  (cost=7500.56..7531.86 rows=2504 width=52) (actual time=9066.002..9096.889 rows=2504 loops=3)
                           Group Key: p.name
                           Batches: 1  Memory Usage: 1393kB
                           Worker 0:  Batches: 1  Memory Usage: 1393kB
```

### Вероятность Кэш-Попадания

```
 ratio 
-------
0.9964564821341222
(1 row)
```

## Выводы

1. **Влияние `autovacuum`:**
   - **До Отключения:** Запрос выполнялся быстро (~525 мс) благодаря актуальной статистике и отсутствию мертвых строк.
   - **После Отключения:** Время выполнения запроса увеличилось до ~9333 мс, что свидетельствует о негативном влиянии накопления мертвых строк на производительность.

2. **Ручное Выполнение `VACUUM`:**
   - Выполнение `VACUUM ANALYZE` восстановило производительность запросов, возвращая время выполнения к исходным показателям (~525 мс).

3. **Кэш-Попадание:**
   - Высокий `cache hit ratio` (~99.6%) демонстрирует эффективное использование кэша, однако без `autovacuum`
    накопление мертвых строк всё равно негативно сказывается на производительности.