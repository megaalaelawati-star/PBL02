// models/kasirModel.js

const pool = require('../config/database');

const Kasir = {
    create: async (dataKasir) => {
        const query = 'INSERT INTO kasir (nama_kasir, nomor_pegawai) VALUES (?,?)';
        const values = [dataKasir.nama_kasir, dataKasir.nomor_pegawai];
        const [result] = await pool.query(query, values);
        return result;
    },
    findAll: async () => {
        const query = 'SELECT * FROM kasir';
        const [rows] = await pool.query(query);
        return rows;
    },
    findById: async (id) => {
        const query = 'SELECT * FROM kasir WHERE id_kasir =?';
        const [rows] = await pool.query(query, [id]);
        return rows || null;
    },
    update: async (id, dataKasir) => {
        const query = 'UPDATE kasir SET nama_kasir =?, nomor_pegawai =? WHERE id_kasir =?';
        const values = [dataKasir.nama_kasir, dataKasir.nomor_pegawai, id];
        const [result] = await pool.query(query, values);
        return result;
    },
    deleteById: async (id) => {
        const query = 'DELETE FROM kasir WHERE id_kasir =?';
        const [result] = await pool.query(query, [id]);
        return result;
    }
};

module.exports = Kasir;