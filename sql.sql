-- Create Database
CREATE DATABASE testdb
    WITH
    OWNER = postgress
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;


-- Delete Database
DROP DATABASE testdb;

-- Clear Connections to database
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = "testdb"
    AND pid <> pg_backend_pid()


-- Create Table
CREATE TABLE book
(
	book_id int PRIMARY KEY,  -- Первичный, внутренний ключ, уникален внутри таблицы
	title text NOT NULL,
	isbn varchar(32) NOT NULL
);


-- Delete Table
DROP TABLE IF EXISTS my_table_name;


-- INSERT DATA INTO TABLE
INSERT INTO table_name1
VALUES
(1, 'dsds', '23123'),
(2, 'dsdsada', '12312');


-- Выборка данных из таблицы
SELECT *      -- все данные
FROM my_table_name;


-- Изменение таблицы
ALTER TABLE my_table_name
ADD COLUMN  fk_publisher_id;
-- Добавляем ограничения
-- Когда к одной колонке ссылается несколько, называют отношение ,один ко многим,
-- Так же есть многим ко многим, один к одному
ALTER TABLE my_table_name   -- создаем внешний ключ
ADD CONSTRAINT fk_book_publisher FOREIGN KEY (fk_publisher_id) REFERENCES publisher(publisher_id);

-- в многие ко многим всегда создается новая таблица
CONSTRAINT book_author_pkey PRIMARY KEY (book_id, author_id);
--composite key



-- -- -- ВЫБОРКА ДАННЫХ -- -- --
SELECT col_name, col_name1
FROM my_table1

SELECT col_name, col_name1, col3*col4
FROM my_table1


-- Вывод уникальных строк
-- Уникальное сочетание в этих двух колонках
SELECT DISTINCT city, country FROM employees


-- Количество строк в таблице/столбце
SELECT COUNT(DISTINCT(my_collum))
FROM my_table


-- Where
SELECT COUNT( city )
FROM employees
WHERE city = 'London'

SELECT company_name, phone
FROM customers
WHERE city = 'London'

SELECT *
FROM table1
WHERE not condition1 or condition2 and condition3

SELECT *
FROM orders
WHERE freight BETWEEN 20 AND 40
-- WHERE freight >= 20 AND freight <= 40

SELECT *
FROM customers
WHERE COUNTRY IN ('Mexico', 'USA')
--WHERE COUNTRY = 'Mexico' OR COUNTRY = 'USA'


-- Sort
SELECT DISTINCT county
FROM customers
ORDER BY country DESC, price ASC--ПО ВОЗРАСТАНИЮ
                -- DESC - ПО УБЫВАНИЮ

SELECT MIN(order_date)
FROM ORDERS
WHERE ship_city = 'London'
--MAX()
--AVG()-среднее значение
--SUM()


-- Pattern matching with LIKE
-- Поиск значений по заданному шаблону
-- % любой сивол или любое к-во символов
-- _ - 1 любой символ
-- '%John%'  |  '_oh%'
WHERE last_name LIKE '%n'


-- LIMIT
SELECT product_name
FROM products
LIMIT 10  -- выведится 10 строк

-- CHECK on NULL
SELECT ship_city
FROM orders
WHERE ship_city IS NOT NULL

-- GROUP BY группировка
SELECT ship_country, COUNT(*)
FROM orders
WHERE freight > 50
GROUP BY ship_country
ORDER BY COUNT(*) DESC


-- HAVING - пост-фильтр
SELECT categoy_id, SUM(unit_price)
FROM products
WHERE discontinued <> 1
GROUP BY category_id
HAVING SUM(unit_price)
ORDER BY SUM(unit_price) ASC


-- объединение результатов - без повторений
SELECT country
FROM customers
UNION
SELECT country
FROM employees

-- вывод пересечения результатов
SELECT country
FROM customers
INTERSECT
SELECT country
FROM employees

-- исключения
-- в таблице counry есть столько стран, где
-- suppliers не проживают, но они есть в customers
-- _разница_
SELECT country
FROM customers
EXCEPT
SELECT country
FROM suppliers



-- Соединения
-- Вытаскиваем данные из соединений таблиц

-- INNER JOIN
-- Соответствие ключам
-- Выведутся строки, где ключу из левой
-- таблицы соответствует значение из правой
SELECT product_name, company_name
FROM products
INNER JOIN suppliers ON products.supplier_id = supplier.supplier_id
ORDER BY units_in_stock DESC

-- LEFT JOIN  ==  !RIGHT JOIN
-- CROSS JOIN
-- SELF JOIN


SELECT ...
FROM ORDERS -- == INNER JOIN
JOIN order_details USING (order_id)
-- JOIN order_details ON _.order_id = _.order.id


-- ПСЕВДОНИМЫ
SELECT COUNT(*) AS EMPLOYEES_COUNT
FROM EMPLOYEES


