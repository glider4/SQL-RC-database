-- Main database program:
-- Drops all tables, creates all tables creates all primary and foreign keys, inserts all values into tables
-- This entire script can be re-run in its entirety if an update is needed


---------- Drop tables & foreign keys to re-run if necessary

DROP TABLE Vendor CASCADE;
DROP TABLE LocalStore CASCADE;
DROP TABLE Customer CASCADE;
DROP TABLE Stock_ID CASCADE;
DROP TABLE Model CASCADE;
DROP TABLE Restock CASCADE;
DROP TABLE Manufacturer CASCADE;
DROP TABLE Purchase CASCADE;
DROP TABLE Airplane CASCADE;
DROP TABLE Helicopter CASCADE;
DROP TABLE Drone CASCADE;


---------- Create tables

-- Vendor table
CREATE TABLE Vendor (
	Vendor_ID INTEGER PRIMARY KEY NOT NULL, 
	Vendor_Name VARCHAR(32) NOT NULL,
	Vendor_ZIP INTEGER NOT NULL);
	
-- LocalStore table
CREATE TABLE LocalStore (
	Store_ID INTEGER PRIMARY KEY NOT NULL,
	Store_Addr VARCHAR(64) NOT NULL,
	Store_City VARCHAR(32) NOT NULL,
	Store_State VARCHAR(2) NOT NULL,
	Store_ZIP INTEGER NOT NULL);
	
-- Customer table
CREATE TABLE Customer (
	Customer_ID INTEGER PRIMARY KEY NOT NULL,
	Customer_First VARCHAR(32) NOT NULL,
	Customer_Last VARCHAR(32) NOT NULL,
	Customer_Phone NUMERIC);
	
-- Stock_ID table
CREATE TABLE Stock_ID (
	Stock_ID INTEGER PRIMARY KEY NOT NULL,
	Vendor_ID INTEGER NOT NULL,
	Mod_ID INTEGER NOT NULL,
	Vendor_Stock INTEGER NOT NULL);
	
-- Model table
CREATE TABLE Model (
	Mod_ID INTEGER PRIMARY KEY NOT NULL,
	Vendor_ID INTEGER NOT NULL,
	Mod_Manufac INTEGER NOT NULL,
	Mod_Name VARCHAR(32) NOT NULL,
	Mod_Type VARCHAR(1) NOT NULL,
	Mod_Price DECIMAL(8,2),
	Mod_Skill VARCHAR(12),
	Mod_FieldReq VARCHAR(12),
	Mod_BattCell INTEGER,
	Mod_NumStock INTEGER NOT NULL,
	Mod_LastStock DATE);
	
-- Restock table
CREATE TABLE Restock (
	Purchase_ID INTEGER PRIMARY KEY NOT NULL,
	Store_ID INTEGER NOT NULL,
	Mod_ID INTEGER NOT NULL,
	Quantity INTEGER NOT NULL,
	Order_Date DATE NOT NULL);
	
-- Manufacturer table
CREATE TABLE Manufacturer (
	Manufac_ID INTEGER PRIMARY KEY NOT NULL,
	Manufac_Name VARCHAR(32) NOT NULL);
	
-- Purchase table
CREATE TABLE Purchase (
	Purchase_ID INTEGER PRIMARY KEY NOT NULL,
	Customer_ID INTEGER NOT NULL,
	Mod_ID INTEGER,
	Quantity INTEGER NOT NULL,
	Purchase_Date DATE);
	
	
---------- Specialization-generalization tables & foreign keys

-- Airplane table
CREATE TABLE Airplane (
	Mod_ID INTEGER PRIMARY KEY NOT NULL,
	WingSpan DECIMAL(6,2) NOT NULL);

-- Helicopter table
CREATE TABLE Helicopter (
	Mod_ID INTEGER PRIMARY KEY NOT NULL,
	BladeLength DECIMAL(6,2) NOT NULL);

-- Drone table
CREATE TABLE Drone (
	Mod_ID INTEGER PRIMARY KEY NOT NULL,
	NumRotors INTEGER NOT NULL);
	
	
---------- Foreign Keys

-- Stock_ID to Vendor_ID
ALTER TABLE Stock_ID
ADD CONSTRAINT vend_fk1
FOREIGN KEY (Vendor_ID)
REFERENCES Vendor(Vendor_ID);

-- Stock_ID to Mod_ID
ALTER TABLE Stock_ID
ADD CONSTRAINT mod_fk1
FOREIGN KEY (Mod_ID)
REFERENCES Model(Mod_ID);

