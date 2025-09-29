// Import routes
const apiRoutes = require('./routes/index');

// Use routes DENGAN prefix /api di server.js
app.use('/api', apiRoutes); // ← prefix /api di sini

// Root route
app.get('/', (req, res) => {
    res.json({
        message: 'Selamat Datang di API Penjualan Kopi!',
        version: '1.0.0',
        endpoints: {
            pembeli: '/api/pembeli',
            kasir: '/api/kasir',
            transaksi: '/api/transaksi'
        }
    });
});