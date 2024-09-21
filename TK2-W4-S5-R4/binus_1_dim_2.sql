-- Adminer 4.8.1 MySQL 8.0.30 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `karyawan`;
CREATE TABLE `karyawan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  `level_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `level_id` (`level_id`),
  CONSTRAINT `karyawan_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `level` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `karyawan` (`id`, `nama`, `level_id`) VALUES
(1,	'Vian Azis',	1),
(2,	'Shakila Zayda',	1),
(3,	'Jamil Satrio',	1),
(4,	'Riki Setiawan',	1),
(5,	'Jurmiah',	1),
(6,	'Faisal Hidayat',	2),
(7,	'Gina Amalia',	2),
(8,	'Hendra Kurniawan',	2),
(9,	'Joko',	2),
(10,	'Ananda',	3),
(11,	'Lina Marlina',	3),
(12,	'Rudi Hartono',	4);

DROP TABLE IF EXISTS `kriteria`;
CREATE TABLE `kriteria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) DEFAULT NULL,
  `bobot` decimal(5,2) DEFAULT NULL,
  `kategori` enum('Benefit','Cost') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `kriteria` (`id`, `nama`, `bobot`, `kategori`) VALUES
(1,	'KPI',	35.00,	'Benefit'),
(2,	'Attitude',	20.00,	'Benefit'),
(3,	'Layanan',	15.00,	'Benefit'),
(4,	'Presensi',	10.00,	'Benefit'),
(5,	'Ketelitian',	20.00,	'Benefit');

DROP TABLE IF EXISTS `level`;
CREATE TABLE `level` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `level` (`id`, `nama`) VALUES
(1,	'Staff'),
(2,	'Supervisor'),
(3,	'Manager'),
(4,	'Direktur');

