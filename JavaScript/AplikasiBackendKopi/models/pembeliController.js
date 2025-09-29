// controllers/pembeliController.js

// Mengimpor model Pembeli
const Pembeli = require('../models/pembeliModel');

// Objek untuk mengelompokkan semua fungsi controller pembeli
const pembeliController = {
    /**
     * Handler untuk membuat pembeli baru.
     * @param {import('express').Request} req - Objek request Express.
     * @param {import('express').Response} res - Objek response Express.
     */
    createPembeli: async (req, res) => {
        try {
            // Memanggil metode create dari model dengan data dari body request
            const result = await Pembeli.create(req.body);
            // Mengirim respons sukses dengan status 201 (Created)
            res.status(201).json({ message: 'Pembeli berhasil dibuat', insertId: result.insertId });
        } catch (error) {
            // Mengirim respons error dengan status 500 (Internal Server Error)
            res.status(500).json({ message: 'Error membuat pembeli', error: error.message });
        }
    },

    /**
     * Handler untuk mendapatkan semua pembeli.
     * @param {import('express').Request} req - Objek request Express.
     * @param {import('express').Response} res - Objek response Express.
     */
    getAllPembeli: async (req, res) => {
        try {
            // Memanggil metode findAll dari model
            const pembeli = await Pembeli.findAll();
            // Mengirim data pembeli sebagai respons JSON dengan status 200 (OK)
            res.status(200).json(pembeli);
        } catch (error) {
            // Mengirim respons error
            res.status(500).json({ message: 'Error mendapatkan data pembeli', error: error.message });
        }
    },

    /**
     * Handler untuk mendapatkan pembeli berdasarkan ID.
     * @param {import('express').Request} req - Objek request Express.
     * @param {import('express').Response} res - Objek response Express.
     */
    getPembeliById: async (req, res) => {
        try {
            // Mengambil ID dari parameter URL
            const id = req.params.id;
            // Memanggil metode findById dari model
            const pembeli = await Pembeli.findById(id);
            if (pembeli) {
                // Jika pembeli ditemukan, kirim datanya
                res.status(200).json(pembeli);
            } else {
                // Jika tidak ditemukan, kirim status 404 (Not Found)
                res.status(404).json({ message: 'Pembeli tidak ditemukan' });
            }
        } catch (error) {
            // Mengirim respons error
            res.status(500).json({ message: 'Error mendapatkan data pembeli', error: error.message });
        }
    },

    /**
     * Handler untuk memperbarui data pembeli.
     * @param {import('express').Request} req - Objek request Express.
     * @param {import('express').Response} res - Objek response Express.
     */
    updatePembeli: async (req, res) => {
        try {
            const id = req.params.id;
            // Memanggil metode update dari model
            const result = await Pembeli.update(id, req.body);
            if (result.affectedRows > 0) {
                // Jika ada baris yang terpengaruh, berarti update berhasil
                res.status(200).json({ message: 'Data pembeli berhasil diperbarui' });
            } else {
                // Jika tidak, berarti pembeli dengan ID tersebut tidak ditemukan
                res.status(404).json({ message: 'Pembeli tidak ditemukan' });
            }
        } catch (error) {
            // Mengirim respons error
            res.status(500).json({ message: 'Error memperbarui data pembeli', error: error.message });
        }
    },

    /**
     * Handler untuk menghapus pembeli.
     * @param {import('express').Request} req - Objek request Express.
     * @param {import('express').Response} res - Objek response Express.
     */
    deletePembeli: async (req, res) => {
        try {
            const id = req.params.id;
            // Memanggil metode deleteById dari model
            const result = await Pembeli.deleteById(id);
            if (result.affectedRows > 0) {
                // Jika ada baris yang terpengaruh, berarti delete berhasil
                res.status(200).json({ message: 'Pembeli berhasil dihapus' });
            } else {
                // Jika tidak, berarti pembeli dengan ID tersebut tidak ditemukan
                res.status(404).json({ message: 'Pembeli tidak ditemukan' });
            }
        } catch (error) {
            // Mengirim respons error
            res.status(500).json({ message: 'Error menghapus pembeli', error: error.message });
        }
    }
};

// Mengekspor objek controller
module.exports = pembeliController;