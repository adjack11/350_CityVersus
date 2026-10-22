USE major_cities;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE
);

-- Test/Example Queries: (will be ran via python/javascript) --

-- Check if the username already exists
SELECT COUNT(*) AS user_count FROM users WHERE username = 'desired_username';

-- If user_count is 0, insert the new account  (also verified by 'unique' constraint on username)

INSERT INTO users (username, password, email, phone) 
VALUES ('desired_username', 'desired_password', 'user@email.com', '123-456-7890');

-- Fetch the user's stored hash based on the login username input
SELECT user_id, username, password 
FROM users 
WHERE username = 'desired_username';

-- Find the account and its linked secondary contact for recovery
SELECT username, email 
FROM users 
WHERE username = 'desired_username' OR email = 'user@email.com' OR phone = '123-456-7890';