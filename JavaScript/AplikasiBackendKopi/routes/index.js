const express = require('express');
const router = express.Router();

// Import route files
const pembeliRoutes = require('./pembeliRoutes');
const kasirRoutes = require('./kasirRoutes');
const transaksiRoutes = require('./transaksiRoutes');

// Gunakan routes TANPA prefix /api di sini
router.use('/pembeli', pembeliRoutes);
router.use('/kasir', kasirRoutes);
router.use('/transaksi', transaksiRoutes);

module.exports = router;