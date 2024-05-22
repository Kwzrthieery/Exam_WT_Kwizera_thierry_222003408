-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 10, 2024 at 01:59 PM
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
-- Database: `olcs`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `lawyer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `duration` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `client_id` int(120) NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `sex` enum('male','female') NOT NULL,
  `email` varchar(200) NOT NULL,
  `phone_number` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `clients`
--
DELIMITER $$
CREATE TRIGGER `after_update_client_info` AFTER UPDATE ON `clients` FOR EACH ROW BEGIN
    IF OLD.full_name <> NEW.full_name THEN
        INSERT INTO updates_on_client_info (client_id, attribute_changed, old_value, new_value)
        VALUES (NEW.client_id, 'full_name', OLD.full_name, NEW.full_name);
    END IF;
    
    IF OLD.sex <> NEW.sex THEN
        INSERT INTO updates_on_client_info (client_id, attribute_changed, old_value, new_value)
        VALUES (NEW.client_id, 'sex', OLD.sex, NEW.sex);
    END IF;
    
    IF OLD.email <> NEW.email THEN
        INSERT INTO updates_on_client_info (client_id, attribute_changed, old_value, new_value)
        VALUES (NEW.client_id, 'email', OLD.email, NEW.email);
    END IF;
    
    IF OLD.phone_number <> NEW.phone_number THEN
        INSERT INTO updates_on_client_info (client_id, attribute_changed, old_value, new_value)
        VALUES (NEW.client_id, 'phone_number', OLD.phone_number, NEW.phone_number);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `consultation`
--

CREATE TABLE `consultation` (
  `consultation_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `lawyer_id` int(11) NOT NULL,
  `consultation` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE `document` (
  `document_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `document_name` varchar(80) NOT NULL,
  `description` varchar(120) NOT NULL,
  `location` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lawyers`
--

CREATE TABLE `lawyers` (
  `lawyer_id` int(11) NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `sex` enum('male','female') NOT NULL,
  `email` varchar(200) NOT NULL,
  `phone_number` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `lawyer_id` int(11) NOT NULL,
  `message` varchar(400) NOT NULL,
  `date_sent` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `report_id` int(11) NOT NULL,
  `lawyer_id` int(11) NOT NULL,
  `consultation_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `notes` varchar(250) NOT NULL,
  `status` enum('Done','forwarded') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `lawyer_id` int(11) NOT NULL,
  `review` varchar(120) NOT NULL,
  `rating` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `updates_on_client_info`
--

CREATE TABLE `updates_on_client_info` (
  `update_id` int(11) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `attribute_changed` varchar(50) DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` varchar(255) DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` int(40) NOT NULL,
  `password` int(18) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `lawyer_id` (`lawyer_id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `consultation`
--
ALTER TABLE `consultation`
  ADD PRIMARY KEY (`consultation_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `lawyer_id` (`lawyer_id`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `lawyers`
--
ALTER TABLE `lawyers`
  ADD PRIMARY KEY (`lawyer_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `lawyer_id` (`lawyer_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `lawyer_id` (`lawyer_id`),
  ADD KEY `consultation_id` (`consultation_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `lawyer_id` (`lawyer_id`);

--
-- Indexes for table `updates_on_client_info`
--
ALTER TABLE `updates_on_client_info`
  ADD PRIMARY KEY (`update_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `client_id` int(120) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `consultation`
--
ALTER TABLE `consultation`
  MODIFY `consultation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lawyers`
--
ALTER TABLE `lawyers`
  MODIFY `lawyer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `updates_on_client_info`
--
ALTER TABLE `updates_on_client_info`
  MODIFY `update_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`lawyer_id`) REFERENCES `lawyers` (`lawyer_id`);

--
-- Constraints for table `consultation`
--
ALTER TABLE `consultation`
  ADD CONSTRAINT `consultation_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  ADD CONSTRAINT `consultation_ibfk_2` FOREIGN KEY (`lawyer_id`) REFERENCES `lawyers` (`lawyer_id`);

--
-- Constraints for table `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `document_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`lawyer_id`) REFERENCES `lawyers` (`lawyer_id`);

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  ADD CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`lawyer_id`) REFERENCES `lawyers` (`lawyer_id`),
  ADD CONSTRAINT `reports_ibfk_3` FOREIGN KEY (`consultation_id`) REFERENCES `consultation` (`consultation_id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`lawyer_id`) REFERENCES `lawyers` (`lawyer_id`);

--
-- Constraints for table `updates_on_client_info`
--
ALTER TABLE `updates_on_client_info`
  ADD CONSTRAINT `updates_on_client_info_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
