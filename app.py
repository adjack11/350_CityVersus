from flask import Flask, jsonify, render_template, request, session, redirect, url_for #render_template for HTML
import os
import mysql.connector
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
app.secret_key = 'test_key'
def get_db_connection():
    connection = mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        port=int(os.getenv("DB_PORT", "3306")),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )

    return connection
# --- INDEX ---
@app.route("/")
def home():
    return render_template("index.html")

# --- CITY ---
@app.route("/city")
def city():
    #Fetch stored city name from session
    city_name = session.get('city_name', None)
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    #Grab corresponding city row from database
    cursor.execute("SELECT * FROM cities WHERE city_name = %s", (city_name,))
    row = cursor.fetchone()
    cursor.close()
    connection.close()
    #Render city.html with fetched row
    return render_template("city.html", city_data=row)

# --- COMPARE CITIES PAGE ---
@app.route("/compare")
def compare():
    return render_template("compare_cities.html")

# --- CHARTS ---
@app.route("/charts")
def charts():
    return render_template("charts.html")

# --- TESTS DATABASE CONNECTION ---
@app.route("/test-db")
def test_db():
    connection = get_db_connection()
    connection.close()
    return "MySQL connection successful!"

@app.route("/test-city")
def test_city():
    connection = get_db_connection()
    cursor = connection.cursor()

    cursor.execute("""
        SELECT description
        FROM city_description
        WHERE city_id = 10
    """)

    result = cursor.fetchone()

    cursor.close()
    connection.close()

    return result[0] if result else "City not found"


@app.route("/api/cities")
def get_cities():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    # Select all city statistics and descriptions
    cursor.execute("""
        SELECT cities.*,
               city_description.description
        FROM cities
        JOIN city_description
            ON cities.city_id = city_description.city_id
        ORDER BY cities.city_id
    """)

    results = cursor.fetchall()

    cursor.close()
    connection.close()

    return jsonify(results)

#Search button
@app.route("/search-city", methods=["POST"])
def search_city():
    #Get data from search function and store it as a session variable
    data = request.get_json()
    session['city_name'] = data["city_name"]
    #Redirect to city load
    redirect(url_for('city'))
    return jsonify("Success")

@app.route("/login", methods=["GET", "POST"])
def login():
    username = None
    error = None
    
    if request.method == "POST":
        #Capture email and password submitted from the form
        email = request.form.get("email")
        password = request.form.get("password")
        
        try:
            #Connect to MySQL database
            conn = get_db_connection()
            # dictionary=True allows accessing columns by name (e.g., user['name'])
            cursor = conn.cursor(dictionary=True)
            
            #Parameterized query to securely check credentials and prevent SQL injection
            query = "SELECT username FROM users WHERE email = %s AND password = %s"
            cursor.execute(query, (email, password))
            user = cursor.fetchone()
            
            cursor.close()
            conn.close()
            
            #Check if a matching user was found
            if user:
                session['username'] = user['username']
                return redirect(url_for('home'))
            else:
                error = "Invalid email or password."
            
        except Exception as e:
            error = str(e)

    #This runs when they first visit the page (GET), or if login fails
    return render_template("login.html", username=session.get('username'), error=error)

@app.route("/logout")
def logout():
    session.pop('username', None)
    return redirect(url_for('home'))

if __name__ == "__main__":
    app.run(debug=True)