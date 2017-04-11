-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 10, 2017 at 06:58 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `iot2`
--
CREATE DATABASE IF NOT EXISTS `iot2` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `iot2`;

-- --------------------------------------------------------

--
-- Table structure for table `beacon`
--

CREATE TABLE IF NOT EXISTS `beacon` (
  `BeaconID` varchar(50) NOT NULL,
  `Location` varchar(50) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`BeaconID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `beacon`
--

INSERT INTO `beacon` (`BeaconID`, `Location`, `type`) VALUES
('http://iotsmusg28.com', 'At exit 28', 'exit'),
('http://iotsmusg29.com', 'At exit 29', 'exit'),
('http://iotsmusg30.com', 'At exit B', 'exit'),
('http://Ks.com', 'At exit A', 'exit');

-- --------------------------------------------------------

--
-- Table structure for table `officer`
--

CREATE TABLE IF NOT EXISTS `officer` (
  `phone_num` varchar(10) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `empID` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`empID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `officer`
--

INSERT INTO `officer` (`phone_num`, `name`, `status`, `empID`, `image`) VALUES
('6594898452', 'Tan Kun Sheng', 'on', 1, 'img/wj.png'),
('6596404133', 'Koh Chu Qian', 'on', 2, 'img/merv.png'),
('6581153520', 'Li Yingnan', 'on', 7, 'img/mh.png');

-- --------------------------------------------------------

--
-- Table structure for table `pi`
--

CREATE TABLE IF NOT EXISTS `pi` (
  `PiID` varchar(50) NOT NULL,
  PRIMARY KEY (`PiID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pi`
--

INSERT INTO `pi` (`PiID`) VALUES
('001');

-- --------------------------------------------------------

--
-- Table structure for table `pi_on_trolley`
--

CREATE TABLE IF NOT EXISTS `pi_on_trolley` (
  `PiID` varchar(50) NOT NULL,
  `TrolleyID` varchar(50) NOT NULL,
  `Battery` int(11) DEFAULT NULL,
  PRIMARY KEY (`PiID`,`TrolleyID`),
  KEY `fk_trolley_idx` (`TrolleyID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pi_on_trolley`
--

INSERT INTO `pi_on_trolley` (`PiID`, `TrolleyID`, `Battery`) VALUES
('001', '1', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE IF NOT EXISTS `schedule` (
  `date` date NOT NULL,
  `empID` int(11) NOT NULL,
  `start_time` int(11) DEFAULT NULL,
  `end_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`date`,`empID`),
  KEY `fk_offier_idx` (`empID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`date`, `empID`, `start_time`, `end_time`) VALUES
('2017-04-03', 1, 8, 15),
('2017-04-03', 2, 20, 23),
('2017-04-10', 1, 12, 23),
('2017-04-10', 7, 15, 20),
('2017-04-11', 1, 8, 15),
('2017-04-11', 2, 8, 12),
('2017-04-11', 7, 8, 23);

-- --------------------------------------------------------

--
-- Table structure for table `trolley`
--

CREATE TABLE IF NOT EXISTS `trolley` (
  `TrolleyID` varchar(50) NOT NULL,
  PRIMARY KEY (`TrolleyID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trolley`
--

INSERT INTO `trolley` (`TrolleyID`) VALUES
('1'),
('2');

-- --------------------------------------------------------

--
-- Table structure for table `trolleypi_beacon_event`
--

CREATE TABLE IF NOT EXISTS `trolleypi_beacon_event` (
  `PiID` varchar(50) NOT NULL,
  `TrolleyID` varchar(50) NOT NULL,
  `BeaconID` varchar(50) NOT NULL,
  `Timestamp` datetime NOT NULL,
  `isBack` varchar(45) DEFAULT 'false',
  PRIMARY KEY (`PiID`,`TrolleyID`,`BeaconID`,`Timestamp`),
  KEY `fk_beacon_idx` (`BeaconID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trolleypi_beacon_event`
--

INSERT INTO `trolleypi_beacon_event` (`PiID`, `TrolleyID`, `BeaconID`, `Timestamp`, `isBack`) VALUES
('001', '1', 'http://iotsmusg28.com', '2017-03-18 19:59:49', 'false'),
('001', '1', 'http://iotsmusg28.com', '2017-04-02 19:02:29', 'true'),
('001', '1', 'http://iotsmusg28.com', '2017-04-02 19:15:14', 'false'),
('001', '1', 'http://iotsmusg28.com', '2017-04-02 19:16:05', 'true'),
('001', '1', 'http://iotsmusg28.com', '2017-04-02 19:18:36', 'false'),
('001', '1', 'http://iotsmusg28.com', '2017-04-02 19:18:55', 'true'),
('001', '1', 'http://iotsmusg28.com', '2017-04-02 19:19:43', 'false'),
('001', '1', 'http://iotsmusg28.com', '2017-04-02 19:19:59', 'true'),
('001', '1', 'http://iotsmusg28.com', '2017-04-02 19:20:01', 'false'),
('001', '1', 'http://iotsmusg28.com', '2017-04-02 19:20:14', 'true'),
('001', '1', 'http://iotsmusg28.com', '2017-04-02 19:20:19', 'false'),
('001', '1', 'http://iotsmusg28.com', '2017-04-02 19:20:40', 'true'),
('001', '1', 'http://iotsmusg28.com', '2017-04-02 19:21:07', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:29:28', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:33:25', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:37:08', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:37:39', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:38:47', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:39:48', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:40:12', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:50:32', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:51:46', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:52:32', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:54:55', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:55:22', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:56:27', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:56:47', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:58:01', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:58:15', 'false'),
('001', '1', 'http://iotsmusg30.com', '2017-03-18 19:58:58', 'false'),
('001', '1', 'http://Ks.com', '2017-03-15 18:44:12', 'false');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pi_on_trolley`
--
ALTER TABLE `pi_on_trolley`
  ADD CONSTRAINT `fk_pi` FOREIGN KEY (`PiID`) REFERENCES `pi` (`PiID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_trolley` FOREIGN KEY (`TrolleyID`) REFERENCES `trolley` (`TrolleyID`) ON UPDATE CASCADE;

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `fk_offier` FOREIGN KEY (`empID`) REFERENCES `officer` (`empID`) ON UPDATE CASCADE;

--
-- Constraints for table `trolleypi_beacon_event`
--
ALTER TABLE `trolleypi_beacon_event`
  ADD CONSTRAINT `fk_beacon` FOREIGN KEY (`BeaconID`) REFERENCES `beacon` (`BeaconID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pi_on_trolley` FOREIGN KEY (`PiID`, `TrolleyID`) REFERENCES `pi_on_trolley` (`PiID`, `TrolleyID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
