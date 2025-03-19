const express = require('express');
const { Pool } = require('pg');
const app = express();
const PORT = 3000;

// PostgreSQL connection
const pool = new Pool({
  user: 'postgres',
  host: 'database',
  database: 'appdb',
  password: 'password',
  port: 5432,
});

app.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT message FROM greetings LIMIT 1');
    res.send(`Backend says: ${result.rows[0].message}`);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error querying the database');
  }
});

app.listen(PORT, () => {
  console.log(`Backend running on http://localhost:${PORT}`);
});
