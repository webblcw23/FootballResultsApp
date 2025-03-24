const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('This is a simple Terraform with Docker Project!');
});

app.listen(port, () => {
  console.log(`App running at http://localhost:${port}`);
});
