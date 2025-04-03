require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const showRoutes = require('./routes/shows'); // Vérifiez bien cette ligne

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(bodyParser.json());
app.use('/uploads', express.static('uploads'));
app.use('/shows', showRoutes); // Assurez-vous que showRoutes est bien défini

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
