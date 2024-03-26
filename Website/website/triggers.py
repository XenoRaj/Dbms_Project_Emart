import mysql.connector

mydb = mysql.connector.connect(
            host='localhost',
            user='root',
            password='Raj@1552003',
            database='emart'
        )

mycursor = mydb.cursor()

sql = '''

CREATE TRIGGER update_inventory 
AFTER INSERT ON orders 
FOR EACH ROW 
BEGIN 
	UPDATE product 
    SET ProductQuantity = ProductQuantity - 1 
    WHERE ProductID = NEW.`ProductID`;
END;
'''

mycursor.execute(sql)

mydb.commit()


