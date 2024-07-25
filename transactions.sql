START TRANSACTION;

INSERT INTO CART (CustomerID, PayableAmount) VALUES (11, 7753.65);
INSERT INTO CART_ITEMS (CartID, ProductID, Quantity) VALUES
(11, 11, 2),
(11, 14, 1);

COMMIT;
START TRANSACTION;

INSERT INTO CART (CustomerID, PayableAmount) VALUES (12, 8414.89);
INSERT INTO CART_ITEMS (CartID, ProductID, Quantity) VALUES
(12, 12, 4);

COMMIT;
START TRANSACTION;

INSERT INTO ORDERS (CustomerID, ProductID, OrderDate, DeliveryPartnerID, DiscountCode, PayableAmount, DeliveryStatus)
VALUES (13, 25, '2023-10-29', 23, '799-64-88507', 1161.63, 'Delivered');

COMMIT;
START TRANSACTION;

INSERT INTO ORDERS (CustomerID, ProductID, OrderDate, DeliveryPartnerID, DiscountCode, PayableAmount, DeliveryStatus)
VALUES (14, 26, '2023-11-02', 26, '436-04-23900', 4714.26, 'Packing');

COMMIT;
START TRANSACTION;

-- Customer 11 attempting to place an order
INSERT INTO ORDERS (CustomerID, ProductID, OrderDate, DeliveryPartnerID, DiscountCode, PayableAmount, DeliveryStatus)
VALUES (11, 16, '2023-10-29', 15, NULL, 2567.89, 'Out for delivery');

-- Customer 12 attempting to modify the cart
UPDATE CART_ITEMS SET Quantity = 3 WHERE CartID = 12 AND ProductID = 12;

COMMIT;
START TRANSACTION;

-- Customer 1 attempting to add more of ProductID 1 to the cart
INSERT INTO CART_ITEMS (CartID, ProductID, Quantity) VALUES (1, 1, 2);

-- Customer 10 attempting to remove ProductID 2 from the cart
DELETE FROM CART_ITEMS WHERE CartID = 10 AND ProductID = 2;

COMMIT;
