DROP DATABASE IF EXISTS homework;
CREATE DATABASE homework;
USE homework;
CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

/* 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов*/ 

CREATE OR REPLACE VIEW cars2 AS
SELECT 
name, cost
FROM cars
WHERE cost <= 25000
WINDOW w AS (PARTITION BY cost); 

SELECT * FROM cars2;

/* 2. Изменить в существующем представлении порог для стоимости: пусть цена будет
 до 30 000 долларов (используя оператор ALTER VIEW)*/
ALTER VIEW cars2 AS
SELECT 
name, cost
FROM cars
WHERE cost <= 30000
WINDOW w AS (PARTITION BY cost);

/* 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)*/

CREATE OR REPLACE VIEW cars3 AS
SELECT 
name, cost
FROM cars
WHERE name = "audi" OR name = "skoda"
WINDOW w AS (PARTITION BY name); 

SELECT * FROM cars3;

/* Доп задания:
1* Получить ранжированный список автомобилей по цене в порядке возрастания*/

SELECT
DENSE_RANK() OVER(ORDER BY cost ASC) `dense_rank`,
name, cost
FROM cars;

/* 2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость*/


SELECT 
name, cost,
SUM(cost) OVER w `sum`
FROM
(SELECT
DENSE_RANK() OVER(ORDER BY cost DESC) `dense_rank`,
name, cost
FROM cars) AS `runk_list`
WHERE  `dense_rank` <= 3
WINDOW w AS (PARTITION BY cost);

/*Не получается вывести общую стоимость*/

/*3* Получить список автомобилей, у которых цена больше предыдущей цены (т.е. у которых произошло повышение цены)*/

CREATE OR REPLACE VIEW cars4 AS
SELECT 
name, cost,
LAG(cost) OVER w `lag`
FROM cars
WINDOW w AS (PARTITION BY cost);
SELECT * FROM cars4;

/* 4* Получить список автомобилей, у которых цена меньше следующей цены (т.е. у которых произойдет снижение цены)*/
CREATE OR REPLACE VIEW cars4 AS
SELECT 
name, cost,
LEAD (cost) OVER w `lead`
FROM cars
WINDOW w AS (PARTITION BY cost);
SELECT * FROM cars4;

/* 5*Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец
 со значением разницы между текущей ценой и ценой следующего автомобиля*/
 
 CREATE OR REPLACE VIEW cars5 AS
 SELECT
 DENSE_RANK() OVER(ORDER BY cost ASC) `dense_rank`,
name, cost,
LEAD (cost) OVER w `lead`,
cost-"lead" AS "Разница"
FROM cars
WINDOW w AS (PARTITION BY name);

SELECT * FROM cars5;

/* Я не совсем поняла доп задания 3 и 4. О каком снижении и повышении 
цены идет речь, если по каждому автомобилю дана только одна цена*.\

/*Также не понимаю как сделать, чтобы lag  и lead  показывали просто предыдущую и следующую строку, 
а у меня выводится NULL, потому что каждый автомоюиль по одному, да?*/