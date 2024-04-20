-- find all deliverypartners of a strore -- 
SELECT *
FROM deliverypartner
WHERE ManagerID = (SELECT ManagerID FROM manager WHERE manager.StoreID = 363);

-- find products availability in each store --
select  StoreId, ProductQuantity
from product
where product.ProductName = "Body Wash";

-- find delivery partner suitable for an order--  
select deliverypartner.DeliveryPartnerID
from deliverypartner
where ManagerID = (select managerID from store as s where s.storeID = (select StoreID from product where product.ProductID = (select ProductID from orders where orderID=735401209)))
limit 1;



-- get bestselling products based on ratings -- 
SELECT p.ProductName, pd.ProductDescription, p.ProductPrice, pd.Ratings
FROM PRODUCT p
JOIN PRODUCT_DETAILS pd ON p.ProductID = pd.ProductID
ORDER BY pd.Ratings DESC;




-- Login relation
SET @UserInputEmail = 'sraya@shutterfly.com';
SET @passwordInput = 'r9M!sT6j';

SELECT 
    CASE 
        WHEN EXISTS (
            SELECT 1 FROM groupsubmission.customers 
            WHERE Email = @UserInputEmail AND passwordVal = @passwordInput
        ) THEN 'Login Successful.'
        ELSE 'Email or password combination does not exist in the database.'
    END AS Result;

SET @InputCustomerID = '1400708923';

SELECT *
FROM orders
WHERE CustomerID = @InputCustomerID;

SELECT COUNT(DISTINCT ci.ProductID) AS UniqueItemsCount
FROM CART_ITEMS ci
JOIN PRODUCT p ON ci.ProductID = p.ProductID;

SELECT oi.ProductID, SUM(oi.Quantity) AS TotalQuantity
FROM product p
JOIN CART_ITEMS oi ON p.ProductID = oi.ProductID
GROUP BY oi.ProductID;

UPDATE DISCOUNT
SET DiscountPercentage = 70
WHERE DiscountCode = '571-54-40966';


delete
from product
WHERE ExpiryDate <= CURDATE();

-- remove expired discounts from being available --

DELETE FROM discount
WHERE ExpiryDate <= CURDATE();