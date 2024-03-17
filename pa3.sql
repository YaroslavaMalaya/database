-- with non-correlated subqueries result

SELECT * FROM services WHERE duration = (SELECT MIN(duration) FROM services);
UPDATE services SET price = 3000 WHERE duration = (SELECT MAX(duration) FROM (SELECT duration FROM services) AS subquery);
DELETE FROM product WHERE quantity = (SELECT MIN(quantity) FROM (SELECT quantity FROM product) AS subquery);

SELECT * FROM employee WHERE id IN (SELECT employee_id FROM employee_service WHERE service_id = 1);
UPDATE product SET quantity = quantity + 10 WHERE id IN (SELECT product_id FROM services2products WHERE service_id = 2);
DELETE FROM payment WHERE appointment_id IN (
    SELECT id FROM appointment WHERE customer_id IN (SELECT id FROM customer WHERE phone = '+3809501843819'));
DELETE FROM appointment WHERE customer_id IN (SELECT id FROM customer WHERE phone = '+3809501843819');

SELECT * FROM employee WHERE id NOT IN (SELECT employee_id FROM appointment);
UPDATE employee SET salary = salary * 1.1 WHERE id NOT IN (SELECT employee_id FROM employee_service WHERE service_id > 3);
DELETE FROM product WHERE id NOT IN (SELECT product_id FROM services2products);

SELECT * FROM services WHERE EXISTS (SELECT 1 FROM services2products WHERE product_id = 3);
UPDATE services SET price = price * 1.1 WHERE EXISTS (SELECT * FROM product WHERE price > 2000);
DELETE FROM services2products WHERE EXISTS (SELECT 1 FROM product WHERE quantity = 0);

SELECT * FROM product WHERE NOT EXISTS (SELECT * FROM services2products WHERE product_id > 7);
UPDATE employee SET salary = salary * 1.1 WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT * FROM employee) AS subquery WHERE subquery.phone = '+380630768334');
DELETE FROM product WHERE NOT EXISTS (SELECT 1 FROM services2products WHERE product_id < 6);

-- with correlated subqueries result
