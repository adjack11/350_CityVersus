USE major_cities;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE
);

SELECT * FROM users;

INSERT INTO users (username, password, email, phone) VALUES 
('john_doe', 'securepass123', 'john@example.com', '502-555-0101'),
('jane_smith', 'mypassword456', 'jane@example.com', '502-555-0102'),
('alex_dev', 'codegeek789', 'alex@example.com', '502-555-0103'),
('sarah_w', 'pythonrules!', 'sarah@example.com', '502-555-0104'),
('mike_j', 'database999#', 'mike@example.com', '502-555-0105');

TRUNCATE TABLE users;