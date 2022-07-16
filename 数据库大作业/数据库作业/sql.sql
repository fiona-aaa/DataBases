-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: system_choose_course
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adminpwd`
--

DROP TABLE IF EXISTS `adminpwd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminpwd` (
  `id` varchar(12) NOT NULL,
  `pwd` varchar(12) NOT NULL,
  `name` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminpwd`
--

LOCK TABLES `adminpwd` WRITE;
/*!40000 ALTER TABLE `adminpwd` DISABLE KEYS */;
INSERT INTO `adminpwd` VALUES ('1','1','AA'),('2','2','AB'),('3','3','AC'),('4','4','AD');
/*!40000 ALTER TABLE `adminpwd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `crId` varchar(12) NOT NULL,
  `crNum` int DEFAULT NULL,
  PRIMARY KEY (`crId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES ('1',50),('2',100),('3',100),('4',50),('5',50);
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_arr`
--

DROP TABLE IF EXISTS `classroom_arr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom_arr` (
  `crId` varchar(12) NOT NULL DEFAULT '',
  `cId` varchar(12) NOT NULL DEFAULT '',
  `cTime` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`crId`,`cId`),
  KEY `cId` (`cId`),
  CONSTRAINT `classroom_arr_ibfk_1` FOREIGN KEY (`crId`) REFERENCES `classroom` (`crId`),
  CONSTRAINT `classroom_arr_ibfk_2` FOREIGN KEY (`cId`) REFERENCES `courseinfo` (`cId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_arr`
--

LOCK TABLES `classroom_arr` WRITE;
/*!40000 ALTER TABLE `classroom_arr` DISABLE KEYS */;
INSERT INTO `classroom_arr` VALUES ('1','3','周一1-2，周三7-8'),('2','5','周一3-4，周三5-6'),('3','4','周二1-2，周四7-8'),('4','1','周一7-8，周三3-4'),('5','2','周三1-2，周五3-4');
/*!40000 ALTER TABLE `classroom_arr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseinfo`
--

DROP TABLE IF EXISTS `courseinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courseinfo` (
  `cId` varchar(12) NOT NULL,
  `cName` varchar(12) DEFAULT NULL,
  `cIntro` varchar(50) DEFAULT NULL,
  `cHour` int DEFAULT NULL,
  `cCredit` float DEFAULT NULL,
  `cWeek` varchar(12) DEFAULT NULL,
  `RC` int DEFAULT NULL,
  PRIMARY KEY (`cId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseinfo`
--

LOCK TABLES `courseinfo` WRITE;
/*!40000 ALTER TABLE `courseinfo` DISABLE KEYS */;
INSERT INTO `courseinfo` VALUES ('1','必修1','slightly',20,2,'1-6',1),('2','必修2','slightly',25,3,'1-8',1),('3','必修3','slightly',20,1,'1-10',1),('4','选修1','slightly',10,2.5,'6-12',0),('5','选修2','slightly',30,2,'6-14',0);
/*!40000 ALTER TABLE `courseinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `major`
--

DROP TABLE IF EXISTS `major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `major` (
  `Mname` varchar(20) NOT NULL,
  `id` varchar(12) NOT NULL,
  PRIMARY KEY (`Mname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major`
--

LOCK TABLES `major` WRITE;
/*!40000 ALTER TABLE `major` DISABLE KEYS */;
INSERT INTO `major` VALUES ('car','4'),('chemistry','5'),('CS','1'),('English','3'),('math','2');
/*!40000 ALTER TABLE `major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sc`
--

DROP TABLE IF EXISTS `sc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sc` (
  `sId` varchar(12) NOT NULL DEFAULT '',
  `cId` varchar(12) NOT NULL DEFAULT '',
  `grade` float DEFAULT NULL,
  PRIMARY KEY (`sId`,`cId`),
  KEY `fk2_idx` (`cId`),
  CONSTRAINT `FK_1` FOREIGN KEY (`sId`) REFERENCES `studentinfo` (`sId`),
  CONSTRAINT `FK_4` FOREIGN KEY (`cId`) REFERENCES `courseinfo` (`cId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sc`
--

LOCK TABLES `sc` WRITE;
/*!40000 ALTER TABLE `sc` DISABLE KEYS */;
INSERT INTO `sc` VALUES ('1001','1',NULL),('1001','2',NULL),('1001','3',NULL),('1001','4',NULL),('1001','5',NULL),('1002','1',NULL),('1002','2',NULL),('1002','3',NULL),('1002','4',NULL),('1002','5',NULL),('1003','1',NULL),('1003','2',NULL),('1003','3',NULL),('1003','4',NULL),('1003','5',NULL),('1004','1',NULL),('1004','2',NULL),('1005','1',NULL);
/*!40000 ALTER TABLE `sc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentinfo`
--

DROP TABLE IF EXISTS `studentinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentinfo` (
  `sId` varchar(12) NOT NULL,
  `sname` varchar(12) NOT NULL,
  `dept` varchar(12) DEFAULT NULL,
  `gender` varchar(2) DEFAULT NULL,
  `birthday` varchar(12) DEFAULT NULL,
  `major` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`sId`),
  KEY `q_idx` (`major`),
  CONSTRAINT `fk1` FOREIGN KEY (`major`) REFERENCES `major` (`Mname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentinfo`
--

LOCK TABLES `studentinfo` WRITE;
/*!40000 ALTER TABLE `studentinfo` DISABLE KEYS */;
INSERT INTO `studentinfo` VALUES ('001','test1',NULL,NULL,NULL,NULL),('1001','s1','unkown','2','2001-09-09','math'),('1002','s2','unkown','2','2022-05-23','math'),('1003','s3','unkown','2','2000-02-06','math'),('1004','s4','unkown','1','2001-05-01','math'),('1005','s5','unkown','2','2002-06-01','math'),('1010','李明','unkown','3','2002-02-02','math'),('1011','test0',NULL,NULL,NULL,NULL),('1012','test1',NULL,NULL,NULL,NULL),('1013','test3',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `studentinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `t1` AFTER INSERT ON `studentinfo` FOR EACH ROW begin
insert into stupwd values(new.sId,new.sId,new.sname);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stupwd`
--

DROP TABLE IF EXISTS `stupwd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stupwd` (
  `id` varchar(12) NOT NULL,
  `pwd` varchar(12) CHARACTER SET latin1 NOT NULL,
  `sname` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`,`pwd`),
  CONSTRAINT `FK_3` FOREIGN KEY (`id`) REFERENCES `studentinfo` (`sId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stupwd`
--

LOCK TABLES `stupwd` WRITE;
/*!40000 ALTER TABLE `stupwd` DISABLE KEYS */;
INSERT INTO `stupwd` VALUES ('001','001','test1'),('1001','1001','t1'),('1002','1002','t2'),('1003','1003','t3'),('1004','1004','t4'),('1005','1005','t5'),('1012','1012','test1'),('1013','1013','test3');
/*!40000 ALTER TABLE `stupwd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teach`
--

DROP TABLE IF EXISTS `teach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teach` (
  `cId` varchar(12) NOT NULL DEFAULT '',
  `tId` varchar(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`tId`,`cId`),
  KEY `cId` (`cId`),
  CONSTRAINT `teach_ibfk_1` FOREIGN KEY (`tId`) REFERENCES `teacherinfo` (`tId`),
  CONSTRAINT `teach_ibfk_2` FOREIGN KEY (`cId`) REFERENCES `courseinfo` (`cId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teach`
--

LOCK TABLES `teach` WRITE;
/*!40000 ALTER TABLE `teach` DISABLE KEYS */;
INSERT INTO `teach` VALUES ('1','3'),('2','4'),('3','5'),('4','1'),('5','2');
/*!40000 ALTER TABLE `teach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacherinfo`
--

DROP TABLE IF EXISTS `teacherinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacherinfo` (
  `tId` varchar(12) NOT NULL,
  `tName` varchar(12) DEFAULT NULL,
  `university` varchar(12) DEFAULT NULL,
  `tTitle` varchar(12) DEFAULT NULL,
  `eduBg` varchar(12) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`tId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacherinfo`
--

LOCK TABLES `teacherinfo` WRITE;
/*!40000 ALTER TABLE `teacherinfo` DISABLE KEYS */;
INSERT INTO `teacherinfo` VALUES ('1','t1','anda','teacher','benke','1990-01-01','1'),('2','t2','anlida','teacher','benke','1991-01-01','1'),('3','t3','keda','teacher','benke','1993-07-01','2'),('4','t4','zheda','teacher','benke','1995-08-09','2'),('5','E','nanda','teacher','benke','1996-08-09','2');
/*!40000 ALTER TABLE `teacherinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v3`
--

DROP TABLE IF EXISTS `v3`;
/*!50001 DROP VIEW IF EXISTS `v3`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v3` AS SELECT 
 1 AS `sId`,
 1 AS `sname`,
 1 AS `cName`,
 1 AS `cId`,
 1 AS `cIntro`,
 1 AS `cCredit`,
 1 AS `cWeek`,
 1 AS `tName`,
 1 AS `crId`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'system_choose_course'
--

--
-- Dumping routines for database 'system_choose_course'
--
/*!50003 DROP PROCEDURE IF EXISTS `p1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p1`(
    in majorname varchar(20),in stuid varchar(12)
)
BEGIN
    update studentinfo 
    set major= majorname
	where sId= stuid 
    and majorname in (select Mname from major);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v3`
--

/*!50001 DROP VIEW IF EXISTS `v3`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v3` AS select `studentinfo`.`sId` AS `sId`,`studentinfo`.`sname` AS `sname`,`courseinfo`.`cName` AS `cName`,`courseinfo`.`cId` AS `cId`,`courseinfo`.`cIntro` AS `cIntro`,`courseinfo`.`cCredit` AS `cCredit`,`courseinfo`.`cWeek` AS `cWeek`,`teacherinfo`.`tName` AS `tName`,`classroom`.`crId` AS `crId` from ((((((`studentinfo` join `sc`) join `courseinfo`) join `teach`) join `teacherinfo`) join `classroom`) join `classroom_arr`) where ((`studentinfo`.`sId` = `sc`.`sId`) and (`courseinfo`.`cId` = `sc`.`cId`) and (`teach`.`tId` = `teacherinfo`.`tId`) and (`classroom`.`crId` = `classroom_arr`.`crId`) and (`classroom_arr`.`cId` = `courseinfo`.`cId`) and (`teach`.`cId` = `courseinfo`.`cId`) and (`studentinfo`.`sId` = '1001')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-26 20:12:15
