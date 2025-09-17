-- Menghapus database jika sudah ada
DROP DATABASE pbl2;

-- Membuat database baru
CREATE DATABASE IF NOT EXISTS pbl2;

-- Menggunakan database yang baru dibuat
USE pbl2;

-- Membuat tabel siswa
CREATE TABLE IF NOT EXISTS siswa (
    nis VARCHAR(5),
    nama VARCHAR(50),
    alamat VARCHAR(100),
    kota VARCHAR(25)
);

-- Mengubah nama kolom 'nis' menjadi 'nisa'
ALTER TABLE siswa
RENAME COLUMN nis TO nisa;


-- Menampilkan struktur tabel siswa
DESCRIBE siswa;

-- Mengubah nama kolom 'nisa' kembali menjadi 'nis' dan mengubah tipe datanya
ALTER TABLE siswa
CHANGE nisa nis VARCHAR(10);

-- Menampilkan semua tabel yang ada di database
SHOW TABLES;

-- Menampilkan struktur tabel siswa kembali
DESCRIBE siswa;


INSERT siswa VALUES ('1234567890', 'Septiawan', 'Cirendeu', 'Bandung');
INSERT siswa VALUES 
	('1234567891', 'Damayanti', 'Gubeng', 'Surabaya'),
    ('1234567892', 'Dzakiy', 'Gubeng', 'Surabaya'),
    ('1234567893', 'Dzaka', 'Ciganitri', 'Bandung'),
    ('1234567894', 'Nabila', 'Ciganitri', 'Bandung');
    
    select * from siswa;