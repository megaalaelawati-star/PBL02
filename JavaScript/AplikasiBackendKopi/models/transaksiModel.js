// models/transaksiModel.js

const pool = require('../config/database');

const Transaksi = {
    /**
     * Membuat data transaksi baru.
     * @param {object} dataTransaksi - Objek berisi data transaksi (pembeli_id, kasir_id, total_harga, metode_pembayaran).
     * @returns {Promise<object>} Hasil dari operasi insert.
     */
    create: async (dataTransaksi) => {
        const query = 'INSERT INTO transaksi (pembeli_id, kasir_id, total_harga, metode_pembayaran) VALUES (?, ?, ?, ?)';
        const values = [dataTransaksi.pembeli_id, dataTransaksi.kasir_id, dataTransaksi.total_harga, dataTransaksi.metode_pembayaran];
        const [result] = await pool.query(query, values);
        return result;
    },

    /**
     * Mengambil semua data transaksi beserta detail pembeli dan kasir.
     * @returns {Promise<Array<object>>} Array objek yang berisi semua data transaksi.
     */
    findAll: async () => {
        // Query ini menggunakan LEFT JOIN untuk menggabungkan data dari tiga tabel.
        // Hasilnya akan mencakup nama pembeli dan nama kasir, bukan hanya ID mereka.
        const query = `
            SELECT
                t.id_transaksi,
                t.tanggal_transaksi,
                t.total_harga,
                t.metode_pembayaran,
                p.id_pembeli,
                p.nama_pembeli,
                k.id_kasir,
                k.nama_kasir
            FROM transaksi t
                     LEFT JOIN pembeli p ON t.pembeli_id = p.id_pembeli
                     LEFT JOIN kasir k ON t.kasir_id = k.id_kasir
            ORDER BY t.tanggal_transaksi DESC
        `;
        const [rows] = await pool.query(query);
        return rows;
    },

    /**
     * Mencari satu transaksi berdasarkan ID-nya, beserta detail pembeli dan kasir.
     * @param {number} id - ID transaksi yang akan dicari.
     * @returns {Promise<object|null>} Objek transaksi jika ditemukan, atau null jika tidak.
     */
    findById: async (id) => {
        const query = `
            SELECT
                t.id_transaksi,
                t.tanggal_transaksi,
                t.total_harga,
                t.metode_pembayaran,
                p.id_pembeli,
                p.nama_pembeli,
                k.id_kasir,
                k.nama_kasir
            FROM transaksi t
                     LEFT JOIN pembeli p ON t.pembeli_id = p.id_pembeli
                     LEFT JOIN kasir k ON t.kasir_id = k.id_kasir
            WHERE t.id_transaksi = ?
        `;
        const [rows] = await pool.query(query, [id]);
        return rows[0] || null;
    },

    /**
     * Memperbarui data transaksi berdasarkan ID.
     * @param {number} id - ID transaksi yang akan diperbarui.
     * @param {object} dataTransaksi - Objek berisi data yang akan diperbarui.
     * @returns {Promise<object>} Hasil dari operasi update.
     */
    update: async (id, dataTransaksi) => {
        const query = 'UPDATE transaksi SET pembeli_id = ?, kasir_id = ?, total_harga = ?, metode_pembayaran = ? WHERE id_transaksi = ?';
        const values = [dataTransaksi.pembeli_id, dataTransaksi.kasir_id, dataTransaksi.total_harga, dataTransaksi.metode_pembayaran, id];
        const [result] = await pool.query(query, values);
        return result;
    },

    /**
     * Menghapus data transaksi berdasarkan ID.
     * @param {number} id - ID transaksi yang akan dihapus.
     * @returns {Promise<object>} Hasil dari operasi delete.
     */
    deleteById: async (id) => {
        const query = 'DELETE FROM transaksi WHERE id_transaksi = ?';
        const [result] = await pool.query(query, [id]);
        return result;
    }

    // Fungsi-fungsi tambahan bisa ditambahkan di sini sesuai kebutuhan
};

module.exports = Transaksi;