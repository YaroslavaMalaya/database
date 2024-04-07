-- HW4

DELIMITER $$
CREATE PROCEDURE product_details_by_name(IN product_name VARCHAR(255))
BEGIN
SELECT name, description, quantity, cost FROM product WHERE name = product_name;
END $$

CREATE PROCEDURE total_income_from_payments(OUT total INT)
BEGIN
SELECT SUM(amount) INTO total FROM payment;
END $$

CREATE PROCEDURE update_total_income_by_dates(INOUT total_income INT, IN start_date DATE, IN end_date DATE)
BEGIN
    DECLARE sales INT DEFAULT 0;
SELECT SUM(amount) INTO sales FROM payment WHERE date BETWEEN start_date AND end_date;
SET total_income = total_income + sales;
END $$

CREATE PROCEDURE update_product_quantity(IN prod_id INT, IN quantity_minus INT)
BEGIN
    DECLARE new_quantity INT;

START TRANSACTION;

UPDATE product SET quantity = quantity - quantity_minus WHERE id = prod_id;
SELECT quantity INTO new_quantity FROM product WHERE id = prod_id;

IF new_quantity < 0 THEN
        ROLLBACK;
ELSE
        COMMIT;
END IF;

SELECT name, quantity FROM product;
END $$
DELIMITER ;