CREATE DATABASE beauty_salon;
USE beauty_salon;

CREATE TABLE services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    duration SMALLINT NOT NULL,
    price DOUBLE(7, 2) NOT NULL
);

CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    quantity SMALLINT NOT NULL,
    cost DOUBLE(7, 2) NOT NULL
);

CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(14) NOT NULL,
    email VARCHAR(255) CHECK (email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
    address VARCHAR(255)
);

CREATE TABLE employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(14) NOT NULL,
    email VARCHAR(255),
    position SET('Master', 'Trainee') NOT NULL,
    salary DOUBLE(7, 2) NOT NULL
);

CREATE TABLE appointment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    service_id INT NOT NULL,
    employee_id INT NOT NULL DEFAULT 5,
    date DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (service_id) REFERENCES services(id),
    FOREIGN KEY (employee_id) REFERENCES employee(id)
);

CREATE TABLE payment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT ,
    amount DOUBLE(10, 2),
    method VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES appointment(id)
);

CREATE TABLE services2products (
    service_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (service_id, product_id),
    FOREIGN KEY (service_id) REFERENCES services(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE TABLE employee_service (
    employee_id INT NOT NULL,
    service_id INT NOT NULL,
    PRIMARY KEY (employee_id, service_id),
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (service_id) REFERENCES services(id)
);

INSERT INTO services (name, description, duration, price) VALUES
('Haircut', 'Basic hair cutting service', 30, 600.00),
('Coloring', 'Hair colouring and highlights', 120, 2500.00),
('Manicure', 'Nail care service', 60, 450.00),
('Pedicure', 'Foot and nail care service', 60, 450.00),
('Facial', 'Facial massage with suitable masks, creams and pilings', 90, 1200.00),
('Forehead botox', 'Botox in the forehead', 60, 2800.00);  -- data for hw3

INSERT INTO product (name, description, quantity, cost) VALUES
('Shampoo', 'Hair cleaning product', 20, 550.50),
('Conditioner', 'Hair conditioning product', 20, 299.99),
('Nail Polish', 'Nail colouring product', 100, 84.99),
('Hair Dye', 'Product for hair colouring', 50, 789.99),
('Facial Cream 1', 'Cream for facial treatment', 50, 899.99),
('Facial Cream 2', 'Cream for facial treatment', 50, 1000.00),
('Botox', 'Botox for forehead (dammy data)', 5, 1800.00),  -- data for hw3
('Botox', 'Botox for forehead (dammy data)', 0, 1200.00);  -- data for hw3

INSERT INTO employee (name, phone, email, position, salary) VALUES
('Emily Carter', '+380664365804', 'emily1997@gmail.com', 'Master', 30000.00), -- stylist and colorist
('Sam Rivera', '+380950561127', 'sam.rivera@gmail.com', 'Master', 45000.00), -- colorist and stylist
('Jordan Flat', '+380657578321', 'jordanflat@gmail.com', 'Trainee', 30000.00), -- manicurist and cosmetologist
('Casey Kim', '+380970746947', 'caseykiki@gmail.com', 'Master', 50000.00), -- cosmetologist 
('Drew Morgan', '+380670768334', 'morgancap@gmail.com', 'Trainee', 25000.00); -- receptionist 

INSERT INTO services2products (service_id, product_id) VALUES
(1, 1),
(1, 2),
(2, 4),
(3, 3),
(4, 3),
(5, 5),
(5, 6);

INSERT INTO employee_service (employee_id, service_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 3),
(3, 4),
(3, 5),
(4, 5);

INSERT INTO customer (name, phone, email, address) VALUES
('Bryce Hall', '+380994568824', 'bryce.hall@gmail.com', '123 Main St'),
('Jane Watson', '+380684515624', 'princess24.smith@gmail.com', '456 Elm St'),
('Alex Johnson', '+380443560814', 'alex.j@gmail.com', '789 Pine St'),
('Chris Lee', '+380636372587', 'chrissleee122@gmail.com', '321 Oak St'),
('Pat Taylor', '+380950501629', 'patnot123@gmail.com', '654 Maple St'),
('Yana Kross', '+380463460822', 'yanakross@gmail.com', '32 Toler St'),
('Angela Pot', '+380676714507', 'angelaa123@gmail.com', '21 Pony St'),
('Kylie Jenner', '+380950501629', 'jennertop@gmail.com', '12 Yamska St'),
('Emma Stoune', '+380993400124', 'emma12345@gmail.com', '91 Wendy St'),
('Robert Patisson', '+380676071506', 'robpat97@gmail.com', '123 Koupline St'),
('Kim Kardashian', '+3809501843819', 'kimmi@gmail.com', '1 Travneva St'),
('Fennis Lorden', '+3809323543819', 'fennis@gmail.com', '12 Gerbers St'); -- data for hw3

INSERT INTO appointment (customer_id, service_id, employee_id, date, status) VALUES
(1, 2, 1, '2024-02-10 10:00:00', 'Scheduled'),
(2, 4, 3, '2024-02-12 12:30:00', 'Scheduled'),
(3, 3, 3, '2024-02-12 12:40:00', 'Scheduled'),
(4, 1, 2, '2024-02-13 09:30:00', 'Scheduled'),
(5, 5, 3, '2024-02-14 15:30:00', 'Scheduled'),
(6, 2, 2, '2024-02-15 10:00:00', 'Scheduled'),
(7, 4, 4, '2024-02-15 11:30:00', 'Scheduled'),
(8, 3, 4, '2024-02-16 12:40:00', 'Scheduled'),
(1, 1, 1, '2024-02-10 12:10:00', 'Scheduled'),
(2, 5, 3, '2024-02-11 11:00:00', 'Scheduled'),
(3, 2, 2, '2024-02-11 10:00:00', 'Scheduled'),
(4, 4, 3, '2024-02-12 12:40:00', 'Scheduled'),
(5, 3, 3, '2024-02-12 11:40:00', 'Scheduled'),
(6, 1, 2, '2024-02-13 10:30:00', 'Scheduled'),
(7, 5, 4, '2024-02-14 10:20:00', 'Scheduled'),
(8, 2, 2, '2024-02-14 10:00:00', 'Scheduled'),
(1, 4, 3, '2024-02-15 17:30:00', 'Scheduled'),
(9, 3, 3, '2024-02-15 10:40:00', 'Scheduled'),
(10, 1, 1, '2024-02-16 13:00:00', 'Scheduled'),
(11, 5, 4, '2024-02-16 11:00:00', 'Scheduled'),
(12, 1, 1, '2024-05-16 13:00:00', 'Scheduled'), -- data for hw3
(12, 5, 4, '2024-05-1 11:00:00', 'Scheduled');  -- data for hw3

INSERT INTO payment (appointment_id, amount, method, date)
SELECT
    a.id,
    s.price,
    'Card',
    a.date
FROM
    appointment a
        JOIN
    services s ON a.service_id = s.id;

-- HW1

-- SHOW TABLES;
-- SELECT * FROM services;
-- SELECT * FROM product;
-- SELECT * FROM customer;
-- SELECT * FROM appointment;
-- SELECT * FROM payment;
-- SELECT * FROM employee;

-- SELECT name, description, price FROM services WHERE price > 1000 ORDER BY price DESC;

-- SELECT services.name, COUNT(*) as appointment_count FROM appointment  
--    JOIN services ON appointment.service_id = services.id WHERE appointment.status = 'Scheduled' -- inner join
--     GROUP BY services.name ORDER BY appointment_count DESC;

-- SELECT customer.name AS customer_name, services.name AS service_name, appointment.date FROM appointment
--     JOIN customer ON appointment.customer_id = customer.id
--     JOIN services ON appointment.service_id = services.id
--     WHERE appointment.status = 'Scheduled' ORDER BY appointment.date ASC LIMIT 5;

-- SELECT name, position, salary FROM employee WHERE salary > 30000 ORDER BY salary DESC;

-- SELECT customer.name, customer.phone, SUM(payment.amount) AS total_spent FROM payment  
--     JOIN customer ON payment.customer_id = customer.id  WHERE MONTH(payment.date) = 2 -- this month
--     GROUP BY payment.customer_id ORDER BY total_spent DESC LIMIT 5;

-- HW2

-- SELECT p.id AS product_id, p.name AS product_name,
--     p.quantity - IFNULL(SUM(s2p.count), 0) AS quantity_left
-- 	FROM product p
-- 	LEFT JOIN (
-- 		SELECT s2p.product_id, COUNT(*) AS count
-- 		FROM services2products s2p
-- 		INNER JOIN appointment a ON s2p.service_id = a.service_id
-- 		GROUP BY s2p.product_id
-- 	) AS s2p ON p.id = s2p.product_id
-- 	GROUP BY p.id;

-- SELECT e.id AS employee_id, e.name AS employee_name, s.name AS service_name, a.date AS start_time,
--     ADDTIME(a.date, SEC_TO_TIME(s.duration * 60)) AS end_time
--     FROM appointment a
--     INNER JOIN employee_service es ON a.employee_id = es.employee_id AND a.service_id = es.service_id
--     INNER JOIN employee e ON a.employee_id = e.id
--     INNER JOIN services s ON a.service_id = s.id
--     WHERE a.date BETWEEN '2024-02-10' AND '2024-02-17'
--     AND s.name = 'Coloring'
--     ORDER BY a.date;

-- index (bonus task)

-- CREATE TABLE appointment_clone LIKE appointment;
-- CREATE INDEX index_employee_id ON appointment_clone(employee_id);

-- INSERT INTO appointment_clone (customer_id, service_id, employee_id, date, status)
-- SELECT customer_id, service_id, employee_id, date, status FROM appointment;

-- SELECT * FROM appointment WHERE employee_id = 1;
-- SELECT * FROM appointment_clone WHERE employee_id = 1;


-- HW3
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
