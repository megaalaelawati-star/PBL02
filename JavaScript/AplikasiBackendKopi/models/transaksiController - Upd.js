// controllers/transaksiController.js

const Transaksi = require('../models/transaksiModel');

const transaksiController = {
    /**
     * Handler untuk membuat transaksi baru.
     * @param {import('express').Request} req - Objek request Express.
     * @param {import('express').Response} res - Objek response Express.
     */
    createTransaksi: async (req, res) => {
        try {
            const result = await Transaksi.create(req.body);
            res.status(201).json({ message: 'Transaksi berhasil dibuat', insertId: result.insertId });
        } catch (error) {
            res.status(500).json({ message: 'Error membuat transaksi', error: error.message });
        }
    },

    /**
     * Handler untuk mendapatkan semua transaksi.
     * @param {import('express').Request} req - Objek request Express.
     * @param {import('express').Response} res - Objek response Express.
     */
    getAllTransaksi: async (req, res) => {
        try {
            const transaksi = await Transaksi.findAll();
            res.status(200).json(transaksi);
        } catch (error) {
            res.status(500).json({ message: 'Error mendapatkan data transaksi', error: error.message });
        }
    },

    /**
     * Handler untuk mendapatkan transaksi berdasarkan ID.
     * @param {import('express').Request} req - Objek request Express.
     * @param {import('express').Response} res - Objek response Express.
     */
    getTransaksiById: async (req, res) => {
        try {
            const transaksi = await Transaksi.findById(req.params.id);
            if (transaksi) {
                res.status(200).json(transaksi);
            } else {
                res.status(404).json({ message: 'Transaksi tidak ditemukan' });
            }
        } catch (error) {
            res.status(500).json({ message: 'Error mendapatkan data transaksi', error: error.message });
        }
    },

    // Handler untuk update dan delete akan ditambahkan di sini
//... (di dalam file controllers/transaksiController.js, tambahkan ke objek transaksiController)

    /**
     * Handler untuk memperbarui data transaksi.
     * @param {import('express').Request} req - Objek request Express.
     * @param {import('express').Response} res - Objek response Express.
     */
    updateTransaksi: async (req, res) => {
        try {
            const result = await Transaksi.update(req.params.id, req.body);
            if (result.affectedRows > 0) {
                res.status(200).json({ message: 'Data transaksi berhasil diperbarui' });
            } else {
                res.status(404).json({ message: 'Transaksi tidak ditemukan' });
            }
        } catch (error) {
            res.status(500).json({ message: 'Error memperbarui data transaksi', error: error.message });
        }
    },

    /**
     * Handler untuk menghapus transaksi.
     * @param {import('express').Request} req - Objek request Express.
     * @param {import('express').Response} res - Objek response Express.
     */
    deleteTransaksi: async (req, res) => {
        try {
            const result = await Transaksi.deleteById(req.params.id);
            if (result.affectedRows > 0) {
                res.status(200).json({ message: 'Transaksi berhasil dihapus' });
            } else {
                res.status(404).json({ message: 'Transaksi tidak ditemukan' });
            }
        } catch (error) {
            res.status(500).json({ message: 'Error menghapus transaksi', error: error.message });
        }
    }
};

module.exports = transaksiController;