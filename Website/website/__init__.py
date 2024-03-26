from flask import Flask
import mysql.connector
def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'asdfghjkl'
    app.config['MYSQL_HOST'] = 'localhost'
    app.config['MYSQL_USER'] = 'root'
    app.config['MYSQL_PASSWORD'] = 'Raj@1552003'
    app.config['MYSQL_DB'] = 'emart'


    def get_db():
            return mysql.connector.connect(
            host=app.config['MYSQL_HOST'],
            user=app.config['MYSQL_USER'],
            password=app.config['MYSQL_PASSWORD'],
            database=app.config['MYSQL_DB']
        )
        
    mysql_conn = get_db()
    
    from .views import views
    from .auth import auth

    app.register_blueprint(views, url_prefix='/')
    app.register_blueprint(auth, url_prefix='/')

    return app