-- HW5

CREATE INDEX index_es_employee_id ON employee_service(employee_id);
CREATE INDEX index_es_service_id ON employee_service(service_id);
CREATE INDEX index_a_employee_id ON appointment(employee_id);
CREATE INDEX index_a_service_id ON appointment(service_id);
CREATE INDEX index_s_id ON services(id);
CREATE INDEX index_e_name ON employee(name);
CREATE INDEX index_a_date ON appointment(date);

CREATE VIEW employee_schedule AS
SELECT
    e.name AS employee_name,
    GROUP_CONCAT(DISTINCT s.name ORDER BY s.id SEPARATOR ', ') AS services_provided,
    CONCAT( DATE_FORMAT(MIN(a.date), '%H:%i'), '-', DATE_FORMAT(MAX(DATE_ADD(a.date, INTERVAL s.duration MINUTE)), '%H:%i')) AS time_from_to,
    CASE
        WHEN 'Haircut' IN (SELECT s2.name FROM employee_service es2 JOIN services s2 ON es2.service_id = s2.id WHERE es2.employee_id = e.id) OR
             'Coloring' IN (SELECT s2.name FROM employee_service es2 JOIN services s2 ON es2.service_id = s2.id WHERE es2.employee_id = e.id)
        THEN 'Hair specialist'
        WHEN 'Manicure' IN (SELECT s2.name FROM employee_service es2 JOIN services s2 ON es2.service_id = s2.id WHERE es2.employee_id = e.id) OR
             'Pedicure' IN (SELECT s2.name FROM employee_service es2 JOIN services s2 ON es2.service_id = s2.id WHERE es2.employee_id = e.id)
        THEN 'Nail technician'
        WHEN 'Facial' IN (SELECT s2.name FROM employee_service es2 JOIN services s2 ON es2.service_id = s2.id WHERE es2.employee_id = e.id)
        THEN 'Cosmetologist'
        ELSE 'General staff'
        END AS kind_of_service
    FROM employee e 
        INNER JOIN employee_service es ON e.id = es.employee_id
        INNER JOIN services s ON es.service_id = s.id
        INNER JOIN appointment a ON e.id = a.employee_id
    WHERE
        DATE(a.date) = CURDATE()
        GROUP BY e.id ORDER BY FIELD(e.position, 'Master', 'Trainee') DESC;

SELECT * FROM employee_schedule;