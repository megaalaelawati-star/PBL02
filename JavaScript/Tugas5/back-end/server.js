const express = require("express");
const app = express();
const PORT = 5000;

// Middleware
app.use(express.json());

// Route contoh
app.get("/", (req, res) => {
  res.send("Hello, Node.js & Express is running!");
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});