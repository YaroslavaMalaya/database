INSERT INTO services (name, description, duration, price) VALUES
('Haircut', 'Basic hair cutting service', 30, 600.00),
('Coloring', 'Hair colouring and highlights', 120, 2500.00),
('Manicure', 'Nail care service', 60, 450.00),
('Pedicure', 'Foot and nail care service', 60, 450.00),
('Facial', 'Facial massage with suitable masks, creams and pilings', 90, 1200.00);

INSERT INTO product (name, description, quantity, cost) VALUES
('Shampoo', 'Hair cleaning product', 20, 550.50),
('Conditioner', 'Hair conditioning product', 20, 299.99),
('Nail Polish', 'Nail colouring product', 100, 84.99),
('Hair Dye', 'Product for hair colouring', 50, 789.99),
('Facial Cream 1', 'Cream for facial treatment', 50, 899.99),
('Facial Cream 2', 'Cream for facial treatment', 50, 1000.00);

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
('Kim Kardashian', '+3809501843819', 'kimmi@gmail.com', '1 Travneva St');

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
(11, 5, 4, '2024-02-16 11:00:00', 'Scheduled');

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
