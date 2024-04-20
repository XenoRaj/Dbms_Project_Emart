CREATE TABLE IF NOT EXISTS CUSTOMERS (
    CustomerID BIGINT AUTO_INCREMENT PRIMARY KEY,
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
    StoreID BIGINT AUTO_INCREMENT PRIMARY KEY,
    LineAddress VARCHAR(30),
    PINCODE INT,
    STATE CHAR(20)
);

CREATE TABLE IF NOT EXISTS PRODUCT (
    ProductID BIGINT AUTO_INCREMENT PRIMARY KEY,
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
    ProductName VARCHAR(400) PRIMARY KEY,
    ProductDescription VARCHAR(500),
    Ratings FLOAT CHECK (Ratings BETWEEN 0 AND 10),
    FOREIGN KEY (ProductName) REFERENCES PRODUCT(ProductName)
);

CREATE TABLE IF NOT EXISTS DISCOUNT (
    DiscountCode VARCHAR(50)  PRIMARY KEY,
    ExpiryDate DATE,
    ProductID BIGINT,
    DiscountPercentage INT CHECK (DiscountPercentage BETWEEN 0 AND 100),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

CREATE TABLE IF NOT EXISTS EMPLOYEE (
    EmployeeID BIGINT AUTO_INCREMENT PRIMARY KEY,
    EName VARCHAR(50),
    Email VARCHAR(50) UNIQUE,
    PhoneNumber VARCHAR(20),
    Salary INT,
    DateOfJoining DATE
);

CREATE TABLE IF NOT EXISTS MANAGER (
    ManagerID BIGINT PRIMARY KEY,
    StoreID BIGINT UNIQUE,
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (StoreID) REFERENCES STORE(StoreID)
);

CREATE TABLE IF NOT EXISTS DELIVERYPARTNER (
    DeliveryPartnerID BIGINT AUTO_INCREMENT PRIMARY KEY,
    ManagerID BIGINT,
    VehicleType VARCHAR(50),
    FOREIGN KEY (DeliveryPartnerID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ManagerID) REFERENCES Manager(ManagerID)
);

CREATE TABLE IF NOT EXISTS ORDERS(
    OrderID BIGINT AUTO_INCREMENT PRIMARY KEY,
    CustomerID BIGINT,
    ProductID BIGINT,
    OrderDate DATE,
    DeliveryPartnerID BIGINT,
    DiscountCode VARCHAR(30),
    PayableAmount FLOAT,
    DeliveryStatus VARCHAR(20),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID),
    FOREIGN KEY (DeliveryPartnerID) REFERENCES DELIVERYPARTNER(DeliveryPartnerID)
);

