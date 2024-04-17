# Beauty Salon Database Project

## Generic Information

This project contains the MySQL database and associated scripts for a beauty salon management system. 
The database tracks services, products, customers, employees, appointments, and payments.

## Project Structure

- `pa1/`: Contains the database schema and inserts of the data.
- `pa2/`: Includes many-to-many relationships for services to products and employee to service.
- `pa3/`: Contains non-correlated subqueries and correlated subqueries.
- `pa4/`: Includes stored procedures with IN/OUT/INOUT parameters and also includes a transaction.
- `pa5/`: Contains view that describes schedule for employees for a specific date. 
- `research/`: Contains research presentation.
- `README.md`: Documentation for the project.

## How to Deploy the Project

To deploy the beauty salon database, follow these steps:

1. Ensure that you have MySQL server installed on your local machine. You can download it from the official MySQL [download page](https://dev.mysql.com/downloads/mysql/).
2. Clone the repository using git. Open your terminal or command prompt and run the following command:\
   ``` git clone https://github.com/YaroslavaMalaya/database.git ```
3. After cloning the repository, navigate to the cloned directory: ` cd database `
4. Then, move into the `pa1/` directory where the schema SQL scripts are located: `cd pa1 `
5. Execute the `schema.sql` script on your MySQL server to create your database and tables.
6. After creating the schema, you can proceed to the `pa2/` directory to run any additional CRUD operation scripts provided in the project.

## How to Run Bonus Tasks

For running bonus tasks that require Python:

1. Ensure you have Python installed on your system. Python can be downloaded from the official [Python website](https://www.python.org/downloads/).
2. Navigate to the directory containing the Python script for the bonus task: ` cd pa3/bonus `
3. Run the Python script using the following command: `python3 main.py`

## Author Information

- **Name**: Mala Yaroslava
- **Email**: ymala@kse.org.ua
- **LinkedIn**: [Mala Yaroslava](https://www.linkedin.com/in/%D1%8F%D1%80%D0%BE%D1%81%D0%BB%D0%B0%D0%B2%D0%B0-%D0%BC%D0%B0%D0%BB%D0%B0-0a08a62b5/)

## Additional Information

- Make sure to keep your database credentials secure.
- Always backup your database before running new scripts that alter the data structure.
