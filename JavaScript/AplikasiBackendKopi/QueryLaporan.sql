SELECT 
    -- 1. Ekstrak tahun dari tanggal transaksi
    YEAR(t.tanggal_transaksi) AS tahun,
    -- 2. Ekstrak nama bulan dari tanggal transaksi
    MONTHNAME(t.tanggal_transaksi) AS bulan,
    -- 3. Hitung jumlah total transaksi dalam grup (bulan) ini
    COUNT(t.id_transaksi) AS jumlah_transaksi,
    -- 4. Jumlahkan total harga dari semua transaksi dalam grup ini
    SUM(t.total_harga) AS total_pendapatan
FROM 
    transaksi AS t -- 5. Mulai dari tabel transaksi
GROUP BY 
    -- 6. Kelompokkan hasil berdasarkan tahun dan bulan
    YEAR(t.tanggal_transaksi),
    MONTH(t.tanggal_transaksi),
    MONTHNAME(t.tanggal_transaksi)
ORDER BY 
    -- 7. Urutkan hasil berdasarkan tahun dan bulan secara kronologis
    tahun ASC,
    MONTH(t.tanggal_transaksi) ASC;