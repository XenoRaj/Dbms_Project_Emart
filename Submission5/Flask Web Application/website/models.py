import mysql.connector
from flask import Flask
from datetime import date

app = Flask(__name__)

host = 'localhost'
user = 'root'
password = '612403'
database = 'projectdbms'

db = mysql.connector.connect(
    host=host,
    user=user,
    password=password,
    database=database
)

cursor = db.cursor()

app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql+mysqlconnector://{user}:{password}@{host}/{database}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

cursor.execute("CREATE DATABASE IF NOT EXISTS projectdbms")

with db:
    with db.cursor() as cursor:
        today_date = date.today()
        formatted_date = today_date.strftime('%Y-%m-%d')  # Corrected the date format
        sql = "INSERT INTO `orders` (`OrderID`,`CustomerID`,`ProductID`,`OrderDate`,`DeliveryPartnerID`,`DiscountCode`,`PayableAmount`,`DeliveryStatus`) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
        cursor.execute(sql, (22, 23, 1, formatted_date, 17, None, 200, 'packing'))
    db.commit()  # Committing the changes to the database
    