CREATE TABLE IF NOT EXISTS CART (
    CartID BIGINT AUTO_INCREMENT PRIMARY KEY,
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
INSERT INTO CUSTOMERS (Membership, UserName, Email, FirstLineAddress, SecondLineAddress, PINCODE, PhoneNumber, passwordVal) 
VALUES 
(0, 'Leontyne Kellar', 'lkellar4@nih.gov', '1602 Scoville Park', 'Suite 17', 670762, '967-878-3329', 'g@Y7qB2v'),
(0, 'Billie Skaife', 'bskaife5@wix.com', '83 Brown Park', 'Suite 80', 865148, '796-471-7194', 'u2X$eF6w'),
(1, 'Emalee Chapleo', 'echapleo6@shop-pro.jp', '0792 Petterle Crossing', 'Room 175', 598186, '518-665-8162', 'b6L%kS1z'),
(0, 'Melania Plastow', 'mplastow7@ucoz.ru', '4 Eastlawn Drive', 'Suite 66', 86194, '807-347-6932', 'v3J!wK9p'),
(1, 'Alvera Blowin', 'ablowin8@ask.com', '0 Nevada Plaza', 'Room 494', 139677, '607-146-4664', 'n@Z4hC7x'),
(0, 'Emili Oleszcuk', 'eoleszcuk9@stanford.edu', '6 Eagle Crest Park', '11th Floor', 123389, '514-960-5862', 'f7P$lQ3m'),
(0, 'See Ray', 'sraya@shutterfly.com', '2801 Oneill Point', 'PO Box 58523', 161785, '260-540-0632', 'r9M!sT6j'),
(0, 'Laurie Wordley', 'lwordleyb@angelfire.com', '5 Riverside Trail', 'Suite 66', 810276, '353-488-7662', 'd#G2bR8t'),
(0, 'Jeramey Dumblton', 'jdumbltonc@blinklist.com', '7 Thompson Avenue', 'Room 1948', 992692, '302-915-2008', 'x8W&mD5y'),
(1, 'Garvin Markova', 'gmarkovad@comsenz.com', '74 Gina Terrace', 'PO Box 30427', 368065, '151-283-7373', 'z1Q@nV4u'),
(0, 'Eada Beveridge', 'ebeveridgee@multiply.com', '85662 Caliangt Hill', '16th Floor', 938975, '167-814-2566', 'l5A$pE7o'),
(0, 'Alastair Walsh', 'awalshf@tinyurl.com', '79724 Vera Junction', 'Room 493', 453001, '642-123-9938', 'h@U6gX2i'),
(0, 'Perkin Petasch', 'ppetaschg@elpais.com', '713 Surrey Junction', 'Suite 9', 717228, '213-960-9203', 'p4O%lY9f'),
(1, 'Letitia Bowich', 'lbowichh@addtoany.com', '42 Jay Lane', 'Room 970', 861969, '137-573-0884', 'y2C!vZ6q'),
(0, 'Travers Tweedie', 'ttweediei@vinaora.com', '70 Milwaukee Avenue', 'Suite 5', 121357, '368-341-9795', 'w%I3fH8d'),
(0, 'Pippy Baal', 'pbaalj@gizmodo.com', '82622 Division Hill', 'PO Box 25098', 222111, '109-163-3078', 'k6N#oR1a');

INSERT INTO CUSTOMERS (Membership, UserName, Email, FirstLineAddress, SecondLineAddress, PINCODE, PhoneNumber, passwordVal) 
VALUES 
(0, 'Zachery Galway', 'zagalway0@xrea.com', '55313 Oriole Hill', 'Suite 40', 53341, '264-526-3439', 'm9H@wPq5'),
(1, 'Claaybourne Iacomettii', 'caiacomettii1@google.de', '23 Thompson Road', 'Apt 892', 502695, '474-126-8440', 'j*E5tL7r'),
(1, 'Meriel O''Kenny', 'moekenny2@dailymail.co.uk', '2734 Sachtjen Drive', 'Room 651', 204032, '252-205-7871', 's#R8pG2k'),
(1, 'Hasheem Tomsen', 'hteomsen3@oaic.gov.au', '6692 Clyde Gallagher Circle', '14th Floor', 644083, '106-816-3615', 'c3K&pN!9');





INSERT INTO STORE (LineAddress, PINCODE, STATE) 
VALUES 
('67762 Esch Lane', 111111, 'AP'),
('57 Hollow Ridge Road', 121212, 'AR'),
('59823 Crowley Place', 112211, 'TL'),
('08 Mallory Point', 222222, 'MH'),
('0619 Anderson Place', 111222, 'DL'),
('7089 Saint Paul Plaza', 222111, 'UP'),
('16072 Green Ridge Lane', 212121, 'HR');

INSERT INTO STORE (LineAddress, PINCODE, STATE) 
VALUES 
('67762 Esch Lane', 111111, 'AP'),
('57 Hollow Ridge Road', 121212, 'AR'),
('59823 Crowley Place', 112211, 'TL');


INSERT INTO EMPLOYEE (EName, Email, PhoneNumber, Salary, DateOfJoining) 
VALUES 
('Jacquenette Cowdrey', 'jc2owdrey0@wordpress.org', '187-552-7153', 100, '2018-06-16'),
('Henrieta Bedward', 'hbe3dward1@cargocollective.com', '403-699-6563', 20, '2019-12-31'),
('Rickert Bonaire', 'rbona231ire2@storify.com', '541-898-3029', 500, '2020-08-09'),
('Kaleb Truse', 'ktruse3@yand321ex.ru', '750-748-3078', 20, '2021-06-26'),
('Aditya kholsa', 'aditya3@yande321x.ru', '751-888-3128', 120, '2022-06-26'),
('Henry ward', 'hward1@collectiv11e.com', '413-799-6593', 220, '2019-12-31');
INSERT INTO EMPLOYEE (EName, Email, PhoneNumber, Salary, DateOfJoining) 
VALUES 
('Jacquenette Cowdrey', 'jcowdrey0@wordpress.org', '187-552-7153', 100, '2018-06-16'),
('Henrieta Bedward', 'hbedward1@cargocollective.com', '403-699-6563', 20, '2019-12-31'),
('Rickert Bonaire', 'rbonaire2@storify.com', '541-898-3029', 500, '2020-08-09'),
('Kaleb Truse', 'ktruse3@yandex.ru', '750-748-3078', 20, '2021-06-26'),
('Tailor Petroff', 'tpetroff4@flickr.com', '215-147-1991', 2320, '2019-01-23'),
('Aldus Holehouse', 'aholehouse5@foxnews.com', '450-626-3452', 212121, '2021-09-29'),
('Kristel Kintish', 'kkintish6@usnews.com', '669-678-9026', 32224453, '2023-02-08'),
('Cortney Farlow', 'cfarlow7@vinaora.com', '509-516-1777', 21321, '2019-07-15'),
('Ki Bateson', 'kbateson8@odnoklassniki.ru', '945-961-0355', 21314, '2021-10-03'),
('Beret Babbe', 'bbabbe9@posterous.com', '792-688-3861', 2424, '2021-10-27'),
('Emilie Isbell', 'eisbella@merriam-webster.com', '802-767-1578', 2142, '2020-03-23'),
('Wini Brackley', 'wbrackleyb@blogger.com', '940-722-4237', 24535, '2020-09-27'),
('Eleonora Glasebrook', 'eglasebrookc@amazon.de', '744-922-4185', 6353, '2018-10-30'),
('Emmett Plak', 'eplakd@merriam-webster.com', '236-165-2088', 535232, '2022-12-10'),
('Evvie Lewer', 'elewere@livejournal.com', '957-428-0199', 4324223, '2018-10-28'),
('Diego Brettel', 'dbrettelf@cbslocal.com', '113-105-3993', 523523, '2021-05-22'),
('Elden Speedin', 'espeeding@123-reg.co.uk', '385-261-7042', 532523, '2018-09-21'),
('Myrtie Brearley', 'mbrearleyh@miitbeian.gov.cn', '817-176-2404', 121212, '2022-09-03'),
('Dee dee Derye-Barrett', 'ddeei@cpanel.net', '678-233-1651', 555, '2019-12-19'),
('Sloane Petett', 'spetettj@seattletimes.com', '310-445-7954', 2221, '2021-01-27');

INSERT INTO MANAGER (ManagerID, StoreID) 
VALUES 
(11, 1),
(4, 2),
(5, 3),
(6, 4),
(3, 5),
(12, 6),
(9, 7);

INSERT INTO MANAGER (ManagerID, StoreID) 
VALUES 
(21, 8),
(22, 9),
(25,10);




INSERT INTO DELIVERYPARTNER (DeliveryPartnerID, ManagerID, VehicleType) 
VALUES 
(23, 21, 'UK 06 N 1309'),
(24, 22, 'FF 16 K 1793'),
(26, 25, 'IJ 65 Z 3488');

INSERT INTO DELIVERYPARTNER (DeliveryPartnerID, ManagerID, VehicleType) 
VALUES 
(1, 4, 'UK 06 N 1309'),
(2, 5, 'FF 16 K 1793'),
(7, 6, 'IJ 65 Z 3488'),
(8, 3, 'SB 27 T 5103'),
(10, 11, 'HT 36 G 3950'),
(13, 12, 'XO 41 G 7118'),
(14, 9, 'PL 10 Q 2811'),
(15, 3, 'GT 67 H 3975'),
(16, 11, 'PS 19 W 4677'),
(17, 4, 'YZ 24 T 3216'),
(18, 5, 'CC 41 H 8617'),
(19, 11, 'HA 30 R 1176'),
(20, 12, 'SB 29 S 2997');


INSERT INTO PRODUCT (StoreID, ProductName, ProductPrice, ProductQuantity, ProductManufacturingDate, ExpiryDate) 
VALUES 
(8, 'Pasta - Fettuccine, Dry', 62.19, 293, '2019-12-27', '2029-08-19'),
(9, 'Honey Syrup', 161.03, 190, '2023-04-22', '2029-02-12'),
(8, 'Electric mixer', 555.45, 144, '2023-04-28', '2021-10-15'),
(10, 'Milk (1kg)', 50.73, 204, '2022-10-21', '2025-06-06'),
(10, 'Tea Peppermint', 78.78, 494, '2022-04-05', '2028-09-11');

INSERT INTO PRODUCT (ProductName, ProductPrice, ProductQuantity, StoreID, ProductManufacturingDate, ExpiryDate)
VALUES
('Pasta - Fettuccine, Dry', 62.19, 293, 1, '2019-12-27', '2029-08-19'),
('Honey Syrup', 161.03, 190, 2, '2023-04-22', '2029-02-12'),
('Electric mixer', 555.45, 144, 3, '2023-04-28', '2027-10-15'),
('Milk (1kg)', 50.73, 204, 4, '2022-10-21', '2025-06-06'),
('Tea Peppermint', 78.78, 494, 1, '2022-04-05', '2028-09-11'),
('Stainless Steel Cleaning gel', 954.37, 273, 2, '2023-12-04', '2026-07-03'),
('Washing Powder', 879.53, 118, 3, '2019-12-28', '2024-12-23'),
('Cup Noodles', 214.05, 8, 4, '2019-10-04', '2027-05-04'),
('Plastic fork(10p)', 17.79, 421, 5, '2022-07-17', '2026-11-23'),
('Sprouts - Pea', 569.52, 499, 6, '2022-09-10', '2024-04-03'),
('Oranges', 738.92, 107, 7, '2020-11-19', '2025-03-25'),
('Body Wash', 394.18, 291, 1, '2022-12-22', '2029-03-28'),
('Red Pasta Sauce', 386.04, 320, 1, '2023-12-04', '2024-10-31'),
('Arrowroot', 851.36, 456, 2, '2023-05-15', '2028-05-30'),
('Oven Mitts 17 Inch', 979.92, 187, 3, '2020-08-01', '2025-06-13'),
('True - Vue Containers', 927.51, 398, 4, '2020-02-06', '2028-02-12'),
('Shampoo', 74.71, 65, 5, '2022-06-24', '2025-05-29'),
('Puree - Raspberry', 594.61, 299, 6, '2022-03-10', '2025-09-22'),
('Broom - Angled', 634.57, 440, 2, '2020-10-19', '2026-06-30'),
('Pasta - Fettuccine, Dry', 62.19, 23, 3, '2020-12-27', '2032-08-19'),
('Washing Powder', 879.53, 188, 1, '2021-12-28', '2028-12-23'),
('Cup Noodles', 214.05, 80, 4, '2023-10-04', '2029-05-04'),
('Red Pasta Sauce', 386.04, 380, 5, '2024-12-04', '2031-10-31'),
('Arrowroot', 851.36, 46, 6, '2021-05-15', '2034-05-30');




INSERT INTO product_details (productName, productDescription, Ratings)
VALUES
('Pasta - Fettuccine, Dry', 'CIF', 1.7),
('Honey Syrup', 'VDR', 8.6),
('Electric mixer', 'LUF', 8.1),
('Milk (1kg)', 'AEE', 4),
('Tea Peppermint', 'HCQ', 8.6),
('Stainless Steel Cleaning gel', 'MPL', 5.7),
('Washing Powder', 'BLI', 7.7),
('Cup Noodles', 'FNH', 6),
('Plastic fork(10p)', 'CBQ', 7.2),
('Sprouts - Pea', 'ULX', 5.7),
('Oranges', 'SAC', 6.3),
('Body Wash', 'UDR', 3.3),
('Red Pasta Sauce', 'BDH', 8.2),
('Arrowroot', 'PAJ', 7),
('Oven Mitts 17 Inch', 'OLP', 4.7),
('True - Vue Containers', 'GMT', 7),
('Shampoo', 'VSG', 0.7),
('Puree - Raspberry', 'CTY', 4.1),
('Broom - Angled', 'URY', 5.7);




INSERT INTO DISCOUNT (DiscountCode, ExpiryDate, ProductID, DiscountPercentage)
VALUES
('799-64-88507', '2024-10-01', 1, 50),
('436-04-23900', '2024-09-26', 3, 10),
('439-43-37000', '2024-11-15', 5, 10),
('201-70-10722', '2024-07-16', 7, 30),
('136-26-81778', '2024-11-07', 9, 30),
('571-54-40966', '2024-12-27', 2, 7),
('424-95-59437', '2024-08-20', 6, 10),
('633-91-00419', '2025-01-06', 4, 20),
('384-17-64957', '2024-11-06', 3, 20),
('602-70-88092', '2024-03-05', 8, 10),
('799-54-88507', '2024-10-01', 23, 50),
('436-14-23900', '2024-09-26', 26, 10),
('439-23-37000', '2024-11-15', 24, 10);



INSERT INTO Orders (CustomerID, ProductID, OrderDate, deliverypartnerID, DiscountCode, PayableAmount, deliverystatus)
VALUES
(1, 11, '2023-10-29', 1, '799-64-88507', 1161.63, 'Delivered'),
(2, 1, '2023-11-02', 2, '436-04-23900', 4714.26, 'Packing'),
(3, 3, '2023-11-03', 7, '439-43-37000', 4892.57, 'Delivered'),
(4, 4, '2023-10-28', 8, '201-70-10722', 4077.22, 'Out for delivery'),
(5, 5, '2023-11-01', 10, '136-26-81778', 1722.35, 'Packing'),
(1, 6, '2023-10-27', 13, '571-54-40966', 2657.48, 'Packing'),
(5, 7, '2023-10-29', 14, '424-95-59437', 1551.77, 'Delivered'),
(6, 12, '2023-10-30', 15, '633-91-00419', 1064.83, 'Delivered'),
(8, 13, '2023-11-02', 16, '384-17-64957', 701.35, 'Delivered'),
(9, 14, '2023-11-05', 17, '602-70-88092', 4143.15, 'Packing'),
(10, 15, '2023-11-03', 18, NULL, 3565.7, 'Out for delivery'),
(11, 16, '2023-10-29', 15, NULL, 2567.89, 'Out for delivery'),
(12, 17, '2023-10-28', 16, NULL, 726.13, 'Packing'),
(11, 18, '2023-10-27', 17, '633-91-00419', 2382.6, 'Delivered'),
(12, 19, '2023-11-03', 18, '384-17-64957', 3034.38, 'Out for delivery');

INSERT INTO ORDERS (CustomerID, ProductID, OrderDate, DeliveryPartnerID, DiscountCode, PayableAmount, DeliveryStatus) 
VALUES 
( 13, 25, '2023-10-29', 23, '799-64-88507', 1161.63, 'Delivered'),
( 14, 26, '2023-11-02', 26, '436-04-23900', 4714.26, 'Packing'),
( 15, 27, '2023-11-03', 24, '439-43-37000', 4892.57, 'Delivered'),
( 16, 28, '2023-10-28', 26, '201-70-10722', 4077.22, 'Out for delivery'),
( 17, 29, '2023-11-01', 24, '136-26-81778', 1722.35, 'Packing');

INSERT INTO CART (CustomerID, PayableAmount) 
VALUES 
( 11, 7753.65),
( 12, 8414.89),
( 13, 8281.17),
( 14, 2567.39);


INSERT INTO cart (CustomerID, PayableAmount)
VALUES
(1, 7753.65),
(2, 8414.89),
(3, 8281.17),
(4, 2567.39),
(5, 9683.83),
(6, 1555.24),
(7, 3407.58),
(8, 5707.14),
(9, 1339.66),
(10, 9250.71);


INSERT INTO CART_ITEMS (CartID, ProductID, Quantity) 
VALUES 
(11, 11, 2),
(12, 12, 4),
(11, 11, 3),
(12, 14, 1),
(13, 15, 2),
(13, 16, 1);

INSERT INTO cart_items (CartID, ProductID, Quantity)
VALUES
(1, 1, 2),
(2, 2, 4),
(1, 3, 3),
(1, 4, 1),
(9, 4, 2),
(3, 5, 1),
(4, 6, 1),
(5, 1, 2),
(5, 2, 3),
(6, 2, 3),
(7, 2, 3),
(7, 1, 3),
(8, 4, 4),
(10, 2, 1);




