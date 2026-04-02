-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 09, 2026 at 04:46 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_parkir`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_area`
--

CREATE TABLE `tb_area` (
  `id_area` int(11) NOT NULL,
  `nama_area` varchar(100) NOT NULL,
  `kapasitas` int(11) NOT NULL,
  `terisi` int(11) DEFAULT 0,
  `jenis_kendaraan` enum('motor','mobil','truk','semua') NOT NULL,
  `status` enum('aktif','nonaktif') DEFAULT 'aktif',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_area`
--

INSERT INTO `tb_area` (`id_area`, `nama_area`, `kapasitas`, `terisi`, `jenis_kendaraan`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Area A - Motor', 50, 0, 'motor', 'aktif', '2026-01-13 01:06:22', '2026-01-13 01:38:03'),
(2, 'Area B - Mobil', 30, 0, 'mobil', 'aktif', '2026-01-13 01:06:22', '2026-01-13 01:06:22'),
(3, 'Area C - Truk', 10, 0, 'truk', 'aktif', '2026-01-13 01:06:22', '2026-01-13 01:48:15'),
(4, 'Area D - Umum', 40, 0, 'semua', 'aktif', '2026-01-13 01:06:22', '2026-01-13 01:06:22');

-- --------------------------------------------------------

--
-- Table structure for table `tb_kendaraan`
--

CREATE TABLE `tb_kendaraan` (
  `id_kendaraan` int(11) NOT NULL,
  `no_plat` varchar(20) NOT NULL,
  `jenis_kendaraan` enum('motor','mobil','truk') NOT NULL,
  `merk` varchar(50) DEFAULT NULL,
  `warna` varchar(30) DEFAULT NULL,
  `pemilik` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_log`
--

CREATE TABLE `tb_log` (
  `id_log` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `aktivitas` varchar(255) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_log`
--

INSERT INTO `tb_log` (`id_log`, `id_user`, `aktivitas`, `keterangan`, `ip_address`, `created_at`) VALUES
(10, 6, 'Login', 'User berhasil login', '::1', '2026-01-13 01:36:57'),
(11, 6, 'Transaksi Masuk', 'Kendaraan D 4679 AEP masuk dengan tiket TKT20260113023742340', '::1', '2026-01-13 01:37:42'),
(12, 6, 'Transaksi Keluar', 'Kendaraan D 4679 AEP keluar dengan tiket TKT20260113023742340', '::1', '2026-01-13 01:38:03'),
(13, 6, 'Logout', 'User logout dari sistem', '::1', '2026-01-13 01:39:09'),
(29, 6, 'Login', 'User berhasil login', '::1', '2026-01-13 01:43:32'),
(30, 6, 'Logout', 'User logout dari sistem', '::1', '2026-01-13 01:43:51'),
(36, 6, 'Login', 'User berhasil login', '::1', '2026-01-13 01:46:16'),
(37, 6, 'Transaksi Masuk', 'Kendaraan D 4679 AEP masuk dengan tiket TKT20260113024811598', '::1', '2026-01-13 01:48:11'),
(38, 6, 'Transaksi Keluar', 'Kendaraan D 4679 AEP keluar dengan tiket TKT20260113024811598', '::1', '2026-01-13 01:48:15'),
(39, 6, 'Logout', 'User logout dari sistem', '::1', '2026-01-13 01:49:57');

-- --------------------------------------------------------

--
-- Table structure for table `tb_tarif`
--

CREATE TABLE `tb_tarif` (
  `id_tarif` int(11) NOT NULL,
  `jenis_kendaraan` enum('motor','mobil','truk') NOT NULL,
  `tarif_per_jam` decimal(10,2) NOT NULL,
  `denda_per_hari` decimal(10,2) DEFAULT 0.00,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_tarif`
--

INSERT INTO `tb_tarif` (`id_tarif`, `jenis_kendaraan`, `tarif_per_jam`, `denda_per_hari`, `keterangan`, `created_at`, `updated_at`) VALUES
(2, 'mobil', 5000.00, 20000.00, 'Tarif parkir mobil per jam', '2026-01-13 01:06:22', '2026-01-13 01:06:22'),
(3, 'truk', 10000.00, 30000.00, 'Tarif parkir truk per jam', '2026-01-13 01:06:22', '2026-01-13 01:06:22'),
(4, 'motor', 2000.00, 0.00, NULL, '2026-02-09 02:32:58', '2026-02-09 02:32:58');

-- --------------------------------------------------------

--
-- Table structure for table `tb_transaksi`
--

CREATE TABLE `tb_transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `kode_tiket` varchar(20) NOT NULL,
  `id_kendaraan` int(11) NOT NULL,
  `id_area` int(11) NOT NULL,
  `id_petugas` int(11) NOT NULL,
  `waktu_masuk` datetime NOT NULL,
  `waktu_keluar` datetime DEFAULT NULL,
  `durasi_jam` int(11) DEFAULT 0,
  `tarif` decimal(10,2) DEFAULT 0.00,
  `denda` decimal(10,2) DEFAULT 0.00,
  `total_bayar` decimal(10,2) DEFAULT 0.00,
  `status` enum('masuk','keluar') DEFAULT 'masuk',
  `catatan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `plat_nomor` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `level` enum('admin','petugas','owner') NOT NULL,
  `status` enum('aktif','nonaktif') DEFAULT 'aktif',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`id_user`, `username`, `password`, `nama_lengkap`, `level`, `status`, `created_at`, `updated_at`) VALUES
(6, 'araska1', '70d3cdc312ae67d3465706c60f137f33', 'Araska1', 'petugas', 'aktif', '2026-01-13 01:34:04', '2026-01-13 01:43:14'),
(8, 'raka', 'raka123', 'raka', 'admin', 'aktif', '2026-02-03 04:17:45', '2026-02-03 04:17:45'),
(9, 'rakapetugas', '1233', '', 'petugas', 'aktif', '2026-02-09 02:27:43', '2026-02-09 02:27:43'),
(11, 'rakaowner', '321', '', 'owner', 'aktif', '2026-02-09 02:28:35', '2026-02-09 02:28:35');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_rekap_transaksi`
-- (See below for the actual view)
--
CREATE TABLE `view_rekap_transaksi` (
`id_transaksi` int(11)
,`kode_tiket` varchar(20)
,`no_plat` varchar(20)
,`jenis_kendaraan` enum('motor','mobil','truk')
,`nama_area` varchar(100)
,`petugas` varchar(100)
,`waktu_masuk` datetime
,`waktu_keluar` datetime
,`durasi_jam` int(11)
,`total_bayar` decimal(10,2)
,`status` enum('masuk','keluar')
);

-- --------------------------------------------------------

--
-- Structure for view `view_rekap_transaksi`
--
DROP TABLE IF EXISTS `view_rekap_transaksi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_rekap_transaksi`  AS SELECT `t`.`id_transaksi` AS `id_transaksi`, `t`.`kode_tiket` AS `kode_tiket`, `k`.`no_plat` AS `no_plat`, `k`.`jenis_kendaraan` AS `jenis_kendaraan`, `a`.`nama_area` AS `nama_area`, `u`.`nama_lengkap` AS `petugas`, `t`.`waktu_masuk` AS `waktu_masuk`, `t`.`waktu_keluar` AS `waktu_keluar`, `t`.`durasi_jam` AS `durasi_jam`, `t`.`total_bayar` AS `total_bayar`, `t`.`status` AS `status` FROM (((`tb_transaksi` `t` join `tb_kendaraan` `k` on(`t`.`id_kendaraan` = `k`.`id_kendaraan`)) join `tb_area` `a` on(`t`.`id_area` = `a`.`id_area`)) join `tb_user` `u` on(`t`.`id_petugas` = `u`.`id_user`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_area`
--
ALTER TABLE `tb_area`
  ADD PRIMARY KEY (`id_area`);

--
-- Indexes for table `tb_kendaraan`
--
ALTER TABLE `tb_kendaraan`
  ADD PRIMARY KEY (`id_kendaraan`),
  ADD UNIQUE KEY `no_plat` (`no_plat`);

--
-- Indexes for table `tb_log`
--
ALTER TABLE `tb_log`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `tb_tarif`
--
ALTER TABLE `tb_tarif`
  ADD PRIMARY KEY (`id_tarif`);

--
-- Indexes for table `tb_transaksi`
--
ALTER TABLE `tb_transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD UNIQUE KEY `kode_tiket` (`kode_tiket`),
  ADD KEY `id_kendaraan` (`id_kendaraan`),
  ADD KEY `id_area` (`id_area`),
  ADD KEY `id_petugas` (`id_petugas`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_area`
--
ALTER TABLE `tb_area`
  MODIFY `id_area` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tb_kendaraan`
--
ALTER TABLE `tb_kendaraan`
  MODIFY `id_kendaraan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_log`
--
ALTER TABLE `tb_log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `tb_tarif`
--
ALTER TABLE `tb_tarif`
  MODIFY `id_tarif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tb_transaksi`
--
ALTER TABLE `tb_transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_log`
--
ALTER TABLE `tb_log`
  ADD CONSTRAINT `tb_log_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `tb_transaksi`
--
ALTER TABLE `tb_transaksi`
  ADD CONSTRAINT `tb_transaksi_ibfk_1` FOREIGN KEY (`id_kendaraan`) REFERENCES `tb_kendaraan` (`id_kendaraan`) ON DELETE CASCADE,
  ADD CONSTRAINT `tb_transaksi_ibfk_2` FOREIGN KEY (`id_area`) REFERENCES `tb_area` (`id_area`),
  ADD CONSTRAINT `tb_transaksi_ibfk_3` FOREIGN KEY (`id_petugas`) REFERENCES `tb_user` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
