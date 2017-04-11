-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
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
  `type` varchar(255) DEFAULT NULL,
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
  `image` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`empID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `officer`
--

LOCK TABLES `officer` WRITE;
/*!40000 ALTER TABLE `officer` DISABLE KEYS */;
INSERT INTO `officer` VALUES ('6594898452','Tan Kun Sheng','on',1,'img/wj.png'),('6596404133','Koh Chu Qian','on',2,'img/merv.png'),('6581153520','Li Yingnan','on',7,'img/mh.png');
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
INSERT INTO `pi` VALUES ('001'),('002'),('003'),('004'),('005'),('006'),('007'),('008'),('009'),('010');
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
INSERT INTO `pi_on_trolley` VALUES ('001','1',NULL),('002','2',NULL),('003','3',NULL),('004','4',NULL),('005','5',NULL),('006','6',NULL),('007','7',NULL),('008','8',NULL),('009','9',NULL),('010','10',NULL);
/*!40000 ALTER TABLE `pi_on_trolley` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule` (
  `date` date NOT NULL,
  `empID` int(11) NOT NULL,
  `start_time` int(11) DEFAULT NULL,
  `end_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`date`,`empID`),
  KEY `fk_offier_idx` (`empID`),
  CONSTRAINT `fk_offier` FOREIGN KEY (`empID`) REFERENCES `officer` (`empID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES ('2017-04-03',1,8,15),('2017-04-03',2,20,23),('2017-04-10',1,12,23),('2017-04-10',7,15,20),('2017-04-11',1,8,15),('2017-04-11',2,8,12),('2017-04-11',7,8,23);
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trolley`
--

DROP TABLE IF EXISTS `trolley`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trolley` (
  `TrolleyID` varchar(50) NOT NULL,
  `lastBattChange` datetime DEFAULT NULL,
  PRIMARY KEY (`TrolleyID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trolley`
--

LOCK TABLES `trolley` WRITE;
/*!40000 ALTER TABLE `trolley` DISABLE KEYS */;
INSERT INTO `trolley` VALUES ('1','2017-04-11 10:30:51'),('10',NULL),('2',NULL),('3',NULL),('4',NULL),('5',NULL),('6',NULL),('7',NULL),('8',NULL),('9',NULL);
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
  `isBack` varchar(45) DEFAULT 'false',
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
INSERT INTO `trolleypi_beacon_event` VALUES ('001','1','http://iotsmusg28.com','2017-02-02 10:21:07','false'),('001','1','http://iotsmusg28.com','2017-02-02 11:21:17','true'),('001','1','http://iotsmusg28.com','2017-02-02 19:51:07','false'),('001','1','http://iotsmusg28.com','2017-02-02 19:51:55','true'),('001','1','http://iotsmusg28.com','2017-02-10 14:41:09','false'),('001','1','http://iotsmusg28.com','2017-02-10 15:43:12','true'),('001','1','http://iotsmusg28.com','2017-02-10 22:51:07','false'),('001','1','http://iotsmusg28.com','2017-02-10 22:51:37','true'),('001','1','http://iotsmusg28.com','2017-03-18 19:59:49','false'),('001','1','http://iotsmusg28.com','2017-04-02 19:02:29','true'),('001','1','http://iotsmusg28.com','2017-04-02 19:15:14','false'),('001','1','http://iotsmusg28.com','2017-04-02 19:16:05','true'),('001','1','http://iotsmusg28.com','2017-04-02 19:18:36','false'),('001','1','http://iotsmusg28.com','2017-04-02 19:18:55','true'),('001','1','http://iotsmusg28.com','2017-04-02 19:19:43','false'),('001','1','http://iotsmusg28.com','2017-04-02 19:19:59','true'),('001','1','http://iotsmusg28.com','2017-04-02 19:20:01','false'),('001','1','http://iotsmusg28.com','2017-04-02 19:20:14','true'),('001','1','http://iotsmusg28.com','2017-04-02 19:20:19','false'),('001','1','http://iotsmusg28.com','2017-04-02 19:20:40','true'),('001','1','http://iotsmusg28.com','2017-04-02 19:21:07','false'),('001','1','http://iotsmusg29.com','2017-01-15 13:48:12','false'),('001','1','http://iotsmusg29.com','2017-01-15 16:28:19','true'),('001','1','http://iotsmusg29.com','2017-01-17 11:54:11','false'),('001','1','http://iotsmusg29.com','2017-01-17 14:24:01','true'),('001','1','http://iotsmusg29.com','2017-01-18 10:01:12','false'),('001','1','http://iotsmusg29.com','2017-01-18 11:08:12','true'),('001','1','http://iotsmusg29.com','2017-02-13 12:51:37','false'),('001','1','http://iotsmusg29.com','2017-02-13 12:58:37','true'),('001','1','http://iotsmusg29.com','2017-02-13 21:51:37','false'),('001','1','http://iotsmusg29.com','2017-02-13 22:01:37','true'),('001','1','http://iotsmusg29.com','2017-02-13 22:51:37','false'),('001','1','http://iotsmusg29.com','2017-02-13 22:51:57','true'),('001','1','http://iotsmusg29.com','2017-03-15 18:44:12','false'),('001','1','http://iotsmusg30.com','2017-02-10 22:51:37','false'),('001','1','http://iotsmusg30.com','2017-02-10 22:56:37','true'),('001','1','http://iotsmusg30.com','2017-02-19 09:16:11','false'),('001','1','http://iotsmusg30.com','2017-02-19 09:19:11','true'),('001','1','http://iotsmusg30.com','2017-02-20 13:16:11','false'),('001','1','http://iotsmusg30.com','2017-02-20 13:18:11','true'),('001','1','http://iotsmusg30.com','2017-02-21 13:16:11','false'),('001','1','http://iotsmusg30.com','2017-02-21 13:19:11','true'),('001','1','http://iotsmusg30.com','2017-02-26 13:16:11','false'),('001','1','http://iotsmusg30.com','2017-02-26 13:19:11','true'),('001','1','http://iotsmusg30.com','2017-03-18 19:29:28','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:33:25','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:37:08','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:37:39','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:38:47','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:39:48','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:40:12','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:50:32','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:51:46','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:52:32','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:54:55','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:55:22','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:56:27','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:56:47','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:58:01','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:58:15','false'),('001','1','http://iotsmusg30.com','2017-03-18 19:58:58','false'),('001','1','http://iotsmusg30.com','2017-04-11 08:15:14','false'),('001','1','http://iotsmusg30.com','2017-04-11 08:19:14','true'),('002','2','http://iotsmusg30.com','2017-04-11 08:22:14','false'),('002','2','http://iotsmusg30.com','2017-04-11 08:23:14','true'),('003','3','http://iotsmusg29.com','2017-04-11 09:20:14','false'),('003','3','http://iotsmusg29.com','2017-04-11 09:21:14','true'),('004','4','http://iotsmusg28.com','2017-04-11 09:33:14','false'),('005','5','http://iotsmusg29.com','2017-04-11 10:01:14','false'),('005','5','http://iotsmusg29.com','2017-04-11 10:03:14','true'),('006','6','http://iotsmusg29.com','2017-04-11 10:19:14','false'),('006','6','http://iotsmusg29.com','2017-04-11 10:21:19','true');
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

-- Dump completed on 2017-04-11 12:13:20
