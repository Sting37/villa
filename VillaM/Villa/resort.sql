-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Apr 23, 2024 at 10:14 AM
-- Server version: 5.7.34
-- PHP Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `resort`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int(11) UNSIGNED NOT NULL,
  `cid` int(11) UNSIGNED NOT NULL,
  `status` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT 'pending',
  `notes` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `cid`, `status`, `notes`) VALUES
(12, 10, 'CONFIRMED', NULL),
(13, 10, 'confirmed', NULL),
(14, 10, 'CANCELLED', NULL),
(15, 13, 'CANCELLED', NULL),
(16, 13, 'CONFIRMED', NULL),
(17, 13, 'CANCELLED', NULL),
(18, 13, 'PENDING', NULL),
(19, 13, 'PENDING', NULL),
(20, 13, 'PENDING', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cid` int(11) UNSIGNED NOT NULL,
  `fullname` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `isadmin` int(1) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cid`, `fullname`, `email`, `password`, `phone`, `isadmin`) VALUES
(10, 'admin@gmail.com', 'admin@gmail.com', '$2y$10$nfud5jYwEnMmqv8YgUF3p.wh3EVGAONlRUUiu2TqFiNW.GsU6QKGm', '', 1),
(11, 'admin@admin.com', 'admin@admin.com', '$2y$10$4FJtbVGCIpFnNxcDvSSXUueMESuDDoZvtygT/O4J9UHB1vfdO3Vza', '', 1),
(13, 'test', 'test@gmail.com', '$2y$10$NvBB7Yiejyp1ZoMn3KpQ6.E35OWVLspbvpUjfe/h.51gbajAJzub2', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `id` int(11) UNSIGNED NOT NULL,
  `start` varchar(30) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `end` varchar(30) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `requirement` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT 'no preference',
  `adults` int(2) NOT NULL,
  `children` int(2) DEFAULT '0',
  `requests` varchar(500) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hash` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;


--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `booking_id_uindex` (`id`),
  ADD KEY `booking_customer__fk` (`cid`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cid`),
  ADD UNIQUE KEY `id_UNIQUE` (`cid`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `cid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_customer__fk` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`) ON DELETE CASCADE;

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_booking__fk` FOREIGN KEY (`id`) REFERENCES `booking` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
