-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2017 at 11:59 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `amkthk-smu fyp`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE IF NOT EXISTS `announcements` (
  `UserID` varchar(40) NOT NULL,
  `new_Announcements` text NOT NULL,
  `entry_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `audit`
--

CREATE TABLE IF NOT EXISTS `audit` (
  `userID` varchar(40) NOT NULL,
  `Login_time` date NOT NULL,
  `Logout_time` date NOT NULL,
  `TNF_application_ID` varchar(40) NOT NULL,
  `createdBy` varchar(40) NOT NULL,
  `updatedBy` varchar(40) NOT NULL,
  `Approvedby` varchar(40) NOT NULL,
  `ElearnCourse` varchar(40) NOT NULL,
  `access_time` date NOT NULL,
  `quiz_takenTime` date NOT NULL,
  `quiz_endTime` date NOT NULL,
  `Quiz_result` int(11) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bonds`
--

CREATE TABLE IF NOT EXISTS `bonds` (
  `BondName` varchar(40) NOT NULL,
  `category` text NOT NULL,
  `criteria` text NOT NULL,
  PRIMARY KEY (`BondName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE IF NOT EXISTS `course` (
  `CourseID` varchar(50) NOT NULL,
  `CourseName` varchar(50) NOT NULL,
  `Price` double NOT NULL,
  `Elearn` tinyint(1) NOT NULL,
  `Vendor` varchar(50) NOT NULL,
  `Venue` varchar(100) DEFAULT NULL,
  `Details` text NOT NULL,
  PRIMARY KEY (`CourseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_content`
--

CREATE TABLE IF NOT EXISTS `course_content` (
  `CourseID` varchar(40) NOT NULL,
  `module_content` text NOT NULL,
  PRIMARY KEY (`CourseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE IF NOT EXISTS `department` (
  `DeptName` varchar(50) NOT NULL,
  `ProjectedBudget` double NOT NULL,
  `ActualBudget` double NOT NULL,
  `DeptHead` varchar(40) NOT NULL,
  PRIMARY KEY (`DeptName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lesson`
--

CREATE TABLE IF NOT EXISTS `lesson` (
  `LessonID` varchar(40) NOT NULL,
  `CourseID` varchar(40) NOT NULL,
  `Lesson_time` time NOT NULL,
  `Lesson_end` time NOT NULL,
  `Lesson_startDate` date NOT NULL,
  `Lesson_endDate` date NOT NULL,
  `Timing` time NOT NULL,
  `Instructor` varchar(40) NOT NULL,
  PRIMARY KEY (`LessonID`,`CourseID`),
  KEY `CourseID` (`CourseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lesson_info`
--

CREATE TABLE IF NOT EXISTS `lesson_info` (
  `ClassID` varchar(40) NOT NULL,
  `UserID` varchar(40) NOT NULL,
  `Attendance` tinyint(1) NOT NULL,
  PRIMARY KEY (`ClassID`,`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE IF NOT EXISTS `materials` (
  `CourseID` varchar(40) NOT NULL,
  `Class_ID` varchar(40) NOT NULL,
  `Materials` text,
  PRIMARY KEY (`CourseID`,`Class_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE IF NOT EXISTS `news` (
  `UserID` varchar(40) NOT NULL,
  `News` text NOT NULL,
  `entry_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE IF NOT EXISTS `notification` (
  `UserID_From` varchar(40) NOT NULL,
  `UserID_To` varchar(40) NOT NULL,
  `TNFID` varchar(40) NOT NULL,
  `Status` varchar(10) NOT NULL,
  `Notif_ID` varchar(40) NOT NULL,
  PRIMARY KEY (`UserID_From`,`UserID_To`,`TNFID`,`Notif_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE IF NOT EXISTS `quiz` (
  `CourseID` varchar(40) NOT NULL,
  `quizID` varchar(40) NOT NULL,
  `quiz_duration` date NOT NULL,
  `quiz_expiryDate` date NOT NULL,
  `Total_score` int(11) NOT NULL,
  PRIMARY KEY (`CourseID`,`quizID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_content`
--

CREATE TABLE IF NOT EXISTS `quiz_content` (
  `CourseID` varchar(40) NOT NULL,
  `quizID` varchar(40) NOT NULL,
  `question_num` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `question_ans` varchar(1) NOT NULL,
  PRIMARY KEY (`CourseID`,`quizID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `Role` varchar(40) NOT NULL,
  `LevelOfSeniority` int(11) NOT NULL,
  `Rights` text NOT NULL,
  PRIMARY KEY (`Role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tef`
--

CREATE TABLE IF NOT EXISTS `tef` (
  `UserID` int(11) NOT NULL,
  `CourseID` int(11) NOT NULL,
  `LessonID` int(11) NOT NULL,
  `Evaluation` int(11) NOT NULL,
  PRIMARY KEY (`UserID`,`CourseID`,`LessonID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tnf`
--

CREATE TABLE IF NOT EXISTS `tnf` (
  `StaffName` varchar(50) NOT NULL,
  `EID` varchar(40) NOT NULL,
  `TNFID` varchar(40) NOT NULL,
  `Designation` varchar(40) NOT NULL,
  `Department` varchar(40) NOT NULL,
  `Cost_centre` varchar(40) NOT NULL,
  `CourseID` varchar(40) NOT NULL,
  `Total_training_hours` int(11) NOT NULL,
  `Course_Fee` double NOT NULL,
  `GST` double NOT NULL,
  `Funding` double NOT NULL,
  `Learning_objectives` text NOT NULL,
  `Post_Training_Action_Plan` text NOT NULL,
  `Signature` tinyint(1) DEFAULT NULL,
  `PreReq` tinyint(1) NOT NULL,
  `MinAppraisal` tinyint(1) NOT NULL,
  `briefing` tinyint(1) NOT NULL,
  `planned` tinyint(1) NOT NULL,
  `adhoc` tinyint(1) NOT NULL,
  `funded` tinyint(1) NOT NULL,
  `competency` tinyint(1) NOT NULL,
  `upgrading` tinyint(1) NOT NULL,
  `job_scope_change` tinyint(1) NOT NULL,
  `leadership` tinyint(1) NOT NULL,
  `expectation_for_staff` text NOT NULL,
  `ensure_expectations_met` text NOT NULL,
  `probation_staff` tinyint(1) NOT NULL,
  `reason_for_sponsorship` text NOT NULL,
  `requestedBy` varchar(40) NOT NULL,
  `approvedBy` varchar(40) NOT NULL,
  `CEO_sign` varchar(40) NOT NULL,
  PRIMARY KEY (`TNFID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `UserID` varchar(40) NOT NULL,
  `Name` varchar(40) NOT NULL,
  `LengthOfService` float NOT NULL,
  `job_category` text NOT NULL,
  `job_title` text NOT NULL,
  `supervisor` varchar(40) NOT NULL,
  `role` text NOT NULL,
  `Elearn_quiz_result` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`UserID`, `Name`, `LengthOfService`, `job_category`, `job_title`, `supervisor`, `role`, `Elearn_quiz_result`) VALUES
('admin', 'Eugene', 10.1, 'Director', 'IT Team', 'CEO', 'Superuser', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `workflow`
--

CREATE TABLE IF NOT EXISTS `workflow` (
  `WFID` varchar(40) NOT NULL,
  `WFName` varchar(40) NOT NULL,
  `probation_period` float NOT NULL,
  `bond_criteria` text NOT NULL,
  PRIMARY KEY (`WFID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `workflow_approvers`
--

CREATE TABLE IF NOT EXISTS `workflow_approvers` (
  `WFID` varchar(40) NOT NULL,
  `WFName` varchar(40) NOT NULL,
  `users` int(11) NOT NULL,
  `roles` int(11) NOT NULL,
  PRIMARY KEY (`WFID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `workflow_sub`
--

CREATE TABLE IF NOT EXISTS `workflow_sub` (
  `WFID` varchar(40) NOT NULL,
  `WFName` varchar(40) NOT NULL,
  `amount_min` double NOT NULL,
  `amount_max` double NOT NULL,
  PRIMARY KEY (`WFID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`);

--
-- Constraints for table `audit`
--
ALTER TABLE `audit`
  ADD CONSTRAINT `audit_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`UserID`);

--
-- Constraints for table `lesson`
--
ALTER TABLE `lesson`
  ADD CONSTRAINT `lesson_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`);

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`);

--
-- Constraints for table `quiz`
--
ALTER TABLE `quiz`
  ADD CONSTRAINT `quiz_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`);

--
-- Constraints for table `quiz_content`
--
ALTER TABLE `quiz_content`
  ADD CONSTRAINT `quiz_content_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`);

--
-- Constraints for table `workflow_approvers`
--
ALTER TABLE `workflow_approvers`
  ADD CONSTRAINT `workflow_approvers_ibfk_1` FOREIGN KEY (`WFID`) REFERENCES `workflow` (`WFID`);

--
-- Constraints for table `workflow_sub`
--
ALTER TABLE `workflow_sub`
  ADD CONSTRAINT `workflow_sub_ibfk_1` FOREIGN KEY (`WFID`) REFERENCES `workflow` (`WFID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
