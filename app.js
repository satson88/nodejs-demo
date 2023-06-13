const express = require('express');
const app = express();

// Set EJS as the template engine
app.set('view engine', 'ejs');

// Set the views directory
app.set('views', './views');

// Set the static files directory
app.use(express.static('public'));

// Define a route to render the index page
app.get('/', (req, res) => {
  res.render('index');
});

// Start the server
app.listen(3000, () => {
  console.log('Server is running on http://localhost:3000');
});