CREATE TABLE appointment_clone LIKE appointment;
CREATE INDEX index_employee_id ON appointment_clone(employee_id);

INSERT INTO appointment_clone (customer_id, service_id, employee_id, date, status)
SELECT customer_id, service_id, employee_id, date, status FROM appointment;

SELECT * FROM appointment WHERE employee_id = 1;
SELECT * FROM appointment_clone WHERE employee_id = 1;
