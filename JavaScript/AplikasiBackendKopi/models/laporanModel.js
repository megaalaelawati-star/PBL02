// models/laporanModel.js

const pool = require('../config/database');

const Laporan = {
    /**
     * Menghasilkan laporan penjualan bulanan.
     * Query ini mengagregasi data dari tabel transaksi untuk memberikan ringkasan per bulan.
     * @returns {Promise<Array<object>>} Array objek yang berisi laporan penjualan bulanan.
     */
    getLaporanBulanan: async () => {
        const query = `
            SELECT 
                YEAR(tanggal_transaksi) AS tahun,
                MONTHNAME(tanggal_transaksi) AS bulan,
                COUNT(id_transaksi) AS jumlah_transaksi,
                SUM(total_harga) AS total_pendapatan
            FROM 
                transaksi
            GROUP BY 
                YEAR(tanggal_transaksi),
                MONTH(tanggal_transaksi),
                MONTHNAME(tanggal_transaksi)
            ORDER BY 
                tahun ASC,
                MONTH(tanggal_transaksi) ASC
        `;
        const [rows] = await pool.query(query);
        return rows;
    }
};

module.exports = Laporan;