-- Model to Vendor_ID
ALTER TABLE Model
ADD CONSTRAINT vend_fk2
FOREIGN KEY (Vendor_ID)
REFERENCES Vendor(Vendor_ID);

-- Model to Mod_Manufac
ALTER TABLE Model
ADD CONSTRAINT manufac_fk1
FOREIGN KEY (Mod_Manufac)
REFERENCES Manufacturer(Manufac_ID);

-- Restock to Store_ID
ALTER TABLE Restock
ADD CONSTRAINT store_fk1
FOREIGN KEY (Store_ID)
REFERENCES LocalStore(Store_ID);

-- Restock to Mod_ID
ALTER TABLE Restock
ADD CONSTRAINT mod_fk2
FOREIGN KEY (Mod_ID)
REFERENCES Model(Mod_ID);

-- Purchase to Customer_ID
ALTER TABLE Purchase
ADD CONSTRAINT cust_fk1
FOREIGN KEY (Customer_ID)
REFERENCES Customer(Customer_ID);

-- Purchase to Mod_ID
ALTER TABLE Purchase
ADD CONSTRAINT mod_fk3
FOREIGN KEY (Mod_ID)
REFERENCES Model(Mod_ID);


-- Specialization-Generalization foreign keys

-- Airplane
ALTER TABLE Airplane
ADD CONSTRAINT mod_fk4
FOREIGN KEY (Mod_ID)
REFERENCES Model(Mod_ID);

-- Helicopter
ALTER TABLE Helicopter
ADD CONSTRAINT mod_fk5
FOREIGN KEY (Mod_ID)
REFERENCES Model(Mod_ID);

-- Drone
ALTER TABLE Drone
ADD CONSTRAINT mod_fk6
FOREIGN KEY (Mod_ID)
REFERENCES Model(Mod_ID);




---------- Indexes

-- Vendor_ID in Stock_ID table
CREATE INDEX idx_vend_id1
ON Stock_ID(Vendor_ID);

-- Mod_ID in Stock_ID table
CREATE UNIQUE INDEX idx_mod_id1
ON Stock_ID(Mod_ID);

-- Vendor_ID in Model table
CREATE INDEX idx_vend_id2
ON Model(Vendor_ID);

-- Mod_Manufac in Model table
CREATE INDEX idx_mod_manufac
ON Model(Mod_Manufac);

-- Store_ID in Restock table
CREATE INDEX idx_store_id
ON Restock(Store_ID);

-- Mod_ID in Restock table
CREATE INDEX idx_mod_id2
ON Restock(Mod_ID);

-- Customer_ID in Purchase table
CREATE INDEX idx_customer_id
ON Purchase(Customer_ID);

-- Mod_ID in Purchase table
CREATE INDEX idx_mod_id3
ON Purchase(Mod_ID);

-- Mod_ID in Airplane table
CREATE UNIQUE INDEX idx_mod_id4
ON Airplane(Mod_ID);

-- Mod_ID in Helicopter table
CREATE UNIQUE INDEX idx_mod_id5
ON Helicopter(Mod_ID);

-- Mod_ID in Drone table
CREATE UNIQUE INDEX idx_mod_id6
ON Drone(Mod_ID);





---------- Insert data into tables

-- Vendor (strong)
INSERT INTO Vendor(Vendor_ID, Vendor_Name, Vendor_ZIP)
VALUES
(1, 'Aloft Hobbies', 94945),
(2, 'Hobby King', 11040),
(3, 'Extreme Flight', 30041),
(4, 'Heli Direct', 47356),
(5, 'AMainHobbies', 95928),
(6, 'Tower Hobbies', 61826),
(7, 'ReadyMadeRC', 43035),
(8, 'Horizon Hobby', 61822);
-- SELECT * FROM VENDOR;


-- LocalStore (Strong)
INSERT INTO LocalStore(Store_ID, Store_Addr, Store_City, Store_State, Store_ZIP)
VALUES (1, '205 Hilliard St.', 'Manchester', 'CT', '06042');
-- SELECT * FROM LOCALSTORE


-- Customer Table (strong)
INSERT INTO Customer(Customer_ID, Customer_First, Customer_Last, Customer_Phone)
VALUES
(1, 'Michael', 'Nero', '8605739283'),
(2, 'Jack', 'Patricks', '8605892013'),
(3, 'Robert', 'Munroe', '8605574848'),
(4, 'Richard', 'Tulley', '2231049877'),
(5, 'Blane', 'Jenson', '2018852938'),
(6, 'Elliot', 'Jackson', '1092838499'),
(7, 'James', 'Pilot', '3395081928'),
(8, 'Bob', 'Vance', '8941029499');
-- SELECT * FROM Customer;


