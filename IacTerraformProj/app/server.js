const express = require('express');
const { Pool } = require('pg');

const app = express();
const port = 5001;

// Middleware to parse JSON
app.use(express.json());

// Database configuration
const pool = new Pool({
  user: 'admin',
  host: '172.17.0.3',
  database: 'mydb',
  password: 'password',
  port: 5432,
});

// Test database connection
app.get('/db', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.send(`Database connected: ${result.rows[0].now}`);
  } catch (error) {
    console.error('Database connection error:', error);
    res.status(500).send('Database connection error!');
  }
});

// Add a new user
app.post('/add-user', async (req, res) => {
  try {
    const { name, email } = req.body;
    const result = await pool.query(
      'INSERT INTO users (name, email) VALUES ($1, $2) RETURNING *',
      [name, email]
    );
    res.send(`User added: ${result.rows[0].name}`);
  } catch (error) {
    console.error('Error adding user:', error);
    res.status(500).send('Error adding user!');
  }
});

app.get('/', (req, res) => {
  res.send('Hello, Node.js with PostgreSQL!');
});

app.listen(port, () => console.log(`App running on http://localhost:${port}`));