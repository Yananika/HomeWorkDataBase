USE lesson_5;

/* 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. 
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/

delimiter //
CREATE PROCEDURE times(seconds INT)
BEGIN
    DECLARE days INT default 0;
    DECLARE hours INT default 0;
    DECLARE minutes INT default 0;

    WHILE seconds >= 84600 DO
    SET days = seconds / 84600;
    SET seconds = seconds % 84600;
    END WHILE;

    WHILE seconds >= 3600 DO
    SET hours = seconds / 3600;
    SET seconds = seconds % 3600;
    END WHILE;

    WHILE seconds >= 60 DO
    SET minutes = seconds / 60;
    SET seconds = seconds % 60;
    END WHILE;

SELECT days, hours, minutes, seconds;
END //
delimiter ;

CALL times(1234567);
/* Через функцию пыталась, но не получилось(((*/
delimiter //
DROP FUNCTION times;
CREATE FUNCTION times(seconds INT)
RETURNS CHAR(100)
DETERMINISTIC
BEGIN
    DECLARE days INT default 0;
    DECLARE hours INT default 0;
    DECLARE minutes INT default 0;
	DECLARE result VARCHAR(50) DEFAULT ' ';

    WHILE seconds >= 84600 DO
	days = seconds / 84600;
    SET seconds = seconds % 84600;
    SET result = CONCAT(days, "дней");
  	END WHILE;
	RETURN result;
    
    WHILE seconds >= 3600 DO
    SET hours = seconds / 3600;
    SET seconds = seconds % 3600;
    SET result = CONCAT(days, "дней", hours, "часов");
    END WHILE;
    RETURN result;

    WHILE seconds >= 60 DO
    SET minutes = seconds / 60;
    SET seconds = seconds % 60;
    SET result=CONCAT(days, "дней", hours, "часов", minutes, "минут", seconds, "секунд");
    END WHILE;
    RETURN result;
END //
delimiter ;

SELECT times(123456);

/* 2. Создайте процедуру которая, выводит только четные числа от 1 до 10. 
Пример: 2,4,6,8,10 
*/
delimiter //
CREATE PROCEDURE numbers()
BEGIN
    DECLARE n INT default 0;
    DROP TABLE IF EXISTS nums;
    CREATE TABLE nums (n INT);

    WHILE n < 10 DO
    SET n = n + 2;
    INSERT INTO nums VALUES(n);
    END WHILE;

SELECT * FROM nums;
END //
delimiter ;

CALL numbers;
