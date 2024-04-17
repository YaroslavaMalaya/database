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
(4, 5);

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
