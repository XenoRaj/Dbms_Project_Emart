

import pymysql
from flask import Blueprint, render_template, Flask, request, jsonify
from flask_login import login_required,current_user
views = Blueprint('views', __name__)
app = Flask(__name__)

# Function to establish a connection to the database
def get_connection():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='612403',
        database='projectdbms',
        cursorclass=pymysql.cursors.DictCursor
    )
# Route to render the home page template with dropdown
@views.route('/')
@login_required
def home():
    # Fetch unique named items from the database
    items = []
    connection = get_connection()
    with connection.cursor() as cursor:
        cursor.execute("SELECT DISTINCT ProductName FROM product_details")  # Replace 'your_table' with your actual table name
        results = cursor.fetchall()
        for result in results:
            items.append(result['ProductName'])

    return render_template('home.html', items=items,user = current_user)

# Route to order an item
@views.route('/order-item', methods=['POST'])
@login_required
def order_item():
    if request.method == 'POST':
        item = request.json.get('item')        
        customer_id = current_user.CustomerID
        # customer_id = 1

        try:
            connection=get_connection()
            with connection.cursor() as cursor:
                # SQL query to get the product ID
                sql = """
                SELECT product.ProductID
                FROM product
                JOIN store ON product.StoreID = store.StoreID
                WHERE product.ProductName = %s
                ORDER BY ABS(store.PINCODE - (
                    SELECT customers.PINCODE
                    FROM customers
                    WHERE customers.CustomerID = %s
                )) LIMIT 1
                """
                cursor.execute(sql, (item, customer_id))
                result = cursor.fetchone()
                if result:
                    product_id = result['ProductID']
                    sql2 = "INSERT INTO orders (CustomerID, ProductID) VALUES (%s, %s)"
                    cursor.execute(sql2, (customer_id, product_id))
                    connection.commit()
                    return jsonify({'message': f'{product_id} ordered successfully!'}), 200

        except Exception as e:
            print(e)
            return jsonify({'message': f'Failed to order item. Error: {str(e)}'}), 500


@views.route('/productInventory')
def product_inventory():
    try:
        connection = get_connection()
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT * 
                FROM PRODUCT
                NATURAL JOIN PRODUCT_DETAILS
            """)
            products = cursor.fetchall()
        item = []
        for product in products:
            item.append(product)
        return render_template('productInventory.html', item=item, user=current_user)

    except Exception as e:
        return jsonify({'message': f'Failed to fetch product inventory. Error: {str(e)}'}), 500

@views.route('/cart')
def cart():
    try:
        if current_user.is_authenticated:
            customer_id = current_user.CustomerID
            connection = get_connection()
            with connection.cursor() as cursor:
                sql = """
                    SELECT *
                    FROM CART
                    NATURAL JOIN CART_ITEMS
                    NATURAL JOIN PRODUCT
                    WHERE CustomerID = %s
                """
                cursor.execute(sql, (customer_id,))
                results = cursor.fetchall()
                item = []
                for result in results:
                    item.append(result)
            return render_template('customerCart.html', item=item, user=current_user)
    except Exception as e:
        return jsonify({'message': f'Failed to fetch shopping cart. Error: {str(e)}'}), 500


