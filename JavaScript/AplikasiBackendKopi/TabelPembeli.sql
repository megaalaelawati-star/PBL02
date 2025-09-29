-- Membuat tabel untuk menyimpan data pembeli
CREATE TABLE pembeli (
    -- ID unik untuk setiap pembeli, bertambah otomatis
    id_pembeli INT AUTO_INCREMENT PRIMARY KEY,
    -- Nama lengkap pembeli, tidak boleh kosong
    nama_pembeli VARCHAR(100) NOT NULL,
    -- Nomor telepon pembeli, bisa digunakan untuk kontak
    nomor_telepon VARCHAR(15),
    -- Alamat email pembeli, harus unik untuk setiap pembeli
    email VARCHAR(100) UNIQUE,
    -- Timestamp kapan data pembeli ini pertama kali dibuat
    dibuat_pada TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;