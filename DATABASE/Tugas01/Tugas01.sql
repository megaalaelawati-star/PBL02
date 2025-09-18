##HAPUS DATABASE
DROP DATABASE IF EXISTS warung;
CREATE DATABASE warung;
USE warung;

##TABEL KELAMIN
CREATE TABLE kelamin (
    id_kelamin INT AUTO_INCREMENT PRIMARY KEY,
    jenis_kelamin VARCHAR(20) NOT NULL
);

##TABEL KOTA
CREATE TABLE kota (
    id_kota INT AUTO_INCREMENT PRIMARY KEY,
    kode_kota CHAR(3) NOT NULL,
    nama_kota VARCHAR(50) NOT NULL,
    UNIQUE KEY unique_kode_kota (kode_kota)
);

##TABEL SATUAN
CREATE TABLE satuan (
    id_satuan INT AUTO_INCREMENT PRIMARY KEY,
    kode_satuan CHAR(3) NOT NULL,
    nama_satuan VARCHAR(20) NOT NULL,
    UNIQUE KEY unique_kode_satuan (kode_satuan),
    UNIQUE KEY unique_nama_satuan (nama_satuan)
);

##TABEL PELANGGAN
CREATE TABLE pelanggan (
    kode_pelanggan CHAR(5) PRIMARY KEY,
    nama VARCHAR(50) NOT NULL,
    id_kelamin INT,
    FOREIGN KEY (id_kelamin) REFERENCES kelamin(id_kelamin)
);

##TABEL ALAMAT PELANGGAN
CREATE TABLE alamat_pelanggan (
    id_alamat INT AUTO_INCREMENT PRIMARY KEY,
    kode_pelanggan CHAR(5),
    alamat VARCHAR(100),
    id_kota INT,
    FOREIGN KEY (kode_pelanggan) REFERENCES pelanggan(kode_pelanggan),
    FOREIGN KEY (id_kota) REFERENCES kota(id_kota)
);

##TABEL PRODUK
CREATE TABLE produk (
    kode_produk CHAR(5) PRIMARY KEY,
    nama VARCHAR(50) NOT NULL,
    id_satuan INT,
    stok INT NOT NULL,
    FOREIGN KEY (id_satuan) REFERENCES satuan(id_satuan)
);

##TABEL HARGA PRODUK
CREATE TABLE harga_produk (
    id_harga INT AUTO_INCREMENT PRIMARY KEY,
    kode_produk CHAR(5),
    jenis_harga ENUM('ecer','grosir') DEFAULT 'ecer',
    harga INT NOT NULL,
    FOREIGN KEY (kode_produk) REFERENCES produk(kode_produk),
    UNIQUE KEY unique_harga_produk (kode_produk, jenis_harga)
);

##TABEL TRANSAKSI
CREATE TABLE transaksi (
    no_jual CHAR(5) PRIMARY KEY,
    tgl_jual DATE NOT NULL,
    kode_pelanggan CHAR(5),
    FOREIGN KEY (kode_pelanggan) REFERENCES pelanggan(kode_pelanggan)
);

##TABEL DETAIL TRANSAKSI
CREATE TABLE detail_transaksi (
    no_jual CHAR(5),
    kode_produk CHAR(5),
    jumlah INT NOT NULL,
    PRIMARY KEY (no_jual, kode_produk),
    FOREIGN KEY (no_jual) REFERENCES transaksi(no_jual),
    FOREIGN KEY (kode_produk) REFERENCES produk(kode_produk)
);

##DATA KELAMIN
INSERT INTO kelamin (jenis_kelamin) VALUES ('Pria'), ('Wanita');

##DATA SATUAN
INSERT INTO satuan (kode_satuan, nama_satuan) VALUES 
('BKS', 'Bungkus'),
('PK', 'Pak'),
('BTL', 'Botol');

##DATA KOTA
INSERT INTO kota (kode_kota, nama_kota) VALUES 
('JKT', 'Jakarta'),
('BDG', 'Bandung'),
('SBY', 'Surabaya');

##DATA PELANGGAN
INSERT INTO pelanggan (kode_pelanggan, nama, id_kelamin) VALUES
('PLG01', 'Mohamad', 1),
('PLG02', 'Naufal', 1),
('PLG03', 'Atila', 1),
('PLG04', 'Tsalsa', 2),
('PLG05', 'Damay', 2),
('PLG06', 'Tsaniy', 1),
('PLG07', 'Nabila', 2);

