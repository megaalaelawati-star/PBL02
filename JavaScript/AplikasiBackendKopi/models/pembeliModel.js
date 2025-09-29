// models/pembeliModel.js
const pool = require('../config/database');

const Pembeli = {
    create: async (dataPembeli) => {
        const query = 'INSERT INTO pembeli (nama_pembeli, nomor_telepon, email) VALUES (?, ?, ?)';
        const values = [dataPembeli.nama_pembeli, dataPembeli.nomor_telepon, dataPembeli.email];
        const [result] = await pool.query(query, values);
        return result;
    },

    findAll: async () => {
        const query = 'SELECT * FROM pembeli ORDER BY id_pembeli DESC';
        const [rows] = await pool.query(query);
        return rows;
    },

    findById: async (id) => {
        const query = 'SELECT * FROM pembeli WHERE id_pembeli = ?'; // Tambahkan spasi
        const [rows] = await pool.query(query, [id]);
        return rows[0] || null; // Return rows[0] bukan rows
    },

    update: async (id, dataPembeli) => {
        const query = 'UPDATE pembeli SET nama_pembeli = ?, nomor_telepon = ?, email = ? WHERE id_pembeli = ?';
        const values = [dataPembeli.nama_pembeli, dataPembeli.nomor_telepon, dataPembeli.email, id];
        const [result] = await pool.query(query, values);
        return result;
    },

    deleteById: async (id) => {
        const query = 'DELETE FROM pembeli WHERE id_pembeli = ?';
        const [result] = await pool.query(query, [id]);
        return result;
    }
};

module.exports = Pembeli;