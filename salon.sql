-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for salon
DROP DATABASE IF EXISTS `salon`;
CREATE DATABASE IF NOT EXISTS `salon` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `salon`;

-- Dumping structure for table salon.korisnik
DROP TABLE IF EXISTS `korisnik`;
CREATE TABLE IF NOT EXISTS `korisnik` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ime` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `lozinka` varchar(255) NOT NULL,
  `rola_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `rola_id` (`rola_id`),
  CONSTRAINT `korisnik_ibfk_1` FOREIGN KEY (`rola_id`) REFERENCES `rola` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table salon.korisnik: ~3 rows (approximately)
DELETE FROM `korisnik`;
INSERT INTO `korisnik` (`id`, `ime`, `email`, `lozinka`, `rola_id`) VALUES
	(3, 'admin', 'admin@salon.com', '$2a$12$fN1AKbf7/WP3zt87jXnQ7u20.VKsQNdfj.8lzYmwjGc6yIyRolzBm', 1),
	(4, 'Petar Petrović', 'petar@salon.com', '$2a$12$ejbaLreoN9hk.T2Jm9bFZOv3fonew83naXwZGmUxOl8lhd340FAS.', 2),
	(5, 'Milica Ilić', 'milica@salon.com', '$2a$12$IBquecCWIQFKkfBQsAvsq./1vvuHSVFpXmqleDmgRQzi2H1x3sdu.', 2);

-- Dumping structure for table salon.rola
DROP TABLE IF EXISTS `rola`;
CREATE TABLE IF NOT EXISTS `rola` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `naziv` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table salon.rola: ~1 rows (approximately)
DELETE FROM `rola`;
INSERT INTO `rola` (`id`, `naziv`) VALUES
	(1, 'ADMIN'),
	(2, 'KORISNIK');

-- Dumping structure for table salon.termin
DROP TABLE IF EXISTS `termin`;
CREATE TABLE IF NOT EXISTS `termin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `datum` date NOT NULL,
  `vreme` time NOT NULL,
  `korisnik_id` bigint(20) DEFAULT NULL,
  `zaposleni_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `korisnik_id` (`korisnik_id`),
  KEY `zaposleni_id` (`zaposleni_id`),
  CONSTRAINT `termin_ibfk_1` FOREIGN KEY (`korisnik_id`) REFERENCES `korisnik` (`id`),
  CONSTRAINT `termin_ibfk_2` FOREIGN KEY (`zaposleni_id`) REFERENCES `zaposleni` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table salon.termin: ~3 rows (approximately)
DELETE FROM `termin`;
INSERT INTO `termin` (`id`, `datum`, `vreme`, `korisnik_id`, `zaposleni_id`) VALUES
	(1, '2025-06-12', '07:27:00', 4, 3),
	(2, '2025-06-28', '22:30:00', 5, 5),
	(6, '2025-06-20', '10:00:00', 3, 3);

-- Dumping structure for table salon.termin_usluga
DROP TABLE IF EXISTS `termin_usluga`;
CREATE TABLE IF NOT EXISTS `termin_usluga` (
  `termin_id` bigint(20) NOT NULL,
  `usluga_id` bigint(20) NOT NULL,
  PRIMARY KEY (`termin_id`,`usluga_id`),
  KEY `usluga_id` (`usluga_id`),
  CONSTRAINT `termin_usluga_ibfk_1` FOREIGN KEY (`termin_id`) REFERENCES `termin` (`id`),
  CONSTRAINT `termin_usluga_ibfk_2` FOREIGN KEY (`usluga_id`) REFERENCES `usluga` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table salon.termin_usluga: ~2 rows (approximately)
DELETE FROM `termin_usluga`;
INSERT INTO `termin_usluga` (`termin_id`, `usluga_id`) VALUES
	(1, 3),
	(2, 5);

-- Dumping structure for table salon.usluga
DROP TABLE IF EXISTS `usluga`;
CREATE TABLE IF NOT EXISTS `usluga` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `naziv` varchar(100) NOT NULL,
  `cena` double NOT NULL,
  `trajanje_minuta` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table salon.usluga: ~6 rows (approximately)
DELETE FROM `usluga`;
INSERT INTO `usluga` (`id`, `naziv`, `cena`, `trajanje_minuta`) VALUES
	(1, 'Muško šišanje', 700, 30),
	(2, 'Žensko šišanje', 1200, 45),
	(3, 'Feniranje', 1000, 40),
	(4, 'Bojanje kose', 2500, 90),
	(5, 'Pranje kose', 400, 15),
	(6, 'Sređivanje brade', 600, 20);

-- Dumping structure for table salon.zaposleni
DROP TABLE IF EXISTS `zaposleni`;
CREATE TABLE IF NOT EXISTS `zaposleni` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ime` varchar(100) NOT NULL,
  `specijalizacija` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table salon.zaposleni: ~4 rows (approximately)
DELETE FROM `zaposleni`;
INSERT INTO `zaposleni` (`id`, `ime`, `specijalizacija`) VALUES
	(1, 'Milan Petrović', 'Muško šišanje'),
	(2, 'Jovana Marković', 'Žensko šišanje i feniranje'),
	(3, 'Nenad Ilić', 'Brada i stilizovanje'),
	(4, 'Ana Nikolić', 'Farbanje i stilizovanje'),
	(5, 'Dejan', 'Narkomancina');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
