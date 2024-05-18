CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;

-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: ECOMMERCE
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

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
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` varchar(36) NOT NULL,
  `cart_id` varchar(36) DEFAULT NULL,
  `product_id` varchar(36) DEFAULT NULL,
  `qty` bigint DEFAULT NULL,
  `base_price` decimal(16,2) DEFAULT NULL,
  `base_total` decimal(16,2) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_cart_items_id` (`id`),
  KEY `idx_cart_items_product_id` (`product_id`),
  KEY `idx_cart_items_cart_id` (`cart_id`),
  CONSTRAINT `fk_carts_cart_items` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`),
  CONSTRAINT `fk_products_cartitems` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES ('c08ef3c4-920f-41f4-8907-646b0ce14045','b34cc845-0ee6-4655-8dee-6f76d44df47d','0d51bd97-707a-4404-8b7b-7bb96afe5521',10,450.00,4500.00,'2024-01-02 21:25:36.075','2024-01-02 21:25:36.192');
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `base_total_price` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_carts_id` (`id`),
  KEY `idx_carts_user_id` (`user_id`),
  CONSTRAINT `fk_users_carts` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES ('b34cc845-0ee6-4655-8dee-6f76d44df47d','26174afc-e5ef-4ee5-9317-a3b8f9d7130a',4500.00);
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` varchar(36) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `slug` varchar(100) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_categories_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('balo-VN01','Balo','','2024-01-02 21:25:35.473','2024-01-02 21:25:35.473'),('chair-123','Chair','','2024-01-02 21:25:35.444','2024-01-02 21:25:35.444'),('Handbag-VN00','Handbag','','2024-01-02 21:25:35.488','2024-01-02 21:25:35.488'),('keyboard-123','Keybroad','','2024-01-02 21:25:35.457','2024-01-02 21:25:35.457'),('mouse-123','Mouse','','2024-01-02 21:25:35.518','2024-01-02 21:25:35.518'),('shirt-123','Shirt','','2024-01-02 21:25:35.503','2024-01-02 21:25:35.503'),('table-123','Table','','2024-01-02 21:25:35.430','2024-01-02 21:25:35.430'),('trousers-123','Trousers','','2024-01-02 21:25:35.412','2024-01-02 21:25:35.412');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_customers`
--

DROP TABLE IF EXISTS `order_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_customers` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `order_id` varchar(36) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_customers_id` (`id`),
  KEY `idx_order_customers_user_id` (`user_id`),
  KEY `idx_order_customers_order_id` (`order_id`),
  CONSTRAINT `fk_order_customers_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_orders_order_customer` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_customers`
--

