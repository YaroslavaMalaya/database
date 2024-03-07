-- HW1

SHOW TABLES;
SELECT * FROM services;
SELECT * FROM product;
SELECT * FROM customer;
SELECT * FROM appointment;
SELECT * FROM payment;
SELECT * FROM employee;

SELECT name, description, price FROM services WHERE price > 1000 ORDER BY price DESC;

SELECT services.name, COUNT(*) as appointment_count FROM appointment  
    JOIN services ON appointment.service_id = services.id WHERE appointment.status = 'Scheduled' -- inner join
    GROUP BY services.name ORDER BY appointment_count DESC;

SELECT customer.name AS customer_name, services.name AS service_name, appointment.date FROM appointment
    JOIN customer ON appointment.customer_id = customer.id
    JOIN services ON appointment.service_id = services.id
    WHERE appointment.status = 'Scheduled' ORDER BY appointment.date ASC LIMIT 5;

SELECT name, position, salary FROM employee WHERE salary > 30000 ORDER BY salary DESC;

SELECT customer.name, customer.phone, SUM(payment.amount) AS total_spent FROM payment  
    JOIN customer ON payment.customer_id = customer.id  WHERE MONTH(payment.date) = 2 -- this month
    GROUP BY payment.customer_id ORDER BY total_spent DESC LIMIT 5;

-- HW2

SELECT p.id AS product_id, p.name AS product_name,
    p.quantity - IFNULL(SUM(s2p.count), 0) AS quantity_left
    FROM product p
    LEFT JOIN (
        SELECT s2p.product_id, COUNT(*) AS count
        FROM services2products s2p
        INNER JOIN appointment a ON s2p.service_id = a.service_id
        GROUP BY s2p.product_id
    ) AS s2p ON p.id = s2p.product_id
    GROUP BY p.id;


SELECT e.id AS employee_id, e.name AS employee_name, s.name AS service_name, a.date AS start_time,
    ADDTIME(a.date, SEC_TO_TIME(s.duration * 60)) AS end_time
    FROM appointment a
    INNER JOIN employee_service es ON a.employee_id = es.employee_id AND a.service_id = es.service_id
    INNER JOIN employee e ON a.employee_id = e.id
    INNER JOIN services s ON a.service_id = s.id
    WHERE a.date BETWEEN '2024-02-10' AND '2024-02-17'
    AND s.name = 'Coloring'
    ORDER BY a.date;
