const express = require('express');
const fileUpload = require('express-fileupload');
const cors = require('cors');
require('dotenv').config();

const app = express();
// cors
app.use(cors());
// app.use(express.json({limit: '50mb'}));
// public directory
app.use(express.static('src/public'));

// lectura y parse del body
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(fileUpload());

// rutas
app.use('/api/auth', require('./routes/auth'));
app.use('/api/data', require('./routes/data'));

app.listen(process.env.PORT, () => {
    console.log(`Servidor corriendo en el puerto ${process.env.PORT}.`);
});