-- with non-correlated subqueries result

-- selects the service with the shortest duration
SELECT * FROM services WHERE duration = (SELECT MIN(duration) FROM services);
-- updates the price to 3000 for the service with the longest duration
UPDATE services SET price = 3000 WHERE duration = (SELECT MAX(duration) FROM (SELECT duration FROM services) AS subquery);
-- deletes the product with the smallest quantity
DELETE FROM product WHERE quantity = (SELECT MIN(quantity) FROM (SELECT quantity FROM product) AS subquery);

-- selects employees who provide the service with ID 1 (Haircut)
SELECT * FROM employee WHERE id IN (SELECT employee_id FROM employee_service WHERE service_id = 1);
-- increases the quantity by 10 for products used in service with ID 2 (Coloring)
UPDATE product SET quantity = quantity + 10 WHERE id IN (SELECT product_id FROM services2products WHERE service_id = 2);
-- deletes payments for appointments of the customer with a specific phone number ('+3809501843819')
DELETE FROM payment WHERE appointment_id IN (
    SELECT id FROM appointment WHERE customer_id IN (SELECT id FROM customer WHERE phone = '+3809501843819'));
-- deletes appointments of the customer with a specific phone number (since we delete it from payment, we should delete it also in appointment)
DELETE FROM appointment WHERE customer_id IN (SELECT id FROM customer WHERE phone = '+3809501843819');

-- selects employees who haven't been assigned to any appointment (it returns a receptionist)
SELECT * FROM employee WHERE id NOT IN (SELECT employee_id FROM appointment);
-- increases the salary by 10% for employees who do not offer services with ID greater than 3
UPDATE employee SET salary = salary * 1.1 WHERE id NOT IN (SELECT employee_id FROM employee_service WHERE service_id > 3);
-- deletes products not linked to any service
DELETE FROM product WHERE id NOT IN (SELECT product_id FROM services2products);

-- selects services that use product ID 3 (Nail Polish)
SELECT * FROM services WHERE EXISTS (SELECT 1 FROM services2products WHERE product_id = 3);
-- increases the price by 10% for services using products priced over 2000
UPDATE services SET price = price * 1.1 WHERE EXISTS (SELECT * FROM product WHERE price > 2000);
-- deletes from services2products where the linked product quantity is 0
DELETE FROM services2products WHERE EXISTS (SELECT 1 FROM product WHERE quantity = 0);

-- selects products not included in any services where use products with ID greater than 7
SELECT * FROM product WHERE NOT EXISTS (SELECT * FROM services2products WHERE product_id > 7);
-- increases the salary by 10% for employees whose phone number is not '+380630768334'
UPDATE employee SET salary = salary * 1.1 WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT * FROM employee) AS subquery WHERE subquery.phone = '+380630768334');
-- deletes products that are not linked to services2products with product ID < 6
DELETE FROM product WHERE NOT EXISTS (SELECT 1 FROM services2products WHERE product_id < 6);

-- with correlated subqueries result

-- selects the first customer who has an appointment for a haircut, ordered by date
SELECT c.* FROM customer c WHERE c.id = (
    SELECT a.customer_id FROM appointment a
    JOIN services s ON a.service_id = s.id
    WHERE s.name = 'Haircut'
    ORDER BY a.date LIMIT 1
);
-- increases the salary by 10% for the employee with the most appointments
UPDATE employee e SET e.salary = e.salary * 1.1 WHERE e.id = (
    SELECT a.employee_id FROM appointment a
    GROUP BY a.employee_id ORDER BY COUNT(a.id) DESC
    LIMIT 1
);

-- selects employees who have an appointment after '2024-02-13'
SELECT e.* FROM employee e WHERE e.id IN (SELECT employee_id FROM appointment WHERE date >= '2024-02-14' AND employee_id = e.id);
-- increases the salary by 10% for employees who provide services priced over 2000
UPDATE employee e SET e.salary = e.salary * 1.1 WHERE e.id IN (
    SELECT es.employee_id FROM employee_service es
    JOIN services s ON es.service_id = s.id WHERE s.price > 2000
    AND es.employee_id = e.id
);
-- deletes product-service links for the 'Botox' product
DELETE FROM services2products sp WHERE sp.product_id IN (SELECT p.id FROM product p WHERE p.id = sp.product_id AND p.name = 'Botox');

-- selects customers who have not made any appointments
SELECT c.* FROM customer c WHERE c.id NOT IN (SELECT a.customer_id FROM appointment a WHERE a.customer_id = c.id);
-- sets product quantity to 0 for products not used in any services
UPDATE product p SET p.quantity = 0 WHERE p.id NOT IN
    (SELECT sp.product_id FROM services2products sp WHERE sp.product_id = p.id);
-- deletes appointments without any payments
DELETE FROM appointment a WHERE a.id NOT IN (SELECT p.appointment_id FROM payment p WHERE p.appointment_id = a.id);

-- selects services that have at least one appointment
SELECT s.* FROM services s WHERE EXISTS (SELECT 1 FROM appointment a WHERE a.service_id = s.id);
-- increases the price by 10% for services that have been chosen at least once
UPDATE services s SET s.price = s.price * 1.1 WHERE EXISTS (SELECT 1 FROM appointment a WHERE a.service_id = s.id);
-- deletes from services2products where the service is linked to at least one appointment
DELETE FROM services2products sp WHERE EXISTS (SELECT 1 FROM appointment a WHERE a.service_id = sp.service_id);

-- selects products that are not included in any service offerings
SELECT p.* FROM product p WHERE NOT EXISTS (SELECT 1 FROM services2products sp WHERE sp.product_id = p.id);
-- reduces the salary by 20% for employees not linked to any service (for the receptionist)
UPDATE employee e SET e.salary = e.salary * 0.8 WHERE NOT EXISTS
    (SELECT 1 FROM employee_service es WHERE es.employee_id = e.id);
-- deletes products not linked to any service
DELETE FROM product p WHERE NOT EXISTS (SELECT * FROM services2products sp WHERE sp.product_id = p.id);

-- for bonus task 3

SELECT user, host FROM mysql.user;
CREATE USER 'yarrochka'@'%' IDENTIFIED BY 'password12345';
GRANT ALL PRIVILEGES ON beauty_salon.* TO 'yarrochka'@'%';
FLUSH PRIVILEGES;

SELECT * FROM services;
