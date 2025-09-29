// routes/index.js (versi akhir untuk bagian ini)

const express = require('express');
const router = express.Router();

// Mengimpor rute-rute
const pembeliRoutes = require('./pembeliRoutes');
const kasirRoutes = require('./kasirRoutes');

// Menggunakan rute-rute
router.use('/pembeli', pembeliRoutes);
router.use('/kasir', kasirRoutes);

module.exports = router;