CREATE TABLE IF NOT EXISTS CUSTOMERS (
    CustomerID BIGINT PRIMARY KEY,
    Membership BOOLEAN,
    UserName VARCHAR(30),
    Email VARCHAR(30) UNIQUE,
    FirstLineAddress VARCHAR(30),
    SecondLineAddress VARCHAR(30),
    PINCODE INT,
    PhoneNumber VARCHAR(20),
    passwordVal VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS STORE(
    StoreID BIGINT PRIMARY KEY,
    LineAddress VARCHAR(30),
    PINCODE INT,
    STATE CHAR(20)
);
CREATE TABLE IF NOT EXISTS PRODUCT (
    ProductID BIGINT PRIMARY KEY,
    StoreID BIGINT, 
    ProductName VARCHAR(400),
    ProductPrice FLOAT,
    ProductQuantity INT CHECK(ProductQuantity >= 0),
    ProductManufacturingDate DATE,
    ExpiryDate DATE,
    INDEX (ProductName),
    FOREIGN KEY (StoreID) REFERENCES STORE(StoreID)
);
CREATE TABLE IF NOT EXISTS PRODUCT_DETAILS (
    ProductName VARCHAR(400) primary key,
    ProductDescription VARCHAR(500),
    Ratings FLOAT CHECK (Ratings BETWEEN 0 AND 10),
    FOREIGN KEY (ProductName) REFERENCES PRODUCT(ProductName)
);
CREATE TABLE IF NOT EXISTS DISCOUNT (
    DiscountCode VARCHAR(50) PRIMARY KEY,
    ExpiryDate DATE,
    ProductID BIGINT,
    DiscountPercentage INT CHECK (DiscountPercentage BETWEEN 0 AND 100),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);
CREATE TABLE IF NOT EXISTS EMPLOYEE (
    EmployeeID BIGINT PRIMARY KEY,
    EName VARCHAR(50),
	Email VARCHAR(50) UNIQUE,
    PhoneNumber VARCHAR(20),
    Salary int,
    DateOfJoining DATE
);
CREATE TABLE IF NOT EXISTS MANAGER (
    ManagerID BIGINT PRIMARY KEY,
    StoreID BIGINT UNIQUE,
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (StoreID) REFERENCES STORE(StoreID)
);
CREATE TABLE IF NOT EXISTS DELIVERYPARTNER (
    DeliveryPartnerID BIGINT PRIMARY KEY,
    ManagerID BIGINT,
    VehicleType VARCHAR(50),
    FOREIGN KEY (DeliveryPartnerID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ManagerID) REFERENCES Manager(ManagerID)
);
CREATE TABLE IF NOT EXISTS ORDERS(
    OrderID BIGINT PRIMARY KEY,
	CustomerID BIGINT,
    ProductID BIGINT,
    OrderDate date,
    DeliveryPartnerID BIGINT,
    DiscountCode VARCHAR(30),
    PayableAmount FLOAT,
    DeliveryStatus VARCHAR(20),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID),
    FOREIGN KEY (DeliveryPartnerID) REFERENCES DELIVERYPARTNER(DeliveryPartnerID)
);
CREATE TABLE IF NOT EXISTS CART (
    CartID BIGINT PRIMARY KEY,
    CustomerID BIGINT,
    PayableAmount FLOAT,
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID)
);
CREATE TABLE IF NOT EXISTS CART_ITEMS (
    CartItemID BIGINT AUTO_INCREMENT PRIMARY KEY,
    CartID BIGINT,
    ProductID BIGINT,
    Quantity INT,
    FOREIGN KEY (CartID) REFERENCES CART(CartID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

INSERT INTO CUSTOMERS (CustomerID, Membership, UserName, Email, FirstLineAddress, SecondLineAddress, PINCODE, PhoneNumber, passwordVal) 
VALUES 
(7427638131, 0, 'Zachery Galway', 'zgalway0@xrea.com', '55313 Oriole Hill', 'Suite 40', 53341, '264-526-3439', 'm9H@wPq5'),
(4866651903, 1, 'Claybourne Iacomettii', 'ciacomettii1@google.de', '23 Thompson Road', 'Apt 892', 502695, '474-126-8440', 'j*E5tL7r'),
(8000079666, 1, 'Meriel O''Kenny', 'mokenny2@dailymail.co.uk', '2734 Sachtjen Drive', 'Room 651', 204032, '252-205-7871', 's#R8pG2k'),
(1718625340, 1, 'Hasheem Tomsen', 'htomsen3@oaic.gov.au', '6692 Clyde Gallagher Circle', '14th Floor', 644083, '106-816-3615', 'c3K&pN!9');



LOAD DATA INFILE 'C:/Users/gadam/OneDrive/Desktop/COLLEGE/Semester 4/DBMS/Submission4/Customer.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


INSERT INTO STORE (StoreID, LineAddress, PINCODE, STATE) 
VALUES 
(664, '67762 Esch Lane', 111111, 'AP'),
(363, '57 Hollow Ridge Road', 121212, 'AR'),
(629, '59823 Crowley Place', 112211, 'TL');


LOAD DATA INFILE 'C:/Users/gadam/OneDrive/Desktop/COLLEGE/Semester 4/DBMS/Submission4/Store.csv'
INTO TABLE store
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

INSERT INTO EMPLOYEE (EmployeeID, EName, Email, PhoneNumber, Salary, DateOfJoining) 
VALUES 
(3820865578, 'Jacquenette Cowdrey', 'jcowdrey0@wordpress.org', '187-552-7153', 100, '2018-06-16'),
(1047615045, 'Henrieta Bedward', 'hbedward1@cargocollective.com', '403-699-6563', 20, '2019-12-31'),
(6474596708, 'Rickert Bonaire', 'rbonaire2@storify.com', '541-898-3029', 500, '2020-08-09'),
(4766886178, 'Kaleb Truse', 'ktruse3@yandex.ru', '750-748-3078', 20, '2021-06-26');

LOAD DATA INFILE 'C:/Users/gadam/OneDrive/Desktop/COLLEGE/Semester 4/DBMS/Submission4/Employee.csv'
INTO TABLE EMPLOYEE
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(EmployeeID, EName, Email, PhoneNumber, Salary, @DateOfJoining)
SET DateOfJoining = STR_TO_DATE(@DateOfJoining, '%m/%d/%Y');


INSERT INTO MANAGER (ManagerID, StoreID) 
VALUES 
(4907464207, 664),
(9713050754, 363),
(3565667362, 629);

LOAD DATA INFILE 'C:/Users/gadam/OneDrive/Desktop/COLLEGE/Semester 4/DBMS/Submission4/Managers.csv'
INTO TABLE manager
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

INSERT INTO DELIVERYPARTNER (DeliveryPartnerID, ManagerID, VehicleType) 
VALUES 
(3820865578, 4907464207, 'UK 06 N 1309'),
(1047615045, 9713050754, 'FF 16 K 1793'),
(6474596708, 3565667362, 'IJ 65 Z 3488'),
(4766886178, 5624754027, 'SB 27 T 5103'),
(3769718011, 1696119162, 'HT 36 G 3950');

LOAD DATA INFILE 'C:/Users/gadam/OneDrive/Desktop/COLLEGE/Semester 4/DBMS/Submission4/deliveryPartner.csv'
INTO TABLE deliverypartner
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


INSERT INTO PRODUCT (ProductID, StoreID, ProductName, ProductPrice, ProductQuantity, ProductManufacturingDate, ExpiryDate) 
VALUES 
(3048017489, 664, 'Pasta - Fettuccine, Dry', 62.19, 293, '2019-12-27', '2029-08-19'),
(7534257077, 363, 'Honey Syrup', 161.03, 190, '2023-04-22', '2029-02-12'),
(3490434374, 629, 'Electric mixer', 555.45, 144, '2023-04-28', '2021-10-15'),
(8843773089, 19, 'Milk (1kg)', 50.73, 204, '2022-10-21', '2025-06-06'),
(7418194250, 425, 'Tea Peppermint', 78.78, 494, '2022-04-05', '2028-09-11');

LOAD DATA INFILE 'C:/Users/gadam/OneDrive/Desktop/COLLEGE/Semester 4/DBMS/Submission4/Product.csv'
INTO TABLE PRODUCT
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(ProductID, ProductName, ProductPrice, ProductQuantity, StoreID, @ManufacturingDate, @ExpiryDate)
SET ProductManufacturingDate = STR_TO_DATE(@ManufacturingDate, '%m/%d/%Y'),
    ExpiryDate = STR_TO_DATE(@ExpiryDate, '%m/%d/%Y');

INSERT INTO PRODUCT_DETAILS (ProductName, ProductDescription, Ratings) 
VALUES 
('Pasta - Fettuccine, Dry', 'CIF', 1.7),
('Honey Syrup', 'VDR', 8.6),
('Electric mixer', 'LUF', 8.1),
('Milk (1kg)', 'AEE', 4),
('Tea Peppermint', 'HCQ', 8.6);

LOAD DATA INFILE 'C:/Users/gadam/OneDrive/Desktop/COLLEGE/Semester 4/DBMS/Submission4/productDescription.csv'
INTO TABLE product_details
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;




LOAD DATA INFILE 'C:/Users/gadam/OneDrive/Desktop/COLLEGE/Semester 4/DBMS/Submission4/Discount.csv'
INTO TABLE DISCOUNT
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(DiscountCode, @ExpiryDate, ProductID, DiscountPercentage)
SET ExpiryDate = STR_TO_DATE(@ExpiryDate, '%m/%d/%Y');

INSERT INTO DISCOUNT (DiscountCode, ExpiryDate, ProductID, DiscountPercentage) 
VALUES 
('799-64-88507', '2024-10-01', 3048017488, 50),
('436-04-23900', '2024-09-26', 7534257077, 10),
('439-43-37000', '2024-11-15', 3490434374, 10);

INSERT INTO ORDERS (OrderID, CustomerID, ProductID, OrderDate, DeliveryPartnerID, DiscountCode, PayableAmount, DeliveryStatus) 
VALUES 
(8384032017, 679077391, 3048017488, '2023-10-29', 1047615045, '799-64-88507', 1161.63, 'Delivered'),
(3188589190, 1378911180, 7534257077, '2023-11-02', 1320395953, '436-04-23900', 4714.26, 'Packing'),
(735401209, 679077391, 3490434374, '2023-11-03', 2382507187, '439-43-37000', 4892.57, 'Delivered'),
(9760888858, 1378911180, 8843773089, '2023-10-28', 3676127382, '201-70-10722', 4077.22, 'Out for delivery'),
(3766982966, 1400708923, 7418194250, '2023-11-01', 3852533643, '136-26-81778', 1722.35, 'Packing');

LOAD DATA INFILE 'C:/Users/gadam/OneDrive/Desktop/COLLEGE/Semester 4/DBMS/Submission4/Orders.csv'
INTO TABLE ORDERS
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(OrderID, CustomerID, ProductID, @OrderDate, DeliveryPartnerID, DiscountCode, PayableAmount, DeliveryStatus)
SET OrderDate = STR_TO_DATE(@OrderDate, '%m/%d/%Y');

INSERT INTO CART (CartID, CustomerID, PayableAmount) 
VALUES 
(17373, 7427638131, 7753.65),
(56437, 4866651903, 8414.89),
(50935, 8000079666, 8281.17),
(1808, 1718625340, 2567.39);


LOAD DATA INFILE 'C:/Users/gadam/OneDrive/Desktop/COLLEGE/Semester 4/DBMS/Submission4/Cart.csv'
INTO TABLE cart
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

INSERT INTO CART_ITEMS (CartID, ProductID, Quantity) 
VALUES 
(17373, 3048017488, 2),
(56437, 7534257077, 4),
(17373, 3490434374, 3),
(17373, 8843773089, 1),
(56437, 3048017488, 2),
(50935, 7534257077, 1);

LOAD DATA INFILE 'C:/Users/gadam/OneDrive/Desktop/COLLEGE/Semester 4/DBMS/Submission4/CartItems.csv'
INTO TABLE cart_items
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(CartID, ProductID, Quantity);



