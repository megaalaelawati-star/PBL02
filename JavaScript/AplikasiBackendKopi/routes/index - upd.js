// routes/index.js (versi yang diperbarui)

const express = require('express');
const router = express.Router();

// Mengimpor rute pembeli
const pembeliRoutes = require('./pembeliRoutes');

// Menggunakan rute pembeli untuk semua permintaan yang diawali dengan /pembeli
// Contoh: GET /api/pembeli akan ditangani oleh pembeliRoutes
router.use('/pembeli', pembeliRoutes);

module.exports = router;