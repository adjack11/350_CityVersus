const mysql = require('mysql2/promise');
const bcrypt = require('bcrypt');

async function runDatabaseApp() {
    // 1. Establish connection to your local XAMPP MySQL server
    const db = await mysql.createConnection({
        host: 'localhost',
        port: 3307,
        user: 'root',
        password: '',          // XAMPP default has no password
        database: 'major_cities'
    });

    console.log('Connected to MySQL server!');

    // FEATURE 1: REGISTER A NEW USER
    async function registerUser(username, plainPassword, email, phone) {
        try {
            // Hash the password securely using bcrypt
            const hashedPassword = await bcrypt.hash(plainPassword, 10);
            
            // Run the SQL INSERT query with the specified columns
            const query = `
                INSERT INTO users (username, password, email, phone) 
                VALUES (?, ?, ?, ?)
            `;
            
            await db.execute(query, [username, hashedPassword, email, phone]);
            console.log(`[Success]: User '${username}' registered successfully!`);
            
        } catch (err) {
            if (err.code === 'ER_DUP_ENTRY') {
                console.log('[Error]: Username, email, or phone is already registered.');
            } else {
                console.log('[Database Error]:', err.message);
            }
        }
    }

    // FEATURE 2: LOGIN VERIFICATION
    async function loginUser(username, plainPassword) {
        // Fetch the user record using the 'password' column name
        const query = `SELECT user_id, username, password FROM users WHERE username = ?`;
        const [rows] = await db.execute(query, [username]);
        
        if (rows.length === 0) {
            console.log('[Login Failed]: Username not found.');
            return false;
        }
        
        const user = rows[0];
        
        // Compare typed password against the stored bcrypt hash
        const passwordMatches = await bcrypt.compare(plainPassword, user.password);
        
        if (passwordMatches) {
            console.log(`[Success]: Welcome back, ${user.username}!`);
            return true;
        } else {
            console.log('[Login Failed]: Incorrect password.');
            return false;
        }
    }

    // FEATURE 3: PASSWORD RECOVERY LOOKUP
    async function recoverAccount(inputIdentifier) {
        // Check username, email, or phone matching the input identifier
        const query = `
            SELECT username, email 
            FROM users 
            WHERE username = ? OR email = ? OR phone = ?
        `;
        const [rows] = await db.execute(query, [inputIdentifier, inputIdentifier, inputIdentifier]);
        
        if (rows.length > 0) {
            console.log(`[Recovery]: Found account for '${rows[0].username}'. Sending reset link to email: ${rows[0].email}`);
        } else {
            console.log('[Recovery]: No matching account found.');
        }
    }

    // Testing the Functions 
    
    await registerUser("johndoe", "SecurePass123!", "john@email.com", "123-456-7890");
    await loginUser("johndoe", "SecurePass123!");
    await recoverAccount("john@email.com");

    // Close the database connection when finished
    await db.end();
}

runDatabaseApp();