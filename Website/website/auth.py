import pymysql.cursors
from flask import Blueprint, render_template, request, flash, redirect, url_for
from flask_login import login_user, login_required, logout_user, current_user, UserMixin, LoginManager
from .models import Customers,Employee,Manager  # Assuming you have a models.py file in the same directory
from flask import session  # Add this import statement

auth = Blueprint('auth', __name__)

# Initialize Flask-Login
login_manager = LoginManager()
 
@login_manager.user_loader
def load_user(user_id):
    # Load user from database based on user_id
    # Example assuming you have a Customers model:
    return Customers.query.get(int(user_id))

# Function to establish a connection to the database
def get_connection():
    return pymysql.connect(host='localhost',
                             user='root',
                             password='612403',
                             database='projectdbms',
                           cursorclass=pymysql.cursors.DictCursor)

@login_manager.unauthorized_handler
def unauthorized_callback():
    flash("You must be logged in to view this page.", category="error")
    return redirect(url_for("auth.login"))

@auth.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')

        # Establish a connection to the database
        connection = get_connection()
        with connection.cursor() as cursor:
            # Fetch user details based on email
            sql = "SELECT * FROM customers WHERE email = %s AND passwordVal = %s"
            cursor.execute(sql, (email, password))
            user = cursor.fetchone()
            user = Customers.query.filter_by(email=email).first()
            if user: 
                flash('Logged in successfully!', category='success')
                isCustomer = True
                session['isCustomer'] = True
                # Implement your login logic here
                login_user(user, remember=True)
                return redirect(url_for('views.home'))
            else:
                flash('Incorrect email or password. Please try again.', category='error')

    return render_template("login.html", user=current_user,isCustomer = True)

@auth.route('/logout')
@login_required
def logout():
    # Check if the user is a manager and set isManager flag accordingly
    if 'isManager' in session:
        isManager = session['isManager']
    else:
        isManager = False
    
    # Check if the user is a customer and set isCustomer flag accordingly
    if 'isCustomer' in session:
        isCustomer = session['isCustomer']
    else:
        isCustomer = False

    # Logout the user
    logout_user()

    # Set isManager and isCustomer flags to False
    session['isManager'] = False
    session['isCustomer'] = False

    # Redirect to the login page
    return redirect(url_for('auth.login'))

@auth.route('/sign-up', methods=['GET','POST'])
def signUp():
    if request.method == 'POST':
        email = request.form.get('email')  
        firstName = request.form.get('firstName')  
        address = request.form.get('address')
        phoneNumber = request.form.get('phoneNumber')
        pinCode = request.form.get('pinCode')
        city = request.form.get('city')
        password = request.form.get('password')

        # Establish a connection to the database
        connection = get_connection()
        with connection.cursor() as cursor:
            # Check if user already exists
            sql = "SELECT * FROM customers WHERE email = %s"
            cursor.execute(sql, (email,))
            customers = cursor.fetchone()

            if customers:
                flash('User already exists.', category="error")
            elif len(firstName) < 2:
                flash("Name should be longer than 1 character!", category="error")
            elif len(password) < 4:
                flash("Password should be greater than 4 characters", category="error")
            else:
                # Insert new customer into the database
                sql = "INSERT INTO customers (Membership, UserName, email, FirstLineAddress, SecondLineAddress, pincode, PhoneNumber, passwordVal) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
                cursor.execute(sql, (0, firstName, email, address, city, pinCode, phoneNumber, password))
                connection.commit()
                flash("Account Created Successfully! Welcome", category="success")
                return redirect(url_for('views.home'))

    return render_template("signup.html", user=current_user)

@auth.route('/manager-login',methods =['GET','POST'])
def managerLogin():
    if request.method == 'POST':
            ManagerID = request.form.get('ManagerID')

            # Establish a connection to the database
            connection = get_connection()
            with connection.cursor() as cursor:
                # Fetch user details based on email
                sql = "SELECT * FROM Manager WHERE ManagerID = %s"
                cursor.execute(sql, (ManagerID))
                user = cursor.fetchone()
                user = Manager.query.filter_by(ManagerID=ManagerID).first()
                if user: 
                    flash('Logged in successfully!', category='success')
                    # Implement your login logic here
                    login_user(user, remember=True)
                    isManager = True
                    session['isManager'] = True
                    return redirect(url_for('views.product_inventory'))
                else:
                    flash('Incorrect ManagerID. Please try again.', category='error')

    return render_template("managerLogin.html", user=current_user,isManager = True)