DROP TABLE IF EXISTS `penilaian`;
CREATE TABLE `penilaian` (
  `id` int NOT NULL AUTO_INCREMENT,
  `karyawan_id` int DEFAULT NULL,
  `kriteria_id` int DEFAULT NULL,
  `nilai` decimal(5,2) DEFAULT NULL,
  `penilai_id` int DEFAULT NULL,
  `penyetuju_id` int DEFAULT NULL,
  `status` enum('Accept','Reject') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `karyawan_id` (`karyawan_id`),
  KEY `kriteria_id` (`kriteria_id`),
  KEY `penilai_id` (`penilai_id`),
  KEY `penyetuju_id` (`penyetuju_id`),
  CONSTRAINT `penilaian_ibfk_1` FOREIGN KEY (`karyawan_id`) REFERENCES `karyawan` (`id`),
  CONSTRAINT `penilaian_ibfk_2` FOREIGN KEY (`kriteria_id`) REFERENCES `kriteria` (`id`),
  CONSTRAINT `penilaian_ibfk_3` FOREIGN KEY (`penilai_id`) REFERENCES `karyawan` (`id`),
  CONSTRAINT `penilaian_ibfk_4` FOREIGN KEY (`penyetuju_id`) REFERENCES `karyawan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `penilaian` (`id`, `karyawan_id`, `kriteria_id`, `nilai`, `penilai_id`, `penyetuju_id`, `status`) VALUES
(1,	1,	1,	80.00,	10,	10,	'Accept'),
(2,	1,	2,	85.00,	6,	10,	'Accept'),
(3,	1,	3,	90.00,	6,	10,	'Accept'),
(4,	1,	4,	95.00,	10,	10,	'Accept'),
(5,	1,	5,	100.00,	6,	10,	'Reject'),
(6,	1,	5,	88.00,	6,	10,	'Accept'),
(7,	2,	1,	75.00,	10,	10,	'Accept'),
(8,	2,	2,	80.00,	7,	10,	'Accept'),
(9,	2,	3,	95.00,	7,	10,	'Accept'),
(10,	2,	4,	85.00,	10,	10,	'Accept'),
(11,	2,	5,	80.00,	7,	10,	'Accept'),
(12,	3,	1,	90.00,	11,	11,	'Accept'),
(13,	3,	2,	88.00,	8,	11,	'Accept'),
(14,	3,	3,	92.00,	8,	11,	'Accept'),
(15,	3,	4,	90.00,	11,	11,	'Accept'),
(16,	3,	5,	95.00,	8,	11,	'Accept'),
(17,	4,	1,	70.00,	11,	11,	'Accept'),
(18,	4,	2,	90.00,	9,	11,	'Accept'),
(19,	4,	3,	80.00,	9,	11,	'Accept'),
(20,	4,	4,	85.00,	11,	11,	'Accept'),
(21,	4,	5,	78.00,	9,	11,	'Accept'),
(22,	5,	1,	85.00,	11,	11,	'Accept'),
(23,	5,	2,	90.00,	9,	11,	'Accept'),
(24,	5,	3,	88.00,	9,	11,	'Accept'),
(25,	5,	4,	95.00,	11,	11,	'Accept'),
(26,	5,	5,	90.00,	9,	11,	'Accept');

DROP VIEW IF EXISTS `view_karyawan`;
CREATE TABLE `view_karyawan` (`karyawan_id` int, `karyawan_nama` varchar(100), `level_nama` varchar(50));


DROP VIEW IF EXISTS `view_karyawan_terbaik`;
CREATE TABLE `view_karyawan_terbaik` (`nama_karyawan` varchar(100), `nilai_akhir` decimal(38,8));


DROP VIEW IF EXISTS `view_penilaian`;
CREATE TABLE `view_penilaian` (`penilaian_id` int, `karyawan_nama` varchar(100), `kriteria_nama` varchar(50), `nilai` decimal(5,2), `status` enum('Accept','Reject'), `penilai_nama` varchar(100), `penyetuju_nama` varchar(100));


DROP TABLE IF EXISTS `view_karyawan`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_karyawan` AS select `k`.`id` AS `karyawan_id`,`k`.`nama` AS `karyawan_nama`,`l`.`nama` AS `level_nama` from (`karyawan` `k` join `level` `l` on((`k`.`level_id` = `l`.`id`)));

DROP TABLE IF EXISTS `view_karyawan_terbaik`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_karyawan_terbaik` AS with `normalisasi` as (select `p`.`karyawan_id` AS `karyawan_id`,`p`.`kriteria_id` AS `kriteria_id`,`p`.`nilai` AS `nilai`,`krt`.`bobot` AS `bobot`,(case when (`krt`.`kategori` = 'Benefit') then (`p`.`nilai` / max(`p`.`nilai`) OVER (PARTITION BY `p`.`kriteria_id` ) ) when (`krt`.`kategori` = 'Cost') then (min(`p`.`nilai`) OVER (PARTITION BY `p`.`kriteria_id` )  / `p`.`nilai`) end) AS `nilai_normalisasi` from (`penilaian` `p` join `kriteria` `krt` on((`p`.`kriteria_id` = `krt`.`id`))) where (`p`.`status` = 'Accept')), `nilaikaryawan` as (select `normalisasi`.`karyawan_id` AS `karyawan_id`,sum((`normalisasi`.`nilai_normalisasi` * `normalisasi`.`bobot`)) AS `nilai_akhir` from `normalisasi` group by `normalisasi`.`karyawan_id`) select `k`.`nama` AS `nama_karyawan`,`nk`.`nilai_akhir` AS `nilai_akhir` from (`nilaikaryawan` `nk` join `karyawan` `k` on((`nk`.`karyawan_id` = `k`.`id`))) order by `nk`.`nilai_akhir` desc;

DROP TABLE IF EXISTS `view_penilaian`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_penilaian` AS select `p`.`id` AS `penilaian_id`,`k`.`nama` AS `karyawan_nama`,`kr`.`nama` AS `kriteria_nama`,`p`.`nilai` AS `nilai`,`p`.`status` AS `status`,`penilai`.`nama` AS `penilai_nama`,`penyetuju`.`nama` AS `penyetuju_nama` from ((((`penilaian` `p` join `karyawan` `k` on((`p`.`karyawan_id` = `k`.`id`))) join `kriteria` `kr` on((`p`.`kriteria_id` = `kr`.`id`))) left join `karyawan` `penilai` on((`p`.`penilai_id` = `penilai`.`id`))) left join `karyawan` `penyetuju` on((`p`.`penyetuju_id` = `penyetuju`.`id`)));

-- 2024-09-21 15:54:13