##DATA ALAMAT PELANGGAN
INSERT INTO alamat_pelanggan (kode_pelanggan, alamat, id_kota) VALUES
('PLG01', 'Priok', 1),
('PLG02', 'Cilincing', 1),
('PLG03', 'Bojongsoang', 2),
('PLG04', 'Buah Batu', 2),
('PLG05', 'Gubeng', 3),
('PLG06', 'Darmo', 3),
('PLG07', 'Lebak Bulus', 1);

##DATA PRODUK
INSERT INTO produk (kode_produk, nama, id_satuan, stok) VALUES
('P001', 'Indomie', 1, 10),
('P002', 'Roti', 2, 3),
('P003', 'Kecap', 3, 8),
('P004', 'Saos Tomat', 3, 8),
('P005', 'Bihun', 1, 5),
('P006', 'Sikat Gigi', 2, 5),
('P007', 'Pasta Gigi', 2, 7),
('P008', 'Saos Sambal', 3, 5);

##DATA HARGA PRODUK
INSERT INTO harga_produk (kode_produk, jenis_harga, harga) VALUES
('P001', 'ecer', 3000),
('P002', 'ecer', 18000),
('P003', 'ecer', 4700),
('P004', 'ecer', 5800),
('P005', 'ecer', 3500),
('P006', 'ecer', 15000),
('P007', 'ecer', 10000),
('P008', 'ecer', 7300);

#DATA TRANSAKSI
INSERT INTO transaksi (no_jual, tgl_jual, kode_pelanggan) VALUES
('J001', '2025-09-08', 'PLG03'),
('J002', '2025-09-08', 'PLG07'),
('J003', '2025-09-09', 'PLG02'),
('J004', '2025-09-10', 'PLG05');

##DATA DETAIL TRANSAKSI
INSERT INTO detail_transaksi (no_jual, kode_produk, jumlah) VALUES
('J001', 'P001', 2),
('J001', 'P003', 1),
('J001', 'P004', 1),
('J002', 'P006', 3),
('J002', 'P007', 1),
('J003', 'P001', 5),
('J003', 'P004', 2),
('J003', 'P008', 2),
('J003', 'P003', 1),
('J004', 'P002', 3),
('J004', 'P004', 2),
('J004', 'P008', 2),
('J004', 'P006', 2),
('J004', 'P007', 1);

##PROSEDUR DAN FUNGSI

DELIMITER $$
##PROSEDUR TAMBAH DATA PELANGGAN
DROP PROCEDURE IF EXISTS sp_insert_pelanggan $$
CREATE PROCEDURE sp_insert_pelanggan(
    IN p_kode CHAR(5),
    IN p_nama VARCHAR(50),
    IN p_id_kelamin INT,
    IN p_alamat VARCHAR(100),
    IN p_id_kota INT
)
BEGIN
    INSERT INTO pelanggan (kode_pelanggan, nama, id_kelamin) 
    VALUES (p_kode, p_nama, p_id_kelamin);
    
    INSERT INTO alamat_pelanggan (kode_pelanggan, alamat, id_kota)
    VALUES (p_kode, p_alamat, p_id_kota);
END $$
DELIMITER ;

DELIMITER $$
##PROSEDUR UPDATE DATA PELANGGAN
DROP PROCEDURE IF EXISTS sp_update_pelanggan $$
CREATE PROCEDURE sp_update_pelanggan(
    IN p_kode CHAR(5),
    IN p_nama VARCHAR(50),
    IN p_id_kelamin INT
)
BEGIN
    UPDATE pelanggan
    SET nama = p_nama, id_kelamin = p_id_kelamin
    WHERE kode_pelanggan = p_kode;
END $$
DELIMITER ;

DELIMITER $$
##PROSEDUR HAPUS PELANGGAN
DROP PROCEDURE IF EXISTS sp_delete_pelanggan $$
CREATE PROCEDURE sp_delete_pelanggan(IN p_kode CHAR(5))
BEGIN
    DELETE FROM alamat_pelanggan WHERE kode_pelanggan = p_kode;
    DELETE FROM transaksi WHERE kode_pelanggan = p_kode;
    DELETE FROM pelanggan WHERE kode_pelanggan = p_kode;
END $$
DELIMITER ;

