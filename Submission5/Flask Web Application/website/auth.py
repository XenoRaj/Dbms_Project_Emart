from flask import Blueprint,render_template, request, flash,redirect,url_for
from .models import Customer
from werkzeug.security import generate_password_hash, check_password_hash
from . import db   ##means from __init__.py import db
from flask_login import login_user, login_required, logout_user, current_user

auth = Blueprint('auth',__name__)

@auth.route('/login', methods=['GET','POST'])
def login():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')
        user=Customer.query.filter_by(email=email).first()
        if user:
            if check_password_hash(user.password,password):
                flash("Logged in Successfully!!", category='success')
                login_user(user,remember=True)
                return redirect('views.home')
            else:
                flash('Incorrect Password. Try Again',category='error')
        else:
            flash('Email does not exist. Please create an account', category='error')

    return  render_template("login.html",user=current_user)

@auth.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect('auth.login')
@auth.route('/sign-up', methods=['GET','POST'])
def signUp():
    if request.method == 'POST':
        email =request.form.get('email')  
        firstName =request.form.get('firstName')  
        address =request.form.get('address')
        phoneNumber = request.form.get('phoneNumber')
        pinCode =request.form.get('pinCode')
        city =request.form.get('city')
        password =request.form.get('password')
        
        user = Customer.query.filter_by(email=email).first()
        if user:
            flash('User already exists.',category="error")
        elif len(firstName)<2:
            flash("Name should be longer than 1 characters!", category="error")
        elif len(password)<4:
            flash("Password should be greater than 4 characters")
        
        else:
            new_user = Customer(Membership = 0,UserName = firstName,Email =email,FirstLineAddress = address,SecondLineAddress = city,pincode = pinCode, PhoneNumber = phoneNumber ,password = generate_password_hash(password, method='sha256' ))
            db.session.add(new_user)
            db.session.commit()
            flash("Account Made Succesfully! Welcome",category="success")
            login_user(user,remember=True)
            return redirect('views.home')
    return render_template("signup.html",user=current_user)