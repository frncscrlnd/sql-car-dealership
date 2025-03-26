DROP DATABASE IF EXISTS Dealerships;
CREATE DATABASE Dealerships;
USE Dealerships;

CREATE TABLE Dealership(
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    d_name VARCHAR(150) NOT NULL,
    address VARCHAR(150) NOT NULL
);

CREATE TABLE Manufacturer(
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    m_name VARCHAR(150) NOT NULL
);

CREATE TABLE Sales(
	id INT(10) PRIMARY KEY AUTO_INCREMENT,
    customer VARCHAR(150) NOT NULL,
    amount INT(10) NOT NULL,
    dealership_id INT(10),
    manufacturer_id INT(10),
    chassis_number VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (dealership_id) REFERENCES Dealership(id) ON DELETE CASCADE,
    FOREIGN KEY (manufacturer_id) REFERENCES Manufacturer(id) ON DELETE CASCADE
);

CREATE TABLE Model(
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    manufacturer_id INT(10),
    m_name VARCHAR(150) NOT NULL,
    FOREIGN KEY (manufacturer_id) REFERENCES Manufacturer(id) ON DELETE CASCADE
);

CREATE TABLE Vehicle(
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    model_id INT(10),
    dealership_id INT(10),
    v_name VARCHAR(150) NOT NULL,
    chassis_number VARCHAR(50) NOT NULL UNIQUE,
    color VARCHAR(50) NOT NULL,
    FOREIGN KEY (model_id) REFERENCES Model(id) ON DELETE CASCADE,
    FOREIGN KEY (dealership_id) REFERENCES Dealership(id) ON DELETE CASCADE
);

CREATE TABLE LicensePlate(
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT(10),
    plate VARCHAR(50) UNIQUE NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(id) ON DELETE CASCADE
);

INSERT INTO Dealership (d_name, address) VALUES 
('AutoLuxury Milano', 'Via Montenapoleone 5, Milan'),
('SuperAuto Roma', 'Via del Corso 120, Rome'),
('SpeedCar Torino', 'Corso Vittorio Emanuele 80, Turin');

INSERT INTO Manufacturer (m_name) VALUES 
('Ferrari'),
('BMW'),
('Tesla'),
('Toyota');

INSERT INTO Model (m_name, manufacturer_id) VALUES 
('Ferrari SF90', 1),
('BMW X5', 2),       
('Tesla Model 3', 3), 
('Toyota Yaris', 4);  

INSERT INTO Vehicle (v_name, chassis_number, color, model_id, dealership_id) VALUES 
('Ferrari SF90 Stradale', 'CHS1234567', 'Red', 1, 1),  
('BMW X5 M Sport', 'CHS9876543', 'Black', 2, 2),      
('Tesla Model 3 Long Range', 'CHS5678901', 'White', 3, 1),
('Toyota Yaris Hybrid', 'CHS4321098', 'Blue', 4, 3);

INSERT INTO LicensePlate (vehicle_id, plate) VALUES 
(1, 'AB123CD'),  
(2, 'EF456GH'),  
(3, 'IJ789KL'),
(4, 'MN012OP');

INSERT INTO Sales (customer, amount, dealership_id, manufacturer_id, chassis_number) VALUES
('Mario Rossi', 250000, 1, 1, 'CHS1234567'),  
('Luca Bianchi', 80000, 2, 2, 'CHS9876543'),  
('Giulia Verdi', 55000, 1, 3, 'CHS5678901'), 
('Alessandro Neri', 25000, 3, 4, 'CHS4321098'); 

-- Show all the dealerships a vehicle is sold in based on its' license plate
SELECT  LicensePlate.plate AS license_plate, Vehicle.v_name, Vehicle.chassis_number, Vehicle.color, model.m_name AS model, Manufacturer.m_name AS manufacturer, Dealership.d_name AS dealership, Dealership.address AS address
FROM LicensePlate
JOIN Vehicle ON LicensePlate.vehicle_id = Vehicle.id
JOIN Model ON Vehicle.model_id = Model.id
JOIN Manufacturer ON Model.Manufacturer_id = Manufacturer.id
JOIN Dealership ON Vehicle.dealership_id = Dealership.id;

-- Show all bought cars
SELECT Sales.id AS sale_id, Sales.customer, Sales.amount, Sales.chassis_number, Dealership.d_name AS dealership, Dealership.address AS dealership_address, Manufacturer.m_name AS manufacturer
FROM Sales
JOIN Dealership ON Sales.dealership_id = Dealership.id
JOIN Manufacturer ON Sales.manufacturer_id = Manufacturer.id;
