from flask import Flask, render_template, session
from flask_login import LoginManager
from flask_sqlalchemy import SQLAlchemy
import pymysql.cursors
from urllib.parse import quote_plus
from datetime import timedelta


db = SQLAlchemy()

def create_app():
    
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'hjshjhdjahkjshkjdhjs'
    db_password = quote_plus('612403')
    app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://root:{db_password}@localhost/projectdbms'
    db.init_app(app)

    from .views import views
    from .auth import auth

    app.register_blueprint(views, url_prefix='/')
    app.register_blueprint(auth, url_prefix='/')

    from .models import Customers

    with app.app_context():
        create_database()

    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    @login_manager.user_loader
    def load_user(id):
        return Customers.get_by_id(id)

    app.config['SESSION_PERMANENT'] = False
    app.config['SESSION_TYPE'] = 'filesystem'   
    app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(minutes=15)

    return app


def create_database():
    connection = pymysql.connect(host='localhost',
                                 user='root',
                                 password='612403',
                                 database='projectdbms',
                                 cursorclass=pymysql.cursors.DictCursor)

    with connection:
        with connection.cursor() as cursor:
            # Create the customers table if it doesn't exist
            sql = """
            CREATE TABLE IF NOT EXISTS customers (
                id INT AUTO_INCREMENT PRIMARY KEY,
                Membership BOOLEAN,
                UserName VARCHAR(30),
                email VARCHAR(30) UNIQUE,
                FirstLineAddress VARCHAR(30),
                SecondLineAddress VARCHAR(30),
                pincode INT,
                PhoneNumber VARCHAR(20),
                passwordVal VARCHAR(20)
            )
            """
            cursor.execute(sql)

    print('Database created!')

