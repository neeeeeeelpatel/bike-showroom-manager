CREATE TABLE customer
(
c_username VARCHAR(20) PRIMARY KEY,
f_name VARCHAR(20),
l_name VARCHAR(20),
c_phone BIGINT(12),
email VARCHAR(30),
c_dob DATE,
c_password VARCHAR(20)
) ; 

CREATE TABLE admin
(
a_username VARCHAR(20) PRIMARY KEY,
f_name VARCHAR(20),
l_name VARCHAR(20),
a_phone BIGINT(12),
email VARCHAR(30),
a_dob DATE,
password VARCHAR(20)
) ;

CREATE TABLE company
 (
 cmp_logo VARCHAR(200),
 cmp_name VARCHAR(20) PRIMARY KEY,
 cmp_email VARCHAR(20),
 no_of_bikes INT(200) DEFAULT 0,
 cmp_address VARCHAR(200),
 cmp_desc VARCHAR(1000)
 ) ;


 CREATE TABLE bikes
(
bike_photo VARCHAR(200),
bike_no INT(20) PRIMARY KEY,
type VARCHAR(20),
bike_name VARCHAR(20),
availability VARCHAR(20),
company VARCHAR(20),
price INT(20),
description VARCHAR(300),
FOREIGN KEY (company) REFERENCES company(cmp_name) ON DELETE 
CASCADE
) ;

CREATE TABLE bookings
(
bike_photo VARCHAR(200),
c_username VARCHAR(20),
booking_id VARCHAR(20) PRIMARY KEY,
bike_no INT,
bike_name VARCHAR(20),
final_price INT(20),
FOREIGN KEY (c_username) REFERENCES customer(c_username) ON DELETE 
CASCADE,
FOREIGN KEY (bike_no) REFERENCES bikes(bike_no) ON DELETE CASCADE
);


-- Inserting sample data into the customer table
INSERT INTO customer (c_username, f_name, l_name, c_phone, email, c_dob, c_password)
VALUES
('john_doe', 'John', 'Doe', 1234567890, 'john@example.com', '1990-01-01', 'password1'),
('jane_smith', 'Jane', 'Smith', 9876543210, 'jane@example.com', '1995-05-15', 'password2'),
('sam_wilson', 'Sam', 'Wilson', 5551234567, 'sam@example.com', '1985-08-20', 'password3'),
('sara_walker', 'Sara', 'Walker', 9998887777, 'sara@example.com', '1988-12-10', 'password4'),
('mike_jones', 'Mike', 'Jones', 7778889999, 'mike@example.com', '1992-04-30', 'password5');

-- Assertions and constraints for the customer table
-- Assertion: Ensure that the email addresses are unique
ALTER TABLE customer ADD CONSTRAINT unique_email UNIQUE (email);

-- Inserting sample data into the admin table
INSERT INTO admin (a_username, f_name, l_name, a_phone, email, a_dob, password)
VALUES
('admin1', 'Admin', 'One', 1112223333, 'admin1@example.com', '1980-03-10', 'admin_password1'),
('admin2', 'Admin', 'Two', 4445556666, 'admin2@example.com', '1975-11-25', 'admin_password2'),
('admin3', 'Admin', 'Three', 7778889999, 'admin3@example.com', '1988-09-15', 'admin_password3'),
('admin4', 'Admin', 'Four', 9998887777, 'admin4@example.com', '1982-07-05', 'admin_password4'),
('admin5', 'Admin', 'Five', 6665554444, 'admin5@example.com', '1970-05-20', 'admin_password5');

-- Assertions and constraints for the admin table
-- Assertion: Ensure that the admin usernames are unique
ALTER TABLE admin ADD CONSTRAINT unique_a_username UNIQUE (a_username);

-- Inserting sample data into the company table
INSERT INTO company (cmp_logo, cmp_name, cmp_email, no_of_bikes, cmp_address, cmp_desc)
VALUES
('logo1.jpg', 'Company A', 'companyA@example.com', 10, '123 Street, City A', 'Description for Company A'),
('logo2.jpg', 'Company B', 'companyB@example.com', 5, '456 Road, City B', 'Description for Company B'),
('logo3.jpg', 'Company C', 'companyC@example.com', 15, '789 Avenue, City C', 'Description for Company C'),
('logo4.jpg', 'Company D', 'companyD@example.com', 20, '101 Park, City D', 'Description for Company D'),
('logo5.jpg', 'Company E', 'companyE@example.com', 8, '222 Lane, City E', 'Description for Company E');

-- Assertions and constraints for the company table
-- Constraint: Ensure that the company name is unique
ALTER TABLE company ADD CONSTRAINT unique_cmp_name UNIQUE (cmp_name);

-- Inserting sample data into the bikes table
INSERT INTO bikes (bike_photo, bike_no, type, bike_name, availability, company, price, description)
VALUES
('bike1.jpg', 1, 'Mountain', 'Mountain Bike', 'Available', 'Company A', 500, 'Description for Mountain Bike 1'),
('bike2.jpg', 2, 'Road', 'Road Bike', 'Available', 'Company B', 600, 'Description for Road Bike 2'),
('bike3.jpg', 3, 'Hybrid', 'Hybrid Bike', 'Available', 'Company C', 700, 'Description for Hybrid Bike 3'),
('bike4.jpg', 4, 'BMX', 'BMX Bike', 'Available', 'Company D', 400, 'Description for BMX Bike 4'),
('bike5.jpg', 5, 'Electric', 'Electric Bike', 'Available', 'Company E', 800, 'Description for Electric Bike 5');

-- Assertions and constraints for the bikes table
-- Constraint: Ensure that the bike numbers are unique
ALTER TABLE bikes ADD CONSTRAINT unique_bike_no UNIQUE (bike_no);

-- Inserting sample data into the bookings table
INSERT INTO bookings (bike_photo, c_username, booking_id, bike_no, bike_name, final_price)
VALUES
('bike1.jpg', 'john_doe', 'booking1', 1, 'Mountain Bike', 500),
('bike2.jpg', 'jane_smith', 'booking2', 2, 'Road Bike', 600),
('bike3.jpg', 'sam_wilson', 'booking3', 3, 'Hybrid Bike', 700),
('bike4.jpg', 'sara_walker', 'booking4', 4, 'BMX Bike', 400),
('bike5.jpg', 'mike_jones', 'booking5', 5, 'Electric Bike', 800);

-- Assertions and constraints for the bookings table
-- Constraint: Ensure that the booking IDs are unique
ALTER TABLE bookings ADD CONSTRAINT unique_booking_id UNIQUE (booking_id);

-- Trigger to increment the no_of_bikes attribute of company table by 1 when a bike information is added to the bikes table.
CREATE TRIGGER add_bike
AFTER INSERT ON bikes
FOR EACH ROW
UPDATE company 
SET no_of_bikes =no_of_bikes+1
WHERE cmp_name = new.company;


-- Trigger to decrement the no_of_bikes attribute of company table by 1 when a bike information is removed from the bikes table.
CREATE TRIGGER remove_bike
AFTER DELETE ON bikes
FOR EACH ROW
UPDATE company 
SET no_of_bikes = no_of_bikes-1
WHERE cmp_name = old.company;

--STORED PROCEDURE.
DELIMITER //
CREATE PROCEDURE ViewBookings()
BEGIN
SELECT * FROM `bookings`;
END;
//
DELIMITER ;
