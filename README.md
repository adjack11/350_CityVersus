# City Versus

City Versus is a web application that allows users to explore and compare statistics from ten major U.S. cities.

The project uses Python, Flask, MySQL, HTML, CSS, and JavaScript.

## 1. Requirements

Before running the project, install:

- Python 3
- MySQL Server
- A MySQL client, such as DataGrip or MySQL Workbench
- Git (optional, if cloning the repository)

## 2. Download the Project

Clone the repository and switch to the integration branch:

```bash
git clone https://github.com/adjack11/350_CityVersus.git
cd 350_CityVersus
git switch flask-integration
```

Alternatively, download the ZIP of the `flask-integration` branch and extract it.

## 3. Set Up the Python Environment

Open a terminal in the project's main directory.

**Windows (PowerShell)**

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

**macOS**

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
```

If the environment activates successfully, the terminal should show `(.venv)`.

## 4. Set Up the MySQL Database

1. Start your local MySQL server.
2. Open DataGrip, MySQL Workbench, or another MySQL client.
3. Connect to your local MySQL server using your own credentials.
4. Open `database/database_setup.sql`.
5. Execute the entire SQL script.

The script creates the `major_cities` database with three tables:

- `cities` — Statistics for ten U.S. cities
- `city_description` — Descriptions of those cities
- `users` — Account information

**Important:** Run this setup script only on a MySQL server where the `major_cities` database does not already exist. Running it again against an existing database can produce errors.

To verify the installation, run:

```sql
USE major_cities;

SELECT COUNT(*) FROM cities;
SELECT COUNT(*) FROM city_description;
SELECT COUNT(*) FROM users;
```

Expected results are 10 cities, 10 descriptions, and 0 users.

## 5. Configure Environment Variables

Create a file named `.env` in the main project directory, alongside `app.py`.

Add the following:

```dotenv
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=YOUR_MYSQL_PASSWORD
DB_NAME=major_cities
```

Replace `YOUR_MYSQL_PASSWORD` with your own MySQL password.

If your MySQL server uses a different port or username, update those values accordingly.

For a local MySQL installation that uses an empty password, leave `DB_PASSWORD=` blank.

**Do not upload `.env` to GitHub or share your actual database password.**

## 6. Run the Application

With the Python environment activated, run:

**Windows**

```powershell
python app.py
```

**macOS**

```bash
python3 app.py
```

Open the application in your browser:

http://127.0.0.1:5000/

## 7. Verify the Database Connection

Visit:

http://127.0.0.1:5000/test-db

Expected response:

```text
MySQL connection successful!
```

To view the city data retrieved from MySQL, visit:

http://127.0.0.1:5000/api/cities

This endpoint returns city statistics and descriptions in JSON format.

## 8. Troubleshooting

**MySQL connection error**

Check that MySQL is running and the host, port, username, password, and database name in `.env` match your local installation.

**Unknown database `major_cities`**

Run `database/database_setup.sql` to create the database.

**ModuleNotFoundError**

Make sure the Python virtual environment is activated and run:

```bash
pip install -r requirements.txt
```

**HTML pages or images not loading**

Run the application through Flask rather than opening the HTML files directly. The application uses Flask templates and static file routing.

**Port 5000 already in use**

Stop any other application using port 5000 before starting Flask.

## 9. Project Structure

```text
350_CityVersus/
├── app.py
├── requirements.txt
├── .env                  # Create locally
├── database/
│   ├── database_setup.sql
│   └── other SQL files
├── templates/
│   ├── index.html
│   ├── city.html
│   ├── compare_cities.html
│   ├── charts.html
│   └── login.html
└── static/
    ├── style.css
    ├── script.js
    └── images/
```

## 10. Development Notes

The application uses Flask as its main backend and MySQL for city data.

The city statistics and descriptions are accessible through the `/api/cities` endpoint. Account-related functionality and some frontend features may still be under development.

This project is intended to run locally for development and demonstration purposes.
