-- Create the department table
CREATE TABLE department (
    dept_num SERIAL PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Insert some arbitrary data into the department table
INSERT INTO department (dept_name) VALUES
('Human Resources'),
('Finance'),
('Engineering'),
('Marketing'),
('Sales'),
('IT'),
('Customer Support');

-- Create the employee table
CREATE TABLE employee (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dept_num INTEGER REFERENCES department(dept_num),
    salary NUMERIC(10, 2)
);

-- Insert some arbitrary data into the employee table
INSERT INTO employee (first_name, last_name, dept_num, salary) VALUES
('John', 'Doe', 1, 60000.00),
('Jane', 'Smith', 2, 65000.00),
('Alice', 'Johnson', 3, 70000.00),
('Bob', 'Brown', 4, 55000.00),
('Charlie', 'Davis', 5, 72000.00),
('Eve', 'Miller', 6, 68000.00),
('Frank', 'Wilson', 7, 50000.00),
('Grace', 'Taylor', 1, 62000.00),
('Hank', 'Anderson', 2, 64000.00),
('Ivy', 'Thomas', 3, 71000.00),
('Jack', 'White', 4, 53000.00),
('Karen', 'Harris', 5, 75000.00),
('Leo', 'Martin', 6, 69000.00),
('Mia', 'Clark', 7, 52000.00),
('Nina', 'Lewis', 1, 63000.00),
('Oscar', 'Walker', 2, 66000.00),
('Paul', 'Hall', 3, 74000.00),
('Quinn', 'Allen', 4, 54000.00);

-- New inserts to test the rank() function.
INSERT INTO employee(first_name, last_name, dept_num, salary) VALUES
('Randy', 'Rogers', 1, 60000.00),
('Sally', 'Simpson', 2, 65000.00),
('Tina', 'Thompson', 3, 70000.00),
('Ulysses', 'Underwood', 4, 55000.00),
('Violet', 'Vance', 5, 72000.00),
('Wendy', 'Wells', 6, 68000.00),
('Xander', 'Xavier', 7, 50000.00),
('Yvonne', 'Young', 1, 62000.00),
('Zach', 'Zimmerman', 2, 64000.00),
('Aaron', 'Adams', 3, 71000.00),
('Brenda', 'Baker', 4, 53000.00),
('Curtis', 'Carter', 5, 75000.00),
('Diane', 'Dixon', 6, 69000.00),
('Evan', 'Edwards', 7, 52000.00),
('Fiona', 'Fisher', 1, 63000.00),
('Gerald', 'Garcia', 2, 66000.00),
('Holly', 'Hernandez', 3, 74000.00),
('Ivan', 'Ingram', 4, 54000.00),
('Jenny', 'Jenkins', 5, 76000.00),
('Kurt', 'Keller', 6, 70000.00),
('Linda', 'Lopez', 7, 51000.00),
('Mason', 'Morgan', 1, 64000.00),
('Nancy', 'Nelson', 2, 67000.00),
('Omar', 'Ortega', 3, 75000.00),
('Pam', 'Perez', 4, 55000.00),
('Quincy', 'Quinn', 5, 77000.00),
('Rita', 'Reed', 6, 71000.00),
('Sam', 'Smith', 7, 52000.00),
('Troy', 'Taylor', 1, 65000.00);