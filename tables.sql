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
