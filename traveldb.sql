-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: traveldb
-- ------------------------------------------------------
-- Server version	8.0.19



--
-- Table structure for table `diary`
--

DROP TABLE IF EXISTS `diary`;

CREATE TABLE `diary` (
  `diaryid` decimal(12,0) NOT NULL,
  `time` datetime NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `description` longtext,
  `photo` longtext,
  `share` decimal(1,0) NOT NULL DEFAULT '0',
  `uid` decimal(5,0) NOT NULL,
  `travelid` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`diaryid`),
  KEY `travelid_idx` (`travelid`),
  KEY `uerid_idx` (`uid`),
  CONSTRAINT `travelid` FOREIGN KEY (`travelid`) REFERENCES `travel` (`travelid`),
  CONSTRAINT `uerid` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日记表';


--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route` (
  `routeid` decimal(14,0) NOT NULL,
  `state` decimal(1,0) NOT NULL DEFAULT '0',
  `method` varchar(100) NOT NULL DEFAULT '未定义出行方式',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `start_siteid` varchar(45) DEFAULT NULL,
  `end_siteid` varchar(45) DEFAULT NULL,
  `travelid` decimal(12,0) NOT NULL,
  PRIMARY KEY (`routeid`),
  KEY `travelid_idx` (`travelid`),
  CONSTRAINT `travel_id` FOREIGN KEY (`travelid`) REFERENCES `travel` (`travelid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='路线表';


--
-- Table structure for table `site`
--

DROP TABLE IF EXISTS `site`;

CREATE TABLE `site` (
  `siteid` varchar(45) NOT NULL,
  `sitename` varchar(100) NOT NULL,
  `city` varchar(45) NOT NULL,
  `distinct` varchar(80) DEFAULT NULL,
  `adcode` varchar(45) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='地点表';


--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;

CREATE TABLE `task` (
  `taskid` decimal(16,0) NOT NULL,
  `state` decimal(1,0) NOT NULL DEFAULT '0',
  `description` varchar(45) NOT NULL,
  `routeid` decimal(14,0) NOT NULL,
  PRIMARY KEY (`taskid`),
  KEY `routeid_idx` (`routeid`),
  CONSTRAINT `route_id` FOREIGN KEY (`routeid`) REFERENCES `route` (`routeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='待办表';


--
-- Table structure for table `travel`
--

DROP TABLE IF EXISTS `travel`;

CREATE TABLE `travel` (
  `travelid` decimal(12,0) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `uid` decimal(5,0) NOT NULL,
  PRIMARY KEY (`travelid`),
  KEY `uid` (`uid`),
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='旅游表';


--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `uid` decimal(5,0) NOT NULL,
  `uname` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `sex` varchar(2) DEFAULT NULL,
  `introduction` varchar(100) DEFAULT '此用户没有填写个人介绍',
  PRIMARY KEY (`uid`),
  CONSTRAINT `user_chk_1` CHECK ((`sex` in (_utf8mb4'男',_utf8mb4'女')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';



