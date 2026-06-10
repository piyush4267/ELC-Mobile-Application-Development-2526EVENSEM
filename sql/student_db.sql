-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 10, 2026 at 10:28 PM
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
-- Database: `student_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `roll_number` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `cgpa` decimal(4,2) NOT NULL CHECK (`cgpa` >= 0 and `cgpa` <= 10),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `name`, `roll_number`, `email`, `cgpa`, `created_at`) VALUES
(5, 'Piyush', '118', 'piyush@gmail.com', 9.00, '2026-06-10 16:32:20'),
(6, 'Akshat', '403', 'akshat@gmail.com', 10.00, '2026-06-10 19:01:50'),
(7, 'Samarveer', '402', 'samar@gmail.com', 9.30, '2026-06-10 19:06:25'),
(38, 'Arpit', '112', 'w1w1@gmail.com', 9.00, '2026-06-10 19:43:51'),
(48, 'Testing', '123456', '123@gmail.com', 9.50, '2026-06-10 20:24:56'),
(49, 'Divyanshu', '400', 'divyanshu@gmail.com', 9.20, '2026-06-10 20:25:30'),
(50, 'Aditya', '1021', 'aditya@gmail.com', 8.90, '2026-06-10 20:26:10'),
(51, 'Piyush Anand', '1025170118', 'testing_email@gmail.com', 8.18, '2026-06-10 20:27:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roll_number` (`roll_number`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
