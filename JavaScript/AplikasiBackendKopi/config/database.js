// config/database.js

// Mengimpor paket dotenv untuk memuat variabel lingkungan dari file.env
require('dotenv').config();
// Mengimpor paket mysql2/promise untuk interaksi database dengan async/await
const mysql = require('mysql2/promise');

// Membuat connection pool untuk mengelola koneksi ke database MySQL secara efisien
// Pool lebih efisien daripada membuat koneksi baru untuk setiap query
const pool = mysql.createPool({
    host: process.env.DB_HOST,       // Host database dari variabel lingkungan
    user: process.env.DB_USER,       // User database dari variabel lingkungan
    password: process.env.DB_PASSWORD, // Password database dari variabel lingkungan
    database: process.env.DB_NAME,   // Nama database dari variabel lingkungan
    waitForConnections: true,        // Menunggu koneksi tersedia jika semua sedang digunakan
    connectionLimit: 10,             // Jumlah maksimum koneksi dalam pool
    queueLimit: 0                    // Tidak ada batasan antrian untuk query yang masuk
});

// Mengekspor pool agar bisa digunakan di modul lain (misalnya, di models)
module.exports = pool;