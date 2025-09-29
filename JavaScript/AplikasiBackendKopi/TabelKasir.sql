-- Membuat tabel untuk menyimpan data kasir
CREATE TABLE kasir (
    -- ID unik untuk setiap kasir, bertambah otomatis
    id_kasir INT AUTO_INCREMENT PRIMARY KEY,
    -- Nama lengkap kasir, tidak boleh kosong
    nama_kasir VARCHAR(100) NOT NULL,
    -- Nomor identifikasi pegawai untuk kasir, harus unik
    nomor_pegawai VARCHAR(50) UNIQUE NOT NULL,
    -- Timestamp kapan data kasir ini pertama kali dibuat
    dibuat_pada TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;