DELIMITER $$
##PROSEDUR MENGAMBIL DATA PELANGGAN
DROP PROCEDURE IF EXISTS sp_get_pelanggan $$
CREATE PROCEDURE sp_get_pelanggan()
BEGIN
    SELECT 
        p.kode_pelanggan,
        p.nama AS nama_pelanggan,
        k.jenis_kelamin,
        a.alamat,
        kt.kode_kota AS kota
    FROM pelanggan p
    JOIN kelamin k ON p.id_kelamin = k.id_kelamin
    JOIN alamat_pelanggan a ON p.kode_pelanggan = a.kode_pelanggan
    JOIN kota kt ON a.id_kota = kt.id_kota;
END $$
DELIMITER ;

DELIMITER $$
##PROSEDUR MENGAMBIL DATA PRODUK
DROP PROCEDURE IF EXISTS sp_get_produk $$
CREATE PROCEDURE sp_get_produk()
BEGIN
    SELECT 
        p.kode_produk AS kode,
        p.nama AS nama,
        s.nama_satuan AS satuan,
        p.stok,
        h.harga
    FROM produk p
    JOIN satuan s ON p.id_satuan = s.id_satuan
    JOIN harga_produk h ON p.kode_produk = h.kode_produk
    ORDER BY p.kode_produk;
END $$
DELIMITER ;

DELIMITER $$
##PROSEDUR MENGAMBIL DATA PENJUALAN
DROP PROCEDURE IF EXISTS sp_get_penjualan $$
CREATE PROCEDURE sp_get_penjualan()
BEGIN
    SELECT 
        DATE_FORMAT(t.tgl_jual, '%d/%m/%Y') AS tanggal_jual,
        t.no_jual,
        p.nama AS nama_pelanggan,
        pr.nama AS nama_produk,
        s.nama_satuan AS satuan,
        d.jumlah,
        h.harga,
        (d.jumlah * h.harga) AS total
    FROM transaksi t
    JOIN pelanggan p ON t.kode_pelanggan = p.kode_pelanggan
    JOIN detail_transaksi d ON t.no_jual = d.no_jual
    JOIN produk pr ON d.kode_produk = pr.kode_produk
    JOIN satuan s ON pr.id_satuan = s.id_satuan
    JOIN harga_produk h ON pr.kode_produk = h.kode_produk
    ORDER BY t.tgl_jual, t.no_jual;
END $$
DELIMITER ;

DELIMITER $$
##PROSEDUR MENCARI PENJUALAN BERDASARKAN NAMA PELANGGAN
DROP PROCEDURE IF EXISTS sp_cari_penjualan $$
CREATE PROCEDURE sp_cari_penjualan(IN keyword VARCHAR(50))
BEGIN
    SELECT 
        t.no_jual,
        DATE_FORMAT(t.tgl_jual, '%d/%m/%Y') AS tanggal,
        p.nama AS nama_pelanggan,
        pr.nama AS nama_produk,
        s.nama_satuan AS satuan,
        d.jumlah,
        h.harga,
        (d.jumlah * h.harga) AS total
    FROM transaksi t
    JOIN pelanggan p ON t.kode_pelanggan = p.kode_pelanggan
    JOIN detail_transaksi d ON t.no_jual = d.no_jual
    JOIN produk pr ON d.kode_produk = pr.kode_produk
    JOIN satuan s ON pr.id_satuan = s.id_satuan
    JOIN harga_produk h ON pr.kode_produk = h.kode_produk
    WHERE p.nama LIKE CONCAT('%', keyword, '%')
    ORDER BY t.no_jual;
END $$
DELIMITER ;

---
DELIMITER $$
##PROSEDUR MENDAPATKAN PELANGGAN BERDASARKAN SATUAN PRODUK
DROP PROCEDURE IF EXISTS sp_get_pelanggan_by_satuan$$
CREATE PROCEDURE sp_get_pelanggan_by_satuan(IN p_kode_satuan CHAR(3))
BEGIN
    SELECT DISTINCT
        p.kode_pelanggan,
        p.nama AS nama_pelanggan,
        k.jenis_kelamin,
        a.alamat,
        kt.kode_kota AS kota,
        s.kode_satuan,
        s.nama_satuan
    FROM pelanggan p
    JOIN kelamin k ON p.id_kelamin = k.id_kelamin
    JOIN alamat_pelanggan a ON p.kode_pelanggan = a.kode_pelanggan
    JOIN kota kt ON a.id_kota = kt.id_kota
    JOIN transaksi t ON p.kode_pelanggan = t.kode_pelanggan
    JOIN detail_transaksi dt ON t.no_jual = dt.no_jual
    JOIN produk pr ON dt.kode_produk = pr.kode_produk
    JOIN satuan s ON pr.id_satuan = s.id_satuan
    WHERE s.kode_satuan = p_kode_satuan
    ORDER BY p.nama;
