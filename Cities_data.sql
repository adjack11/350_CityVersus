CREATE DATABASE major_cities;
USE major_cities;

CREATE TABLE cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(30),
    state CHAR(2),

    population INT,
    white_percent DECIMAL(5,2),
    black_percent DECIMAL(5,2),
    american_indian_percent DECIMAL(5,2),
    asian_percent DECIMAL(5,2),
    pacific_islander_percent DECIMAL(5,2),
    -- two or more races
    two_plus_races_percent DECIMAL(5,2),
    hispanic_percent DECIMAL(5,2),

    median_income INT,
    median_gross_rent INT,
    median_monthly_owner_cost INT,
    unemployment_rate DECIMAL(5,2),

    uninsured_percent DECIMAL(5,2),
    poverty_percent DECIMAL(5,2),

    violent_crime_rate DECIMAL(8,2),
    property_crime_rate DECIMAL(8,2)
);

SELECT * FROM cities