-- Manufacturer Table (strong)
INSERT INTO Manufacturer(Manufac_ID, Manufac_Name)
VALUES
(1, 'Align'),
(2, 'E-Flite'),
(3, '3DHS'),
(4, 'Parkzone'),
(5, 'Finwing'),
(6, 'SAB'),
(7, 'Strix'),
(8, 'Skyartec'),
(9, 'Blejzyk'),
(10, 'DJI');
-- SELECT * FROM MANUFACTURER


-- Model (FK Vendor_ID, FK Mod_Manufac)
INSERT INTO Model(Mod_ID, Vendor_ID, Mod_Manufac, Mod_Name, Mod_Type, Mod_Price, Mod_Skill, Mod_FieldReq, Mod_BattCell, Mod_NumStock, Mod_LastStock)
VALUES
(1, 1, 9, 'Vampire', 'A', '422.40', 'Intermediate', 'Large', '2', '3', '01-01-2018'),
(2, 2, 8, 'Skyfun', 'A', '65.00', 'Expert', 'Large', '3', '2', '05-09-2013'),
(3, 3, 3, 'Velox Revolution', 'A', '239.95', 'Intermediate', 'Large', '4', '4', '06-23-2019'),
(4, 4, 1, 'T-Rex 450LP', 'H', '530.09', 'Expert', 'Medium', '3', '3', '12-14-2018'),
(5, 5, 6, 'Goblin 380', 'H', '419.00', 'Expert', 'Medium', '6', '1', '08-12-2016'),
(6, 6, 4, 'F4F Wildcat', 'A', '149.99', 'Intermediate', 'Medium', '3', '6', '06-07-2015'),
(7, 7, 7, 'Nano Goblin', 'A', '139.99', 'Intermediate', 'Medium', '2', '7', '02-27-2018'),
(8, 8, 2, 'Night Radian', 'A', '199.99', 'Beginner', 'Large', '3', '3', '10-10-2019'),
(9, 8, 10, 'Mavic Mini', 'D', '499.99', 'Beginner', 'Small', '3', '5', '11-01-2019');
-- SELECT * FROM MODEL


-- Stock_ID (FK Vendor_ID, FK Mod_ID)
INSERT INTO Stock_ID(Stock_ID, Vendor_ID, Mod_ID, Vendor_Stock)
VALUES
(1, 1, 1, 100),
(2, 2, 2, 100),
(3, 3, 3, 200),
(4, 4, 4, 50),
(5, 5, 5, 65),
(6, 6, 6, 500),
(7, 7, 7, 100),
(8, 8, 8, 200);
-- SELECT * FROM STOCK_ID


-- Restock Table (FK Store_ID, FK Mod_ID)
INSERT INTO Restock(Purchase_ID, Store_ID, Mod_ID, Quantity, Order_Date)
VALUES
(1, 1, 1, 10, '06-05-2018'),
(2, 1, 3, 12, '06-08-2018'),
(3, 1, 5, 15, '07-14-2018'),
(4, 1, 2, 10, '08-01-2018'),
(5, 1, 4, 8, '10-02-2018'),
(6, 1, 8, 20, '11-15-2018'),
(7, 1, 6, 15, '11-24-2018'),
(8, 1, 7, 12, '12-02-2018');
-- SELECT * FROM RESTOCK


-- Purchase Table (FK Customer_ID, FK Mod_ID)
INSERT INTO Purchase(Purchase_ID, Customer_ID, Mod_ID, Quantity, Purchase_Date)
VALUES
(1, 8, 8, 1, '11-15-2018'),
(2, 2, 6, 1, '11-24-2018'),
(3, 1, 3, 1, '12-02-2018'),
(4, 3, 5, 1, '06-05-2019'),
(5, 5, 4, 1, '06-08-2019'),
(6, 6, 1, 1, '07-14-2019'),
(7, 4, 2, 1, '08-01-2019'),
(8, 7, 4, 1, '10-02-2019');
-- SELECT * FROM PURCHASE


-- Specialization-Generalization Tables
INSERT INTO Airplane(Mod_ID, WingSpan)
VALUES
(1, '3600.00'),
(2, '875.00'),
(3, '1000.00'),
(6, '1000.00'),
(7, '580.00'),
(8, '2000.00');
-- SELECT * FROM AIRPLANE

INSERT INTO Helicopter(Mod_ID, BladeLength)
VALUES
(4, '325.00'),
(5, '380.00');
-- SELECT * FROM HELICOPTER

INSERT INTO Drone
VALUES
(9, 4);
-- SELECT * FROM DRONE;


