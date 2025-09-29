// models/pembeliModel.js (dengan JSDoc)

const pool = require('../config/database');

const Pembeli = {
    /**
     * Mencari satu pembeli berdasarkan ID-nya.
     * Fungsi ini menjalankan query SELECT untuk mendapatkan satu record dari tabel pembeli.
     * @param {number} id - ID unik dari pembeli yang akan dicari.
     * @returns {Promise<object|null>} Sebuah Promise yang resolve dengan objek pembeli jika ditemukan, atau null jika tidak ada pembeli dengan ID tersebut.
     */
    findById: async (id) => {
        const query = 'SELECT * FROM pembeli WHERE id_pembeli =?';
        const [rows] = await pool.query(query, [id]);
        return rows || null;
    },
};