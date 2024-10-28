-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: petdb
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu0.16.04.1

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
-- Table structure for table `breed`
--

DROP TABLE IF EXISTS `breed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `breed` (
  `breedname` varchar(200) NOT NULL,
  `breedcost` bigint(20) DEFAULT NULL,
  `country_of_origin` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`breedname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `breed`
--

LOCK TABLES `breed` WRITE;
/*!40000 ALTER TABLE `breed` DISABLE KEYS */;
INSERT INTO `breed` VALUES ('Afghan Hound',45000,'Afghanistan'),('Basset Hound',50000,'France'),('Beagle',15000,'United Kingdom'),('Boxer',20000,'Germany'),('Bulldog',15000,'United Kingdom'),('Chihuahua',25000,'Mexico'),('Chow Chow',38000,'China'),('Collie',30000,'United Kingdom'),('Dalmatian',40000,'United Kingdom'),('Doberman Pinscher',30000,'Germany'),('Exotic Shorthair',12000,'United States'),('German Shepherd',20000,'Germany'),('Golden Retriever',40000,'United Kingdom'),('Labrador Retriever',20000,'Canada, USA'),('Maine Coon',14000,'United States'),('Mastiff',40000,'United Kingdom'),('Pomeranian',35000,'Germany'),('Poodle',25000,'Germany, France'),('Pug',10000,'China'),('Ragdoll',15000,'United States'),('Rottweiler',50000,'Germany'),('Shih Tzu',25000,'China'),('Siberian Husky',50000,'Russia');
/*!40000 ALTER TABLE `breed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet`
--

DROP TABLE IF EXISTS `pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet` (
  `petid` bigint(20) NOT NULL,
  `petname` varchar(100) DEFAULT NULL,
  `pettype` varchar(100) NOT NULL,
  `gender` varchar(100) NOT NULL,
  `adopted_by` varchar(100) DEFAULT NULL,
  `donated_by` varchar(100) DEFAULT NULL,
  `vetid` bigint(20) DEFAULT NULL,
  `breedname` varchar(200) NOT NULL,
  `shelterid` bigint(20) DEFAULT NULL,
  `donation_date` date DEFAULT NULL,
  `adoption_date` date DEFAULT NULL,
  `imgsource` varchar(200) DEFAULT NULL,
  `height` bigint(20) DEFAULT NULL,
  `weight` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`petid`),
  KEY `adopted_by` (`adopted_by`),
  KEY `donated_by` (`donated_by`),
  KEY `breedname` (`breedname`),
  KEY `shelterid` (`shelterid`),
  KEY `vetid` (`vetid`),
  CONSTRAINT `pet_ibfk_1` FOREIGN KEY (`adopted_by`) REFERENCES `user` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `pet_ibfk_2` FOREIGN KEY (`donated_by`) REFERENCES `user` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `pet_ibfk_4` FOREIGN KEY (`breedname`) REFERENCES `breed` (`breedname`) ON DELETE CASCADE,
  CONSTRAINT `pet_ibfk_5` FOREIGN KEY (`shelterid`) REFERENCES `shelter` (`shelterid`),
  CONSTRAINT `pet_ibfk_6` FOREIGN KEY (`vetid`) REFERENCES `vet` (`vetid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet`
--

LOCK TABLES `pet` WRITE;
/*!40000 ALTER TABLE `pet` DISABLE KEYS */;
INSERT INTO `pet` VALUES (1,'pet1','dog','male',NULL,'ndk_02',1,'Boxer',2,'2015-04-16',NULL,'/static/Boxer.jpg',50,40),(2,'pet2','dog','female',NULL,'best_01',5,'Afghan Hound',7,'2015-02-24',NULL,'/static/Afghan Hound.jpg',70,50),(3,'pet3','dog','male','ndk_02','don_05',2,'Basset Hound',1,'2016-07-18','2016-12-21','/static/Basset Hound.jpg',60,37),(4,'pet4','dog','female',NULL,'robcross_04',4,'Labrador Retriever',4,'2016-06-30',NULL,'/static/Labrador Retriever.jpg',65,47),(5,'pet5','dog','male',NULL,'best_01',1,'German Shepherd',9,'2015-01-01',NULL,'/static/German Shepherd.jpg',65,49),(6,'pet6','cat','female',NULL,'ndk_02',4,'Maine Coon',4,'2015-12-22',NULL,'/static/Maine Coon.jpg',20,10),(7,'pet7','cat','female','don_05','robcross_04',5,'Ragdoll',1,'2016-11-19','2017-02-02','/static/Ragdoll.jpg',19,9),(8,'pet8','dog','male',NULL,'don_05',6,'Golden Retriever',10,'2016-05-18',NULL,'/static/Golden Retriever.jpg',41,23),(9,'pet9','dog','female',NULL,'best_01',2,'Rottweiler',11,'2016-02-24',NULL,'/static/Rottweiler.jpg',50,47);
/*!40000 ALTER TABLE `pet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shelter`
--

DROP TABLE IF EXISTS `shelter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shelter` (
  `shelterid` bigint(20) NOT NULL,
  `sheltername` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `pnumber` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`shelterid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shelter`
--

LOCK TABLES `shelter` WRITE;
/*!40000 ALTER TABLE `shelter` DISABLE KEYS */;
INSERT INTO `shelter` VALUES (1,'shelter1','#222 Ranka Manor 2/9 Artillery Road, Ulsoor, Karnataka 560008',7001254736),(2,'shelter2','#111 Rajathadri Layout, JP nagar 8th phase, Karnataka 560008',8500214572),(3,'shelter3','#211 Thimmareddy Layout, Kaggadasapura, Karnataka 560093',9564545411),(4,'shelter4','#311 Bharath Residency, Marathhalli, Karnataka 560037',8024563587),(5,'shelter5','#356 Nandanam Colony, Kalyan Nagar Post, Karnataka 560043',7622548937),(6,'shelter6','#678 Lotusheights Apartment, Kundalahalli Gate, Karnataka 566037',8601247963),(7,'shelter7','#777 Gandhi Nagar, Tumkur, Karnataka 572102',9988775566),(8,'shelter8','#666 Near IIM-B, Bannerghatta Rd, Karnataka 572102',9988775566),(9,'shelter9','#555 Ramagondanahalli Village, Varthur Hobli, Karnataka 560066',8891125054),(10,'shelter10','#123 2rd Cross Road, 16th B Main Road 3rd Block , Karnataka 560095',9007854123),(11,'shelter11','#465 3rd Block, Bhashyam Circle, Karnataka 560010',8033923275);
/*!40000 ALTER TABLE `shelter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `userid` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `userpasswd` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `pnumber` bigint(20) DEFAULT NULL,
  `gender` varchar(20) NOT NULL,
  `doj` date NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('best_01','Saurabh Bhushan','2468abcdea','#102 Sanjay nagar, Mehkri circle, Karnataka 560080',9972899438,'male','2005-01-21'),('don_05','Jatin Bhutani','JbUkPeKyXfSo','#234 KGhalli, Jalahalli west, Karnataka 560015',7411107235,'male','2005-04-19'),('ndk_02','N Deepak kumar','876Aa81p','#442 Suryodaya layout, Rajankunte, Karnataka 560064',8105591083,'male','2005-05-25'),('robcross_04','Hemant Singh','HfNcPwVmRlM','#112 Air force, Jalahalli west, Karnataka 560015',8045782356,'male','2005-11-28');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vet`
--

DROP TABLE IF EXISTS `vet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vet` (
  `vetid` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `pnumber` bigint(20) DEFAULT NULL,
  `gender` varchar(20) NOT NULL,
  PRIMARY KEY (`vetid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vet`
--

LOCK TABLES `vet` WRITE;
/*!40000 ALTER TABLE `vet` DISABLE KEYS */;
INSERT INTO `vet` VALUES (1,'Bhavin Mishra','#103 Kambipura, Mysore road, Karnataka 560074',8892241125,'male'),(2,'Medha Sharma','#222 Binny mill, Magadi road, Karnataka 560023',8892241125,'female'),(3,'Pulkit Verma','#231 West of Chord Road, opp Rajajinagar, Karnataka 560086',9741828720,'male'),(4,'Shreya Mishra','#999 No.14 Cunningham Road, Sheriffs Chamber, Karnataka 560052',7895423000,'female'),(5,'Ronita Pandey','#342 No.23 80 Feet Road, Guru Krupa Layout, Karnataka 560007',8554477663,'female'),(6,'Champak Naik','#485 8th A Cross, Jeevanbheema Nagar, Karnataka 560075',8030656602,'male'),(7,'Nandhini MK','#195 22nd Cross 3rd Sector HSR, HSR Layout, Karnataka 560102',8033085390,'female');
/*!40000 ALTER TABLE `vet` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-28 17:57:18
