const login = (username, password) => {
    // Dummy validation for simplicity
    if (username === 'admin' && password === 'password123') {
        return 'Login successful';
    } else {
        return 'Invalid credentials';
    }
};

module.exports = login; // Export the function for testing.
