// controllers/pembeliController.js (dengan JSDoc)

const Pembeli = require('../models/pembeliModel');

const pembeliController = {
    /**
     * Handler untuk mendapatkan pembeli berdasarkan ID.
     * Mengambil ID dari parameter URL, memanggil model untuk mencari data,
     * dan mengirimkan respons JSON yang sesuai.
     * @param {import('express').Request} req - Objek request Express. Berisi parameter URL (req.params).
     * @param {import('express').Response} res - Objek response Express. Digunakan untuk mengirim respons ke klien.
     * @returns {void} Fungsi ini tidak mengembalikan nilai secara langsung, tetapi mengirimkan respons HTTP.
     */
    getPembeliById: async (req, res) => {
        try {
            const id = req.params.id;
            const pembeli = await Pembeli.findById(id);
            if (pembeli) {
                res.status(200).json(pembeli);
            } else {
                res.status(404).json({ message: 'Pembeli tidak ditemukan' });
            }
        } catch (error) {
            res.status(500).json({ message: 'Error mendapatkan data pembeli', error: error.message });
        }
    },
};