-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2024 at 06:08 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uoj`
--

-- --------------------------------------------------------

--
-- Table structure for table `uoj_class`
--

CREATE TABLE `uoj_class` (
  `class_id` int(11) NOT NULL,
  `lecr_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `class_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uoj_class`
--

INSERT INTO `uoj_class` (`class_id`, `lecr_id`, `course_id`, `class_date`, `start_time`, `end_time`) VALUES
(6, 1, 2, '0000-00-00', '00:00:00', '02:17:00'),
(9, 3, 2, '2024-10-18', '01:24:00', '02:23:00'),
(16, 2, 1, '2024-10-26', '18:54:00', '19:54:00'),
(17, 2, 1, '2024-10-28', '18:45:00', '19:45:00'),
(18, 2, 1, '2024-10-28', '20:02:00', '21:02:00'),
(19, 2, 1, '2024-10-28', '00:00:00', '23:47:00'),
(20, 1, 2, '2024-10-28', '22:57:00', '23:57:00'),
(21, 1, 1, '2024-10-29', '01:09:00', '02:09:00'),
(22, 1, 1, '2024-10-29', '19:29:00', '19:33:00'),
(23, 1, 2, '2024-10-29', '19:35:00', '19:40:00'),
(24, 2, 1, '2024-10-29', '00:00:00', '19:42:00'),
(25, 1, 2, '2024-10-29', '19:56:00', '20:00:00'),
(26, 2, 1, '2024-10-22', '19:57:00', '20:00:00'),
(27, 2, 1, '2024-10-29', '19:58:00', '20:02:00'),
(28, 1, 3, '2024-10-29', '20:01:00', '20:03:00'),
(29, 1, 3, '2024-10-30', '00:05:00', '00:08:00'),
(30, 1, 2, '2024-10-30', '01:09:00', '01:12:00'),
(31, 2, 1, '2024-10-30', '02:05:00', '02:07:00'),
(32, 2, 1, '2024-10-30', '19:13:00', '19:16:00'),
(33, 2, 1, '2024-10-30', '19:16:00', '19:20:00'),
(34, 2, 1, '2024-10-30', '19:48:00', '19:52:00'),
(35, 2, 1, '2024-10-30', '20:25:00', '20:29:00'),
(36, 2, 1, '2024-10-30', '20:44:00', '20:47:00'),
(37, 2, 1, '2024-10-30', '21:38:00', '21:40:00'),
(38, 1, 3, '2024-10-30', '22:39:00', '22:42:00'),
(39, 1, 2, '2024-10-30', '22:44:00', '23:00:00'),
(40, 2, 1, '2024-10-30', '23:01:00', '23:07:00'),
(41, 2, 1, '2024-10-30', '23:43:00', '23:46:00'),
(42, 1, 2, '2024-10-31', '00:01:00', '00:30:00'),
(43, 1, 2, '2024-10-31', '00:58:00', '00:03:00'),
(44, 1, 2, '2024-10-31', '01:07:00', '01:10:00'),
(45, 1, 2, '2024-10-31', '01:53:00', '01:56:00'),
(46, 1, 3, '2024-10-31', '01:58:00', '02:20:00'),
(47, 1, 3, '2024-10-31', '02:33:00', '02:36:00'),
(48, 2, 1, '2024-10-31', '02:36:00', '02:40:00'),
(50, 1, 1, '2024-10-31', '02:42:00', '02:45:00'),
(51, 2, 1, '2024-10-31', '03:02:00', '03:06:00'),
(52, 4, 2, '2024-10-31', '10:47:00', '10:53:00'),
(53, 2, 1, '2024-10-31', '10:50:00', '10:53:00'),
(55, 1, 2, '2024-10-31', '11:02:00', '11:06:00'),
(56, 2, 1, '2024-10-31', '11:05:00', '11:10:00'),
(57, 4, 2, '2024-10-31', '11:09:00', '11:14:00'),
(58, 1, 2, '2024-11-02', '18:19:00', '18:22:00'),
(59, 2, 1, '2024-11-02', '18:28:00', '18:33:00'),
(60, 1, 3, '2024-11-02', '20:33:00', '20:35:00'),
(64, 2, 1, '2024-11-04', '09:00:00', '10:00:00'),
(65, 1, 1, '2024-11-04', '09:53:00', '09:57:00');

