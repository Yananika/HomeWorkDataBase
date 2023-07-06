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
name
FROM cars;

/* 2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость*/


SELECT name, 
sum(cost) over() FROM 
( SELECT name, cost FROM cars ORDER BY cost DESC LIMIT 3) AS table_1;


/*3* Получить список автомобилей, у которых цена больше предыдущей цены (т.е. у которых произошло повышение цены)*/

SELECT name FROM 
(SELECT name, cost, 
LAG(cost) OVER() lag 
FROM cars) 
AS table_2 WHERE cost > lag;

/* 4* Получить список автомобилей, у которых цена меньше следующей цены (т.е. у которых произойдет снижение цены)*/
SELECT name 
FROM
 (SELECT name, cost,
 LEAD(cost) OVER() lead
 FROM cars) AS table_2 
 WHERE cost < lead;
/* 5*Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец
 со значением разницы между текущей ценой и ценой следующего автомобиля*/
 
SELECT name, cost, 
cost-lead "Разница с ценой предыдущего авто"
FROM(SELECT name, cost, LEAD(cost) OVER(ORDER BY cost) lead 
FROM cars) table_3;

SELECT * FROM cars5;

 
