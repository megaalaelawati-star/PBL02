const express = require('express');
const router = express.Router();

// Import route files
const pembeliRoutes = require('./pembeliRoutes');
const kasirRoutes = require('./kasirRoutes');
const transaksiRoutes = require('./transaksiRoutes');

// Setup routes
router.use('/pembeli', pembeliRoutes);
router.use('/kasir', kasirRoutes);
router.use('/transaksi', transaksiRoutes);

// Health check route
router.get('/health', (req, res) => {
    res.json({
        status: 'OK',
        timestamp: new Date().toISOString(),
        service: 'Coffee Shop API'
    });
});

module.exports = router;