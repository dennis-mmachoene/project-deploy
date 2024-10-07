-- Create a directory called mysql-init in your project root and save this as init.sql
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `roleID` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`roleID`)
);
INSERT INTO `roles` VALUES (1,'ADMIN'),(2,'MANAGER'),(3,'RESIDENT'),(4,'SUPERVISOR');

DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `deptID` int NOT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`deptID`)
);
INSERT INTO `department` VALUES (100,'Water'),(200,'Transport'),(300,'Crime'),(400,'Electricity'),(500,'Maintenance');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `surname` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `roleID` int DEFAULT NULL,
  `departmentID` int DEFAULT NULL,
  `empID` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `otp_secret` varchar(255) DEFAULT NULL,
  `profilePic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `roleID` (`roleID`),
  KEY `users_ibfk_2` (`departmentID`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`roleID`) REFERENCES `roles` (`roleID`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`departmentID`) REFERENCES `department` (`deptID`)
);

DROP TABLE IF EXISTS `issue`;
CREATE TABLE `issue` (
  `issueID` int NOT NULL AUTO_INCREMENT,
  `residentID` int DEFAULT NULL,
  `description` text,
  `status` varchar(50) DEFAULT NULL,
  `dateReported` datetime DEFAULT CURRENT_TIMESTAMP,
  `dateResolved` date DEFAULT NULL,
  `assignedSupervisorID` int DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `issueCategory` varchar(255) DEFAULT NULL,
  `issue_image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`issueID`),
  KEY `residentID` (`residentID`),
  KEY `assignedSupervisorID` (`assignedSupervisorID`),
  CONSTRAINT `issue_ibfk_1` FOREIGN KEY (`residentID`) REFERENCES `users` (`id`),
  CONSTRAINT `issue_ibfk_2` FOREIGN KEY (`assignedSupervisorID`) REFERENCES `users` (`id`)
);

DROP TABLE IF EXISTS `assignment`;
CREATE TABLE `assignment` (
  `assignmentID` int NOT NULL AUTO_INCREMENT,
  `issueID` int DEFAULT NULL,
  `technicianID` int DEFAULT NULL,
  `managerID` int DEFAULT NULL,
  `dateAssigned` date DEFAULT NULL,
  PRIMARY KEY (`assignmentID`),
  KEY `issueID` (`issueID`),
  KEY `technicianID` (`technicianID`),
  KEY `managerID` (`managerID`),
  CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`issueID`) REFERENCES `issue` (`issueID`),
  CONSTRAINT `assignment_ibfk_2` FOREIGN KEY (`technicianID`) REFERENCES `users` (`id`),
  CONSTRAINT `assignment_ibfk_3` FOREIGN KEY (`managerID`) REFERENCES `users` (`id`)
);

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `feedbackID` int NOT NULL AUTO_INCREMENT,
  `issueID` int DEFAULT NULL,
  `residentID` int DEFAULT NULL,
  `comments` text,
  `rating` int DEFAULT NULL,
  `dateProvided` date DEFAULT NULL,
  PRIMARY KEY (`feedbackID`),
  KEY `issueID` (`issueID`),
  KEY `residentID` (`residentID`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`issueID`) REFERENCES `issue` (`issueID`),
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`residentID`) REFERENCES `users` (`id`)
);

DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `notificationID` int NOT NULL AUTO_INCREMENT,
  `userID` int DEFAULT NULL,
  `message` text,
  `dateSent` date DEFAULT NULL,
  `readStatus` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`notificationID`),
  KEY `userID` (`userID`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
);