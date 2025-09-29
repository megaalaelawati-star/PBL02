// server.js (versi yang diperbarui)

require('dotenv').config();
const express = require('express');
const app = express();
const PORT = process.env.PORT | 3000;

// Impor rute utama dari folder routes
const mainRouter = require('./routes/index');

app.use(express.json());

app.get('/', (req, res) => {
    res.send('Selamat Datang di API Penjualan Kopi!');
});

// Gunakan rute utama untuk semua permintaan yang masuk ke /api
// Ini berarti semua rute yang didefinisikan di dalam mainRouter akan diawali dengan /api
app.use('/api', mainRouter);
// server.js

// Mengimpor paket dotenv untuk memuat variabel lingkungan
require('dotenv').config();
// Mengimpor framework Express
const express = require('express');

// Membuat instance aplikasi Express
const app = express();
// Mengambil port dari variabel lingkungan, atau default ke 3000
const PORT = process.env.PORT | 3000;

// Middleware untuk mem-parsing body request dalam format JSON
// Ini memungkinkan kita untuk membaca data yang dikirim dari klien (misal: dari form)
app.use(express.json());

// Rute dasar untuk memastikan server berjalan
app.get('/', (req, res) => {
    res.send('Selamat Datang di API Penjualan Kopi!');
});

// Menjalankan server dan mendengarkan koneksi yang masuk pada port yang ditentukan
app.listen(PORT, () => {
    console.log(`Server berjalan pada port ${PORT}`);
});

//Jalankan server dengan perintah `npm run dev`. Jika semua konfigurasi benar, Anda akan melihat pesan "Server berjalan pada port 3000" di terminal. Anda juga dapat membuka `http://localhost:3000` di *browser* dan melihat pesan selamat datang.
app.listen(PORT, () => {
    console.log(`Server berjalan pada port ${PORT}`);
});