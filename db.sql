-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: 151.106.112.154    Database: gereja
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acara`
--

DROP TABLE IF EXISTS `acara`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acara` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `description_thumbnail` text,
  `description` text,
  `quota` int unsigned DEFAULT NULL,
  `time_before` time DEFAULT NULL,
  `time_after` time DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `canceled_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acara`
--

LOCK TABLES `acara` WRITE;
/*!40000 ALTER TABLE `acara` DISABLE KEYS */;
INSERT INTO `acara` VALUES (2,'kegiatan paskah 2024','a','kegiatan ini akan diisi dengan acara berdoa bersama dan merayakan hari raya paskah','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1000,'19:00:00','20:30:00','2023-10-09','2023-07-09 00:07:39','2023-07-31 00:00:00'),(3,'kegiatan outbonding 2024','a','kegiatan ini akan diisi dengan acara outbound dengan tujuan mempersatukan','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1000,'19:00:00','20:30:00','2023-10-09','2023-07-09 00:07:39',NULL),(4,'kegiatan natal 2023','a','kegiatan ini akan diisi dengan acara berdoa bersama dan merayakan hari raya natal','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1000,'19:00:00','20:30:00','2023-10-09','2023-07-09 00:07:39',NULL),(5,'kegiatan paskah 2024','a','kegiatan ini akan diisi dengan acara berdoa bersama dan merayakan hari raya paskah','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1000,'19:00:00','20:30:00','2023-10-09','2023-07-09 00:07:39',NULL),(6,'kegiatan outbonding 2024',NULL,'kegiatan ini akan diisi dengan acara outbound dengan tujuan mempersatukan','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1000,'19:00:00','20:30:00','2023-10-09','2023-07-31 20:01:02',NULL),(7,'title','image','test','test',1000,'09:00:00','18:00:00','2023-01-01','2023-07-31 20:44:42',NULL);
/*!40000 ALTER TABLE `acara` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acara_user_registration`
--

DROP TABLE IF EXISTS `acara_user_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acara_user_registration` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `acara_id` bigint unsigned DEFAULT NULL,
  `registered_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `event_user_registration_event_id_fk` (`acara_id`),
  KEY `event_user_registration_user_id_fk` (`user_id`),
  CONSTRAINT `event_user_registration_event_id_fk` FOREIGN KEY (`acara_id`) REFERENCES `acara` (`id`) ON DELETE CASCADE,
  CONSTRAINT `event_user_registration_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acara_user_registration`
--

LOCK TABLES `acara_user_registration` WRITE;
/*!40000 ALTER TABLE `acara_user_registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `acara_user_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(200) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','$2b$10$DBwQDPSbfesB9JznBWqo2urFL3CPmQkKxCXp59OZHr.8kDqihMPxq','2023-07-31 20:23:16');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bible`
--

DROP TABLE IF EXISTS `bible`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bible` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bible`
--

LOCK TABLES `bible` WRITE;
/*!40000 ALTER TABLE `bible` DISABLE KEYS */;
INSERT INTO `bible` VALUES (2,'title','desc','2023-07-31 22:12:28');
/*!40000 ALTER TABLE `bible` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bible_detail`
--

DROP TABLE IF EXISTS `bible_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bible_detail` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bible_id` bigint unsigned DEFAULT NULL,
  `date` date DEFAULT NULL,
  `bab` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bible_detail_bible_id_fk` (`bible_id`),
  CONSTRAINT `bible_detail_bible_id_fk` FOREIGN KEY (`bible_id`) REFERENCES `bible` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bible_detail`
--

LOCK TABLES `bible_detail` WRITE;
/*!40000 ALTER TABLE `bible_detail` DISABLE KEYS */;
INSERT INTO `bible_detail` VALUES (2,2,'2023-01-01','kejadian');
/*!40000 ALTER TABLE `bible_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bible_detail_read`
--

DROP TABLE IF EXISTS `bible_detail_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bible_detail_read` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bible_detail_id` bigint unsigned DEFAULT NULL,
  `pasal` tinyint unsigned DEFAULT NULL,
  `ayat` tinyint unsigned DEFAULT NULL,
  `isi` text,
  PRIMARY KEY (`id`),
  KEY `bible_detail_read_bible_detail_id_fk` (`bible_detail_id`),
  CONSTRAINT `bible_detail_read_bible_detail_id_fk` FOREIGN KEY (`bible_detail_id`) REFERENCES `bible_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bible_detail_read`
--

LOCK TABLES `bible_detail_read` WRITE;
/*!40000 ALTER TABLE `bible_detail_read` DISABLE KEYS */;
INSERT INTO `bible_detail_read` VALUES (2,2,10,1,'tes');
/*!40000 ALTER TABLE `bible_detail_read` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bible_detail_read_status_user`
--

DROP TABLE IF EXISTS `bible_detail_read_status_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bible_detail_read_status_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bible_detail_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `bible_detail_read_status_user_bible_detail_id_fk` (`bible_detail_id`),
  KEY `bible_detail_read_status_user_user_id_fk` (`user_id`),
  CONSTRAINT `bible_detail_read_status_user_bible_detail_id_fk` FOREIGN KEY (`bible_detail_id`) REFERENCES `bible_detail` (`id`),
  CONSTRAINT `bible_detail_read_status_user_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bible_detail_read_status_user`
--

LOCK TABLES `bible_detail_read_status_user` WRITE;
/*!40000 ALTER TABLE `bible_detail_read_status_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `bible_detail_read_status_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bible_self_reflection`
--

DROP TABLE IF EXISTS `bible_self_reflection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bible_self_reflection` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bible_detail_id` bigint unsigned DEFAULT NULL,
  `reflection` text,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `bible_self_reflection_bible_detail_id_fk` (`bible_detail_id`),
  KEY `bible_self_reflection_user_id_fk` (`user_id`),
  CONSTRAINT `bible_self_reflection_bible_detail_id_fk` FOREIGN KEY (`bible_detail_id`) REFERENCES `bible_detail` (`id`),
  CONSTRAINT `bible_self_reflection_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bible_self_reflection`
--

LOCK TABLES `bible_self_reflection` WRITE;
/*!40000 ALTER TABLE `bible_self_reflection` DISABLE KEYS */;
INSERT INTO `bible_self_reflection` VALUES (1,2,'reflexsii',1,'2023-07-31 22:46:37');
/*!40000 ALTER TABLE `bible_self_reflection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ebook`
--

DROP TABLE IF EXISTS `ebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ebook` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `author` varchar(200) DEFAULT NULL,
  `total_halaman` int unsigned DEFAULT NULL,
  `description` text,
  `publisher` varchar(200) DEFAULT NULL,
  `ISBN` varchar(200) DEFAULT NULL,
  `bahasa` bigint unsigned DEFAULT NULL,
  `whatsapp_number` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ebook_master_ebook_bahasa_id_fk` (`bahasa`),
  CONSTRAINT `ebook_master_ebook_bahasa_id_fk` FOREIGN KEY (`bahasa`) REFERENCES `master_ebook_bahasa` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ebook`
--

LOCK TABLES `ebook` WRITE;
/*!40000 ALTER TABLE `ebook` DISABLE KEYS */;
INSERT INTO `ebook` VALUES (1,'keintiman dengan Tuhan','revy halim (founder grace depth)',150,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','PT. Gramedia','7812.2892.29392',1,'0812991283192','2023-07-09 00:48:30'),(2,'when god calls you','revy halim (founder grace depth)',132,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','PT. Gramedia','7812.2892.29392',2,'0812991283192','2023-07-31 20:03:58'),(3,'keintiman dengan Tuhan','revy halim (founder grace depth)',150,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','PT. Gramedia','7812.2892.29392',1,'0812991283192','2023-07-09 00:48:30'),(4,'when god calls you','revy halim (founder grace depth)',132,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','PT. Gramedia','7812.2892.29392',2,'0812991283192','2023-07-31 20:03:58'),(5,'keintiman dengan Tuhan','revy halim (founder grace depth)',150,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','PT. Gramedia','7812.2892.29392',1,'0812991283192','2023-07-09 00:48:30'),(6,'when god calls you','revy halim (founder grace depth)',132,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','PT. Gramedia','7812.2892.29392',2,'0812991283192','2023-07-31 20:03:58'),(7,'keintiman dengan Tuhan','revy halim (founder grace depth)',150,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','PT. Gramedia','7812.2892.29392',1,'0812991283192','2023-07-09 00:48:30'),(8,'when god calls you','revy halim (founder grace depth)',132,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','PT. Gramedia','7812.2892.29392',2,'0812991283192','2023-07-31 20:03:58');
/*!40000 ALTER TABLE `ebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ebook_tags`
--

DROP TABLE IF EXISTS `ebook_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ebook_tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ebook_id` bigint unsigned DEFAULT NULL,
  `tags_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ebook_tags_ebook_id_fk` (`ebook_id`),
  KEY `ebook_tags_master_tags_id_fk` (`tags_id`),
  CONSTRAINT `ebook_tags_ebook_id_fk` FOREIGN KEY (`ebook_id`) REFERENCES `ebook` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ebook_tags_master_tags_id_fk` FOREIGN KEY (`tags_id`) REFERENCES `master_ebook_tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ebook_tags`
--

LOCK TABLES `ebook_tags` WRITE;
/*!40000 ALTER TABLE `ebook_tags` DISABLE KEYS */;
INSERT INTO `ebook_tags` VALUES (2,1,1),(3,1,2),(14,2,1),(15,2,2),(16,3,1),(17,3,1),(18,4,1),(19,4,2),(20,5,1),(21,5,2),(22,6,1),(23,6,2),(24,7,1),(25,7,2),(26,8,1),(27,8,2);
/*!40000 ALTER TABLE `ebook_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `family`
--

DROP TABLE IF EXISTS `family`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `family` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `family_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `family_user_id_fk` (`user_id`),
  KEY `family_user_id_fk_2` (`family_id`),
  CONSTRAINT `family_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `family_user_id_fk_2` FOREIGN KEY (`family_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `family`
--

LOCK TABLES `family` WRITE;
/*!40000 ALTER TABLE `family` DISABLE KEYS */;
INSERT INTO `family` VALUES (4,4,1,'2023-07-11 15:59:59'),(5,1,3,'2023-07-11 16:00:37');
/*!40000 ALTER TABLE `family` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kegiatan`
--

DROP TABLE IF EXISTS `kegiatan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kegiatan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `description_thumbnail` text,
  `description` text,
  `quota` int unsigned DEFAULT NULL,
  `time_before` time DEFAULT NULL,
  `time_after` time DEFAULT NULL,
  `day_repeat_of_week` tinyint unsigned DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `canceled_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kegiatan`
--

LOCK TABLES `kegiatan` WRITE;
/*!40000 ALTER TABLE `kegiatan` DISABLE KEYS */;
INSERT INTO `kegiatan` VALUES (1,'kegiatan sekolah minggu','a','kegiatan ini akan diisi dengan acara berdoa bersama di hari minggu','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',100,'23:37:00','23:51:04',7,NULL,'2023-07-08 16:42:22',NULL),(2,'pelayanan gereja','a','kegiatan ini akan diisi dengan melayani gereja dengan menjadi paduan suara','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',100,'23:37:00','23:51:04',NULL,'2023-08-08','2023-07-08 16:42:22',NULL),(3,'kegiatan sekolah minggu','a','kegiatan ini akan diisi dengan acara berdoa bersama di hari minggu','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',100,'23:37:00','23:51:04',7,NULL,'2023-07-08 16:42:22',NULL),(4,'pelayanan gereja','a','kegiatan ini akan diisi dengan melayani gereja dengan menjadi paduan suara','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',100,'23:37:00','23:51:04',NULL,'2023-08-08','2023-07-08 16:42:22',NULL),(5,'kegiatan sekolah minggu','a','kegiatan ini akan diisi dengan acara berdoa bersama di hari minggu','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',100,'23:37:00','23:51:04',7,NULL,'2023-07-08 16:42:22',NULL),(6,'pelayanan gereja','a','kegiatan ini akan diisi dengan melayani gereja dengan menjadi paduan suara','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',100,'23:37:00','23:51:04',NULL,'2023-08-08','2023-07-08 16:42:22',NULL);
/*!40000 ALTER TABLE `kegiatan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kegiatan_user_registration`
--

DROP TABLE IF EXISTS `kegiatan_user_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kegiatan_user_registration` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kegiatan_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `registered_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `kegiatan_user_registration_user_id_fk` (`user_id`),
  KEY `kegiatan_user_registration_kegiatan_id_fk` (`kegiatan_id`),
  CONSTRAINT `kegiatan_user_registration_kegiatan_id_fk` FOREIGN KEY (`kegiatan_id`) REFERENCES `kegiatan` (`id`) ON DELETE CASCADE,
  CONSTRAINT `kegiatan_user_registration_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kegiatan_user_registration`
--

LOCK TABLES `kegiatan_user_registration` WRITE;
/*!40000 ALTER TABLE `kegiatan_user_registration` DISABLE KEYS */;
INSERT INTO `kegiatan_user_registration` VALUES (1,1,1,'2023-07-09 00:05:03');
/*!40000 ALTER TABLE `kegiatan_user_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_ebook_bahasa`
--

DROP TABLE IF EXISTS `master_ebook_bahasa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_ebook_bahasa` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_ebook_bahasa`
--

LOCK TABLES `master_ebook_bahasa` WRITE;
/*!40000 ALTER TABLE `master_ebook_bahasa` DISABLE KEYS */;
INSERT INTO `master_ebook_bahasa` VALUES (1,'indonesia'),(2,'english');
/*!40000 ALTER TABLE `master_ebook_bahasa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_ebook_tags`
--

DROP TABLE IF EXISTS `master_ebook_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_ebook_tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_ebook_tags`
--

LOCK TABLES `master_ebook_tags` WRITE;
/*!40000 ALTER TABLE `master_ebook_tags` DISABLE KEYS */;
INSERT INTO `master_ebook_tags` VALUES (1,'pendidikan'),(2,'rohani');
/*!40000 ALTER TABLE `master_ebook_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `phone` varchar(200) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `joined_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nama` (`nama`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'eric','ericanthonywu899@gmail.com','6281236391375','$2b$10$KDDU8vdccTFdVEOCoD9Lk.XToPu/qyI59IY2uFSQA4mmqagQ/7Y5K','2023-07-08 15:34:40'),(3,'erica','ericaanthonywu89@gmail.com','0812363913755','$2b$10$RnUGlsmxeeZJczj..ribXuXHO/aP9Dd7p1XdYoeSYNNAsWh.BWkMS','2023-07-08 16:25:26'),(4,'usertest','test@gmail.com','123','$2b$10$9oAYDy7Z7TQMuCQHKyPPSem9eV7p0jSlhcSQuQ8GYJrUxOgC4FLdy','2023-07-11 15:59:21'),(6,'user','user@gmail.com','12345678','$2b$10$MpAjyYbeMegqQMAYUN4xZ./H8Ufii8WxFxSDyeTZbMsTegKrTw0fC','2023-07-13 23:48:09'),(7,'denn','denny@gmail.com','08137123218','$2b$10$D1AdqMTUusOCrQxJHLkSZuxd822VvWPOlwo/QQLXOrw6H0h5WgkKC','2023-07-15 15:23:53'),(8,'denny','denny@gmail.co','08273712381','$2b$10$0VQ7mB8LadXyyBdG9yh3M.33JBG/u3YOsEb/YXW7n5117/gm1Oao6','2023-07-15 15:25:26');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-31 22:55:25