LOCK TABLES `order_customers` WRITE;
/*!40000 ALTER TABLE `order_customers` DISABLE KEYS */;
INSERT INTO `order_customers` VALUES ('61c56647-8a6b-471a-8242-d2fd81fa1ecd','26174afc-e5ef-4ee5-9317-a3b8f9d7130a','aad392ee-c5f3-4971-9584-4e0c76fc7f29','2024-01-02 21:25:36.215','2024-01-02 21:25:36.215');
/*!40000 ALTER TABLE `order_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` varchar(36) NOT NULL,
  `order_id` varchar(36) DEFAULT NULL,
  `product_id` varchar(36) DEFAULT NULL,
  `qty` bigint DEFAULT NULL,
  `base_price` decimal(16,2) DEFAULT NULL,
  `base_total` decimal(16,2) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_items_id` (`id`),
  KEY `idx_order_items_product_id` (`product_id`),
  KEY `idx_order_items_order_id` (`order_id`),
  CONSTRAINT `fk_orders_order_items` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `fk_products_order_items` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES ('b7d3f2f1-a85b-4357-84ba-25d159e98adc','aad392ee-c5f3-4971-9584-4e0c76fc7f29','0d51bd97-707a-4404-8b7b-7bb96afe5521',10,450.00,4500.00,'2024-01-02 21:25:36.220','2024-01-02 21:25:36.220');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `status` bigint DEFAULT NULL,
  `order_date` datetime(3) DEFAULT NULL,
  `payment_due` datetime(3) DEFAULT NULL,
  `payment_status` varchar(50) DEFAULT NULL,
  `payment_token` varchar(100) DEFAULT NULL,
  `base_total_price` decimal(16,2) DEFAULT NULL,
  `shipping_cost` decimal(16,2) DEFAULT NULL,
  `note` text,
  `cancelled_by` varchar(36) DEFAULT NULL,
  `cancelled_at` datetime(3) DEFAULT NULL,
  `cancellation_note` varchar(255) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_orders_id` (`id`),
  KEY `idx_orders_code` (`code`),
  KEY `idx_orders_payment_status` (`payment_status`),
  KEY `idx_orders_payment_token` (`payment_token`),
  KEY `idx_orders_user_id` (`user_id`),
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES ('aad392ee-c5f3-4971-9584-4e0c76fc7f29','26174afc-e5ef-4ee5-9317-a3b8f9d7130a','1/ORDER/I/2024',1,'2024-01-02 21:25:36.212','2024-01-09 21:25:36.212','',NULL,4500.00,100.00,'hello',NULL,NULL,NULL,'2024-01-02 21:25:36.213','2024-01-02 21:25:36.213',NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` varchar(36) NOT NULL,
  `order_id` varchar(36) DEFAULT NULL,
  `number` varchar(100) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `method` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `token` varchar(100) DEFAULT NULL,
  `payload` text,
  `payment_type` varchar(100) DEFAULT NULL,
  `va_number` varchar(100) DEFAULT NULL,
  `bill_code` varchar(100) DEFAULT NULL,
  `bill_key` varchar(100) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_payments_id` (`id`),
  KEY `idx_payments_order_id` (`order_id`),
  KEY `idx_payments_number` (`number`),
  KEY `idx_payments_token` (`token`),
  CONSTRAINT `fk_payments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` varchar(36) NOT NULL,
  `product_id` varchar(36) DEFAULT NULL,
  `path` text,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_product_images_id` (`id`),
  KEY `fk_products_product_images` (`product_id`),
  CONSTRAINT `fk_products_product_images` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES ('00310775-036e-416b-affa-81e0bba937de','49a53695-a5b4-4d23-9d3a-ae225c27c9ca','./data/images/handbag/handbag1/tui_xach_marina.png','2024-01-02 21:25:35.559','2024-01-02 21:25:35.559'),('05e6e8f8-13ff-491a-bb25-a97789d61939','253962b2-23b3-4e63-943c-2cd7027afc48','./data/images/trousers/trouserswh/trouserswh2.jpg','2024-01-02 21:25:35.695','2024-01-02 21:25:35.695'),('20502302-4ace-4a87-80d4-1d1b44ab422b','c0363707-58a3-420f-abfa-b2991124555f','./data/images/mouse/mouse2/mouse_2_2.jpg','2024-01-02 21:25:35.924','2024-01-02 21:25:35.924'),('24f6369a-a23f-46b8-958a-6ff90673a042','16ff50a1-48aa-48fc-bab2-934628ffb8ff','./data/images/handbag/handbag3/tui_xach_hong.png','2024-01-02 21:25:35.581','2024-01-02 21:25:35.581'),('343dc12d-f3aa-4478-b74f-78aed7b27d48','29435911-a083-4011-a010-74bc76c0bed2','./data/images/chair/chair1/i1.jpg','2024-01-02 21:25:35.601','2024-01-02 21:25:35.601'),('3f8fe9c9-fb62-4727-9ac6-ffd512d7223a','c0363707-58a3-420f-abfa-b2991124555f','./data/images/mouse/mouse2/mouse_2_1.jpg','2024-01-02 21:25:35.924','2024-01-02 21:25:35.924'),('408f7c1a-c9f4-40ed-970f-b5bb08656d15','3ebb0a23-3de5-40bb-8798-65555258bc02','./data/images/chair/chair2/i2.jpg','2024-01-02 21:25:35.621','2024-01-02 21:25:35.621'),('4ae6ea02-d87b-4b86-87f6-4e479fa63e33','b0324254-cd51-4014-a87c-f6479e02d614','./data/images/keyboard/keyboard1/keyboard_1_2.jpg','2024-01-02 21:25:35.831','2024-01-02 21:25:35.831'),('4bbaf91a-10f4-4f6e-8754-b0c3d8103f79','258cce5c-d5a9-4b20-adaf-61165c2a84ec','./data/images/table/table2/i2.jpg','2024-01-02 21:25:35.847','2024-01-02 21:25:35.847'),('4d13a562-686a-4254-83c7-f2bc0af8e8bf','49a53695-a5b4-4d23-9d3a-ae225c27c9ca','./data/images/handbag/handbag1/tui_xach_marina2.png','2024-01-02 21:25:35.559','2024-01-02 21:25:35.559'),('5eb67c10-5d45-4cf0-a655-bbcafe351e02','0d51bd97-707a-4404-8b7b-7bb96afe5521','./data/images/trousers/trousersbl/trousersbl1.jpg','2024-01-02 21:25:35.770','2024-01-02 21:25:35.770'),('62c81795-d89e-4f69-a673-deaa8f584eec','e15d4092-8ed6-4f6a-bdc7-1b4a46cb1826','./data/images/mouse/mouse1/mouse_1_1.jpg','2024-01-02 21:25:35.884','2024-01-02 21:25:35.884'),('6ac5ee24-ff5d-4c82-8f07-fb08bc0aab83','fb1a2e7d-7c28-4203-ae60-7dfaff949ee5','./data/images/balo/balo2/balolaptop.png','2024-01-02 21:25:35.978','2024-01-02 21:25:35.978'),('6c0306d6-c381-4c7e-b718-833a6708c884','258cce5c-d5a9-4b20-adaf-61165c2a84ec','./data/images/table/table2/i1.jpg','2024-01-02 21:25:35.847','2024-01-02 21:25:35.847'),('6cbd8396-dd82-4744-a4e0-84715f562060','fb1a2e7d-7c28-4203-ae60-7dfaff949ee5','./data/images/balo/balo2/balolaptop.png','2024-01-02 21:25:35.978','2024-01-02 21:25:35.978'),('6f1e02d5-99fe-48ca-ac30-4050d1bd19dc','f0a88913-9b0c-43d5-a548-e0a87d0da8ef','./data/images/keyboard/keyboard2/keyboard_2_2.jpg','2024-01-02 21:25:35.811','2024-01-02 21:25:35.811'),('6fac235e-f534-4424-9060-13828e6f6d52','b0324254-cd51-4014-a87c-f6479e02d614','./data/images/keyboard/keyboard1/keyboard_1_1.jpg','2024-01-02 21:25:35.831','2024-01-02 21:25:35.831'),('74da0ac9-a603-4939-be40-114120926a3b','8213df13-2d4a-4597-8af2-8fd596633bb7','./data/images/keyboard/keyboard3/keyboard_3_2.jpg','2024-01-02 21:25:35.787','2024-01-02 21:25:35.787'),('83cc8806-f259-46b1-94f5-0eaa196eb5e7','16ff50a1-48aa-48fc-bab2-934628ffb8ff','./data/images/handbag/handbag3/tui_xach_hong2.png','2024-01-02 21:25:35.581','2024-01-02 21:25:35.581'),('8a1c9a7a-6ed0-4090-97ba-5a5054b94da7','253962b2-23b3-4e63-943c-2cd7027afc48','./data/images/trousers/trouserswh/trouserswh1.jpg','2024-01-02 21:25:35.695','2024-01-02 21:25:35.695'),('93707828-d8a4-44b9-ac25-f4f2bcc6bab9','f0a88913-9b0c-43d5-a548-e0a87d0da8ef','./data/images/keyboard/keyboard2/keyboard_2_1.jpg','2024-01-02 21:25:35.811','2024-01-02 21:25:35.811'),('93fad3f8-535c-43e3-99c9-a8bc016825e8','eb102705-27a7-44cb-904f-88c138356096','./data/images/balo/balo1/minibalo2.png','2024-01-02 21:25:35.942','2024-01-02 21:25:35.942'),('96424ef3-c9bf-4a8e-93d1-e53021ad6cf9','708c79c7-4a9a-4975-9840-f922c5316e32','./data/images/mouse/mouse3/mouse_3_2.jpg','2024-01-02 21:25:35.905','2024-01-02 21:25:35.905'),('980b0d43-5de5-4779-9a65-ce2dd35ccaaa','d24441e2-2847-4941-87e0-d68e8d09ec4a','./data/images/trousers/trousersbe/trousersbe2.jpg','2024-01-02 21:25:35.739','2024-01-02 21:25:35.739'),('a25f73c9-9127-495b-a3f7-2bd2ee65cc46','a816f140-dd29-45a2-885e-0ac6e67383ce','./data/images/table/table1/i2.jpg','2024-01-02 21:25:35.865','2024-01-02 21:25:35.865'),('a8fd472f-db55-413a-9160-ba37c9ab4871','29435911-a083-4011-a010-74bc76c0bed2','./data/images/chair/chair1/i2.jpg','2024-01-02 21:25:35.601','2024-01-02 21:25:35.601'),('ab059986-2db6-451c-9760-761fb05d9416','93f44436-4681-4064-9e19-769ec1b12bca','./data/images/balo/balo3/pinkbalo2.png','2024-01-02 21:25:35.959','2024-01-02 21:25:35.959'),('aea163cf-b12c-4bb4-b0ae-1425cccbc955','3ebb0a23-3de5-40bb-8798-65555258bc02','./data/images/chair/chair2/i1.jpg','2024-01-02 21:25:35.621','2024-01-02 21:25:35.621'),('bf084236-d77b-4f56-93b4-435b1c1fa749','708c79c7-4a9a-4975-9840-f922c5316e32','./data/images/mouse/mouse3/mouse_3_1.jpg','2024-01-02 21:25:35.905','2024-01-02 21:25:35.905'),('c8f2efdb-e5f0-473f-b1f7-a52648435be2','8213df13-2d4a-4597-8af2-8fd596633bb7','./data/images/keyboard/keyboard3/keyboard_3_1.jpg','2024-01-02 21:25:35.787','2024-01-02 21:25:35.787'),('c9cc20b8-bb98-41fa-9a7d-0d8281e553ed','0d51bd97-707a-4404-8b7b-7bb96afe5521','./data/images/trousers/trousersbl/trousersbl2.jpg','2024-01-02 21:25:35.770','2024-01-02 21:25:35.770'),('d08056ee-e93b-4049-b505-a79e29367407','eb102705-27a7-44cb-904f-88c138356096','./data/images/balo/balo1/minibalo.png','2024-01-02 21:25:35.942','2024-01-02 21:25:35.942'),('d1e65b1f-e5c4-4143-989f-124dfae7bddc','d24441e2-2847-4941-87e0-d68e8d09ec4a','./data/images/trousers/trousersbe/trousersbe1.jpg','2024-01-02 21:25:35.739','2024-01-02 21:25:35.739'),('d31a2d78-0a47-462c-bf73-53bce0d70c02','3d5d8256-14d3-4f07-8982-358cdc1ac604','./data/images/handbag/handbag2/tui_xach_xanh2.png','2024-01-02 21:25:35.538','2024-01-02 21:25:35.538'),('db8360fa-7580-4734-9d40-2b16663bc38c','e15d4092-8ed6-4f6a-bdc7-1b4a46cb1826','./data/images/mouse/mouse1/mouse_1_2.jpg','2024-01-02 21:25:35.884','2024-01-02 21:25:35.884'),('e26d0add-632b-4c82-8893-f017b90f4751','3d5d8256-14d3-4f07-8982-358cdc1ac604','./data/images/handbag/handbag2/tui_xach_xanh.png','2024-01-02 21:25:35.538','2024-01-02 21:25:35.538'),('eb61bcb6-457a-43f0-98c1-8fc3e3ef7246','93f44436-4681-4064-9e19-769ec1b12bca','./data/images/balo/balo3/pinkbalo.png','2024-01-02 21:25:35.959','2024-01-02 21:25:35.959'),('fadc118e-fe6b-4fc4-ac21-a3b89e034545','a816f140-dd29-45a2-885e-0ac6e67383ce','./data/images/table/table1/i1.jpg','2024-01-02 21:25:35.865','2024-01-02 21:25:35.865');
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` varchar(36) NOT NULL,
  `category_id` varchar(36) DEFAULT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(16,2) DEFAULT NULL,
  `stock` bigint DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT NULL,
  `description` text,
  `status` bigint DEFAULT '0',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_products_id` (`id`),
  KEY `idx_products_sku` (`sku`),
  KEY `fk_categories_products` (`category_id`),
  CONSTRAINT `fk_categories_products` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('0d51bd97-707a-4404-8b7b-7bb96afe5521','trousers-123','','trousers bl',450.00,0,0.25,'A high-quality shirt for people.',2,'2024-01-02 21:25:35.767','2024-01-02 21:25:35.767',NULL),('16ff50a1-48aa-48fc-bab2-934628ffb8ff','Handbag-VN00','','Pink Handbag',1500.00,0,0.60,'A high-quality chair.',5,'2024-01-02 21:25:35.578','2024-01-02 21:25:35.578',NULL),('253962b2-23b3-4e63-943c-2cd7027afc48','trousers-123','','trousers wh',470.00,0,0.25,'A high-quality shirt for people.',3,'2024-01-02 21:25:35.693','2024-01-02 21:25:35.693',NULL),('258cce5c-d5a9-4b20-adaf-61165c2a84ec','table-123','','table 2',500.00,0,1.00,'A high-quality table for people.',1,'2024-01-02 21:25:35.845','2024-01-02 21:25:35.845',NULL),('29435911-a083-4011-a010-74bc76c0bed2','chair-123','','chair 1',599.99,0,0.50,'A high-quality chair.',1,'2024-01-02 21:25:35.598','2024-01-02 21:25:35.598',NULL),('3d5d8256-14d3-4f07-8982-358cdc1ac604','Handbag-VN00','','Medium Handbag',5000.00,0,1.20,'A highend handbag from famous branch.',3,'2024-01-02 21:25:35.534','2024-01-02 21:25:35.534',NULL),('3ebb0a23-3de5-40bb-8798-65555258bc02','chair-123','','chair 2',500.00,0,1.00,'A high-quality chair for people.',1,'2024-01-02 21:25:35.618','2024-01-02 21:25:35.618',NULL),('49a53695-a5b4-4d23-9d3a-ae225c27c9ca','Handbag-VN00','','Marina Mini Handbag',2000.00,0,0.60,'A highend handbag from famous branch.',1,'2024-01-02 21:25:35.557','2024-01-02 21:25:35.557',NULL),('708c79c7-4a9a-4975-9840-f922c5316e32','mouse-123','','mouse 3',500.00,0,0.10,'A high-quality mouse for people.',1,'2024-01-02 21:25:35.901','2024-01-02 21:25:35.901',NULL),('8213df13-2d4a-4597-8af2-8fd596633bb7','keyboard-123','','keyboard 3',500.00,0,0.30,'A high-quality keyboard for people.',1,'2024-01-02 21:25:35.785','2024-01-02 21:25:35.785',NULL),('93f44436-4681-4064-9e19-769ec1b12bca','balo-VN01','','Pink balo',4000.00,0,0.60,'A highend balo from famous branch.',4,'2024-01-02 21:25:35.956','2024-01-02 21:25:35.956',NULL),('a816f140-dd29-45a2-885e-0ac6e67383ce','table-123','','table 1',599.99,0,0.50,'A high-quality table.',1,'2024-01-02 21:25:35.862','2024-01-02 21:25:35.862',NULL),('b0324254-cd51-4014-a87c-f6479e02d614','keyboard-123','','keyboard 1',300.00,0,0.10,'A high-quality keyboard for people.',1,'2024-01-02 21:25:35.828','2024-01-02 21:25:35.828',NULL),('c0363707-58a3-420f-abfa-b2991124555f','mouse-123','','mouse 2',400.00,0,0.10,'A high-quality mouse for people.',1,'2024-01-02 21:25:35.920','2024-01-02 21:25:35.920',NULL),('d24441e2-2847-4941-87e0-d68e8d09ec4a','trousers-123','','trousers be',500.00,0,0.25,'A high-quality shirt for people.',1,'2024-01-02 21:25:35.719','2024-01-02 21:25:35.719',NULL),('e15d4092-8ed6-4f6a-bdc7-1b4a46cb1826','mouse-123','','mouse 1',300.00,0,0.10,'A high-quality mouse for people.',1,'2024-01-02 21:25:35.881','2024-01-02 21:25:35.881',NULL),('eb102705-27a7-44cb-904f-88c138356096','balo-VN01','','Mini balo',3500.00,0,0.60,'A highend balo from famous branch.',3,'2024-01-02 21:25:35.941','2024-01-02 21:25:35.941',NULL),('f0a88913-9b0c-43d5-a548-e0a87d0da8ef','keyboard-123','','keyboard 2',400.00,0,0.20,'A high-quality keyboard for people.',1,'2024-01-02 21:25:35.808','2024-01-02 21:25:35.808',NULL),('fb1a2e7d-7c28-4203-ae60-7dfaff949ee5','balo-VN01','','Laptop balo',3500.00,0,0.60,'The best choice for woman.',3,'2024-01-02 21:25:35.976','2024-01-02 21:25:35.976',NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipments`
--

DROP TABLE IF EXISTS `shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipments` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `order_id` varchar(36) DEFAULT NULL,
  `track_number` varchar(255) DEFAULT NULL,
  `status` varchar(36) DEFAULT NULL,
  `total_qty` bigint DEFAULT NULL,
  `total_weight` decimal(10,2) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `shipped_by` varchar(36) DEFAULT NULL,
  `shipped_at` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_shipments_id` (`id`),
  KEY `idx_shipments_user_id` (`user_id`),
  KEY `idx_shipments_order_id` (`order_id`),
  KEY `idx_shipments_track_number` (`track_number`),
  KEY `idx_shipments_status` (`status`),
  CONSTRAINT `fk_shipments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `fk_shipments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipments`
--

LOCK TABLES `shipments` WRITE;
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` varchar(36) NOT NULL,
  `address` longtext,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(255) NOT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_users_email` (`email`),
  UNIQUE KEY `idx_users_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('26174afc-e5ef-4ee5-9317-a3b8f9d7130a','','aaa','nnnn','aaa@a.a','$2a$10$WFj7FO65AVh.EKo8TIbYYeGLQ1wJa8n5OQIDGnbLzxdxPL2EO30qi','','2024-01-02 21:25:35.372','2024-01-02 21:25:35.372',NULL);
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

-- Dump completed on 2024-01-02 21:26:10