-- --------------------------------------------------------

--
-- Table structure for table `uoj_class_instrucctor`
--

CREATE TABLE `uoj_class_instrucctor` (
  `lecr_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uoj_course`
--

CREATE TABLE `uoj_course` (
  `course_id` int(11) NOT NULL,
  `course_code` varchar(10) DEFAULT NULL,
  `course_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uoj_course`
--

INSERT INTO `uoj_course` (`course_id`, `course_code`, `course_name`) VALUES
(1, 'CSC234S3', 'Programming'),
(2, 'CSC204S3', 'Maths'),
(3, 'CSC234S4', 'Crypto');

-- --------------------------------------------------------

--
-- Table structure for table `uoj_lecturer`
--

CREATE TABLE `uoj_lecturer` (
  `lecr_id` int(11) NOT NULL,
  `lecr_nic` varchar(12) NOT NULL,
  `lecr_name` varchar(255) NOT NULL,
  `lecr_mobile` char(10) NOT NULL,
  `lecr_email` varchar(30) DEFAULT NULL,
  `lecr_gender` tinyint(1) DEFAULT NULL,
  `lecr_address` varchar(50) DEFAULT NULL,
  `lecr_profile_pic` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uoj_lecturer`
--

INSERT INTO `uoj_lecturer` (`lecr_id`, `lecr_nic`, `lecr_name`, `lecr_mobile`, `lecr_email`, `lecr_gender`, `lecr_address`, `lecr_profile_pic`, `user_id`) VALUES
(1, '200008706785', 'siriwardana', '1234534256', 'sirrr@gmail.com', 0, 'colombo', '/MyAttendanceSys/res/profiles/lecturer/200008706785_photo.jpg', 1),
(2, '123456789901', 'jhondshhcsd', '1234567890', 'Jhon@gmail.com', 0, 'Kurunegala', NULL, 2),
(3, '123456781234', 'mynameinstruct', '0675867456', 'gg@gmail.com', 0, 'fghsddfsadfadfdf', NULL, 4),
(4, '123456789123', 'fchvjbknbknkjn', '1234567891', 'adsjdcbjhdbj@gmail.com', 1, 'hewbfjchbejfcbkejwb', NULL, 5);

-- --------------------------------------------------------

--
-- Table structure for table `uoj_lecturer_course`
--

CREATE TABLE `uoj_lecturer_course` (
  `lecr_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uoj_lecturer_course`
--

INSERT INTO `uoj_lecturer_course` (`lecr_id`, `course_id`) VALUES
(2, 1),
(4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `uoj_nfc_data`
--

CREATE TABLE `uoj_nfc_data` (
  `nfc_id` int(11) NOT NULL,
  `nfc_hash` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uoj_student`
--

CREATE TABLE `uoj_student` (
  `std_id` int(11) NOT NULL,
  `std_index` char(7) NOT NULL,
  `std_fullname` varchar(100) DEFAULT NULL,
  `std_gender` tinyint(1) DEFAULT NULL,
  `std_batchno` varchar(10) DEFAULT NULL,
  `std_nic` varchar(12) NOT NULL,
  `std_dob` date DEFAULT NULL,
  `date_admission` date DEFAULT NULL,
  `current_address` varchar(50) DEFAULT NULL,
  `permanent_address` varchar(50) DEFAULT NULL,
  `mobile_tp_no` char(10) NOT NULL,
  `home_tp_no` char(10) DEFAULT NULL,
  `std_email` varchar(50) NOT NULL,
  `std_profile_pic` varchar(255) DEFAULT NULL,
  `current_level` char(2) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `fingerprint_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uoj_student`
--

INSERT INTO `uoj_student` (`std_id`, `std_index`, `std_fullname`, `std_gender`, `std_batchno`, `std_nic`, `std_dob`, `date_admission`, `current_address`, `permanent_address`, `mobile_tp_no`, `home_tp_no`, `std_email`, `std_profile_pic`, `current_level`, `user_id`, `fingerprint_id`) VALUES
(1, 's 45657', 'dileeesha malshan', 0, '47', '234567890145', NULL, NULL, 'djfgkdsfjs', 'dfjjgnkjdfns', '2345678987', '2345678975', 'hdfs@gmail.com', NULL, '2', 3, 1),
(2, 's 22483', 'dilan madusanka', 0, '47', '123456789145', NULL, NULL, 'Alawwa', 'jaffna', '0456785498', '0987656478', 'mmm@gmail.com', NULL, '2', 6, 2),
(7, 's 11548', 'bitchhh', 0, '46', '456784354675', NULL, NULL, 'jaffna thirunelweli', 'colombo', '1234567890', '3456234523', 'vhbfodiv@gmail.com', NULL, '2', 11, 3),
(8, 's 34561', 'tharindu sathsara', 0, '47', '444444444444', '2001-11-29', '2020-06-25', 'jaffna kkss', 'kegalla', '3333333333', '2222222222', 'th@gmail.com', NULL, '2', 12, 4);

-- --------------------------------------------------------

--
-- Table structure for table `uoj_student_class`
--

CREATE TABLE `uoj_student_class` (
  `std_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `attend_time` time DEFAULT NULL,
  `attendance_status` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uoj_student_class`
--

INSERT INTO `uoj_student_class` (`std_id`, `class_id`, `attend_time`, `attendance_status`) VALUES
(1, 16, '19:00:19', 1),
(1, 17, '00:00:00', 0),
(1, 19, '22:49:13', 2),
(1, 20, '22:58:04', 1),
(1, 24, '19:41:29', 2),
(1, 25, '19:57:00', 1),
(1, 27, '19:59:37', 1),
(1, 28, '00:00:00', 0),
(1, 47, '00:00:00', 0),
(1, 48, '00:00:00', 0),
(1, 51, '00:00:00', 0),
(1, 52, '00:00:00', 0),
(1, 53, '00:00:00', 0),
(1, 55, '00:00:00', 0),
(1, 56, '00:00:00', 0),
(1, 58, '00:00:00', 0),
(1, 59, '00:00:00', 0),
(1, 65, '00:00:00', 0),
(2, 16, '19:00:24', 1),
(2, 17, '00:00:00', 0),
(2, 19, '22:49:15', 2),
(2, 24, '19:41:31', 2),
(2, 29, '00:00:00', 0),
(2, 30, '01:10:16', 1),
(2, 32, '00:00:00', 0),
(2, 36, '00:00:00', 0),
(2, 37, '00:00:00', 0),
(2, 40, '00:00:00', 0),
(2, 41, '00:00:00', 0),
(2, 43, '00:00:00', 0),
(2, 46, '00:00:00', 0),
(2, 47, '02:33:55', 1),
(2, 48, '02:37:08', 1),
(2, 51, '00:00:00', 0),
(2, 52, '00:00:00', 0),
(2, 53, '00:00:00', 0),
(2, 55, '00:00:00', 0),
(2, 56, '00:00:00', 0),
(2, 58, '00:00:00', 0),
(2, 59, '00:00:00', 0),
(2, 60, '00:00:00', 0),
(2, 65, '00:00:00', 0),
(7, 25, '19:57:02', 1),
(7, 27, '00:00:00', 0),
(7, 28, '20:02:40', 1),
(7, 30, '01:10:45', 1),
(7, 31, '02:06:10', 1),
(7, 32, '00:00:00', 0),
(7, 33, '19:16:51', 1),
(7, 34, '19:50:23', 1),
(7, 35, '00:00:00', 0),
(7, 46, '00:00:00', 0),
(7, 47, '00:00:00', 0),
(7, 48, '00:00:00', 0),
(7, 51, '03:03:53', 1),
(7, 52, '10:48:32', 1),
(7, 53, '10:51:16', 1),
(7, 55, '00:00:00', 0),
(7, 56, '00:00:00', 0),
(7, 58, '00:00:00', 0),
(7, 59, '00:00:00', 0),
(7, 60, '00:00:00', 0),
(7, 64, '00:00:00', 0),
(7, 65, '00:00:00', 0),
(8, 55, '11:04:30', 1),
(8, 56, '11:07:33', 1),
(8, 58, '18:21:05', 1),
(8, 59, '18:29:53', 1),
(8, 60, '20:34:15', 1),
(8, 64, '00:00:00', 0),
(8, 65, '09:54:31', 1);

-- --------------------------------------------------------

--
-- Table structure for table `uoj_student_course`
--

CREATE TABLE `uoj_student_course` (
  `std_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uoj_student_course`
--

INSERT INTO `uoj_student_course` (`std_id`, `course_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(7, 2),
(8, 1),
(8, 2),
(8, 3);

-- --------------------------------------------------------

--
-- Table structure for table `uoj_user`
--

CREATE TABLE `uoj_user` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `user_password` char(60) NOT NULL,
  `user_salt` char(32) NOT NULL,
  `user_status` tinyint(1) NOT NULL DEFAULT 2,
  `user_role` tinyint(1) NOT NULL,
  `user_session` tinyint(1) DEFAULT 0,
  `fingerprint_template` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uoj_user`
--

INSERT INTO `uoj_user` (`user_id`, `username`, `user_password`, `user_salt`, `user_status`, `user_role`, `user_session`, `fingerprint_template`) VALUES
(1, 'admin123', '$2y$10$STwe92fSGRzxnzvAvHhVfu0smQ4rzSRP/0YlOIBDi5ctCdXztMWWC', '42a5526e83a75a12e3d7b61ee95c7a7a', 1, 0, 1, ''),
(2, 'lec001', '$2y$10$rWNM/kdbt.HgkZfFLYWy6es3GQwIxrAP2b5hSze0Zp0i58VBHguCW', '354b27cd6bfc86f04faebbb16d2193d3', 1, 1, 1, ''),
(3, '2020csc056', '$2y$10$bhfWho37QjpkUYmLzPh9fOYJifg8h2wdVt7KwoJXUTDtnes9TT7/K', 'd1daa5555e0f02469638762c702f9e31', 1, 3, 0, ''),
(4, 'instruct1', '$2y$10$X3Du0iyJDHbFo5cSu5BSKusCgOdGH0VufDh0drDgFyjWMciQ.R.Pu', '00cf48f1221c9462d210336cca0297eb', 1, 2, 1, ''),
(5, 'lec002', '$2y$10$8NlFtgRXaGxG8/uyWbZ92O688yYjFeAXBNOJ9BoQWoIDKsG5gY49W', 'd6255b593b24eb2a1f2930ba9f4cd793', 1, 1, 0, ''),
(6, '2021csc046', '$2y$10$HZl7jHk6PhzMziZqYv19leDZ6NhooAn6AvfjLry2VVku1WQTNGIRO', '9488316ea1a1e158b28c5bd9f21a6fb0', 1, 3, 0, ''),
(7, '2021csc048', '$2y$10$578ypwOl9uPnB9TDI5/a8.Ik4KPcCCHpAPjz8IoxM5JlbHbtMYa8W', 'f4dd6d519e3ed8783de58bb03d607e4d', 2, 3, 0, ''),
(8, '2021csc022', '$2y$10$GNfBffRoXbIFTmhnq25qquGGvsWV9ZxRuyi9ZkHGmeuTMA0JsX7pW', '3ef209be98414fc4dc8ad219c9c29fb0', 2, 3, 0, ''),
(9, '2020csc001', '$2y$10$/YZWJUjEIInNO3EBkEKTvechsifWwcbYA6SyT5mdWlIXi0iQir.kO', 'd2515cf1b5d1f2cf59b399238bc85241', 2, 3, 0, ''),
(10, '2020csc002', '$2y$10$.ZBItBS/FWM9zI/Fre.J/umNKuD.AZLZOa0t/4L21Xvem51qqAABO', '89ee6a7fd53a9af936c0efb5ec205fb7', 2, 3, 0, ''),
(11, '2020csc067', '$2y$10$XiHE3f9Vyu9doTaHNg/F0uUmAefuBz5AfALlnBRJxytlfp.LCixt.', '712e864a88f964e0ff0ff30617181710', 1, 3, 0, ''),
(12, '2020csc080', '$2y$10$h/TOajufsiIkbdsYf6VEPu265kwCH/DGGndnG3d9azF7ZkXrhC14a', 'a4e7189841ec61829debf13bb363b9e9', 1, 3, 0, '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `uoj_class`
--
ALTER TABLE `uoj_class`
  ADD PRIMARY KEY (`class_id`,`lecr_id`,`course_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `lecr_id` (`lecr_id`);

--
-- Indexes for table `uoj_class_instrucctor`
--
ALTER TABLE `uoj_class_instrucctor`
  ADD PRIMARY KEY (`lecr_id`,`class_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `uoj_course`
--
ALTER TABLE `uoj_course`
  ADD PRIMARY KEY (`course_id`),
  ADD UNIQUE KEY `course_code` (`course_code`);

--
-- Indexes for table `uoj_lecturer`
--
ALTER TABLE `uoj_lecturer`
  ADD PRIMARY KEY (`lecr_id`,`user_id`),
  ADD UNIQUE KEY `lecr_nic` (`lecr_nic`),
  ADD UNIQUE KEY `lecr_mobile` (`lecr_mobile`),
  ADD UNIQUE KEY `lecr_email` (`lecr_email`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `uoj_lecturer_course`
--
ALTER TABLE `uoj_lecturer_course`
  ADD PRIMARY KEY (`lecr_id`,`course_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `uoj_nfc_data`
--
ALTER TABLE `uoj_nfc_data`
  ADD PRIMARY KEY (`nfc_id`,`user_id`),
  ADD UNIQUE KEY `nfc_hash` (`nfc_hash`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `uoj_student`
--
ALTER TABLE `uoj_student`
  ADD PRIMARY KEY (`std_id`,`user_id`),
  ADD UNIQUE KEY `std_index` (`std_index`),
  ADD UNIQUE KEY `mobile_tp_no` (`mobile_tp_no`),
  ADD UNIQUE KEY `std_email` (`std_email`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `uoj_student_class`
--
ALTER TABLE `uoj_student_class`
  ADD PRIMARY KEY (`std_id`,`class_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `uoj_student_course`
--
ALTER TABLE `uoj_student_course`
  ADD PRIMARY KEY (`std_id`,`course_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `uoj_user`
--
ALTER TABLE `uoj_user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `user_salt` (`user_salt`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `uoj_class`
--
ALTER TABLE `uoj_class`
  MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `uoj_course`
--
ALTER TABLE `uoj_course`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `uoj_lecturer`
--
ALTER TABLE `uoj_lecturer`
  MODIFY `lecr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `uoj_nfc_data`
--
ALTER TABLE `uoj_nfc_data`
  MODIFY `nfc_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uoj_student`
--
ALTER TABLE `uoj_student`
  MODIFY `std_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `uoj_user`
--
ALTER TABLE `uoj_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `uoj_class`
--
ALTER TABLE `uoj_class`
  ADD CONSTRAINT `uoj_class_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `uoj_course` (`course_id`),
  ADD CONSTRAINT `uoj_class_ibfk_2` FOREIGN KEY (`lecr_id`) REFERENCES `uoj_lecturer` (`lecr_id`);

--
-- Constraints for table `uoj_class_instrucctor`
--
ALTER TABLE `uoj_class_instrucctor`
  ADD CONSTRAINT `uoj_class_instrucctor_ibfk_1` FOREIGN KEY (`lecr_id`) REFERENCES `uoj_lecturer` (`lecr_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `uoj_class_instrucctor_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `uoj_class` (`class_id`) ON DELETE CASCADE;

--
-- Constraints for table `uoj_lecturer`
--
ALTER TABLE `uoj_lecturer`
  ADD CONSTRAINT `uoj_lecturer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `uoj_user` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `uoj_lecturer_course`
--
ALTER TABLE `uoj_lecturer_course`
  ADD CONSTRAINT `uoj_lecturer_course_ibfk_1` FOREIGN KEY (`lecr_id`) REFERENCES `uoj_lecturer` (`lecr_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `uoj_lecturer_course_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `uoj_course` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `uoj_nfc_data`
--
ALTER TABLE `uoj_nfc_data`
  ADD CONSTRAINT `uoj_nfc_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `uoj_user` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `uoj_student`
--
ALTER TABLE `uoj_student`
  ADD CONSTRAINT `uoj_student_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `uoj_user` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `uoj_student_class`
--
ALTER TABLE `uoj_student_class`
  ADD CONSTRAINT `uoj_student_class_ibfk_1` FOREIGN KEY (`std_id`) REFERENCES `uoj_student` (`std_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `uoj_student_class_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `uoj_class` (`class_id`) ON DELETE CASCADE;

--
-- Constraints for table `uoj_student_course`
--
ALTER TABLE `uoj_student_course`
  ADD CONSTRAINT `uoj_student_course_ibfk_1` FOREIGN KEY (`std_id`) REFERENCES `uoj_student` (`std_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `uoj_student_course_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `uoj_course` (`course_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
