-- Hapus database jika sudah ada, lalu buat baru
DROP DATABASE IF EXISTS AplikasiBackendKopi;
CREATE DATABASE Kopi;
USE Kopi;

-- Membuat tabel kasir
CREATE TABLE kasir (
    id_kasir INT AUTO_INCREMENT PRIMARY KEY,
    nama_kasir VARCHAR(100) NOT NULL,
    nomor_pegawai VARCHAR(50) UNIQUE NOT NULL,
    dibuat_pada TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Membuat tabel pembeli
CREATE TABLE pembeli (
    id_pembeli INT AUTO_INCREMENT PRIMARY KEY,
    nama_pembeli VARCHAR(100) NOT NULL,
    nomor_telepon VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    dibuat_pada TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Membuat tabel transaksi
CREATE TABLE transaksi (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    pembeli_id INT NOT NULL,
    kasir_id INT NOT NULL,
    tanggal_transaksi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_harga DECIMAL(10, 2) NOT NULL,
    metode_pembayaran VARCHAR(50),
    
    CONSTRAINT fk_pembeli
        FOREIGN KEY (pembeli_id) 
        REFERENCES pembeli(id_pembeli)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
        
    CONSTRAINT fk_kasir
        FOREIGN KEY (kasir_id) 
        REFERENCES kasir(id_kasir)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Membuat view untuk laporan (bukan tabel)
CREATE VIEW QueryLaporan AS
SELECT 
    YEAR(t.tanggal_transaksi) AS tahun,
    MONTHNAME(t.tanggal_transaksi) AS bulan,
    COUNT(t.id_transaksi) AS jumlah_transaksi,
    SUM(t.total_harga) AS total_pendapatan
FROM 
    transaksi AS t
GROUP BY 
    YEAR(t.tanggal_transaksi),
    MONTH(t.tanggal_transaksi),
    MONTHNAME(t.tanggal_transaksi)
ORDER BY 
    tahun ASC,
    MONTH(t.tanggal_transaksi) ASC;