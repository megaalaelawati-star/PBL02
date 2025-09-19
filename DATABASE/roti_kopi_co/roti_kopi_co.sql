-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 18, 2025 at 05:12 PM
-- Server version: 8.0.30
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `roti_kopi_co`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `customer_name` varchar(100) DEFAULT NULL,
  `customer_phone` varchar(15) DEFAULT NULL,
  `nomor_antrian` varchar(10) NOT NULL,
  `tipe_pesanan` enum('dine_in','take_away') NOT NULL,
  `waktu_pesan` datetime DEFAULT CURRENT_TIMESTAMP,
  `waktu_selesai` datetime DEFAULT NULL,
  `status` enum('pending','processing','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'pending',
  `total_harga` decimal(10,2) NOT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `detail_id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `jumlah` int NOT NULL,
  `harga_satuan` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_status_history`
--

CREATE TABLE `order_status_history` (
  `history_id` int NOT NULL,
  `order_id` int NOT NULL,
  `status` enum('pending','processing','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `changed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `changed_by` int DEFAULT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int NOT NULL,
  `order_id` int NOT NULL,
  `metode` enum('cash','qris','kartu') NOT NULL,
  `jumlah_bayar` decimal(10,2) NOT NULL,
  `status` enum('paid','unpaid') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'unpaid',
  `waktu_bayar` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `permission_id` int NOT NULL,
  `permission_name` varchar(50) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permission_id`, `permission_name`, `description`) VALUES
(1, 'manage_products', 'Mengelola produk (tambah, edit, hapus)'),
(2, 'manage_promos', 'Mengelola promo'),
(3, 'view_reports', 'Melihat laporan'),
(4, 'manage_orders', 'Mengelola pesanan'),
(5, 'manage_users', 'Mengelola pengguna'),
(6, 'place_orders', 'Membuat pesanan'),
(7, 'view_orders', 'Melihat pesanan sendiri');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `nama` varchar(100) NOT NULL,
  `deskripsi` text,
  `harga` decimal(10,2) NOT NULL,
  `original_price` decimal(10,2) DEFAULT NULL,
  `discount_percent` int DEFAULT NULL,
  `kategori` varchar(50) DEFAULT NULL,
  `subkategori` varchar(50) DEFAULT NULL,
  `status` enum('available','unavailable') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'available',
  `is_promo` tinyint(1) DEFAULT '0',
  `valid_until` date DEFAULT NULL,
  `gambar_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `nama`, `deskripsi`, `harga`, `original_price`, `discount_percent`, `kategori`, `subkategori`, `status`, `is_promo`, `valid_until`, `gambar_url`) VALUES
(1, 'Family Package', 'Paket keluarga dengan 4 minuman dan 4 roti pilihan', '150000.00', '200000.00', 25, 'combo', NULL, 'available', 1, NULL, 'https://placehold.co/300x200'),
(2, 'Combo Hemat', 'Paket hemat dengan satu minuman dan satu roti pilihan', '55000.00', '75000.00', 27, 'combo', NULL, 'available', 1, NULL, 'https://placehold.co/300x200'),
(3, 'Breakfast Combo', 'Paket sarapan dengan kopi dan sandwich', '45000.00', '60000.00', 25, 'combo', NULL, 'available', 1, NULL, 'https://placehold.co/300x200'),
(4, 'Espresso', 'Kopi murni dengan rasa yang kuat dan pekat', '18000.00', NULL, NULL, 'coffee', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(5, 'Cappuccino', 'Espresso dengan steamed milk dan foam', '22000.00', NULL, NULL, 'coffee', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(6, 'Latte', 'Espresso dengan lebih banyak steamed milk dan sedikit foam', '24000.00', NULL, NULL, 'coffee', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(7, 'Americano', 'Espresso dengan air panas', '20000.00', NULL, NULL, 'coffee', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(8, 'Mocha', 'Espresso dengan coklat dan steamed milk', '26000.00', NULL, NULL, 'coffee', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(9, 'Macchiato', 'Espresso dengan sedikit foam milk', '23000.00', NULL, NULL, 'coffee', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(10, 'Green Tea Latte', 'Teh hijau dengan steamed milk', '22000.00', NULL, NULL, 'tea', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(11, 'Black Tea', 'Teh hitam pilihan dengan aroma yang harum', '15000.00', NULL, NULL, 'tea', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(12, 'Chamomile Tea', 'Teh chamomile yang menenangkan', '18000.00', NULL, NULL, 'tea', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(13, 'Earl Grey', 'Teh hitam dengan aroma bergamot', '20000.00', NULL, NULL, 'tea', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(14, 'Thai Tea', 'Teh Thailand dengan rasa yang unik', '23000.00', NULL, NULL, 'tea', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(15, 'Hot Chocolate', 'Coklat panas dengan whipped cream', '22000.00', NULL, NULL, 'nonCoffee', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(16, 'Green Tea Matcha', 'Matcha premium dengan susu', '25000.00', NULL, NULL, 'nonCoffee', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(17, 'Strawberry Smoothie', 'Smoothie stroberi segar dengan yogurt', '28000.00', NULL, NULL, 'nonCoffee', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(18, 'Mango Blast', 'Minuman mangga segar dengan soda', '26000.00', NULL, NULL, 'nonCoffee', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(19, 'Vanilla Milkshake', 'Milkshake vanilla dengan es krim', '27000.00', NULL, NULL, 'nonCoffee', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(20, 'French Toast', 'Roti panggang ala Perancis dengan maple syrup', '25000.00', NULL, NULL, 'bread', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(21, 'Avocado Toast', 'Roti panggang dengan alpukat dan telur', '28000.00', NULL, NULL, 'bread', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(22, 'Garlic Bread', 'Roti panggang dengan bawang putih dan butter', '18000.00', NULL, NULL, 'bread', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(23, 'Cinnamon Toast', 'Roti panggang dengan kayu manis dan gula', '20000.00', NULL, NULL, 'bread', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(24, 'Cheese Toast', 'Roti panggang dengan keju leleh', '22000.00', NULL, NULL, 'bread', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(25, 'Chocolate Chip Cookie', 'Cookie dengan choco chips yang melimpah', '15000.00', NULL, NULL, 'bites', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(26, 'Croissant', 'Croissant mentega yang renyah dan lembut', '18000.00', NULL, NULL, 'bites', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(27, 'Muffin Blueberry', 'Muffin dengan blueberry segar', '20000.00', NULL, NULL, 'bites', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(28, 'Brownie', 'Brownie coklat yang kaya dan lembut', '22000.00', NULL, NULL, 'bites', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(29, 'Donut', 'Donut dengan berbagai topping pilihan', '15000.00', NULL, NULL, 'bites', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(30, 'Iced Coffee Bottle', 'Kopi dingin dalam botol siap minum', '25000.00', NULL, NULL, 'bottled', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(31, 'Green Tea Bottle', 'Teh hijau dalam botol siap minum', '20000.00', NULL, NULL, 'bottled', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(32, 'Sparkling Water', 'Air soda segar dalam botol', '15000.00', NULL, NULL, 'bottled', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(33, 'Orange Juice Bottle', 'Jus jeruk segar dalam botol', '22000.00', NULL, NULL, 'bottled', NULL, 'available', 0, NULL, 'https://placehold.co/300x200'),
(34, 'Iced Tea Bottle', 'Teh dingin dalam botol siap minum', '18000.00', NULL, NULL, 'bottled', NULL, 'available', 0, NULL, 'https://placehold.co/300x200');

-- --------------------------------------------------------

--
-- Table structure for table `promos`
--

CREATE TABLE `promos` (
  `promo_id` int NOT NULL,
  `promo_name` varchar(100) NOT NULL,
  `promo_description` text,
  `promo_type` enum('discount_percent','discount_amount','combo','bundle') NOT NULL,
  `discount_value` decimal(10,2) DEFAULT NULL,
  `min_purchase` decimal(10,2) DEFAULT NULL,
  `valid_start` date NOT NULL,
  `valid_until` date NOT NULL,
  `max_usage` int DEFAULT NULL,
  `current_usage` int DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `promos`
--

INSERT INTO `promos` (`promo_id`, `promo_name`, `promo_description`, `promo_type`, `discount_value`, `min_purchase`, `valid_start`, `valid_until`, `max_usage`, `current_usage`, `is_active`, `created_at`) VALUES
(1, '2 Combo Roti Spesial', 'Dapatkan 2 roti spesial pilihan dengan harga khusus. Pilihan roti dapat disesuaikan dengan selera Anda.', 'discount_percent', '25.00', NULL, '2025-01-01', '2025-12-31', 100, 0, 1, '2025-09-15 21:41:35'),
(2, 'Happy Hour', 'Nikmati diskon 30% untuk semua minuman kopi selama jam Happy Hour (15:00 - 17:00 setiap hari).', 'discount_percent', '30.00', NULL, '2025-01-01', '2025-12-31', NULL, 0, 1, '2025-09-15 21:41:35'),
(3, 'Diskon Pengguna Baru', 'Khusus pengguna baru! Dapatkan diskon 20% untuk pembelian pertama dengan minimum transaksi Rp 50.000.', 'discount_percent', '20.00', '50000.00', '2025-01-01', '2025-12-31', NULL, 0, 1, '2025-09-15 21:41:35'),
(4, 'Buy 1 Get 1', 'Untuk pembelian minuman spesial tertentu, dapatkan satu minuman gratis dengan jenis yang sama.', 'bundle', NULL, NULL, '2025-01-01', '2025-10-31', 50, 0, 1, '2025-09-15 21:41:35'),
(5, 'Weekend Special', 'Setiap akhir pekan, nikmati paket spesial roti dan kopi dengan harga khusus hanya Sabtu dan Minggu.', 'discount_percent', '27.00', NULL, '2025-01-01', '2025-12-31', NULL, 0, 1, '2025-09-15 21:41:35'),
(6, 'Member Discount', 'Member setia Roti & Kopi Co mendapatkan diskon 15% untuk setiap pembelian dengan minimum transaksi Rp 40.000.', 'discount_percent', '15.00', '40000.00', '2025-01-01', '2025-12-31', NULL, 0, 1, '2025-09-15 21:41:35');

-- --------------------------------------------------------

--
-- Table structure for table `promo_products`
--

CREATE TABLE `promo_products` (
  `promo_product_id` int NOT NULL,
  `promo_id` int NOT NULL,
  `product_id` int NOT NULL,
  `required_quantity` int DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `promo_products`
--

INSERT INTO `promo_products` (`promo_product_id`, `promo_id`, `product_id`, `required_quantity`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 2, 4, 1),
(4, 2, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_permission_id` int NOT NULL,
  `role` enum('admin','kasir','pelanggan') NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_permission_id`, `role`, `permission_id`) VALUES
(1, 'admin', 1),
(2, 'admin', 2),
(3, 'admin', 3),
(4, 'admin', 4),
(5, 'admin', 5),
(6, 'admin', 6),
(7, 'admin', 7),
(8, 'kasir', 4),
(9, 'kasir', 6),
(10, 'kasir', 7),
(11, 'pelanggan', 6),
(12, 'pelanggan', 7);

-- --------------------------------------------------------

--
-- Table structure for table `special_events`
--

CREATE TABLE `special_events` (
  `event_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `price` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `button_text` varchar(50) DEFAULT 'Book Now',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `special_events`
--

INSERT INTO `special_events` (`event_id`, `title`, `price`, `description`, `image_url`, `button_text`, `is_active`, `created_at`) VALUES
(1, 'Birthday Package', 'Start from Rp. 800.000/20 pax', 'Rayakan hari spesial dengan paket ulang tahun eksklusif kami. Termasuk dekorasi tema, kue custom, dan minuman spesial untuk tamu Anda.', 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1469&q=80', 'Book Now', 1, '2025-09-16 19:24:44'),
(2, 'Big Order', 'Custom Quote Available', 'Khusus diberikan bagi seluruh pelanggan Roti & Kopi Co yang ingin memesan produk dalam jumlah banyak untuk acara perusahaan, pernikahan, atau pertemuan besar.', 'https://images.unsplash.com/photo-1555244162-803834f70033?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80', 'Inquire Now', 1, '2025-09-16 19:24:44');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `nomor_telepon` varchar(15) NOT NULL,
  `role` enum('admin','kasir','pelanggan') DEFAULT 'pelanggan',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_login` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `nama`, `email`, `password_hash`, `nomor_telepon`, `role`, `created_at`, `last_login`, `is_active`) VALUES
(1, 'Administrator', 'admin@rotikopico.com', '$2a$12$qK.ilpOJJ0nWvaoYz9BFYurxm9.LCYVAIxuRs3xxaM6RnDSzL9sua', '081234567890', 'admin', '2025-09-17 17:23:05', NULL, 1),
(2, 'Kasir 1', 'kasir@rotikopico.com', '$2a$12$DwXBxT7ZAYlDXsyOODKmaeSms9rJC.mDceV3VuYOt1a8AsNLs18Vu', '081234567891', 'kasir', '2025-09-17 17:23:05', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_otps`
--

CREATE TABLE `user_otps` (
  `otp_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `kode_otp` varchar(6) NOT NULL,
  `expired_at` datetime NOT NULL,
  `is_used` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_orders_status` (`status`),
  ADD KEY `idx_orders_waktu_pesan` (`waktu_pesan`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `idx_order_details_order_id` (`order_id`),
  ADD KEY `idx_order_details_product_id` (`product_id`);

--
-- Indexes for table `order_status_history`
--
ALTER TABLE `order_status_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `changed_by` (`changed_by`),
  ADD KEY `idx_order_status_history_order_id` (`order_id`),
  ADD KEY `idx_order_status_history_status` (`status`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`permission_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `idx_products_status` (`status`),
  ADD KEY `idx_products_kategori` (`kategori`);

--
-- Indexes for table `promos`
--
ALTER TABLE `promos`
  ADD PRIMARY KEY (`promo_id`);

--
-- Indexes for table `promo_products`
--
ALTER TABLE `promo_products`
  ADD PRIMARY KEY (`promo_product_id`),
  ADD KEY `promo_id` (`promo_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `special_events`
--
ALTER TABLE `special_events`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `nomor_telepon` (`nomor_telepon`),
  ADD KEY `idx_users_role` (`role`),
  ADD KEY `idx_users_email` (`email`);

--
-- Indexes for table `user_otps`
--
ALTER TABLE `user_otps`
  ADD PRIMARY KEY (`otp_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `detail_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_status_history`
--
ALTER TABLE `order_status_history`
  MODIFY `history_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `permission_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `promos`
--
ALTER TABLE `promos`
  MODIFY `promo_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `promo_products`
--
ALTER TABLE `promo_products`
  MODIFY `promo_product_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `role_permission_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `special_events`
--
ALTER TABLE `special_events`
  MODIFY `event_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_otps`
--
ALTER TABLE `user_otps`
  MODIFY `otp_id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `order_status_history`
--
ALTER TABLE `order_status_history`
  ADD CONSTRAINT `order_status_history_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_status_history_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `promo_products`
--
ALTER TABLE `promo_products`
  ADD CONSTRAINT `promo_products_ibfk_1` FOREIGN KEY (`promo_id`) REFERENCES `promos` (`promo_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `promo_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_otps`
--
ALTER TABLE `user_otps`
  ADD CONSTRAINT `user_otps_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
