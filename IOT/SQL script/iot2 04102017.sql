-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: iot2
-- ------------------------------------------------------
-- Server version	5.6.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `beacon`
--

DROP TABLE IF EXISTS `beacon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beacon` (
  `BeaconID` varchar(50) NOT NULL,
  `Location` varchar(50) DEFAULT NULL,
  `Type` varchar(255) NOT NULL,
  PRIMARY KEY (`BeaconID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beacon`
--

LOCK TABLES `beacon` WRITE;
/*!40000 ALTER TABLE `beacon` DISABLE KEYS */;
INSERT INTO `beacon` VALUES ('http://iotsmusg28.com','At exit 28','exit'),('http://iotsmusg29.com','At exit 29','exit'),('http://iotsmusg30.com','At exit B','exit'),('http://Ks.com','At exit A','exit');
/*!40000 ALTER TABLE `beacon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `officer`
--

DROP TABLE IF EXISTS `officer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `officer` (
  `phone_num` varchar(10) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `empID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`empID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `officer`
--

LOCK TABLES `officer` WRITE;
/*!40000 ALTER TABLE `officer` DISABLE KEYS */;
INSERT INTO `officer` VALUES ('6594898452','Tan Kun Sheng','on',1);
/*!40000 ALTER TABLE `officer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pi`
--

DROP TABLE IF EXISTS `pi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pi` (
  `PiID` varchar(50) NOT NULL,
  PRIMARY KEY (`PiID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pi`
--

LOCK TABLES `pi` WRITE;
/*!40000 ALTER TABLE `pi` DISABLE KEYS */;
INSERT INTO `pi` VALUES ('001'),('002');
/*!40000 ALTER TABLE `pi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pi_on_trolley`
--

DROP TABLE IF EXISTS `pi_on_trolley`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pi_on_trolley` (
  `PiID` varchar(50) NOT NULL,
  `TrolleyID` varchar(50) NOT NULL,
  `Battery` int(11) DEFAULT NULL,
  PRIMARY KEY (`PiID`,`TrolleyID`),
  KEY `fk_trolley_idx` (`TrolleyID`),
  CONSTRAINT `fk_pi` FOREIGN KEY (`PiID`) REFERENCES `pi` (`PiID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trolley` FOREIGN KEY (`TrolleyID`) REFERENCES `trolley` (`TrolleyID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pi_on_trolley`
--

LOCK TABLES `pi_on_trolley` WRITE;
/*!40000 ALTER TABLE `pi_on_trolley` DISABLE KEYS */;
INSERT INTO `pi_on_trolley` VALUES ('001','1',NULL),('002','2',0);
/*!40000 ALTER TABLE `pi_on_trolley` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trolley`
--

DROP TABLE IF EXISTS `trolley`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trolley` (
  `TrolleyID` varchar(50) NOT NULL,
  `lastBattChange` datetime NOT NULL,
  PRIMARY KEY (`TrolleyID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trolley`
--

LOCK TABLES `trolley` WRITE;
/*!40000 ALTER TABLE `trolley` DISABLE KEYS */;
INSERT INTO `trolley` VALUES ('1','2017-04-10 15:28:51'),('2','2017-04-10 12:35:19');
/*!40000 ALTER TABLE `trolley` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trolleypi_beacon_event`
--

DROP TABLE IF EXISTS `trolleypi_beacon_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trolleypi_beacon_event` (
  `PiID` varchar(50) NOT NULL,
  `TrolleyID` varchar(50) NOT NULL,
  `BeaconID` varchar(50) NOT NULL,
  `Timestamp` datetime NOT NULL,
  `isBack` varchar(255) NOT NULL DEFAULT '''false''',
  PRIMARY KEY (`PiID`,`TrolleyID`,`BeaconID`,`Timestamp`),
  KEY `fk_beacon_idx` (`BeaconID`),
  CONSTRAINT `fk_beacon` FOREIGN KEY (`BeaconID`) REFERENCES `beacon` (`BeaconID`) ON UPDATE CASCADE,
  CONSTRAINT `fk_pi_on_trolley` FOREIGN KEY (`PiID`, `TrolleyID`) REFERENCES `pi_on_trolley` (`PiID`, `TrolleyID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trolleypi_beacon_event`
--

LOCK TABLES `trolleypi_beacon_event` WRITE;
/*!40000 ALTER TABLE `trolleypi_beacon_event` DISABLE KEYS */;
INSERT INTO `trolleypi_beacon_event` VALUES ('001','1','http://iotsmusg28.com','2017-03-18 19:40:12','true'),('001','1','http://iotsmusg28.com','2017-03-18 19:54:55','false'),('001','1','http://iotsmusg28.com','2017-03-18 19:58:58','true'),('001','1','http://iotsmusg28.com','2017-03-18 19:59:49','false'),('001','1','http://iotsmusg28.com','2017-04-03 16:28:56','false'),('001','1','http://iotsmusg28.com','2017-04-03 16:29:13','true'),('001','1','http://iotsmusg28.com','2017-04-03 16:36:33','false'),('001','1','http://iotsmusg28.com','2017-04-03 16:36:51','true'),('001','1','http://iotsmusg28.com','2017-04-03 16:37:13','false'),('001','1','http://iotsmusg28.com','2017-04-03 16:37:33','true'),('001','1','http://iotsmusg28.com','2017-04-03 16:38:00','false'),('001','1','http://iotsmusg28.com','2017-04-03 16:38:16','true'),('001','1','http://iotsmusg28.com','2017-04-03 16:38:53','false'),('001','1','http://iotsmusg28.com','2017-04-03 16:39:14','true'),('001','1','http://iotsmusg28.com','2017-04-03 16:41:04','false'),('001','1','http://iotsmusg28.com','2017-04-03 16:41:20','true'),('001','1','http://iotsmusg28.com','2017-04-03 16:42:31','false'),('001','1','http://iotsmusg28.com','2017-04-03 16:42:50','true'),('001','1','http://iotsmusg28.com','2017-04-03 16:43:29','false'),('001','1','http://iotsmusg28.com','2017-04-03 16:43:43','true'),('001','1','http://iotsmusg28.com','2017-04-03 17:00:00','false'),('001','1','http://iotsmusg28.com','2017-04-03 17:00:11','true'),('001','1','http://iotsmusg28.com','2017-04-03 17:04:19','false'),('001','1','http://iotsmusg28.com','2017-04-03 17:04:32','true'),('001','1','http://iotsmusg28.com','2017-04-03 17:04:33','false'),('001','1','http://iotsmusg28.com','2017-04-03 17:04:48','true'),('001','1','http://iotsmusg28.com','2017-04-03 17:06:19','false'),('001','1','http://iotsmusg28.com','2017-04-03 17:06:35','true'),('001','1','http://iotsmusg28.com','2017-04-03 17:08:57','false'),('001','1','http://iotsmusg28.com','2017-04-03 17:09:08','true'),('001','1','http://iotsmusg28.com','2017-04-03 17:09:34','false'),('001','1','http://iotsmusg28.com','2017-04-03 17:09:45','true'),('001','1','http://iotsmusg28.com','2017-04-03 17:10:06','false'),('001','1','http://iotsmusg28.com','2017-04-03 17:10:21','true'),('001','1','http://iotsmusg30.com','2017-03-18 19:37:08','true'),('001','1','http://iotsmusg30.com','2017-03-18 19:37:39','true'),('001','1','http://iotsmusg30.com','2017-03-18 19:38:47','true'),('001','1','http://iotsmusg30.com','2017-03-18 19:39:48','true'),('001','1','http://iotsmusg30.com','2017-03-18 19:50:32','true'),('001','1','http://iotsmusg30.com','2017-03-18 19:52:32','true'),('001','1','http://iotsmusg30.com','2017-03-18 19:55:22','true'),('001','1','http://iotsmusg30.com','2017-03-18 19:56:27','true'),('001','1','http://iotsmusg30.com','2017-03-18 19:56:47','true'),('001','1','http://iotsmusg30.com','2017-03-18 19:58:01','true'),('001','1','http://iotsmusg30.com','2017-03-18 19:58:15','true'),('001','1','http://Ks.com','2017-03-15 18:44:12','false'),('001','1','http://Ks.com','2017-03-18 19:29:28','true'),('001','1','http://Ks.com','2017-03-18 19:33:25','false'),('001','1','http://Ks.com','2017-03-18 19:51:46','true'),('002','2','http://iotsmusg28.com','2017-03-18 20:59:50','true'),('002','2','http://iotsmusg28.com','2017-03-18 21:59:49','false'),('002','2','http://iotsmusg28.com','2017-04-02 00:00:00','false');
/*!40000 ALTER TABLE `trolleypi_beacon_event` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-10 15:57:22
