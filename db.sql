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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acara`
--

LOCK TABLES `acara` WRITE;
/*!40000 ALTER TABLE `acara` DISABLE KEYS */;
INSERT INTO `acara` VALUES (1,'a','a','a','a',1,'00:00:00','23:59:59','2023-07-09','2023-07-09 00:07:39',NULL);
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
  CONSTRAINT `event_user_registration_event_id_fk` FOREIGN KEY (`acara_id`) REFERENCES `acara` (`id`),
  CONSTRAINT `event_user_registration_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acara_user_registration`
--

LOCK TABLES `acara_user_registration` WRITE;
/*!40000 ALTER TABLE `acara_user_registration` DISABLE KEYS */;
INSERT INTO `acara_user_registration` VALUES (1,1,1,'2023-07-09 00:11:14');
/*!40000 ALTER TABLE `acara_user_registration` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ebook`
--

LOCK TABLES `ebook` WRITE;
/*!40000 ALTER TABLE `ebook` DISABLE KEYS */;
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
  CONSTRAINT `ebook_tags_ebook_id_fk` FOREIGN KEY (`ebook_id`) REFERENCES `ebook` (`id`),
  CONSTRAINT `ebook_tags_master_tags_id_fk` FOREIGN KEY (`tags_id`) REFERENCES `master_tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ebook_tags`
--

LOCK TABLES `ebook_tags` WRITE;
/*!40000 ALTER TABLE `ebook_tags` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `family`
--

LOCK TABLES `family` WRITE;
/*!40000 ALTER TABLE `family` DISABLE KEYS */;
INSERT INTO `family` VALUES (2,1,3,'2023-07-08 16:33:56');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kegiatan`
--

LOCK TABLES `kegiatan` WRITE;
/*!40000 ALTER TABLE `kegiatan` DISABLE KEYS */;
INSERT INTO `kegiatan` VALUES (1,'a','a','a','a',1,'23:37:00','23:51:04',6,NULL,'2023-07-08 16:42:22',NULL);
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
  KEY `kegiatan_user_registration_kegiatan_id_fk` (`kegiatan_id`),
  KEY `kegiatan_user_registration_user_id_fk` (`user_id`),
  CONSTRAINT `kegiatan_user_registration_kegiatan_id_fk` FOREIGN KEY (`kegiatan_id`) REFERENCES `kegiatan` (`id`),
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_ebook_bahasa`
--

LOCK TABLES `master_ebook_bahasa` WRITE;
/*!40000 ALTER TABLE `master_ebook_bahasa` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_ebook_bahasa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_tags`
--

DROP TABLE IF EXISTS `master_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_tags`
--

LOCK TABLES `master_tags` WRITE;
/*!40000 ALTER TABLE `master_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_tags` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'eric','ericanthonywu899@gmail.com','6281236391375','$2b$10$KDDU8vdccTFdVEOCoD9Lk.XToPu/qyI59IY2uFSQA4mmqagQ/7Y5K','2023-07-08 15:34:40'),(3,'erica','ericaanthonywu89@gmail.com','0812363913755','$2b$10$RnUGlsmxeeZJczj..ribXuXHO/aP9Dd7p1XdYoeSYNNAsWh.BWkMS','2023-07-08 16:25:26');
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

-- Dump completed on 2023-07-09  0:18:59
