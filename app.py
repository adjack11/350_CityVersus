from flask import Flask, jsonify, render_template #render_template for HTML
import os
import mysql.connector
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__, template_folder=".", static_folder=".", static_url_path="/static")
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

#--- CITY ---
@app.route("/city")
def city():
    return render_template("city.html")

#--- COMPARE CITIES PAGE ---
@app.route("/compare")
def compare():
    return render_template("compare_cities.html")

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

        cursor.execute("""
            SELECT cities.city_id,
                   cities.city_name,
                   cities.state,
                   city_description.description
            FROM cities
            JOIN city_description
                ON cities.city_id = city_description.city_id
        """)

        results = cursor.fetchall()

        cursor.close()
        connection.close()

        return jsonify(results)

if __name__ == "__main__":
    app.run(debug=True)