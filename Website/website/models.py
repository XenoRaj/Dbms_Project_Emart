import pymysql.cursors
from . import db
from flask_login import UserMixin
# # Connect to the database
connection = pymysql.connect(host='localhost',
                             user='root',
                             password='612403',
                             database='projectdbms',
                             cursorclass=pymysql.cursors.DictCursor)

class Customers(db.Model,UserMixin):
    __tablename__ = 'customers'
    
    CustomerID = db.Column(db.Integer, primary_key=True)
    Membership = db.Column(db.Boolean)
    UserName = db.Column(db.String(30))
    email = db.Column(db.String(30), unique=True)
    FirstLineAddress = db.Column(db.String(30))
    SecondLineAddress = db.Column(db.String(30))
    pincode = db.Column(db.Integer)
    PhoneNumber = db.Column(db.String(20))
    passwordVal = db.Column(db.String(20))

    def __init__(self, Membership, UserName, email, FirstLineAddress, SecondLineAddress, pincode, PhoneNumber, passwordVal):
        self.Membership = Membership
        self.UserName = UserName
        self.email = email
        self.FirstLineAddress = FirstLineAddress
        self.SecondLineAddress = SecondLineAddress
        self.pincode = pincode
        self.PhoneNumber = PhoneNumber
        self.passwordVal = passwordVal

    def save_to_db(self):
        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='Raj@1552003',
                                    database='Emart',
                                     cursorclass=pymysql.cursors.DictCursor)
        with connection:
            with connection.cursor() as cursor:
                # Create a new record
                sql = "INSERT INTO `customers` (`Membership`, `UserName`, `email`, `FirstLineAddress`, `SecondLineAddress`, `pincode`, `PhoneNumber`, `passwordVal`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
                cursor.execute(sql, (self.Membership, self.UserName, self.email, self.FirstLineAddress, self.SecondLineAddress, self.pincode, self.PhoneNumber, self.passwordVal))
            # Commit the transaction
            connection.commit()

    @staticmethod
    def find_by_email(email):
        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='Raj@1552003',
                                    database='Emart',
                                     cursorclass=pymysql.cursors.DictCursor)
        with connection:
            with connection.cursor() as cursor:
                # Query the database to find a customer by email
                sql = "SELECT * FROM `customers` WHERE `email` = %s"
                cursor.execute(sql, (email,))
                return cursor.fetchone()
    @staticmethod
    def get_by_id(user_id):
        # Assuming you are using SQLAlchemy
        return Customers.query.filter_by(CustomerID=user_id).first()

    def get_id(self):
        return str(self.CustomerID)
    
class Employee(db.Model, UserMixin):
    __tablename__ = 'employee'
    
    EmployeeID = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    EName = db.Column(db.String(50))
    Email = db.Column(db.String(50), unique=True)
    PhoneNumber = db.Column(db.String(20))
    Salary = db.Column(db.Integer)
    DateOfJoining = db.Column(db.Date)

    def __init__(self, EName, Email, PhoneNumber, Salary, DateOfJoining):
        self.EName = EName
        self.Email = Email
        self.PhoneNumber = PhoneNumber
        self.Salary = Salary
        self.DateOfJoining = DateOfJoining

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    @staticmethod
    def find_by_email(email):
        return Employee.query.filter_by(Email=email).first()

    @staticmethod
    def get_by_id(user_id):
        return Employee.query.get(user_id)

    def get_id(self):
        return str(self.EmployeeID)




class Manager(db.Model, UserMixin):
    __tablename__ = 'manager'
    
    ManagerID = db.Column(db.BigInteger, primary_key=True)
    StoreID = db.Column(db.BigInteger, unique=True)

    def __init__(self, ManagerID, StoreID):
        self.ManagerID = ManagerID
        self.StoreID = StoreID

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    @staticmethod
    def find_by_id(manager_id):
        return Manager.query.filter_by(ManagerID=manager_id).first()

    def get_id(self):
        return str(self.ManagerID)
