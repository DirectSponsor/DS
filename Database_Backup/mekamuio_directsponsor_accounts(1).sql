-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 10, 2015 at 05:42 PM
-- Server version: 5.5.23
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mekamuio_directsponsor_accounts`
--

-- --------------------------------------------------------

--
-- Table structure for table `coordinators`
--

DROP TABLE IF EXISTS `coordinators`;
CREATE TABLE IF NOT EXISTS `coordinators` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `project_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `coordinators_user_id_index` (`user_id`),
  KEY `coordinators_project_id_index` (`project_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `coordinators`
--

INSERT INTO `coordinators` (`id`, `user_id`, `project_id`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '2014-01-10 05:08:36', '2014-01-10 05:08:36'),
(2, 12, 2, '2014-01-15 20:31:51', '2014-01-15 20:31:51'),
(3, 17, 3, '2014-01-29 01:54:19', '2014-01-29 01:54:19'),
(4, 18, 4, '2014-01-29 02:22:50', '2014-01-29 02:22:50');

-- --------------------------------------------------------

--
-- Table structure for table `invitations`
--

DROP TABLE IF EXISTS `invitations`;
CREATE TABLE IF NOT EXISTS `invitations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `sent_to` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `invitations_url_unique` (`url`),
  KEY `invitations_project_id_index` (`project_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=23 ;

--
-- Dumping data for table `invitations`
--

INSERT INTO `invitations` (`id`, `project_id`, `sent_to`, `url`, `created_at`, `updated_at`) VALUES
(2, 4, 'invitee01@mailinator.com', 'fG.UmuBuq', '2014-01-29 02:24:52', '2014-01-29 02:24:52'),
(5, 4, 'invitee01@mailinator.com', 'mHQIrHxkS', '2014-01-29 02:39:01', '2014-01-29 02:39:01'),
(6, 3, 'fredonyangokenya@gmail.com', 'neQm5eJ7u', '2014-01-29 19:52:20', '2014-01-29 19:52:20'),
(7, 3, 'fredonyangokenya@gmail.com', 'sTbtLHSMi', '2014-01-29 19:53:00', '2014-01-29 19:53:00'),
(8, 3, 'fredonyangokenya@gmail.com', 'fPDt9Yt6K', '2014-01-29 19:53:30', '2014-01-29 19:53:30'),
(9, 3, 'brecipient1@mailinator.com', 'RGrDbbdne', '2014-01-29 20:00:24', '2014-01-29 20:00:24'),
(10, 3, 'brecipient1@mailinator.com', '2j8uGRkqm', '2014-01-29 20:01:38', '2014-01-29 20:01:38'),
(11, 3, 'brecipient1@mailinator.com', '47oPLz5xm', '2014-01-29 20:02:21', '2014-01-29 20:02:21'),
(12, 1, 'crecipient1@mailinator.com', 'MW95hdCh6', '2014-01-29 20:08:54', '2014-01-29 20:08:54'),
(13, 1, 'crecipient1@mailinator.com', '90lBiURC', '2014-01-29 20:09:24', '2014-01-29 20:09:24'),
(14, 1, 'crecipient1@mailinator.com', 'nuV2TTRxK', '2014-01-29 20:11:10', '2014-01-29 20:11:10'),
(15, 1, 'tp1r03@mailinator.com', 'eFxZMJyR2', '2014-01-29 20:54:52', '2014-01-29 20:54:52'),
(16, 1, 'nospamatall@iol.ie', 'ul7MFUNDe', '2014-01-29 20:56:06', '2014-01-29 20:56:06'),
(18, 1, 'tp1r01@mailinator.com', 'JlVSpEoGC', '2014-09-23 22:17:01', '2014-09-23 22:17:01'),
(19, 1, 'tp1s04@mailinator.com', 'HwuKNbYZK', '2014-09-23 23:06:46', '2014-09-23 23:06:46'),
(21, 3, 'fredonyangokenya@gmail.com', 'SpWJWnhfy', '2014-10-27 17:34:43', '2014-10-27 17:34:43'),
(22, 3, 'brecipient2@mailinator.com', 'L3YpHOb.', '2015-02-10 16:29:19', '2015-02-10 16:29:19');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2013_09_28_152008_create_projects_table', 1),
('2013_09_28_152153_create_users_table', 1),
('2013_09_28_152603_create_coordinators_table', 1),
('2013_09_28_152848_create_recipients_table', 1),
('2013_09_28_153045_create_sponsors_table', 1),
('2013_09_28_153322_create_invitations_table', 1),
('2013_09_28_153553_create_payments_table', 1),
('2013_09_28_153730_create_settings_table', 1),
('2013_09_28_153815_create_spends_table', 1),
('2013_09_28_153900_pivot_project_sponsor_table', 1),
('2013_09_28_164140_remove_account_id_from_users_table', 1),
('2013_12_05_081147_create_password_reminders_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reminders`
--

DROP TABLE IF EXISTS `password_reminders`;
CREATE TABLE IF NOT EXISTS `password_reminders` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `password_reminders`
--

INSERT INTO `password_reminders` (`email`, `token`, `created_at`) VALUES
('sagar4ever@hotmail.com', 'ff26eb500296df6ec67fe70e28ed08e08fa13397', '2015-04-23 18:53:49');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `sender_id` int(10) unsigned NOT NULL,
  `receiver_id` int(10) unsigned NOT NULL,
  `stat` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `payments_project_id_index` (`project_id`),
  KEY `payments_sender_id_index` (`sender_id`),
  KEY `payments_receiver_id_index` (`receiver_id`),
  KEY `payments_type_index` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=151 ;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `project_id`, `sender_id`, `receiver_id`, `stat`, `type`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 3, 'accepted', 'sponsoring', '2014-01-10 05:27:39', '2014-01-11 01:14:26'),
(2, 1, 5, 3, 'accepted', 'sponsoring', '2014-01-11 01:01:01', '2014-01-11 01:14:23'),
(3, 1, 6, 3, 'accepted', 'sponsoring', '2014-01-11 01:03:17', '2014-01-11 01:14:20'),
(4, 1, 7, 3, 'accepted', 'sponsoring', '2014-01-11 01:06:45', '2014-01-11 01:14:16'),
(5, 1, 8, 3, 'accepted', 'sponsoring', '2014-01-11 01:09:47', '2014-01-11 01:14:11'),
(6, 1, 3, 2, 'accepted', 'group fund', '2014-01-11 01:13:36', '2014-01-11 01:34:33'),
(7, 1, 8, 3, 'accepted', 'sponsoring', '2014-01-11 01:13:36', '2014-01-11 01:13:36'),
(8, 1, 3, 2, 'accepted', 'group fund', '2014-01-11 01:14:11', '2014-01-11 01:34:30'),
(9, 1, 3, 2, 'accepted', 'group fund', '2014-01-11 01:14:16', '2014-01-11 01:34:27'),
(10, 1, 3, 2, 'accepted', 'group fund', '2014-01-11 01:14:20', '2014-01-11 01:34:24'),
(11, 1, 3, 2, 'accepted', 'group fund', '2014-01-11 01:14:23', '2014-01-11 01:34:21'),
(12, 1, 3, 2, 'accepted', 'group fund', '2014-01-11 01:14:26', '2014-01-11 01:34:15'),
(13, 1, 10, 9, 'accepted', 'sponsoring', '2014-01-11 02:39:42', '2014-01-25 02:33:38'),
(14, 2, 14, 13, 'accepted', 'sponsoring', '2014-01-15 20:46:06', '2014-01-15 20:50:42'),
(15, 2, 13, 12, 'accepted', 'group fund', '2014-01-15 20:50:42', '2014-01-15 20:51:39'),
(16, 1, 9, 2, 'accepted', 'group fund', '2014-01-25 02:33:22', '2014-02-02 09:16:14'),
(17, 1, 10, 9, 'accepted', 'sponsoring', '2014-01-25 02:33:22', '2014-01-25 02:33:22'),
(18, 1, 9, 2, 'accepted', 'group fund', '2014-01-25 02:33:38', '2014-02-02 09:16:07'),
(19, 1, 16, 9, 'accepted', 'sponsoring', '2014-01-25 02:45:44', '2014-02-27 02:33:25'),
(20, 2, 22, 13, 'accepted', 'sponsoring', '2014-01-31 20:34:41', '2014-09-11 00:33:29'),
(21, 1, 3, 2, 'accepted', 'group fund', '2014-02-02 05:43:03', '2014-02-02 09:15:56'),
(22, 1, 8, 3, 'accepted', 'sponsoring', '2014-02-02 05:43:03', '2014-02-02 05:43:03'),
(23, 1, 3, 2, 'accepted', 'group fund', '2014-02-02 05:43:46', '2014-02-02 09:15:47'),
(24, 1, 8, 3, 'accepted', 'sponsoring', '2014-02-02 05:43:46', '2014-02-02 05:43:46'),
(25, 1, 3, 2, 'accepted', 'group fund', '2014-02-09 04:04:36', '2014-02-11 19:41:38'),
(26, 1, 8, 3, 'accepted', 'sponsoring', '2014-02-09 04:04:36', '2014-02-09 04:04:36'),
(27, 1, 3, 2, 'accepted', 'group fund', '2014-02-09 04:04:37', '2014-02-11 19:41:36'),
(28, 1, 8, 3, 'accepted', 'sponsoring', '2014-02-09 04:04:37', '2014-02-09 04:04:37'),
(29, 1, 3, 2, 'accepted', 'group fund', '2014-02-14 21:11:55', '2014-02-14 21:17:32'),
(30, 1, 8, 3, 'accepted', 'sponsoring', '2014-02-14 21:11:55', '2014-02-14 21:11:55'),
(31, 1, 3, 2, 'accepted', 'group fund', '2014-02-14 21:15:17', '2014-02-14 21:17:25'),
(32, 1, 8, 3, 'accepted', 'sponsoring', '2014-02-14 21:15:17', '2014-02-14 21:15:17'),
(33, 1, 9, 2, 'accepted', 'group fund', '2014-02-27 02:32:21', '2014-02-27 02:34:43'),
(34, 1, 16, 9, 'accepted', 'sponsoring', '2014-02-27 02:32:21', '2014-02-27 02:32:21'),
(35, 1, 9, 2, 'accepted', 'group fund', '2014-02-27 02:33:25', '2014-02-27 02:34:36'),
(36, 2, 13, 12, 'accepted', 'group fund', '2014-09-11 00:31:06', '2014-09-11 00:56:30'),
(37, 2, 22, 13, 'accepted', 'sponsoring', '2014-09-11 00:31:07', '2014-09-11 00:31:07'),
(38, 2, 13, 12, 'accepted', 'group fund', '2014-09-11 00:33:29', '2014-09-11 00:56:23'),
(39, 1, 3, 2, 'accepted', 'group fund', '2014-09-11 00:46:38', '2014-09-20 23:02:33'),
(40, 1, 8, 3, 'accepted', 'sponsoring', '2014-09-11 00:46:38', '2014-09-11 00:46:38'),
(41, 1, 3, 2, 'accepted', 'group fund', '2014-09-11 00:48:41', '2014-09-20 23:02:38'),
(42, 1, 7, 3, 'accepted', 'sponsoring', '2014-09-11 00:48:41', '2014-09-11 00:48:41'),
(43, 2, 13, 12, 'accepted', 'group fund', '2014-09-11 00:51:18', '2014-09-11 00:56:11'),
(44, 2, 22, 13, 'accepted', 'sponsoring', '2014-09-11 00:51:18', '2014-09-11 00:51:18'),
(45, 2, 13, 12, 'accepted', 'group fund', '2014-09-11 00:51:53', '2014-09-11 00:56:04'),
(46, 2, 14, 13, 'accepted', 'sponsoring', '2014-09-11 00:51:53', '2014-09-11 00:51:53'),
(47, 2, 13, 12, 'accepted', 'group fund', '2014-09-11 00:53:27', '2014-09-11 00:55:55'),
(48, 2, 14, 13, 'accepted', 'sponsoring', '2014-09-11 00:53:27', '2014-09-11 00:53:27'),
(49, 2, 13, 12, 'accepted', 'group fund', '2014-09-11 01:11:56', '2014-09-11 01:18:04'),
(50, 2, 22, 13, 'accepted', 'sponsoring', '2014-09-11 01:11:56', '2014-09-11 01:11:56'),
(51, 2, 13, 12, 'accepted', 'group fund', '2014-09-11 01:13:18', '2014-09-11 01:17:56'),
(52, 2, 14, 13, 'accepted', 'sponsoring', '2014-09-11 01:13:18', '2014-09-11 01:13:18'),
(53, 1, 3, 2, 'accepted', 'group fund', '2014-09-20 17:02:51', '2014-09-20 23:02:42'),
(54, 1, 8, 3, 'accepted', 'sponsoring', '2014-09-20 17:02:51', '2014-09-20 17:02:51'),
(55, 1, 3, 2, 'accepted', 'group fund', '2014-09-20 17:22:39', '2014-09-20 23:02:24'),
(56, 1, 4, 3, 'accepted', 'sponsoring', '2014-09-20 17:22:39', '2014-09-20 17:22:39'),
(57, 1, 3, 2, 'accepted', 'group fund', '2014-09-20 17:41:05', '2014-09-20 23:02:09'),
(58, 1, 7, 3, 'accepted', 'sponsoring', '2014-09-20 17:41:05', '2014-09-20 17:41:05'),
(59, 1, 3, 2, 'accepted', 'group fund', '2014-09-20 17:42:05', '2014-09-20 23:01:58'),
(60, 1, 6, 3, 'accepted', 'sponsoring', '2014-09-20 17:42:05', '2014-09-20 17:42:05'),
(61, 1, 9, 2, 'accepted', 'group fund', '2014-09-23 23:04:50', '2014-09-23 23:34:48'),
(62, 1, 16, 9, 'accepted', 'sponsoring', '2014-09-23 23:04:50', '2014-09-23 23:04:50'),
(63, 1, 9, 2, 'accepted', 'group fund', '2014-09-23 23:05:03', '2014-09-23 23:34:56'),
(64, 1, 10, 9, 'accepted', 'sponsoring', '2014-09-23 23:05:03', '2014-09-23 23:05:03'),
(65, 1, 3, 2, 'accepted', 'group fund', '2014-09-23 23:05:42', '2014-09-23 23:35:00'),
(66, 1, 4, 3, 'accepted', 'sponsoring', '2014-09-23 23:05:42', '2014-09-23 23:05:42'),
(67, 1, 3, 2, 'accepted', 'group fund', '2014-09-23 23:05:51', '2014-09-23 23:35:03'),
(68, 1, 6, 3, 'accepted', 'sponsoring', '2014-09-23 23:05:51', '2014-09-23 23:05:51'),
(69, 1, 26, 9, 'accepted', 'sponsoring', '2014-09-23 23:19:35', '2014-09-23 23:32:39'),
(70, 1, 27, 9, 'accepted', 'sponsoring', '2014-09-23 23:21:45', '2014-09-23 23:32:28'),
(71, 1, 27, 9, 'accepted', 'sponsoring', '2014-09-23 23:24:21', '2014-09-23 23:32:33'),
(72, 1, 28, 9, 'accepted', 'sponsoring', '2014-09-23 23:25:09', '2014-09-23 23:32:24'),
(73, 1, 29, 24, 'pending', 'sponsoring', '2014-09-23 23:27:31', '2014-09-23 23:27:31'),
(74, 1, 9, 2, 'accepted', 'group fund', '2014-09-23 23:32:07', '2014-09-23 23:35:12'),
(75, 1, 28, 9, 'accepted', 'sponsoring', '2014-09-23 23:32:07', '2014-09-23 23:32:07'),
(76, 1, 9, 2, 'accepted', 'group fund', '2014-09-23 23:32:24', '2014-10-01 17:44:52'),
(77, 1, 9, 2, 'accepted', 'group fund', '2014-09-23 23:32:29', '2014-10-01 17:44:59'),
(78, 1, 9, 2, 'pending', 'group fund', '2014-09-23 23:32:33', '2014-09-23 23:32:33'),
(79, 1, 9, 2, 'pending', 'group fund', '2014-09-23 23:32:39', '2014-09-23 23:32:39'),
(80, 1, 3, 2, 'pending', 'group fund', '2014-10-06 21:23:13', '2014-10-06 21:23:13'),
(81, 1, 8, 3, 'accepted', 'sponsoring', '2014-10-06 21:23:13', '2014-10-06 21:23:13'),
(82, 1, 3, 2, 'pending', 'group fund', '2014-10-06 21:23:57', '2014-10-06 21:23:57'),
(83, 1, 7, 3, 'accepted', 'sponsoring', '2014-10-06 21:23:57', '2014-10-06 21:23:57'),
(84, 1, 3, 2, 'pending', 'group fund', '2014-10-06 21:24:45', '2014-10-06 21:24:45'),
(85, 1, 5, 3, 'accepted', 'sponsoring', '2014-10-06 21:24:45', '2014-10-06 21:24:45'),
(86, 1, 3, 2, 'accepted', 'group fund', '2014-10-06 21:25:05', '2015-04-26 09:37:48'),
(87, 1, 4, 3, 'accepted', 'sponsoring', '2014-10-06 21:25:05', '2014-10-06 21:25:05'),
(88, 1, 3, 2, 'rejected', 'group fund', '2014-10-06 22:16:33', '2015-04-26 09:37:54'),
(89, 1, 8, 3, 'accepted', 'sponsoring', '2014-10-06 22:16:33', '2014-10-06 22:16:33'),
(90, 1, 3, 2, 'pending', 'group fund', '2014-10-06 23:47:23', '2014-10-06 23:47:23'),
(91, 1, 8, 3, 'accepted', 'sponsoring', '2014-10-06 23:47:23', '2014-10-06 23:47:23'),
(92, 1, 3, 2, 'pending', 'group fund', '2014-10-15 18:18:28', '2014-10-15 18:18:28'),
(93, 1, 4, 3, 'accepted', 'sponsoring', '2014-10-15 18:18:28', '2014-10-15 18:18:28'),
(94, 1, 3, 2, 'pending', 'group fund', '2014-10-15 18:18:41', '2014-10-15 18:18:41'),
(95, 1, 5, 3, 'accepted', 'sponsoring', '2014-10-15 18:18:41', '2014-10-15 18:18:41'),
(96, 1, 3, 2, 'pending', 'group fund', '2014-10-15 18:18:53', '2014-10-15 18:18:53'),
(97, 1, 6, 3, 'accepted', 'sponsoring', '2014-10-15 18:18:53', '2014-10-15 18:18:53'),
(98, 1, 3, 2, 'pending', 'group fund', '2014-10-15 18:19:04', '2014-10-15 18:19:04'),
(99, 1, 7, 3, 'accepted', 'sponsoring', '2014-10-15 18:19:04', '2014-10-15 18:19:04'),
(100, 1, 3, 2, 'pending', 'group fund', '2014-10-15 18:19:12', '2014-10-15 18:19:12'),
(101, 1, 8, 3, 'accepted', 'sponsoring', '2014-10-15 18:19:12', '2014-10-15 18:19:12'),
(102, 1, 3, 2, 'pending', 'group fund', '2014-10-15 18:55:28', '2014-10-15 18:55:28'),
(103, 1, 8, 3, 'accepted', 'sponsoring', '2014-10-15 18:55:28', '2014-10-15 18:55:28'),
(104, 1, 3, 2, 'pending', 'group fund', '2014-10-15 18:56:00', '2014-10-15 18:56:00'),
(105, 1, 7, 3, 'accepted', 'sponsoring', '2014-10-15 18:56:00', '2014-10-15 18:56:00'),
(106, 3, 34, 21, 'accepted', 'sponsoring', '2015-02-10 15:14:30', '2015-02-10 16:07:28'),
(107, 3, 35, 21, 'accepted', 'sponsoring', '2015-02-10 15:23:15', '2015-02-10 16:07:18'),
(108, 3, 36, 33, 'pending', 'sponsoring', '2015-02-10 15:37:42', '2015-02-10 15:37:42'),
(109, 3, 37, 33, 'pending', 'sponsoring', '2015-02-10 15:42:17', '2015-02-10 15:42:17'),
(110, 3, 21, 17, 'accepted', 'group fund', '2015-02-10 16:00:49', '2015-02-10 16:18:31'),
(111, 3, 35, 21, 'accepted', 'sponsoring', '2015-02-10 16:00:49', '2015-02-10 16:00:49'),
(112, 3, 21, 17, 'accepted', 'group fund', '2015-02-10 16:05:21', '2015-02-10 16:18:24'),
(113, 3, 35, 21, 'accepted', 'sponsoring', '2015-02-10 16:05:21', '2015-02-10 16:05:21'),
(114, 3, 21, 17, 'accepted', 'group fund', '2015-02-10 16:07:05', '2015-02-10 16:18:13'),
(115, 3, 35, 21, 'accepted', 'sponsoring', '2015-02-10 16:07:05', '2015-02-10 16:07:05'),
(116, 3, 21, 17, 'accepted', 'group fund', '2015-02-10 16:07:18', '2015-02-10 16:18:06'),
(117, 3, 21, 17, 'accepted', 'group fund', '2015-02-10 16:07:28', '2015-02-10 16:17:45'),
(118, 3, 21, 17, 'accepted', 'group fund', '2015-02-10 16:08:25', '2015-02-10 16:17:39'),
(119, 3, 21, 17, 'accepted', 'group fund', '2015-02-10 16:09:39', '2015-02-10 16:17:34'),
(120, 3, 34, 21, 'accepted', 'sponsoring', '2015-02-10 16:09:39', '2015-02-10 16:09:39'),
(121, 3, 21, 17, 'accepted', 'group fund', '2015-02-10 16:10:09', '2015-02-10 16:17:28'),
(122, 3, 34, 21, 'accepted', 'sponsoring', '2015-02-10 16:10:09', '2015-02-10 16:10:09'),
(123, 3, 21, 17, 'accepted', 'group fund', '2015-02-14 18:18:26', '2015-02-14 19:52:00'),
(124, 3, 35, 21, 'accepted', 'sponsoring', '2015-02-14 18:18:26', '2015-02-14 18:18:26'),
(125, 1, 22, 24, 'pending', 'sponsoring', '2015-03-16 23:25:00', '2015-03-16 23:25:00'),
(126, 1, 4, 3, 'pending', 'sponsoring', '2015-03-19 13:57:55', '2015-03-19 13:57:55'),
(127, 2, 4, 13, 'accepted', 'sponsoring', '2015-03-19 13:59:12', '2015-04-26 09:32:32'),
(128, 2, 13, 12, 'pending', 'group fund', '2015-04-10 19:42:37', '2015-04-10 19:42:37'),
(129, 2, 14, 13, 'accepted', 'sponsoring', '2015-04-10 19:42:37', '2015-04-10 19:42:37'),
(130, 4, 4, 19, 'pending', 'sponsoring', '2015-04-26 09:30:28', '2015-04-26 09:30:28'),
(131, 2, 13, 12, 'pending', 'group fund', '2015-04-26 09:32:24', '2015-04-26 09:32:24'),
(132, 2, 14, 13, 'accepted', 'sponsoring', '2015-04-26 09:32:24', '2015-04-29 06:24:17'),
(133, 2, 13, 12, 'pending', 'group fund', '2015-04-26 09:36:38', '2015-04-26 09:36:38'),
(134, 2, 14, 13, 'accepted', 'sponsoring', '2015-04-26 09:36:38', '2015-04-26 09:36:38'),
(135, 4, 4, 19, 'pending', 'sponsoring', '2015-04-28 05:31:54', '2015-04-28 05:31:54'),
(136, 4, 4, 19, 'pending', 'sponsoring', '2015-04-28 08:43:46', '2015-04-28 08:43:46'),
(137, 4, 4, 19, 'pending', 'sponsoring', '2015-04-28 08:44:06', '2015-04-28 08:44:06'),
(138, 1, 14, 24, 'pending', 'sponsoring', '2015-05-04 05:48:45', '2015-05-04 05:48:45'),
(139, 2, 14, 13, 'pending', 'sponsoring', '2015-05-04 06:50:26', '2015-05-04 06:50:26'),
(140, 1, 14, 25, 'pending', 'sponsoring', '2015-05-04 06:53:42', '2015-05-04 06:53:42'),
(141, 1, 14, 25, 'pending', 'sponsoring', '2015-05-04 06:54:09', '2015-05-04 06:54:09'),
(142, 1, 14, 24, 'pending', 'sponsoring', '2015-05-04 06:56:07', '2015-05-04 06:56:07'),
(143, 2, 14, 13, 'pending', 'sponsoring', '2015-05-04 07:03:26', '2015-05-04 07:03:26'),
(144, 1, 14, 24, 'pending', 'sponsoring', '2015-05-04 07:22:41', '2015-05-04 07:22:41'),
(145, 2, 14, 13, 'pending', 'sponsoring', '2015-05-04 07:23:48', '2015-05-04 07:23:48'),
(146, 1, 14, 24, 'pending', 'sponsoring', '2015-05-04 07:28:29', '2015-05-04 07:28:29'),
(147, 2, 14, 13, 'pending', 'sponsoring', '2015-05-04 07:38:10', '2015-05-04 07:38:10'),
(148, 1, 14, 24, 'pending', 'sponsoring', '2015-05-04 07:39:18', '2015-05-04 07:39:18'),
(149, 2, 14, 13, 'pending', 'sponsoring', '2015-05-04 07:46:41', '2015-05-04 07:46:41'),
(150, 4, 4, 19, 'pending', 'sponsoring', '2015-06-02 01:13:02', '2015-06-02 01:13:02');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `max_recipients` int(11) NOT NULL,
  `max_sponsors_per_recipient` int(11) NOT NULL,
  `currency` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `euro_amount` decimal(8,2) NOT NULL,
  `gf_commission` decimal(8,2) NOT NULL,
  `open` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `projects_url_unique` (`url`),
  KEY `projects_open_index` (`open`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `name`, `url`, `content`, `max_recipients`, `max_sponsors_per_recipient`, `currency`, `amount`, `euro_amount`, `gf_commission`, `open`, `created_at`, `updated_at`) VALUES
(1, 'tp1', 'tp1', '<p>test to see where this appears, if anywhere.</p>\r\n', 12, 5, 'Kenyan Shilling (KES)', 1300.00, 12.00, 300.00, 1, '2014-01-10 05:08:36', '2015-04-26 09:31:54'),
(2, 'tp2', 'tp2', '<p>test</p>\r\n', 12, 5, 'Kenya Shillings (KES)', 1200.00, 10.00, 400.00, 1, '2014-01-15 20:31:51', '2014-01-15 20:31:51'),
(3, 'badilishatest', 'badilishatest', '<p>??</p>\r\n', 6, 2, 'Kenya Shillings (KES)', 1200.00, 12.00, 300.00, 1, '2014-01-29 01:54:19', '2015-02-10 16:33:51'),
(4, 'orderofprioritytest', 'orderofprioritytest', '<p>??</p>\r\n', 4, 3, 'euro', 10.00, 10.00, 3.00, 1, '2014-01-29 02:22:50', '2014-01-29 02:22:50');

-- --------------------------------------------------------

--
-- Table structure for table `project_sponsor`
--

DROP TABLE IF EXISTS `project_sponsor`;
CREATE TABLE IF NOT EXISTS `project_sponsor` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `sponsor_id` int(10) unsigned NOT NULL,
  `recipient_id` int(10) unsigned NOT NULL,
  `next_pay` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `project_sponsor_project_id_index` (`project_id`),
  KEY `project_sponsor_sponsor_id_index` (`sponsor_id`),
  KEY `project_sponsor_recipient_id_index` (`recipient_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=29 ;

--
-- Dumping data for table `project_sponsor`
--

INSERT INTO `project_sponsor` (`id`, `project_id`, `sponsor_id`, `recipient_id`, `next_pay`, `created_at`, `updated_at`) VALUES
(2, 1, 2, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 1, 3, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, 1, 4, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 1, 5, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(6, 1, 6, 2, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(8, 1, 8, 2, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(10, 1, 10, 2, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(11, 1, 11, 2, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(12, 1, 12, 2, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(13, 1, 13, 9, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(14, 3, 14, 7, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(15, 3, 15, 7, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(16, 3, 16, 14, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(17, 3, 17, 14, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(18, 1, 9, 9, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(19, 1, 1, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(20, 2, 1, 3, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(21, 1, 18, 9, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(22, 4, 1, 5, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(23, 1, 19, 9, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(24, 1, 20, 9, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(25, 1, 21, 10, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(26, 1, 22, 10, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(27, 1, 23, 10, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(28, 1, 24, 10, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `recipients`
--

DROP TABLE IF EXISTS `recipients`;
CREATE TABLE IF NOT EXISTS `recipients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `project_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `skrill_acc` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mepsa` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmed` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `recipients_skrill_acc_unique` (`skrill_acc`),
  KEY `recipients_project_id_index` (`project_id`),
  KEY `recipients_user_id_index` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Dumping data for table `recipients`
--

INSERT INTO `recipients` (`id`, `name`, `project_id`, `user_id`, `skrill_acc`, `mepsa`, `confirmed`, `created_at`, `updated_at`) VALUES
(1, 'tp1r01', 1, 3, 'tp1r01@mailinator.com', NULL, 1, '2014-01-10 05:20:46', '2014-01-10 05:23:40'),
(2, 'tp1r02', 1, 9, 'tp1r02@mailinator.com', NULL, 1, '2014-01-11 01:42:55', '2014-01-11 01:44:04'),
(3, 'Mobs', 2, 13, 'tp2r01@mailinator.org', '125352779', 1, '2014-01-15 20:39:29', '2015-06-02 01:29:48'),
(4, 'tp2r02', 2, 15, 'tp2r02@directsponsor.org', NULL, 0, '2014-01-25 02:27:48', '2014-01-25 02:27:48'),
(5, 'invitee03', 4, 19, 'invitee03@mailinator.com', NULL, 1, '2014-01-29 02:27:59', '2014-01-29 02:29:16'),
(6, 'invitee02', 4, 20, 'invitee02@mailinator.com', NULL, 1, '2014-01-29 02:37:23', '2014-01-29 02:38:07'),
(7, 'brecipient1', 3, 21, 'brecipient1@mailinator.com', NULL, 1, '2014-01-30 01:02:08', '2014-01-30 01:03:07'),
(8, 'Fredrick Onyango ', 3, 23, 'fredonyangokenya@gmail.com', NULL, 0, '2014-03-04 18:39:30', '2014-03-04 18:39:30'),
(9, 'tp1r03', 1, 24, 'tp1r03@mailinator.com', NULL, 1, '2014-09-20 17:59:09', '2014-09-20 18:01:28'),
(10, 'tp1r04', 1, 25, 'tp1r04@mailinator.com', NULL, 1, '2014-09-23 23:13:19', '2014-09-23 23:13:56'),
(11, 'tp1r05', 1, 30, 'tp1r05@mailinator.com', NULL, 1, '2014-10-01 17:48:36', '2014-10-01 17:49:02'),
(12, 'tp1r06', 1, 31, 'tp1r06@mailinator.com', NULL, 1, '2014-10-15 18:15:13', '2014-10-15 18:15:46'),
(13, 'brecipient2 ', 3, 32, 'brecipient2@mailinator.com', NULL, 0, '2014-10-27 18:06:59', '2014-10-27 18:06:59'),
(14, 'brecipient3', 3, 33, 'brecipient3@mailinator.com', NULL, 1, '2014-10-27 18:13:22', '2014-10-27 18:28:19');

-- --------------------------------------------------------

--
-- Table structure for table `spends`
--

DROP TABLE IF EXISTS `spends`;
CREATE TABLE IF NOT EXISTS `spends` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `spends_project_id_index` (`project_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `spends`
--

INSERT INTO `spends` (`id`, `project_id`, `amount`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 20.00, 'test payment by coordinator.', '2014-02-11 19:41:11', '2014-02-11 19:41:11'),
(2, 2, 500.00, 'bought a new thing. ', '2014-09-11 01:01:07', '2014-09-11 01:01:07'),
(3, 1, 3000.00, 'another test payment - bought something. ', '2014-09-20 17:49:16', '2014-09-20 17:49:16'),
(4, 1, 1200.00, 'description of expense.', '2014-10-01 17:45:42', '2014-10-01 17:45:42');

-- --------------------------------------------------------

--
-- Table structure for table `sponsors`
--

DROP TABLE IF EXISTS `sponsors`;
CREATE TABLE IF NOT EXISTS `sponsors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `skrill_acc` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sponsors_skrill_acc_unique` (`skrill_acc`),
  KEY `sponsors_user_id_index` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=25 ;

--
-- Dumping data for table `sponsors`
--

INSERT INTO `sponsors` (`id`, `user_id`, `name`, `skrill_acc`, `confirmed`, `suspended`, `created_at`, `updated_at`) VALUES
(1, 4, 'tp1s01', 'tp1s01@mailinator.com', 1, 0, '2014-01-10 05:26:33', '2015-04-28 01:17:46'),
(2, 5, 'tp1s02', 'tp1s02@mailinator.com', 1, 0, '2014-01-11 00:59:47', '2014-01-11 01:01:01'),
(3, 6, 'tp1s03', 'tp1s03@mailinator.com', 1, 0, '2014-01-11 01:02:32', '2014-01-11 01:03:17'),
(4, 7, 'tp1s04', 'tp1s04@mailinator.com', 1, 0, '2014-01-11 01:05:06', '2014-01-11 01:06:45'),
(5, 8, 'tp1s05', 'tp1s05@mailinator.com', 1, 0, '2014-01-11 01:09:00', '2014-01-11 01:09:47'),
(6, 10, 'tp1s06', 'tp1s06@mailinator.com', 1, 0, '2014-01-11 01:48:09', '2014-01-11 02:39:42'),
(7, 14, 'tp2s01', 'tp2s01@mailinator.com', 1, 0, '2014-01-15 20:44:54', '2014-01-15 20:46:06'),
(8, 16, 'tp1s07', 'tp1s07@mailinator.com', 1, 0, '2014-01-25 02:44:33', '2014-02-11 19:39:12'),
(9, 22, 'name', 'tp2s09@mailinator.com', 1, 0, '2014-01-31 20:32:12', '2014-01-31 20:34:40'),
(10, 26, 'tp1s08', 'tp1s08@mailinator.com', 1, 0, '2014-09-23 23:18:45', '2014-09-23 23:19:35'),
(11, 27, 'tp1s09', 'tp1s09@mailinator.com', 1, 0, '2014-09-23 23:21:20', '2014-09-23 23:24:21'),
(12, 28, 'tp1s10', 'tp1s10@mailinator.com', 1, 0, '2014-09-23 23:23:36', '2014-09-23 23:25:09'),
(13, 29, 'tp1s11', 'tp1s11@mailinator.com', 1, 0, '2014-09-23 23:26:59', '2014-09-23 23:27:31'),
(14, 34, 'bsponsor01', 'bsponsor01@mailinator.com', 1, 0, '2015-02-10 15:05:35', '2015-02-10 15:14:30'),
(15, 35, 'bsponsor03', 'bsponsor03@mailinator.com', 1, 0, '2015-02-10 15:22:47', '2015-02-10 15:23:15'),
(16, 36, 'bsponsor04', 'bsponsor04@mailinator.com', 1, 0, '2015-02-10 15:32:24', '2015-02-10 15:37:42'),
(17, 37, 'bsponsor02', 'bsponsor02@mailinator.com', 1, 0, '2015-02-10 15:38:50', '2015-02-10 15:42:17'),
(18, 38, 'Mubheer', 'sagar4ever@hotmail.com', 0, 0, '2015-04-01 21:20:36', '2015-04-01 21:20:36'),
(19, 44, 'Senin Rashi Ashraf', '3user@1.com', 0, 0, '2015-06-02 17:58:18', '2015-06-02 17:58:18'),
(20, 45, 'Senin Rashi Ashraf', '4user@1.com', 0, 0, '2015-06-02 18:06:22', '2015-06-02 18:06:22'),
(21, 46, 'Senin Rashi Ashraf', '5user@1.com', 0, 0, '2015-06-02 18:15:03', '2015-06-02 18:15:03'),
(22, 47, 'Senin Rashi Ashraf', '6user@1.com', 0, 0, '2015-06-02 18:15:42', '2015-06-02 18:15:42'),
(23, 48, 'Senin Rashi Ashraf', '7user@1.com', 0, 0, '2015-06-02 18:19:11', '2015-06-02 18:19:11'),
(24, 49, 'Senin Rashi Ashraf', '8user@1.com', 0, 0, '2015-06-02 18:19:51', '2015-06-02 18:19:51');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `account_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=50 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `account_type`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@directsponsor.org', '$2y$08$i83FqmOTvdkVqP0U97i0iOVQhXEAcARsYMXIZFozYu9ngNnf.nxIa', 'Admin', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'tp1c', 'tp1c@mailinator.com', '$2y$08$w0Mo8enDMTAbdswJYyLsleTp30M/x5c9K3RIKnfqQZ9S6H26EYTte', 'Coordinator', '2014-01-10 05:08:36', '2014-01-10 05:08:36'),
(3, 'tp1r01', 'tp1r01@mailinator.com', '$2y$08$p54DKap/DC91iNmEsuNxyOkgewccMA8yUjdAlePIr2Q1mkc2hZJBa', 'Recipient', '2014-01-10 05:20:46', '2014-01-10 05:20:46'),
(4, 'tp1s01', 'tp1s01@mailinator.com', '$2y$08$2u1XMMefRuVCKU/ithVqoex/7vEQsi0tdmLMDXtmwfXRszBQMHt9e', 'Sponsor', '2014-01-10 05:26:33', '2014-01-10 05:26:33'),
(5, 'tp1s02', 'tp1s02@mailinator.com', '$2y$08$OOiXKyR2IW50fpAzgyDkhethp/HQla8XfFjcAQqAuHAI67mbmELHy', 'Sponsor', '2014-01-11 00:59:47', '2014-01-11 00:59:47'),
(6, 'tp1s03', 'tp1s03@mailinator.com', '$2y$08$VX2.vY.IHT5N1.vKwleGD.bjbHQPkazPgnnJ7NpS9.WDFGD2.Fg46', 'Sponsor', '2014-01-11 01:02:32', '2014-01-11 01:02:32'),
(7, 'tp1s04', 'tp1s04@mailinator.com', '$2y$08$3TrPStoiq2OfeTLYH1HFlefBUvw65d0DBoRQskSdKsQUVA/TjpE4a', 'Sponsor', '2014-01-11 01:05:06', '2014-01-11 01:05:06'),
(8, 'tp1s05', 'tp1s05@mailinator.com', '$2y$08$tRBqaBR8H.pogMe3pmvXkO6xGTmxaZW7x25.3GG/ksmIW4pt1BWLa', 'Sponsor', '2014-01-11 01:09:00', '2014-01-11 01:09:00'),
(9, 'tp1r02', 'tp1r02@mailinator.com', '$2y$08$SdKGVzvh26SrRk6hobfjA.09WySINiYztl3kzOkf7Aseg7KzCvXK.', 'Recipient', '2014-01-11 01:42:55', '2014-01-11 01:42:55'),
(10, 'tp1s06', 'tp1s06@mailinator.com', '$2y$08$ixrc5K13Gpo2TlT87zcNUu/M1DIrHPzB7FXKHAfdoUPR12AtiLTSu', 'Sponsor', '2014-01-11 01:48:09', '2014-01-11 01:48:09'),
(12, 'tp2c', 'tp2c@mailinator.com', '$2y$08$n.p6ZenUNekz7vQtBnAnJOOOyqoTZ4oRLUuvGiP4W9MxsxCG2HLDu', 'Coordinator', '2014-01-15 20:31:51', '2014-01-15 20:31:51'),
(13, 'tp2r01', 'tp2r01@mailinator.com', '$2y$08$QYH40cEsmyRENbUBsvjcYe1wgEjTzhcd6gXYDa9HK9BbuzVCZzs2i', 'Recipient', '2014-01-15 20:39:29', '2014-01-15 20:39:29'),
(14, 'tp2s01', 'tp2s01@mailinator.com', '$2y$08$6DKzMmsqYx82CQY0K5NDBuEc9dJLM0LCjQ30eGzBOdAdCTlYQMM52', 'Sponsor', '2014-01-15 20:44:54', '2014-01-15 20:44:54'),
(15, 'tp2r02', 'tp2r02@directsponsor.org', '$2y$08$6wXWSErq5Bcm1JD5WHLW8u1H7.XlSqwyeSiKYr2zPSRvyVysS3MmG', 'Recipient', '2014-01-25 02:27:48', '2014-01-25 02:27:48'),
(16, 'tp1s07', 'tp1s07@mailinator.com', '$2y$08$e3ao8V49JYymGYR.BPKiwe2Rx841pP2MfmZQkrygUX3Mjd8BAjxa6', 'Sponsor', '2014-01-25 02:44:33', '2014-01-25 02:44:33'),
(17, 'Evans', 'fworldproject@yahoo.com', '$2y$08$K.0a1V6mRL6Q8qjl9FJQM.jRt64ESaiYoT5rFVG8vJCLztZpveAB2', 'Coordinator', '2014-01-29 01:54:19', '2014-01-29 01:54:19'),
(18, 'andy', 'andy@directsponsor.org', '$2y$08$qRyQikSh4dEHCmC5LxRj7.W75t6dgtzLRvPI8dH4OC911sOboioga', 'Coordinator', '2014-01-29 02:22:50', '2014-01-29 02:22:50'),
(19, 'invitee03', 'invitee03@mailinator.com', '$2y$08$4TyH/iIGpdIfqXtIJU2Fi.Cj53y0V9fbyWyWiMOKwoQdijvJlt3Zy', 'Recipient', '2014-01-29 02:27:59', '2014-01-29 02:27:59'),
(20, 'invitee02', 'invitee02@mailinator.com', '$2y$08$X2fqwRE2M3kT2rLkRfI6ruBCRx2bROr.o5LlehNSfcjH3U8AI1ruW', 'Recipient', '2014-01-29 02:37:23', '2014-01-29 02:37:23'),
(21, 'brecipient1', 'brecipient1@mailinator.com', '$2y$08$sEZ5FB1ffhTD.29jZisP4efSJNOFDY5AaPS2rIPw1o25uoOfxZ.Uy', 'Recipient', '2014-01-30 01:02:08', '2014-01-30 01:02:08'),
(22, 'tp2s09', 'tp2s09@mailinator.com', '$2y$08$R1at2rqC9hlN5c/MiXoAHOnh3isjVu1vxgIX6mHs21QFOLxNTpBdS', 'Sponsor', '2014-01-31 20:32:12', '2014-01-31 20:32:12'),
(23, 'fredonyangokenya@gmail.com', 'fredonyangokenya@gmail.com', '$2y$08$FRiJhvEMeyZdfTiYhUWSCOI8LIbJjiorYbamLQR3Us5exDJakd57S', 'Recipient', '2014-03-04 18:39:30', '2014-03-04 18:39:30'),
(24, 'tp1r03', 'tp1r03@mailinator.com', '$2y$08$mb/O.2PDLZ7Tw.6YzH7f0emINGe3KQaDQWhJzHrK0t5cgDZSoG00u', 'Recipient', '2014-09-20 17:59:09', '2014-09-20 17:59:09'),
(25, 'tp1r04', 'tp1r04@mailinator.com', '$2y$08$sla/gJ0.GXLHW.lRtcCmgeQCR7wlcW1xFng0YlQ5i8qYf5pzeLQMC', 'Recipient', '2014-09-23 23:13:19', '2014-09-23 23:13:19'),
(26, 'tp1s08', 'tp1s08@mailinator.com', '$2y$08$Hbsz2mpUqxVdWoihZO2Byeea44r10W9me0ia/Q26WxbLp9vgZXcpi', 'Sponsor', '2014-09-23 23:18:45', '2014-09-23 23:18:45'),
(27, 'tp1s09', 'tp1s09@mailinator.com', '$2y$08$MhQN4CLcND8bW5w3jqM9xOjVCCDR2mQAHLP8usegE2866k5Jcagte', 'Sponsor', '2014-09-23 23:21:20', '2014-09-23 23:21:20'),
(28, 'tp1s10', 'tp1s10@mailinator.com', '$2y$08$Iy7wb93w1c2Ool/cR86XZOXoNIFacHbd.Pa8qdhZdH.TKGwb9.ugC', 'Sponsor', '2014-09-23 23:23:36', '2014-09-23 23:23:36'),
(29, 'tp1s11', 'tp1s11@mailinator.com', '$2y$08$Q29OYjtVtmMV/fW5YpqpYuqP11LBQ458xKCluETSwz4TzFUSMPazW', 'Sponsor', '2014-09-23 23:26:59', '2014-09-23 23:26:59'),
(30, 'tp1r05', 'tp1r05@mailinator.com', '$2y$08$iOOCEnhzVrUE42vbNPDFPuW2eIMznH2KcN1TULS8NHroy7FDS70pO', 'Recipient', '2014-10-01 17:48:36', '2014-10-01 17:48:36'),
(31, 'tp1r06', 'tp1r06@mailinator.com', '$2y$08$ScO.mhYsl05Kkbm5MsjRuuYTB0ulBQTDm6UTOxuFzD05GLk7vVueC', 'Recipient', '2014-10-15 18:15:13', '2014-10-15 18:15:13'),
(32, 'brecipient2', 'brecipient2@mailinator.com', '$2y$08$vLmm58PEkOMlXKRIoLDq5u5mnjWewvIJEkWOfcSQjSSdOpKgcleqy', 'Recipient', '2014-10-27 18:06:59', '2014-10-27 18:06:59'),
(33, 'brecipient3', 'brecipient3@mailinator.com', '$2y$08$W6upTYOBbhGHHNctyGJneeehmktt/SDqeuPBfdrLNt6UJg3MePcJK', 'Recipient', '2014-10-27 18:13:22', '2014-10-27 18:13:22'),
(34, 'bsponsor01', 'bsponsor01@mailinator.com', '$2y$08$j04wlW5ICEY3hPK5Z8fTw.j36/Ivyl1ZqMzvulvf8u.VqK7BB.sZm', 'Sponsor', '2015-02-10 15:05:35', '2015-02-10 15:05:35'),
(35, 'bsponsor03', 'bsponsor03@mailinator.com', '$2y$08$8auF7mtU5qB3VtBPguBa6.n1RVTIjHrf0SYkC5ehAXra8E29l.cQK', 'Sponsor', '2015-02-10 15:22:47', '2015-02-10 15:22:47'),
(36, 'bsponsor04', 'bsponsor04@mailinator.com', '$2y$08$wdV/dQSNm0Ix11zfeQnP/uaKVJdc5HuJ1zSTcHXOOw9iF45jm0412', 'Sponsor', '2015-02-10 15:32:24', '2015-02-10 15:32:24'),
(37, 'bsponsor02', 'bsponsor02@mailinator.com', '$2y$08$4/vt6sbqJRg1fA7gGQNGT.8SnToG8Nh.NkAm/ToaFgxg2ZNbQbB5W', 'Sponsor', '2015-02-10 15:38:50', '2015-02-10 15:38:50'),
(38, 'mubheer', 'sagar4ever@hotmail.com', '$2y$08$FoWJ0yGefENEBDI2grxm6O9q1CrKGn9LGj5xqk.fnP5OhwhSEz6PC', 'Sponsor', '2015-04-01 21:20:36', '2015-04-01 21:20:36'),
(41, '1zenin', '1zeninrashi.ashraf@yahoo.com', '$2y$08$ykZ6xx8rWVKArAdEsCZAVe3.A.H833OVZeqZvCeRGfj7WVJdT/QFC', 'Sponsor', '2015-06-02 02:23:14', '2015-06-02 02:23:14'),
(42, '1user', '1user@1.com', '$2y$08$3chLrxrUHSS1l/9d8rfvPesyeu2O7V.WERz4O41/91ucxKY8/hOKu', 'Sponsor', '2015-06-02 17:16:36', '2015-06-02 17:16:36'),
(43, '2user', '2user@1.com', '$2y$08$8wzzt7fksnxQOgRGOgGXy.PtzBl/xrdDgXBrBGnqHWw8bnxpgWNEG', 'Sponsor', '2015-06-02 17:54:29', '2015-06-02 17:54:29'),
(44, '3user', '3user@1.com', '$2y$08$pnyJz/l8GUzmqUkFCpqQCuEAmNbBe./bDPDzGa6IS7lCeNyZ5JQkG', 'Sponsor', '2015-06-02 17:58:18', '2015-06-02 17:58:18'),
(45, '4user', '4user@1.com', '$2y$08$m5nhePIrCgi7oGxCj1GgyuE1RkWNZ.qNTu/Qd/pSppKvrUnv1.iRi', 'Sponsor', '2015-06-02 18:06:22', '2015-06-02 18:06:22'),
(46, '5user', '5user@1.com', '$2y$08$Bp8h9A3AtVIlM7jaJ49BFuJAPyEa9YR/rk.0NuMUNVShrj4bXdJ82', 'Sponsor', '2015-06-02 18:15:03', '2015-06-02 18:15:03'),
(47, '6user', '6user@1.com', '$2y$08$6LzLIhWrlAhECo61h98pl.3HJqNpydp/qJN9p1pVGGSrWA/1G8PuW', 'Sponsor', '2015-06-02 18:15:42', '2015-06-02 18:15:42'),
(48, '7user', '7user@1.com', '$2y$08$zUw.JH5/oIoC6.wuJzgEP.v.l5QwuBu.qWV6/MSu72GmTAzCnfcDW', 'Sponsor', '2015-06-02 18:19:11', '2015-06-02 18:19:11'),
(49, '8user', '8user@1.com', '$2y$08$oDuMw8EsCY21WsRp3YK4HegPPPv3yw/d1DAx38JBcLEWSo3gDaZwG', 'Sponsor', '2015-06-02 18:19:51', '2015-06-02 18:19:51');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `coordinators`
--
ALTER TABLE `coordinators`
  ADD CONSTRAINT `coordinators_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `coordinators_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `invitations`
--
ALTER TABLE `invitations`
  ADD CONSTRAINT `invitations_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `payments_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `payments_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `project_sponsor`
--
ALTER TABLE `project_sponsor`
  ADD CONSTRAINT `project_sponsor_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `project_sponsor_recipient_id_foreign` FOREIGN KEY (`recipient_id`) REFERENCES `recipients` (`id`),
  ADD CONSTRAINT `project_sponsor_sponsor_id_foreign` FOREIGN KEY (`sponsor_id`) REFERENCES `sponsors` (`id`);

--
-- Constraints for table `recipients`
--
ALTER TABLE `recipients`
  ADD CONSTRAINT `recipients_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `recipients_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `spends`
--
ALTER TABLE `spends`
  ADD CONSTRAINT `spends_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`);

--
-- Constraints for table `sponsors`
--
ALTER TABLE `sponsors`
  ADD CONSTRAINT `sponsors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
