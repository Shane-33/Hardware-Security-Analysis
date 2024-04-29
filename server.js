// server.js

const express = require('express');
const path = require('path');
const app = express();
const port = 3001;

// Serve static files from the React frontend app
app.use(express.static(path.join(__dirname, 'build')));

// API endpoint
app.get('/api/data', (req, res) => {
  res.json({ message: 'Data from Express backend' });
});

// All other GET requests not handled before will return React app
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'build', 'index.html'));
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
