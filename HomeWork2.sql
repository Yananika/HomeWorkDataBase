CREATE DATABASE homework2;
USE homework2;
CREATE TABLE IF NOT EXISTS sales
(
id INT PRIMARY KEY AUTO_INCREMENT,
order_date DATE NOT NULL,
count_product INT NOT NULL
);

INSERT INTO sales (order_date, count_product)
VALUES
	("2022-01-01", 156),
    ("2022-01-02", 180),
    ("2022-01-03", 21),
    ("2022-01-04", 124),
    ("2022-01-05", 341);
    SELECT * FROM sales;
	SELECT id,
	IF (count_product < 100, "Маленький заказ",
		IF(count_product >= 100 AND count_product < 300, "Средний заказ",
			IF(count_product >= 300, "Большой заказ", "Не определено"))) AS "Тип заказа"
	FROM sales;
     SELECT id, 
    CASE
		WHEN count_product < 100 THEN "Маленький заказ"
        WHEN count_product > 100 AND count_product<300 THEN "Средний заказ"
		WHEN count_product > 300 THEN "Большой заказ"
		ELSE "Не определено"
    END AS "Тип заказа"
    FROM sales;
    CREATE TABLE IF NOT EXISTS orders
(
id INT PRIMARY KEY AUTO_INCREMENT,
employee_id TEXT NOT NULL,
amount DOUBLE NOT NULL,
order_status TEXT NOT NULL
);
INSERT INTO orders (employee_id, amount, order_status)
VALUES
	("e03", 15.00, "OPEN"),
    ("e01", 25.50, "OPEN"),
    ("e05", 100.70, "CLOSED"),
    ("e02", 22.18, "OPEN"),
    ("e04", 9.50, "CANSELLED");
SELECT * FROM orders;
 SELECT id, 
    CASE
		WHEN order_status = "OPEN" THEN "Order is in open state"
        WHEN order_status = "CLOSED" THEN "Order is closed"
        WHEN order_status = "CANSELLED" THEN "Order is cancelled"
		ELSE "NOT FOUND"
    END AS "full_order_status"
    FROM orders;
    SELECT id,
	IF (order_status = "OPEN", "Order is in open state",
		IF(order_status = "CLOSED", "Order is closed",
			IF(order_status = "CANSELLED","Order is cancelled", "NOT FOUND"))) AS "full_order_status"
	FROM orders;
