// controllers/laporanController.js

const Laporan = require('../models/laporanModel');

const laporanController = {
    /**
     * Handler untuk mendapatkan laporan penjualan bulanan.
     * @param {import('express').Request} req - Objek request Express.
     * @param {import('express').Response} res - Objek response Express.
     */
    generateLaporanBulanan: async (req, res) => {
        try {
            const laporan = await Laporan.getLaporanBulanan();
            res.status(200).json(laporan);
        } catch (error) {
            res.status(500).json({ message: 'Error menghasilkan laporan', error: error.message });
        }
    }
};

module.exports = laporanController;