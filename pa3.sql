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

SELECT c.* FROM customer c WHERE c.id = (
    SELECT a.customer_id FROM appointment a
    JOIN services s ON a.service_id = s.id
    WHERE s.name = 'Haircut'
    ORDER BY a.date LIMIT 1
);
UPDATE employee e SET e.salary = e.salary * 1.1 WHERE e.id = (
    SELECT a.employee_id FROM appointment a
    GROUP BY a.employee_id ORDER BY COUNT(a.id) DESC
    LIMIT 1
);

SELECT e.* FROM employee e WHERE e.id IN (SELECT employee_id FROM appointment WHERE date >= '2024-02-14' AND employee_id = e.id);
UPDATE employee e SET e.salary = e.salary * 1.1 WHERE e.id IN (
    SELECT es.employee_id FROM employee_service es
    JOIN services s ON es.service_id = s.id WHERE s.price > 2000
    AND es.employee_id = e.id
);
DELETE FROM services2products sp WHERE sp.product_id IN (SELECT p.id FROM product p WHERE p.id = sp.product_id AND p.name = 'Botox');

SELECT c.* FROM customer c WHERE c.id NOT IN (SELECT a.customer_id FROM appointment a WHERE a.customer_id = c.id);
UPDATE product p SET p.quantity = 0 WHERE p.id NOT IN
    (SELECT sp.product_id FROM services2products sp WHERE sp.product_id = p.id);
DELETE FROM appointment a WHERE a.id NOT IN (SELECT p.appointment_id FROM payment p WHERE p.appointment_id = a.id);

SELECT s.* FROM services s WHERE EXISTS (SELECT 1 FROM appointment a WHERE a.service_id = s.id);
UPDATE services s SET s.price = s.price * 1.1 WHERE EXISTS (SELECT 1 FROM appointment a WHERE a.service_id = s.id);
DELETE FROM services2products sp WHERE EXISTS (SELECT 1 FROM appointment a WHERE a.service_id = sp.service_id);

SELECT p.* FROM product p WHERE NOT EXISTS (SELECT 1 FROM services2products sp WHERE sp.product_id = p.id);
UPDATE employee e SET e.salary = e.salary * 0.8 WHERE NOT EXISTS
    (SELECT 1 FROM employee_service es WHERE es.employee_id = e.id);
DELETE FROM product p WHERE NOT EXISTS (SELECT * FROM services2products sp WHERE sp.product_id = p.id);
