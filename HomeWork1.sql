CREATE DATABASE homework1;
USE homework1;
CREATE TABLE mobile
(
id INT PRIMARY KEY NOT NULL,
ProductName VARCHAR(30) NOT NULL,
Manufacturer VARCHAR(30) NOT NULL,
ProductCount INT NOT NULL,
price INT NOT NULL
);
SELECT * FROM mobile;
INSERT mobile(id, ProductName, Manufacturer, ProductCount,price )
VALUES
(1, "IPhoneX", "Apple", 3, 76000),
(2, "IPhone8", "Apple", 2, 51000),
(3, "GalaxyS9", "Samsung", 2, 56000),
(4, "GalaxyS8", "Samsung", 1, 41000),
(5, "P20Pro", "Huawei", 5, 36000);
SELECT * FROM mobile;
SELECT * FROM mobile 
WHERE ProductCount > 2;
SELECT * FROM mobile 
WHERE Manufacturer = "Samsung";