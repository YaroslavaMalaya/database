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
