const express = require('express');
const { Pool } = require('pg');

const app = express();
const port = 5001;

// Database configuration
const pool = new Pool({
  user: 'admin',
  host: 'localhost',
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
    res.status(500).send('Database connection error!');
  }
});

app.get('/', (req, res) => {
  res.send('Hello, Node.js with PostgreSQL!');
});

app.listen(port, () => console.log(`App running on http://localhost:${port}`));
