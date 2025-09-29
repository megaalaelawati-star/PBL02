// routes/index.js (versi final)

const express = require('express');
const router = express.Router();

const pembeliRoutes = require('./pembeliRoutes');
const kasirRoutes = require('./kasirRoutes');
const transaksiRoutes = require('./transaksiRoutes');
const laporanRoutes = require('./laporanRoutes');

router.use('/pembeli', pembeliRoutes);
router.use('/kasir', kasirRoutes);
router.use('/transaksi', transaksiRoutes);
router.use('/laporan', laporanRoutes);

module.exports = router;