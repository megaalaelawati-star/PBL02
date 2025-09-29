// routes/index.js (versi akhir)

const express = require('express');
const router = express.Router();

const pembeliRoutes = require('./pembeliRoutes');
const kasirRoutes = require('./kasirRoutes');
const transaksiRoutes = require('./transaksiRoutes');

router.use('/pembeli', pembeliRoutes);
router.use('/kasir', kasirRoutes);
router.use('/transaksi', transaksiRoutes);

module.exports = router;