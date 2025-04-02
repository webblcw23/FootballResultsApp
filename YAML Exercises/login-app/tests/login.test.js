const login = require('../app');

describe('Login Function', () => {
    test('Valid credentials return success message', () => {
        const result = login('admin', 'password123');
        expect(result).toBe('Login successful');
    });

    test('Invalid credentials return error message', () => {
        const result = login('user', 'wrongpassword');
        expect(result).toBe('Invalid credentials');
    });
});
