-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Mar 02, 2025 at 07:55 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `elearning`
--
CREATE DATABASE IF NOT EXISTS `elearning` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `elearning`;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `full_name`, `email`, `username`, `password`) VALUES
(56125, 'System Admin', 'mail@rupom.dev', 'rupom', '$2y$10$RAD4iikVW8QyzC.cX3jy2uPJUKMstv221zYl7B1.D7cgMEubII5Om');

-- --------------------------------------------------------

--
-- Table structure for table `certificate`
--

CREATE TABLE `certificate` (
  `certificate_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `issue_date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chapter`
--

CREATE TABLE `chapter` (
  `chapter_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `title` varchar(1023) NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `content`
--

CREATE TABLE `content` (
  `content_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `data` text NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `course_id` int(11) NOT NULL,
  `title` varchar(1023) NOT NULL,
  `description` varchar(1023) NOT NULL,
  `instructor_id` int(11) NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp(),
  `status` enum('Public','Private') NOT NULL DEFAULT 'Public',
  `cover` varchar(255) NOT NULL DEFAULT 'default_course.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coursesmaterial`
--

CREATE TABLE `coursesmaterial` (
  `material_id` int(11) NOT NULL,
  `URL` varchar(1023) NOT NULL,
  `type` varchar(127) NOT NULL,
  `instructor_id` int(11) NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `enrolled_student`
--

CREATE TABLE `enrolled_student` (
  `enrolled_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `enrolled_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `instructor`
--

CREATE TABLE `instructor` (
  `instructor_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(1023) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `date_of_birth` date NOT NULL,
  `date_of_joined` date NOT NULL,
  `status` enum('Active','Not Active') NOT NULL DEFAULT 'Active',
  `profile_img` varchar(255) NOT NULL DEFAULT 'default.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instructor`
--

INSERT INTO `instructor` (`instructor_id`, `username`, `password`, `first_name`, `last_name`, `email`, `date_of_birth`, `date_of_joined`, `status`, `profile_img`) VALUES
(1, 'rupom', '$2y$10$RAD4iikVW8QyzC.cX3jy2uPJUKMstv221zYl7B1.D7cgMEubII5Om', 'Rupom', 'Chowdhury', 'mail@rupom.dev', '2000-01-07', '2024-01-15', 'Active', 'rupom67c4916aaa7645.40970066.png'),
(4, 'nusrat', '$2y$10$I7Qekj8Q6AXR90Z.ppaqkuH9IGseb.jTO.jctb1rd9KHv2pG5kSE2', 'Nusrat', 'Jahan', 'nusrat@vu.edu.bd', '2002-01-02', '0000-00-00', 'Active', 'default.jpg'),
(5, 'tester', '$2y$10$RAD4iikVW8QyzC.cX3jy2uPJUKMstv221zYl7B1.D7cgMEubII5Om', 'Test', 'Instructor', 'test@rupom.dev', '2025-03-02', '0000-00-00', 'Active', 'default.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(1023) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `date_of_birth` date NOT NULL,
  `date_of_joined` date NOT NULL DEFAULT current_timestamp(),
  `status` enum('Active','Not Active') NOT NULL DEFAULT 'Active',
  `profile_img` varchar(255) NOT NULL DEFAULT 'default.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `username`, `password`, `first_name`, `last_name`, `email`, `date_of_birth`, `date_of_joined`, `status`, `profile_img`) VALUES
(1, 'rupom', '$2y$10$RAD4iikVW8QyzC.cX3jy2uPJUKMstv221zYl7B1.D7cgMEubII5Om', 'Rupom', 'Chowdhury', 'mail@rupom.dev', '2000-01-07', '2024-01-14', 'Active', 'rupom67c492e1c31426.45318053.png');

-- --------------------------------------------------------

--
-- Table structure for table `student_progress`
--

CREATE TABLE `student_progress` (
  `progress_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `progress` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `topic`
--

CREATE TABLE `topic` (
  `topic_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `title` varchar(1023) NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `certificate`
--
ALTER TABLE `certificate`
  ADD PRIMARY KEY (`certificate_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `chapter`
--
ALTER TABLE `chapter`
  ADD PRIMARY KEY (`chapter_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `content`
--
ALTER TABLE `content`
  ADD PRIMARY KEY (`content_id`),
  ADD KEY `topic_id` (`topic_id`),
  ADD KEY `chapter_id` (`chapter_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `instructor_id` (`instructor_id`);

--
-- Indexes for table `coursesmaterial`
--
ALTER TABLE `coursesmaterial`
  ADD PRIMARY KEY (`material_id`),
  ADD KEY `instructor_id` (`instructor_id`);

--
-- Indexes for table `enrolled_student`
--
ALTER TABLE `enrolled_student`
  ADD PRIMARY KEY (`enrolled_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `instructor`
--
ALTER TABLE `instructor`
  ADD PRIMARY KEY (`instructor_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_progress`
--
ALTER TABLE `student_progress`
  ADD PRIMARY KEY (`progress_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `topic`
--
ALTER TABLE `topic`
  ADD PRIMARY KEY (`topic_id`),
  ADD KEY `chapter_id` (`chapter_id`),
  ADD KEY `course_id` (`course_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `certificate`
--
ALTER TABLE `certificate`
  MODIFY `certificate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `chapter`
--
ALTER TABLE `chapter`
  MODIFY `chapter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `content`
--
ALTER TABLE `content`
  MODIFY `content_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `coursesmaterial`
--
ALTER TABLE `coursesmaterial`
  MODIFY `material_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `enrolled_student`
--
ALTER TABLE `enrolled_student`
  MODIFY `enrolled_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `instructor`
--
ALTER TABLE `instructor`
  MODIFY `instructor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `student_progress`
--
ALTER TABLE `student_progress`
  MODIFY `progress_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `topic`
--
ALTER TABLE `topic`
  MODIFY `topic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `certificate`
--
ALTER TABLE `certificate`
  ADD CONSTRAINT `certificate_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  ADD CONSTRAINT `certificate_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`);

--
-- Constraints for table `chapter`
--
ALTER TABLE `chapter`
  ADD CONSTRAINT `chapter_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);

--
-- Constraints for table `content`
--
ALTER TABLE `content`
  ADD CONSTRAINT `content_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`topic_id`),
  ADD CONSTRAINT `content_ibfk_2` FOREIGN KEY (`chapter_id`) REFERENCES `chapter` (`chapter_id`),
  ADD CONSTRAINT `content_ibfk_3` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`);

--
-- Constraints for table `coursesmaterial`
--
ALTER TABLE `coursesmaterial`
  ADD CONSTRAINT `coursesmaterial_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`);

--
-- Constraints for table `enrolled_student`
--
ALTER TABLE `enrolled_student`
  ADD CONSTRAINT `enrolled_student_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  ADD CONSTRAINT `enrolled_student_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`);

--
-- Constraints for table `student_progress`
--
ALTER TABLE `student_progress`
  ADD CONSTRAINT `student_progress_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  ADD CONSTRAINT `student_progress_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`);

--
-- Constraints for table `topic`
--
ALTER TABLE `topic`
  ADD CONSTRAINT `topic_ibfk_1` FOREIGN KEY (`chapter_id`) REFERENCES `chapter` (`chapter_id`),
  ADD CONSTRAINT `topic_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
