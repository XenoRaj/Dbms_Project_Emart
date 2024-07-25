import mysql.connector

mydb = mysql.connector.connect(
        host='localhost',
        user='root',
        password='612403',
        database='projectdbms'
        )

mycursor = mydb.cursor()

update_inventory = '''
CREATE TRIGGER update_inventory 
AFTER INSERT ON orders
FOR EACH ROW 
BEGIN 
    UPDATE product 
    SET ProductQuantity = ProductQuantity - 1 
    WHERE ProductID = NEW.`ProductID`;
END;
'''



Set_order_details = '''

CREATE TRIGGER set_order_details 
BEFORE INSERT ON orders 

FOR EACH ROW 
BEGIN

    DECLARE amount DECIMAL(10,2);

    DECLARE available_quantity INT;

    SELECT productquantity INTO available_quantity
    FROM product
    WHERE productID = NEW.productID;

    IF available_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = "Insufficent product in stock. Order could not be added.";
    END IF;
   
    SET NEW.DeliveryPartnerID = (SELECT deliverypartner.DeliveryPartnerID
                                    FROM deliverypartner
                                    WHERE ManagerID = (SELECT ManagerID FROM Manager WHERE storeID = (SELECT StoreID FROM product WHERE product.ProductID = NEW.ProductID))
                                    LIMIT 1);

    SET NEW.OrderDate = DATE_FORMAT(NOW(), '%Y/%m/%d');
    
   
    SELECT ProductPrice INTO amount
    FROM product
    WHERE product.productID = NEW.ProductID;
    SET NEW.PayableAmount = amount;

    SET NEW.DeliveryStatus = 'Out for delivery';
END;
'''
mycursor.execute('DROP TRIGGER IF EXISTS update_inventory ')
mycursor.execute(update_inventory)
mycursor.execute("DROP TRIGGER IF EXISTS set_order_details;")
mycursor.execute(Set_order_details)


mydb.commit()