END $$
DELIMITER ;

---
DELIMITER $$
##FUNGSI MENGHITUNG SUB-TOTAL UNTUK SATU ITEM
DROP FUNCTION IF EXISTS fn_sub_total_item$$
CREATE FUNCTION fn_sub_total_item(p_kode_produk CHAR(5), p_jumlah INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE harga_item INT;
    SELECT harga INTO harga_item FROM harga_produk WHERE kode_produk = p_kode_produk;
    RETURN p_jumlah * IFNULL(harga_item, 0);
END $$
DELIMITER ;

---
DELIMITER $$
##PROSEDUR MENGAMBIL DATA PENJUALAN KESELURUHAN
DROP PROCEDURE IF EXISTS sp_get_penjualan_lengkap $$
CREATE PROCEDURE sp_get_penjualan_lengkap()
BEGIN
    SELECT 
        p.nama AS nama_pelanggan,
        k.jenis_kelamin,
        ap.alamat,
        kt.nama_kota AS kota,
        DATE_FORMAT(t.tgl_jual, '%d/%m/%Y') AS tanggal_jual,
        t.no_jual,
        pr.nama AS nama_produk,
        d.jumlah,
        s.nama_satuan AS satuan,
        h.harga,
        (d.jumlah * h.harga) AS total
    FROM transaksi t
    JOIN pelanggan p ON t.kode_pelanggan = p.kode_pelanggan
    JOIN kelamin k ON p.id_kelamin = k.id_kelamin
    JOIN alamat_pelanggan ap ON p.kode_pelanggan = ap.kode_pelanggan
    JOIN kota kt ON ap.id_kota = kt.id_kota
    JOIN detail_transaksi d ON t.no_jual = d.no_jual
    JOIN produk pr ON d.kode_produk = pr.kode_produk
    JOIN satuan s ON pr.id_satuan = s.id_satuan
    JOIN harga_produk h ON pr.kode_produk = h.kode_produk
    ORDER BY t.tgl_jual, t.no_jual;
END $$
DELIMITER ;

DELIMITER $$

##PROSEDUR MENGAMBIL DATA PENJUALAN KESELURUHAN
DROP PROCEDURE IF EXISTS sp_get_penjualan_lengkap $$
CREATE PROCEDURE sp_get_penjualan_lengkap()
BEGIN
    SELECT 
        p.kode_pelanggan,
        p.nama AS nama_pelanggan,
        k.jenis_kelamin,
        ap.alamat,
        kt.nama_kota AS kota,
        DATE_FORMAT(t.tgl_jual, '%d/%m/%Y') AS tanggal_jual,
        t.no_jual,
        pr.nama AS nama_produk,
        pr.kode_produk AS kode_produk,
        d.jumlah,
        s.nama_satuan AS satuan,
        h.harga,
        (d.jumlah * h.harga) AS total
    FROM transaksi t
    JOIN pelanggan p ON t.kode_pelanggan = p.kode_pelanggan
    JOIN kelamin k ON p.id_kelamin = k.id_kelamin
    JOIN alamat_pelanggan ap ON p.kode_pelanggan = ap.kode_pelanggan
    JOIN kota kt ON ap.id_kota = kt.id_kota
    JOIN detail_transaksi d ON t.no_jual = d.no_jual
    JOIN produk pr ON d.kode_produk = pr.kode_produk
    JOIN satuan s ON pr.id_satuan = s.id_satuan
    JOIN harga_produk h ON pr.kode_produk = h.kode_produk
    ORDER BY t.tgl_jual, t.no_jual;
END $$
DELIMITER ;

DELIMITER $$
##FUNGSI MENGHITUNG TOTAL PENJUALAN
DROP FUNCTION IF EXISTS fn_total_penjualan$$
CREATE FUNCTION fn_total_penjualan(noJual CHAR(5))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(fn_sub_total_item(d.kode_produk, d.jumlah))
    INTO total
    FROM detail_transaksi d
    WHERE d.no_jual = noJual;
    RETURN IFNULL(total, 0);
END $$
DELIMITER ;

CALL sp_get_pelanggan();
CALL sp_get_produk();
CALL sp_get_penjualan();
CALL sp_get_penjualan_lengkap();