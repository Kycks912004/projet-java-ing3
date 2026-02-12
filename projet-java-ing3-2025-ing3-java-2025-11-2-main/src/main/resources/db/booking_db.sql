-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: booking_db
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `accommodation_amenities`
--

DROP TABLE IF EXISTS `accommodation_amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accommodation_amenities` (
  `accommodation_id` int NOT NULL,
  `amenity_id` int NOT NULL,
  PRIMARY KEY (`accommodation_id`,`amenity_id`),
  KEY `amenity_id` (`amenity_id`),
  CONSTRAINT `accommodation_amenities_ibfk_1` FOREIGN KEY (`accommodation_id`) REFERENCES `accommodations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `accommodation_amenities_ibfk_2` FOREIGN KEY (`amenity_id`) REFERENCES `amenities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accommodation_amenities`
--

LOCK TABLES `accommodation_amenities` WRITE;
/*!40000 ALTER TABLE `accommodation_amenities` DISABLE KEYS */;
/*!40000 ALTER TABLE `accommodation_amenities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accommodation_images`
--

DROP TABLE IF EXISTS `accommodation_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accommodation_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accommodation_id` int NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_primary` tinyint(1) DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accommodation_id` (`accommodation_id`),
  CONSTRAINT `accommodation_images_ibfk_1` FOREIGN KEY (`accommodation_id`) REFERENCES `accommodations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accommodation_images`
--

LOCK TABLES `accommodation_images` WRITE;
/*!40000 ALTER TABLE `accommodation_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `accommodation_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accommodations`
--

DROP TABLE IF EXISTS `accommodations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accommodations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `description` text,
  `price_per_night` decimal(10,2) NOT NULL,
  `max_guests` int NOT NULL,
  `accommodation_type` varchar(20) NOT NULL,
  `has_wifi` tinyint(1) DEFAULT '0',
  `has_pool` tinyint(1) DEFAULT '0',
  `has_parking_space` tinyint(1) DEFAULT '0',
  `rating` int DEFAULT '0',
  `has_restaurant` tinyint(1) DEFAULT '0',
  `has_air_conditioning` tinyint(1) DEFAULT '0',
  `latitude` decimal(9,6) DEFAULT NULL,
  `thumbnail_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accommodations`
--

LOCK TABLES `accommodations` WRITE;
/*!40000 ALTER TABLE `accommodations` DISABLE KEYS */;
INSERT INTO `accommodations` VALUES (27,'Luxury Hotel Paris','123 Avenue des Champs-Élysées','Paris','France','Elegant 5-star hotel in the heart of Paris with stunning views of the Eiffel Tower.',350.00,4,'hotel',1,1,1,4,1,1,48.869800,'hotel_paris_1.jpg'),(28,'Cozy Apartment Montmartre','45 Rue des Abbesses','Paris','France','Charming apartment in the artistic district of Montmartre, close to cafés and galleries.',120.00,2,'apartment',1,0,0,4,0,1,48.886500,'apartment_paris_1.jpg'),(32,'Seaside Villa Amalfi','Via Marina Grande 22','Amalfi','Italy','Beautiful villa with panoramic sea views and a private pool on the Amalfi Coast.',420.00,6,'villa',1,1,1,5,0,1,40.634600,'villa_amalfi.jpg'),(33,'Rustic Chalet Chamonix','100 Route des Praz','Chamonix','France','Traditional alpine chalet close to ski lifts, ideal for winter sports lovers.',180.00,5,'chalet',1,0,1,3,0,1,45.923700,'chalet_chamonix.jpg'),(34,'City Apartment Tokyo','3-15-1 Shibuya','Tokyo','Japan','Modern apartment in the heart of Shibuya with easy metro access.',130.00,2,'apartment',1,0,0,4,0,1,35.661800,'apartment_tokyo.jpg'),(35,'Eco Cottage Quebec','12 Forest Lane','Quebec','Canada','Sustainable cottage surrounded by nature with a cozy wood stove.',110.00,3,'cottage',0,0,1,2,0,0,46.813900,'cottage_quebec.jpg'),(36,'Boutique Hotel Lisbon','7 Rua Augusta','Lisbon','Portugal','Charming boutique hotel near Praça do Comércio with river views.',160.00,2,'hotel',1,0,1,4,1,1,38.707100,'hotel_lisbon.jpg'),(37,'Beachfront Bungalow Bali','Jl. Pantai Seseh','Canggu','Indonesia','Relaxing bungalow just steps from the beach with tropical garden.',95.00,2,'cottage',1,1,0,3,0,0,-8.647800,'bungalow_bali.jpg'),(38,'Historic Hotel Vienna','1 Opernring','Vienna','Austria','Elegant historic hotel near the Vienna Opera House with classical charm.',275.00,3,'hotel',1,0,1,5,1,1,48.202700,'hotel_vienna.jpg'),(39,'Lakeview Cabin Tahoe','88 Pine Ridge','Lake Tahoe','USA','Rustic cabin with lake views, fireplace and nearby hiking trails.',140.00,4,'cabin',1,0,1,1,0,1,39.096800,'cabin_tahoe.jpg'),(40,'Contemporary Condo Sydney','10 Darling Drive','Sydney','Australia','Stylish condo with harbor views, ideal for urban explorers.',220.00,2,'condo',1,0,1,2,0,1,-33.871000,'condo_sydney.jpg'),(41,'Countryside Cottage Cotswolds','The Lane, Bourton-on-the-Water','Cotswolds','UK','Quaint stone cottage in the English countryside, perfect for relaxing retreats.',150.00,4,'cottage',1,0,1,3,0,0,51.885000,'cottage_cotswolds.jpg');
/*!40000 ALTER TABLE `accommodations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amenities`
--

DROP TABLE IF EXISTS `amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `category` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenities`
--

LOCK TABLES `amenities` WRITE;
/*!40000 ALTER TABLE `amenities` DISABLE KEYS */;
INSERT INTO `amenities` VALUES (1,'Free WiFi','wifi','ESSENTIAL'),(2,'Swimming Pool','pool','LEISURE'),(3,'Parking','parking','CONVENIENCE'),(4,'Restaurant','restaurant','DINING'),(5,'Air Conditioning','ac','COMFORT'),(6,'Pet Friendly','pet','SPECIAL'),(7,'Gym','gym','WELLNESS'),(8,'Spa','spa','WELLNESS'),(9,'Bar','bar','DINING'),(10,'Room Service','service','COMFORT'),(11,'Business Center','business','WORK'),(12,'Free Breakfast','breakfast','DINING'),(13,'Laundry Service','laundry','CONVENIENCE'),(14,'Airport Shuttle','shuttle','TRANSPORTATION'),(15,'Concierge','concierge','SERVICE'),(16,'Beach Access','beach','LOCATION'),(17,'Kid Friendly','kids','SPECIAL'),(18,'Hot Tub','hottub','WELLNESS'),(19,'Mountain View','mountain','VIEW'),(20,'Sea View','sea','VIEW');
/*!40000 ALTER TABLE `amenities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `accommodation_id` int NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `number_of_guests` int NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `booking_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `accommodation_id` (`accommodation_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`accommodation_id`) REFERENCES `accommodations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (10,2,27,'2025-04-17','2025-04-19',2,1400.00,'CANCELLED','2025-04-16'),(11,2,28,'2025-04-18','2025-04-20',2,480.00,'CONFIRMED','2025-04-17'),(12,2,27,'2025-05-01','2025-05-05',2,1400.00,'CONFIRMED','2025-04-25'),(13,3,28,'2025-06-10','2025-06-15',4,480.00,'CONFIRMED','2025-05-25'),(17,7,32,'2025-10-01','2025-10-05',6,1500.00,'CONFIRMED','2025-09-20'),(18,3,34,'2025-12-01','2025-12-05',4,720.00,'CONFIRMED','2025-11-10'),(19,4,35,'2026-01-10','2026-01-15',3,900.00,'CONFIRMED','2025-12-20'),(20,5,36,'2026-02-01','2026-02-05',2,600.00,'CONFIRMED','2026-01-15'),(21,6,37,'2026-03-10','2026-03-15',5,1500.00,'CONFIRMED','2026-02-25'),(22,7,38,'2026-04-15','2026-04-20',6,1800.00,'CONFIRMED','2026-04-05'),(23,2,39,'2026-05-01','2026-05-05',2,1000.00,'CONFIRMED','2026-04-20'),(24,3,40,'2026-06-01','2026-06-05',4,1200.00,'CONFIRMED','2026-05-20'),(25,4,41,'2026-07-10','2026-07-15',3,900.00,'CONFIRMED','2026-06-25');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(20) NOT NULL,
  `payment_date` datetime NOT NULL,
  `status` varchar(20) NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (10,10,700.00,'CREDIT_CARD','2025-04-16 14:46:10','COMPLETED','TRX-20250416-9f19e8'),(11,11,240.00,'CREDIT_CARD','2025-04-17 07:47:07','COMPLETED','TRX-20250417-d122de');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accommodation_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `discount_percentage` decimal(5,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `promo_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `promo_code` (`promo_code`),
  KEY `accommodation_id` (`accommodation_id`),
  CONSTRAINT `promotions_ibfk_1` FOREIGN KEY (`accommodation_id`) REFERENCES `accommodations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
INSERT INTO `promotions` VALUES (11,27,'Summer Blast','20% off for summer 2025 vacations!',20.00,'2025-06-01','2025-09-01','SUMMER25'),(12,28,'Weekend Escape','15% off all weekend stays!',15.00,'2025-04-01','2025-12-31','WEEKEND15'),(13,27,'New Year Special','Celebrate 2024 with a 25% discount!',25.00,'2024-01-01','2024-01-31','NY2024'),(14,28,'Spring 2024','Spring discount of 10% for early birds!',10.00,'2024-03-01','2024-05-31','SPRING24');
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `accommodation_id` int NOT NULL,
  `booking_id` int NOT NULL,
  `rating` int NOT NULL,
  `comment` text,
  `review_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `accommodation_id` (`accommodation_id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`accommodation_id`) REFERENCES `accommodations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_3` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (16,5,36,10,4,'Good stay overall, but the air conditioning was a bit noisy.','2024-05-04'),(17,6,37,11,3,'Good location, but the place felt a bit dated.','2024-05-05'),(22,7,38,22,5,'Fantastic stay, the resort exceeded our expectations!','2026-04-21'),(23,2,39,23,4,'Nice place, but the parking was a bit far from the entrance.','2026-05-06'),(24,3,40,24,4,'Great condo, but the kitchen could use a few more utensils.','2026-06-06'),(25,4,41,25,5,'Perfect stay, everything was as expected and the view was stunning!','2026-07-16'),(26,2,27,12,4,'Wonderful stay, great location, but the check-in process could have been faster.','2025-05-06'),(27,3,28,13,5,'Amazing apartment with a great view! Very comfortable.','2025-06-16'),(28,7,32,17,4,'The resort was nice, but the beach was a bit crowded.','2025-10-06'),(29,3,34,18,5,'The cabin was perfect for a winter getaway. Very cozy and warm!','2025-12-06'),(30,4,35,19,4,'Great location and very comfortable, but the Wi-Fi was spotty.','2026-01-16');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT '0',
  `new_users` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin123','admin@booking.com','Admin','User','+33123456789',1,0),(2,'john_doe','password123','john.doe@example.com','John','Doe','+33612345678',0,0),(3,'jane_smith','password123','jane.smith@example.com','Jane','Smith','+33687654321',0,0),(4,'alice_johnson','password123','alice.johnson@example.com','Alice','Johnson','+33612345679',0,0),(5,'bob_brown','password123','bob.brown@example.com','Bob','Brown','+33687654322',0,0),(6,'charlie_davis','password123','charlie.davis@example.com','Charlie','Davis','+33612345670',0,0),(7,'diana_evans','password123','diana.evans@example.com','Diana','Evans','+33687654323',0,0),(8,'test','Test1234','test@gmail.com','test','test','5678230210',0,0),(9,'vtraaz','Vtr123456789','vtr@gmail.com','victor','mazloum','0783971069',0,0),(10,'testteststtst','Test1234.','tst@gmail.com','lalal','lalala','0909090909',0,0),(11,'ttttt','Test1234.','ttttt@gmail.com','tetattatatat','etatte','0909090909',0,0),(12,'newuser','password','newuser@example.com','First','Last','1234567890',0,1),(13,'jeteste','Password123','jetest@gmail.com','jeteste','jeteste','0909090909',0,0),(15,'victor1','Password123','tesefzesfefrvt@gmail.com','tetetat','zefefer','0909090909',0,0),(16,'poiu','Password123','tetdadz@gmail.com','zefzjeb','guzejiz','0909090909',0,0),(17,'victormaz','Password123','ozeipfhv@gmail.com','efclmidec','ohecnl','0909090909',0,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-26 10:33:34
