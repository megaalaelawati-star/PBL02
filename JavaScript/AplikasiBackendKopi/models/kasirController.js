// controllers/kasirController.js

const Kasir = require('../models/kasirModel');

const kasirController = {
    createKasir: async (req, res) => {
        try {
            const result = await Kasir.create(req.body);
            res.status(201).json({ message: 'Kasir berhasil dibuat', insertId: result.insertId });
        } catch (error) {
            res.status(500).json({ message: 'Error membuat kasir', error: error.message });
        }
    },
    getAllKasir: async (req, res) => {
        try {
            const kasir = await Kasir.findAll();
            res.status(200).json(kasir);
        } catch (error) {
            res.status(500).json({ message: 'Error mendapatkan data kasir', error: error.message });
        }
    },
    getKasirById: async (req, res) => {
        try {
            const kasir = await Kasir.findById(req.params.id);
            if (kasir) {
                res.status(200).json(kasir);
            } else {
                res.status(404).json({ message: 'Kasir tidak ditemukan' });
            }
        } catch (error) {
            res.status(500).json({ message: 'Error mendapatkan data kasir', error: error.message });
        }
    },
    updateKasir: async (req, res) => {
        try {
            const result = await Kasir.update(req.params.id, req.body);
            if (result.affectedRows > 0) {
                res.status(200).json({ message: 'Data kasir berhasil diperbarui' });
            } else {
                res.status(404).json({ message: 'Kasir tidak ditemukan' });
            }
        } catch (error) {
            res.status(500).json({ message: 'Error memperbarui data kasir', error: error.message });
        }
    },
    deleteKasir: async (req, res) => {
        try {
            const result = await Kasir.deleteById(req.params.id);
            if (result.affectedRows > 0) {
                res.status(200).json({ message: 'Kasir berhasil dihapus' });
            } else {
                res.status(404).json({ message: 'Kasir tidak ditemukan' });
            }
        } catch (error) {
            res.status(500).json({ message: 'Error menghapus kasir', error: error.message });
        }
    }
};

module.exports = kasirController;