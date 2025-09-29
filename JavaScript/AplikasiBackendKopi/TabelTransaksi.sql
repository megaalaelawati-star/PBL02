-- Membuat tabel untuk mencatat setiap transaksi penjualan
CREATE TABLE transaksi (
    -- ID unik untuk setiap transaksi, bertambah otomatis
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    -- Foreign Key yang merujuk ke ID pembeli di tabel 'pembeli'
    pembeli_id INT NOT NULL,
    -- Foreign Key yang merujuk ke ID kasir di tabel 'kasir'
    kasir_id INT NOT NULL,
    -- Tanggal dan waktu kapan transaksi terjadi
    tanggal_transaksi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- Total harga dari transaksi, menggunakan tipe data DECIMAL untuk presisi keuangan
    total_harga DECIMAL(10, 2) NOT NULL,
    -- Metode pembayaran yang digunakan (misal: 'Tunai', 'Kartu Kredit', 'Digital')
    metode_pembayaran VARCHAR(50),

    -- Mendefinisikan batasan Foreign Key untuk pembeli_id
    -- Ini memastikan bahwa setiap transaksi harus terhubung dengan pembeli yang valid
    CONSTRAINT fk_pembeli
        FOREIGN KEY (pembeli_id) 
        REFERENCES pembeli(id_pembeli)
        ON DELETE RESTRICT -- Mencegah penghapusan pembeli jika masih memiliki transaksi
        ON UPDATE CASCADE, -- Jika id_pembeli berubah, update juga di sini

    -- Mendefinisikan batasan Foreign Key untuk kasir_id
    -- Ini memastikan bahwa setiap transaksi harus ditangani oleh kasir yang valid
    CONSTRAINT fk_kasir
        FOREIGN KEY (kasir_id) 
        REFERENCES kasir(id_kasir)
        ON DELETE RESTRICT -- Mencegah penghapusan kasir jika masih memiliki transaksi
        ON UPDATE CASCADE -- Jika id_kasir berubah, update juga di sini
) ENGINE=InnoDB;