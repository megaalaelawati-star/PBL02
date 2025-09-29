// routes/laporanRoutes.js

const express = require('express');
const router = express.Router();
const laporanController = require('../controllers/laporanController');

// Rute untuk menghasilkan laporan penjualan bulanan
// GET /api/laporan/bulanan
router.get('/bulanan', laporanController.generateLaporanBulanan);

module.exports = router;