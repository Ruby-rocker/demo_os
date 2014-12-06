-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 31, 2014 at 12:58 PM
-- Server version: 5.5.35
-- PHP Version: 5.4.6-1ubuntu1.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `one_story_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE IF NOT EXISTS `assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attachable_id` int(11) DEFAULT NULL,
  `attachable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `src_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `src_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `src_file_size` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `src_updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=92 ;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`id`, `attachable_id`, `attachable_type`, `src_file_name`, `src_content_type`, `src_file_size`, `src_updated_at`, `created_at`, `updated_at`, `user_id`) VALUES
(1, NULL, NULL, 'W4.jpg', 'image/jpeg', '50252', '2013-12-12 12:40:20', '2013-12-12 07:10:20', '2013-12-12 07:10:20', 12),
(2, NULL, NULL, 'Om-151.jpg', 'image/jpeg', '889232', '2013-12-12 13:11:58', '2013-12-12 07:41:58', '2013-12-12 07:41:58', 12),
(3, NULL, NULL, 'om-667.jpg', 'image/jpeg', '184601', '2013-12-12 14:08:12', '2013-12-12 08:38:13', '2013-12-12 08:38:13', 12),
(4, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-12 14:12:37', '2013-12-12 08:42:40', '2013-12-12 08:42:40', 12),
(5, NULL, NULL, 'om-670.jpg', 'image/jpeg', '82408', '2013-12-12 14:58:17', '2013-12-12 09:28:18', '2013-12-12 09:28:18', 12),
(6, NULL, NULL, 'William Simpson - The Fort at Amber 1860.jpg', 'image/jpeg', '251029', '2013-12-12 17:17:52', '2013-12-12 11:47:52', '2013-12-12 11:47:52', 12),
(7, NULL, NULL, 'om-662.jpg', 'image/jpeg', '178509', '2013-12-12 17:55:40', '2013-12-12 12:25:41', '2013-12-12 12:25:41', 12),
(8, NULL, NULL, 'fullscreen.jpg', 'image/jpeg', '119859', '2013-12-12 18:00:57', '2013-12-12 12:30:57', '2013-12-12 12:30:57', 12),
(9, NULL, NULL, 'Anmol Vachan1439.jpg', 'image/jpeg', '157569', '2013-12-12 19:00:13', '2013-12-12 13:30:14', '2013-12-12 13:30:14', 12),
(10, NULL, NULL, '20080723170044.JPG', 'image/jpeg', '1107396', '2013-12-12 19:53:42', '2013-12-12 14:23:44', '2013-12-12 14:23:44', 12),
(11, NULL, NULL, 'om-662.jpg', 'image/jpeg', '178509', '2013-12-13 10:59:37', '2013-12-13 05:29:38', '2013-12-13 05:29:38', 12),
(12, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 11:02:50', '2013-12-13 05:32:50', '2013-12-13 05:32:50', 12),
(13, NULL, NULL, 'om-667.jpg', 'image/jpeg', '184601', '2013-12-13 11:54:11', '2013-12-13 06:24:11', '2013-12-13 06:24:11', 12),
(14, NULL, NULL, 'om-662.jpg', 'image/jpeg', '178509', '2013-12-13 11:57:35', '2013-12-13 06:27:36', '2013-12-13 06:27:36', 12),
(15, NULL, NULL, 'om-670.jpg', 'image/jpeg', '82408', '2013-12-13 12:01:58', '2013-12-13 06:31:59', '2013-12-13 06:31:59', 12),
(16, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 12:03:47', '2013-12-13 06:33:49', '2013-12-13 06:33:49', 12),
(17, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 12:04:24', '2013-12-13 06:34:26', '2013-12-13 06:34:26', 12),
(18, NULL, NULL, 'ganesha-525.jpg', 'image/jpeg', '222967', '2013-12-13 12:05:41', '2013-12-13 06:35:41', '2013-12-13 06:35:41', 12),
(19, NULL, NULL, 'om-662.jpg', 'image/jpeg', '178509', '2013-12-13 12:08:35', '2013-12-13 06:38:35', '2013-12-13 06:38:35', 12),
(20, NULL, NULL, 'ganesha-525.jpg', 'image/jpeg', '222967', '2013-12-13 12:09:18', '2013-12-13 06:39:18', '2013-12-13 06:39:18', 12),
(21, NULL, NULL, 'ganesha-525.jpg', 'image/jpeg', '222967', '2013-12-13 12:10:30', '2013-12-13 06:40:30', '2013-12-13 06:40:30', 12),
(22, NULL, NULL, 'ganesha-525.jpg', 'image/jpeg', '222967', '2013-12-13 12:12:11', '2013-12-13 06:42:12', '2013-12-13 06:42:12', 12),
(23, NULL, NULL, 'om-653.jpg', 'image/jpeg', '203899', '2013-12-13 12:27:56', '2013-12-13 06:57:57', '2013-12-13 06:57:57', 12),
(24, NULL, NULL, 'om-653.jpg', 'image/jpeg', '203899', '2013-12-13 12:28:27', '2013-12-13 06:58:27', '2013-12-13 06:58:27', 12),
(25, NULL, NULL, 'Om-151.jpg', 'image/jpeg', '889232', '2013-12-13 12:29:13', '2013-12-13 06:59:14', '2013-12-13 06:59:14', 12),
(26, NULL, NULL, 'ganesha-525.jpg', 'image/jpeg', '222967', '2013-12-13 12:29:18', '2013-12-13 06:59:19', '2013-12-13 06:59:19', 12),
(27, NULL, NULL, 'om-662.jpg', 'image/jpeg', '178509', '2013-12-13 12:31:02', '2013-12-13 07:01:03', '2013-12-13 07:01:03', 12),
(28, NULL, NULL, 'om-667.jpg', 'image/jpeg', '184601', '2013-12-13 12:32:41', '2013-12-13 07:02:41', '2013-12-13 07:02:41', 12),
(29, NULL, NULL, 'om-662.jpg', 'image/jpeg', '178509', '2013-12-13 12:33:41', '2013-12-13 07:03:41', '2013-12-13 07:03:41', 12),
(30, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 12:34:27', '2013-12-13 07:04:27', '2013-12-13 07:04:27', 12),
(31, NULL, NULL, '20080720181241.jpg', 'image/jpeg', '1979144', '2013-12-13 12:41:05', '2013-12-13 07:11:06', '2013-12-13 07:11:06', 12),
(32, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 12:54:58', '2013-12-13 07:24:58', '2013-12-13 07:24:58', 12),
(33, NULL, NULL, 'download1.png', 'image/png', '180423', '2013-12-13 13:01:21', '2013-12-13 07:31:22', '2013-12-13 07:31:22', 12),
(34, NULL, NULL, 'download.png', 'image/png', '1905740', '2013-12-13 13:18:08', '2013-12-13 07:48:09', '2013-12-13 07:48:09', 12),
(35, NULL, NULL, 'download.jpeg', 'image/jpeg', '225547', '2013-12-13 13:19:14', '2013-12-13 07:49:15', '2013-12-13 07:49:15', 12),
(36, NULL, NULL, 'om-667.jpg', 'image/jpeg', '184601', '2013-12-13 13:27:57', '2013-12-13 07:57:58', '2013-12-13 07:57:58', 12),
(37, NULL, NULL, 'fullscreen.jpg', 'image/jpeg', '119859', '2013-12-13 14:07:34', '2013-12-13 08:37:34', '2013-12-13 08:37:34', 12),
(38, NULL, NULL, '2010_mavericks_competition.jpg', 'image/jpeg', '2456008', '2013-12-13 14:10:24', '2013-12-13 08:40:26', '2013-12-13 08:40:26', 12),
(39, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 14:10:46', '2013-12-13 08:40:49', '2013-12-13 08:40:49', 12),
(40, NULL, NULL, '2010_mavericks_competition.jpg', 'image/jpeg', '2456008', '2013-12-13 14:11:50', '2013-12-13 08:41:52', '2013-12-13 08:41:52', 12),
(41, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 14:15:37', '2013-12-13 08:45:39', '2013-12-13 08:45:39', 12),
(42, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 14:27:37', '2013-12-13 08:57:39', '2013-12-13 08:57:39', 12),
(43, NULL, NULL, 'download.png', 'image/png', '1905740', '2013-12-13 15:00:13', '2013-12-13 09:30:14', '2013-12-13 09:30:14', 12),
(44, NULL, NULL, 'download2.png', 'image/png', '423568', '2013-12-13 15:34:15', '2013-12-13 10:04:15', '2013-12-13 10:04:15', 12),
(45, NULL, NULL, 'download.png', 'image/png', '1905740', '2013-12-13 15:36:44', '2013-12-13 10:06:45', '2013-12-13 10:06:45', 12),
(46, NULL, NULL, 'ganesha-525.jpg', 'image/jpeg', '222967', '2013-12-13 15:46:09', '2013-12-13 10:16:10', '2013-12-13 10:16:10', 12),
(47, NULL, NULL, 'om-662.jpg', 'image/jpeg', '178509', '2013-12-13 15:48:03', '2013-12-13 10:18:03', '2013-12-13 10:18:03', 12),
(48, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 15:50:51', '2013-12-13 10:20:51', '2013-12-13 10:20:51', 12),
(49, NULL, NULL, 'om-662.jpg', 'image/jpeg', '178509', '2013-12-13 15:51:55', '2013-12-13 10:21:56', '2013-12-13 10:21:56', 12),
(50, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 15:52:43', '2013-12-13 10:22:45', '2013-12-13 10:22:45', 12),
(51, NULL, NULL, 'download.png', 'image/png', '1905740', '2013-12-13 15:53:36', '2013-12-13 10:23:37', '2013-12-13 10:23:37', 12),
(52, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 15:54:32', '2013-12-13 10:24:33', '2013-12-13 10:24:33', 12),
(53, NULL, NULL, 'om-662.jpg', 'image/jpeg', '178509', '2013-12-13 15:55:31', '2013-12-13 10:25:32', '2013-12-13 10:25:32', 12),
(54, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 15:56:21', '2013-12-13 10:26:23', '2013-12-13 10:26:23', 12),
(55, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 15:57:45', '2013-12-13 10:27:47', '2013-12-13 10:27:47', 12),
(56, NULL, NULL, 'om-653.jpg', 'image/jpeg', '203899', '2013-12-13 16:00:12', '2013-12-13 10:30:13', '2013-12-13 10:30:13', 12),
(57, NULL, NULL, 'om-662.jpg', 'image/jpeg', '178509', '2013-12-13 16:10:27', '2013-12-13 10:40:28', '2013-12-13 10:40:28', 12),
(58, NULL, NULL, 'shine-om-image-487.jpg', 'image/jpeg', '88654', '2013-12-13 16:10:56', '2013-12-13 10:40:57', '2013-12-13 10:40:57', 12),
(59, NULL, NULL, 'W4.jpg', 'image/jpeg', '50252', '2013-12-13 16:11:33', '2013-12-13 10:41:33', '2013-12-13 10:41:33', 12),
(60, NULL, NULL, 'om-670.jpg', 'image/jpeg', '82408', '2013-12-13 16:19:46', '2013-12-13 10:49:47', '2013-12-13 10:49:47', 12),
(61, NULL, NULL, 'om-667.jpg', 'image/jpeg', '184601', '2013-12-13 16:21:31', '2013-12-13 10:51:32', '2013-12-13 10:51:32', 12),
(62, NULL, NULL, 'om-662.jpg', 'image/jpeg', '178509', '2013-12-13 16:43:34', '2013-12-13 11:13:35', '2013-12-13 11:13:35', 12),
(63, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 16:44:37', '2013-12-13 11:14:37', '2013-12-13 11:14:37', 12),
(64, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 16:49:31', '2013-12-13 11:19:33', '2013-12-13 11:19:33', 12),
(65, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 16:50:21', '2013-12-13 11:20:21', '2013-12-13 11:20:21', 12),
(66, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 16:50:56', '2013-12-13 11:20:59', '2013-12-13 11:20:59', 12),
(67, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 16:57:01', '2013-12-13 11:27:02', '2013-12-13 11:27:02', 12),
(68, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 16:58:03', '2013-12-13 11:28:04', '2013-12-13 11:28:04', 12),
(69, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 16:59:54', '2013-12-13 11:29:55', '2013-12-13 11:29:55', 12),
(70, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 17:00:32', '2013-12-13 11:30:32', '2013-12-13 11:30:32', 12),
(71, NULL, NULL, 'fullscreen.jpg', 'image/jpeg', '119859', '2013-12-13 17:03:48', '2013-12-13 11:33:48', '2013-12-13 11:33:48', 12),
(72, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 17:04:33', '2013-12-13 11:34:33', '2013-12-13 11:34:33', 12),
(73, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 17:05:21', '2013-12-13 11:35:23', '2013-12-13 11:35:23', 12),
(74, NULL, NULL, 'download1.png', 'image/png', '180423', '2013-12-13 17:06:46', '2013-12-13 11:36:46', '2013-12-13 11:36:46', 12),
(75, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 17:19:29', '2013-12-13 11:49:31', '2013-12-13 11:49:31', 12),
(76, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 17:33:35', '2013-12-13 12:03:38', '2013-12-13 12:03:38', 12),
(77, NULL, NULL, 'shine-om-image-487.jpg', 'image/jpeg', '88654', '2013-12-13 17:42:19', '2013-12-13 12:12:19', '2013-12-13 12:12:19', 12),
(78, NULL, NULL, 'Om-151.jpg', 'image/jpeg', '889232', '2013-12-13 17:48:20', '2013-12-13 12:18:21', '2013-12-13 12:18:21', 12),
(79, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 17:49:31', '2013-12-13 12:19:32', '2013-12-13 12:19:32', 12),
(80, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 18:02:09', '2013-12-13 12:32:11', '2013-12-13 12:32:11', 12),
(81, NULL, NULL, 'IMG_6686_zpsf8837942.jpg', 'image/jpeg', '6061111', '2013-12-13 18:04:37', '2013-12-13 12:34:39', '2013-12-13 12:34:39', 12),
(82, NULL, NULL, '2010_mavericks_competition.jpg', 'image/jpeg', '2456008', '2013-12-13 18:19:16', '2013-12-13 12:49:18', '2013-12-13 12:49:18', 12),
(83, NULL, NULL, 'om-670.jpg', 'image/jpeg', '82408', '2013-12-13 18:21:41', '2013-12-13 12:51:41', '2013-12-13 12:51:41', 12),
(84, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 18:25:05', '2013-12-13 12:55:05', '2013-12-13 12:55:05', 12),
(85, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 18:27:43', '2013-12-13 12:57:44', '2013-12-13 12:57:44', 12),
(86, NULL, NULL, 'om-667.jpg', 'image/jpeg', '184601', '2013-12-13 18:28:28', '2013-12-13 12:58:29', '2013-12-13 12:58:29', 12),
(87, NULL, NULL, '2010_mavericks_competition.jpg', 'image/jpeg', '2456008', '2013-12-13 18:37:17', '2013-12-13 13:07:19', '2013-12-13 13:07:19', 12),
(88, NULL, NULL, 'om-662.jpg', 'image/jpeg', '178509', '2013-12-13 18:40:50', '2013-12-13 13:10:51', '2013-12-13 13:10:51', 12),
(89, NULL, NULL, 'om-653.jpg', 'image/jpeg', '203899', '2013-12-13 18:41:31', '2013-12-13 13:11:31', '2013-12-13 13:11:31', 12),
(90, NULL, NULL, 'om-653.jpg', 'image/jpeg', '203899', '2013-12-13 18:43:43', '2013-12-13 13:13:43', '2013-12-13 13:13:43', 12),
(91, NULL, NULL, 'Meditation--701.jpg', 'image/jpeg', '536773', '2013-12-13 18:50:08', '2013-12-13 13:20:09', '2013-12-13 13:20:09', 12);

-- --------------------------------------------------------

--
-- Table structure for table `authentications`
--

CREATE TABLE IF NOT EXISTS `authentications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE IF NOT EXISTS `banners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `photo_file_name` varchar(255) DEFAULT NULL,
  `photo_content_type` varchar(255) DEFAULT NULL,
  `photo_file_size` int(11) DEFAULT NULL,
  `photo_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`id`, `name`, `status`, `created_at`, `updated_at`, `photo_file_name`, `photo_content_type`, `photo_file_size`, `photo_updated_at`) VALUES
(1, '', 0, '2013-11-30 09:39:22', '2013-11-30 09:39:22', NULL, NULL, NULL, NULL),
(2, 'fffff', 0, '2013-12-12 12:47:53', '2013-12-12 12:47:53', 'om-667.jpg', 'image/jpeg', 184601, '2013-12-12 18:17:53');

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE IF NOT EXISTS `bookmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `story_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `bookmarks`
--

INSERT INTO `bookmarks` (`id`, `user_id`, `story_id`, `created_at`) VALUES
(1, 2, 7, '2013-05-01 11:53:04'),
(2, 12, 18, '2013-07-10 07:20:20'),
(3, 12, 32, '2014-01-23 10:41:03'),
(4, 12, 44, '2014-01-23 12:41:10'),
(5, 12, 52, '2014-03-28 10:32:24');

-- --------------------------------------------------------

--
-- Table structure for table `buzzs`
--

CREATE TABLE IF NOT EXISTS `buzzs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `from_user_id` int(11) DEFAULT NULL,
  `to_user_id` int(11) DEFAULT NULL,
  `root_id` int(11) DEFAULT NULL,
  `from_user_deleted` tinyint(1) DEFAULT NULL,
  `to_user_deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=17 ;

--
-- Dumping data for table `buzzs`
--

INSERT INTO `buzzs` (`id`, `subject`, `body`, `from_user_id`, `to_user_id`, `root_id`, `from_user_deleted`, `to_user_deleted`, `created_at`, `updated_at`) VALUES
(1, 'Error', 'Rails Error', 12, 2, 1, NULL, NULL, '2013-07-08 06:07:20', '2013-07-08 06:07:20'),
(2, '', '', 12, 12, 2, NULL, NULL, '2013-07-10 07:20:04', '2013-07-10 07:20:04'),
(3, '', '', 12, 47, 3, NULL, NULL, '2014-03-03 06:00:16', '2014-03-03 06:00:16'),
(4, '', '', 12, 47, 4, NULL, NULL, '2014-03-03 06:36:15', '2014-03-03 06:36:15'),
(5, 'hi', 'hello', 12, 47, 5, NULL, NULL, '2014-03-03 06:38:22', '2014-03-03 06:38:22'),
(6, 'hi', 'hello', 12, 47, 6, NULL, NULL, '2014-03-03 07:03:52', '2014-03-03 07:03:52'),
(7, 'hi', 'hello', 12, 47, 7, NULL, NULL, '2014-03-03 07:11:45', '2014-03-03 07:11:45'),
(8, 'hi', 'hello', 12, 47, 8, NULL, NULL, '2014-03-03 07:13:14', '2014-03-03 07:13:14'),
(9, 'hi test', 'hello test', 12, 47, 9, NULL, NULL, '2014-03-03 07:15:39', '2014-03-03 07:15:39'),
(10, 'my test', 'my test', 12, 47, 10, NULL, NULL, '2014-03-03 07:17:47', '2014-03-03 07:17:47'),
(11, 'working', 'working', 12, 47, 11, NULL, NULL, '2014-03-03 07:27:18', '2014-03-03 07:27:18'),
(12, 'working', 'working', 12, 47, 12, NULL, NULL, '2014-03-03 07:29:06', '2014-03-03 07:29:06'),
(13, 'working', 'working', 12, 47, 13, NULL, NULL, '2014-03-03 08:19:22', '2014-03-03 08:19:22'),
(14, 'hi', 'hi', 12, 47, 14, NULL, NULL, '2014-03-03 08:20:26', '2014-03-03 08:20:26'),
(15, 'hi', 'hi', 12, 47, 15, NULL, NULL, '2014-03-03 08:44:56', '2014-03-03 08:44:56'),
(16, 'hi', 'hi', 12, 47, 16, NULL, NULL, '2014-03-03 08:50:58', '2014-03-03 08:50:58');

-- --------------------------------------------------------

--
-- Table structure for table `data_files`
--

CREATE TABLE IF NOT EXISTS `data_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upload` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `geocodes`
--

CREATE TABLE IF NOT EXISTS `geocodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `latitude` decimal(15,12) DEFAULT NULL,
  `longitude` decimal(15,12) DEFAULT NULL,
  `query` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locality` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `region` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `precision` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `geocodes_query_index` (`query`),
  KEY `geocodes_longitude_index` (`longitude`),
  KEY `geocodes_latitude_index` (`latitude`),
  KEY `geocodes_locality_index` (`locality`),
  KEY `geocodes_region_index` (`region`),
  KEY `geocodes_postal_code_index` (`postal_code`),
  KEY `geocodes_country_index` (`country`),
  KEY `geocodes_precision_index` (`precision`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=19 ;

--
-- Dumping data for table `geocodes`
--

INSERT INTO `geocodes` (`id`, `latitude`, `longitude`, `query`, `street`, `locality`, `region`, `postal_code`, `country`, `precision`) VALUES
(1, NULL, NULL, 'n/a', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 42.310267600000, -83.094892000000, 'West Fort Street\nDetroit, MI US', 'West Fort Street', 'Detroit', 'MI', NULL, 'US', 'street'),
(4, 38.767384900000, -93.548820100000, 'East Lucas\nKnob Noster, MO 65336 US', 'East Lucas', 'Knob Noster', 'MO', '65336', 'US', 'street'),
(5, 39.181054900000, -78.202691000000, 'O''Keefe Drive\nWinchester, VA 22602 US', 'O''Keefe Drive', 'Winchester', 'VA', '22602', 'US', 'street'),
(6, 23.039567700000, 72.566004500000, 'Ahmedabad, Gujarat IN', NULL, 'Ahmedabad', 'Gujarat', NULL, 'IN', 'city'),
(7, 23.224819600000, 72.646376900000, 'Gandhinagar, Gujarat IN', NULL, 'Gandhinagar', 'Gujarat', NULL, 'IN', 'city'),
(8, 23.039567700000, 72.566004500000, '\nAhmedabad, GJ IN', NULL, 'Ahmedabad', 'GJ', NULL, 'IN', 'locality'),
(9, 22.307309500000, 73.181097600000, '\nVadodara, GJ IN', NULL, 'Vadodara', 'GJ', NULL, 'IN', 'locality'),
(10, 40.228528100000, -105.664714200000, '\nCO 80510 US', NULL, 'Allenspark', 'CO', '80510', 'US', 'postal_code'),
(11, 34.430165600000, -119.869669100000, '\nCA 93117 US', NULL, 'Goleta', 'CA', '93117', 'US', 'postal_code'),
(12, 41.521887800000, -111.162415900000, '\nWoodruff, UT 84086 US', NULL, 'Woodruff', 'UT', '84086', 'US', 'locality'),
(13, 40.940376200000, -74.131809600000, '\nFair Lawn, NJ US', NULL, 'Fair Lawn', 'NJ', NULL, 'US', 'locality'),
(14, 40.926849200000, -74.109178100000, 'Raphael St\nFair Lawn, NJ 07410 US', 'Raphael St', 'Fair Lawn', 'NJ', '07410', 'US', 'street'),
(15, 46.068844700000, -87.165973600000, '\nRock, MI 49880 US', NULL, 'Rock', 'MI', '49880', 'US', 'locality'),
(16, 45.061644600000, -99.512059100000, '\nSeneca, SD 57473 US', NULL, 'Seneca', 'SD', '57473', 'US', 'locality'),
(17, 34.420830500000, -119.698190100000, '\nSanta Barbara, CA US', NULL, 'Santa Barbara', 'CA', NULL, 'US', 'locality'),
(18, 24.721388900000, -77.789444400000, '\nAndros Town, North Andros BS', NULL, 'Andros Town', 'North Andros', NULL, 'BS', 'locality');

-- --------------------------------------------------------

--
-- Table structure for table `geocodings`
--

CREATE TABLE IF NOT EXISTS `geocodings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `geocodable_id` int(11) DEFAULT NULL,
  `geocode_id` int(11) DEFAULT NULL,
  `geocodable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `geocodings_geocodable_type_index` (`geocodable_type`),
  KEY `geocodings_geocode_id_index` (`geocode_id`),
  KEY `geocodings_geocodable_id_index` (`geocodable_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=96 ;

--
-- Dumping data for table `geocodings`
--

INSERT INTO `geocodings` (`id`, `geocodable_id`, `geocode_id`, `geocodable_type`, `created_at`) VALUES
(1, 2, 2, 'User', '2013-04-30 10:05:45'),
(2, 3, 3, 'User', '2013-04-30 10:05:49'),
(3, 10, 4, 'User', '2013-04-30 10:06:00'),
(4, 11, 5, 'User', '2013-04-30 10:06:03'),
(27, 6, 6, 'Story', '2013-04-30 10:57:22'),
(34, 3, 2, 'Story', '2013-04-30 11:03:11'),
(46, 8, 2, 'Story', '2013-04-30 11:15:04'),
(47, 2, 2, 'Story', '2013-04-30 11:15:33'),
(48, 1, 2, 'Story', '2013-04-30 11:15:55'),
(49, 5, 2, 'Story', '2013-04-30 11:16:20'),
(50, 9, 2, 'Story', '2013-04-30 11:16:53'),
(51, 13, 2, 'Story', '2013-04-30 11:17:26'),
(52, 12, 2, 'Story', '2013-04-30 12:58:50'),
(53, 11, 2, 'Story', '2013-04-30 12:59:17'),
(54, 4, 2, 'Story', '2013-04-30 13:00:05'),
(56, 10, 2, 'Story', '2013-04-30 13:05:13'),
(57, 7, 6, 'Story', '2013-05-01 11:43:46'),
(59, 14, 6, 'Story', '2013-05-23 11:36:17'),
(60, 15, 6, 'Story', '2013-07-08 06:01:07'),
(61, 16, 6, 'Story', '2013-07-08 06:02:31'),
(62, 17, 6, 'Story', '2013-07-08 06:12:37'),
(64, 31, 8, 'Story', '2013-11-11 12:13:47'),
(65, 32, 8, 'Story', '2013-11-11 12:15:52'),
(66, 44, 8, 'User', '2013-11-11 12:18:12'),
(67, 47, 8, 'User', '2013-11-11 12:22:06'),
(68, 33, 8, 'Story', '2013-11-11 12:25:10'),
(69, 12, 8, 'User', '2013-11-13 07:00:22'),
(70, 34, 9, 'Story', '2013-11-13 08:30:59'),
(71, 35, 10, 'Story', '2013-11-13 09:12:13'),
(72, 36, 10, 'Story', '2013-11-13 09:14:23'),
(73, 37, 11, 'Story', '2013-11-13 09:18:31'),
(74, 18, 8, 'Story', '2013-11-13 09:23:25'),
(75, 38, 12, 'Story', '2013-11-13 09:35:43'),
(78, 40, 15, 'Story', '2013-11-13 10:57:00'),
(79, 41, 16, 'Story', '2013-11-13 11:00:14'),
(80, 42, 17, 'Story', '2013-11-13 11:05:11'),
(81, 43, 8, 'Story', '2013-11-15 06:28:42'),
(82, 44, 8, 'Story', '2013-11-27 05:25:12'),
(83, 48, 8, 'User', '2013-11-27 07:02:43'),
(84, 49, 8, 'User', '2013-11-28 08:52:10'),
(85, 53, 18, 'User', '2013-12-02 05:42:25'),
(86, 45, 8, 'Story', '2013-12-12 07:49:28'),
(87, 46, 8, 'Story', '2013-12-12 12:26:49'),
(89, 48, 8, 'Story', '2013-12-13 05:30:24'),
(91, 50, 8, 'Story', '2013-12-13 05:37:20'),
(92, 58, 8, 'User', '2013-12-16 05:36:13'),
(93, 59, 8, 'User', '2013-12-16 10:45:08'),
(94, 51, 8, 'Story', '2013-12-17 12:48:33'),
(95, 52, 8, 'Story', '2014-03-28 10:29:45');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE IF NOT EXISTS `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `story_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=57 ;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `story_id`, `created_at`, `updated_at`) VALUES
(1, 2, 9, '2013-04-30 10:31:17', '2013-04-30 10:31:17'),
(38, 2, 7, '2013-05-01 13:27:03', '2013-05-01 13:27:03'),
(39, 2, 13, '2013-05-01 13:27:45', '2013-05-01 13:27:45'),
(40, 2, 10, '2013-05-01 13:28:08', '2013-05-01 13:28:08'),
(41, 2, 3, '2013-05-01 13:28:24', '2013-05-01 13:28:24'),
(44, 12, 14, '2013-07-08 05:57:25', '2013-07-08 05:57:25'),
(45, 12, 16, '2013-07-08 06:02:47', '2013-07-08 06:02:47'),
(46, 12, 6, '2013-07-08 06:07:47', '2013-07-08 06:07:47'),
(47, 12, 17, '2013-07-08 06:12:47', '2013-07-08 06:12:47'),
(48, 12, 15, '2013-07-08 06:12:55', '2013-07-08 06:12:55'),
(52, 12, 48, '2014-01-23 10:41:27', '2014-01-23 10:41:27'),
(53, 12, 46, '2014-01-23 10:41:44', '2014-01-23 10:41:44'),
(54, 12, 18, '2014-01-23 10:52:45', '2014-01-23 10:52:45'),
(56, 12, 52, '2014-03-28 10:32:49', '2014-03-28 10:32:49');

-- --------------------------------------------------------

--
-- Table structure for table `paragraphs`
--

CREATE TABLE IF NOT EXISTS `paragraphs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `story_id` int(11) DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'admin'),
(2, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `roles_users`
--

CREATE TABLE IF NOT EXISTS `roles_users` (
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  KEY `index_roles_users_on_role_id` (`role_id`),
  KEY `index_roles_users_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `roles_users`
--

INSERT INTO `roles_users` (`role_id`, `user_id`) VALUES
(1, 1),
(1, 12),
(2, 44),
(2, 47),
(2, 48),
(2, 49),
(2, 50),
(2, 51),
(2, 52),
(2, 53),
(2, 54),
(2, 55),
(2, 56),
(2, 57),
(2, 58),
(2, 59);

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20090701185153'),
('20090701185154'),
('20090701185155'),
('20090701185157'),
('20090701201438'),
('20090701201818'),
('20090701204158'),
('20090729214355'),
('20090816075831'),
('20090818041916'),
('20090921181106'),
('20090921210257'),
('20110924230220'),
('20120122233303'),
('20120125221433'),
('20121018064128'),
('20121106094939'),
('20131115063810'),
('20131115064919'),
('20131119100513'),
('20131119100820'),
('20131120064612'),
('20131127045346'),
('20131128054835'),
('20131128074422'),
('20131205052848'),
('20131227071356'),
('20131227071927'),
('20131227073100'),
('20131227094730'),
('20131231065939');

-- --------------------------------------------------------

--
-- Table structure for table `simple_captcha_data`
--

CREATE TABLE IF NOT EXISTS `simple_captcha_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(40) DEFAULT NULL,
  `value` varchar(6) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Dumping data for table `simple_captcha_data`
--

INSERT INTO `simple_captcha_data` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'ee24d73892f5f50e298beb41e7182cb4a2790d6f', 'AIZMKW', '2013-12-17 04:45:20', '2013-12-17 04:45:20'),
(2, '3c1ac68128e98d6700d69854239ca70b0773f6b9', 'XRNAGM', '2013-12-17 13:16:59', '2013-12-17 13:16:59'),
(3, 'c49c41312f1ccc173b37869e53a19e3f06786f47', 'PUDZEZ', '2013-12-18 05:17:32', '2013-12-18 05:17:32'),
(4, '26913bb720f5eb01c72a765375255bd10644037f', 'XGBLRV', '2013-12-18 05:33:49', '2013-12-18 05:33:49'),
(5, '8cd2fec7c5fba07ac4d1115bb2a3d091114ff3ea', 'JRELTE', '2013-12-18 09:35:51', '2013-12-18 09:37:57'),
(6, '5289f0952cf5a06ab7061cb22346616801d5ac1b', 'TCSSGL', '2013-12-19 04:31:54', '2013-12-19 04:31:54'),
(7, '020a10bbccf8669b8ee55c25a55e76be95a60380', 'QWUETI', '2013-12-20 04:42:19', '2013-12-20 04:42:19'),
(8, 'ada08c270acb0d16c25d2ef4586fb07e31b3f296', 'BKGUIW', '2013-12-23 09:07:59', '2013-12-23 09:07:59'),
(9, '021aded3264513068d3216d32bd0f48d10b61382', 'KOZJVY', '2013-12-27 05:23:07', '2013-12-27 05:23:07'),
(10, '82131be0e0f50ec738df8ea9a0f7997cb478141d', 'VBIDKS', '2013-12-31 09:47:49', '2013-12-31 09:47:49'),
(11, '45275e25d5d8193e3efa9b885861a845dfb40dcb', 'NOZZJS', '2014-01-06 10:19:51', '2014-01-06 10:19:51'),
(12, '3bacdb513d53ba32d9cf6e93b7cd23d223420214', 'TGFNJJ', '2014-01-08 05:54:05', '2014-01-08 05:54:05'),
(13, '52ae6ec831616c4e8da98a25eafbed49656e1870', 'RLSRNV', '2014-01-20 07:52:15', '2014-01-20 08:31:05'),
(14, '8f0b994b5760c7a3956b415876fc2c33bc589418', 'TXRNNG', '2014-01-21 10:14:54', '2014-01-21 10:14:54'),
(15, '3eec46d785b9c43d9ed9f16cab566b5513566d89', 'VMSOFA', '2014-01-23 04:57:47', '2014-01-23 04:57:47'),
(16, '3d45ab4e03c6f324291af55c936237560c03d7c0', 'YIYKEW', '2014-01-23 05:37:36', '2014-01-23 05:37:36'),
(17, '0fa868caf7dd898802bfc552e8a16da98a7f53a0', 'NNYCOV', '2014-01-23 06:16:50', '2014-01-23 06:30:03'),
(18, 'ccbb92367fcb4ddd8475dc8c21f1d862be96ba1a', 'NBRYNH', '2014-01-23 06:20:03', '2014-01-23 06:20:03'),
(19, 'becb1f9966546d84b58c2d481e66f51286f5ac30', 'FVQTAM', '2014-01-23 10:02:17', '2014-01-23 11:54:24'),
(20, '6578cd188e0cf9a0b2697c162eccf46a4d684120', 'ACNKOQ', '2014-01-23 12:19:32', '2014-01-23 12:19:32'),
(21, 'd334b93512bef1d5c78ade5ad5926ac12cd60ca3', 'WCHMDI', '2014-01-23 12:40:37', '2014-01-23 12:40:37'),
(22, '58edc6317fca283b1dbcfc50151370323d4c0a6f', 'MFZQBL', '2014-01-23 13:29:32', '2014-01-23 13:29:32'),
(23, 'a149a10e16dd7b6ecf9fc7e313543fc5159542c2', 'PILQWZ', '2014-01-23 13:31:31', '2014-01-23 13:31:31'),
(24, '25e5fef6c241b5c6937be779ca4d3c23857287c5', 'IIRSVS', '2014-01-29 09:13:32', '2014-01-29 09:13:32'),
(25, '55717ac8e69737a44279631b93e67460eed6f324', 'VJHUVB', '2014-01-29 09:19:42', '2014-01-29 09:19:42'),
(26, '24428ef8e2b258fe1b88a4a8a6871cda1b482890', 'PHLFXK', '2014-03-03 05:03:59', '2014-03-03 05:03:59'),
(27, 'a7d537206d49b6d65f38a2010170098a17d9f6d7', 'ASHDLH', '2014-03-03 05:55:28', '2014-03-03 05:55:28'),
(28, 'e7ba13f0a3682b4a8678649af214729c76b605c0', 'UROOLE', '2014-03-25 10:46:32', '2014-03-25 10:46:32'),
(29, '3d6985992e663968e254acfc03f18a11201ea955', 'VEUXDQ', '2014-03-26 06:45:09', '2014-03-26 06:45:09'),
(30, '95af093e73475f785bd140d5f073fd6b83489575', 'CNMSTU', '2014-03-28 10:26:32', '2014-03-28 10:26:32'),
(31, '90dd33b1e35b41273975fefbd7933850bf399efc', 'DFKNZX', '2014-03-28 10:28:25', '2014-03-28 10:28:25'),
(32, '2122a523626e7cf9835cfd6a1aba674dfbc3f7f0', 'JIOTDF', '2014-03-28 10:34:42', '2014-03-28 10:34:42');

-- --------------------------------------------------------

--
-- Table structure for table `stories`
--

CREATE TABLE IF NOT EXISTS `stories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `age` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fiction` tinyint(1) DEFAULT NULL,
  `year` bigint(20) DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author_location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `use_author_location` tinyint(1) DEFAULT NULL,
  `anonymous` tinyint(1) DEFAULT '0',
  `published` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `featured_at` datetime DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media_file_size` int(11) DEFAULT NULL,
  `media_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=53 ;

--
-- Dumping data for table `stories`
--

INSERT INTO `stories` (`id`, `user_id`, `title`, `path`, `subject`, `age`, `gender`, `fiction`, `year`, `location`, `author_location`, `use_author_location`, `anonymous`, `published`, `created_at`, `updated_at`, `featured_at`, `body`, `state`, `country`, `media_file_name`, `media_content_type`, `media_file_size`, `media_updated_at`) VALUES
(1, 2, 'Story 1', 'story_1', 'Story', '25', 'Male', NULL, 2013, 'Ahmedabad', NULL, 1, 0, 1, '2013-04-30 10:08:28', '2013-04-30 11:15:55', NULL, '<p>This is a test story</p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(2, 2, 'Story 2', 'story_2', 'Story', '25', 'Male', NULL, 2013, 'Ahmedabad', NULL, 1, 0, 1, '2013-04-30 10:09:10', '2013-04-30 11:15:33', NULL, '<p>Test story 2</p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(3, 2, 'Story 3', 'story_3', 'Story', '25', 'Male', NULL, 2013, 'Ahmedabad', NULL, 1, 0, 1, '2013-04-30 10:10:09', '2013-04-30 11:03:11', NULL, '<p>Test again</p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(4, 2, 'Story 4', 'story_4', 'Story', '25', 'Male', NULL, 2013, 'Ahmedabad', NULL, 1, 0, 1, '2013-04-30 10:10:57', '2013-04-30 13:00:05', NULL, '<p>test it again</p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(5, 2, 'Story 5', 'story_5', 'Story', '25', 'Male', NULL, 2013, 'Ahmedabad', NULL, 1, 0, 1, '2013-04-30 10:11:59', '2013-04-30 11:16:20', NULL, '<p>test, again, story, test, again, story, test, again, story, test, again, story</p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(6, 2, 'Rails errors', 'rails_errors', 'Story', '25', 'Male', NULL, 2013, 'Ahmedabad', NULL, 0, 0, 1, '2013-04-30 10:15:51', '2013-04-30 10:57:22', NULL, '<p>I''m getting this error when running the development environment through RubyMine 3.1. The mysql gem is attached, it''s running off of Bundler.</p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(7, 2, 'Rails', 'rails', 'Story', '25', 'Male', NULL, 2013, 'Ahmedabad', NULL, 0, 0, 1, '2013-04-30 10:24:19', '2013-05-01 11:43:46', NULL, '<p>I''m getting this error when running the development environment through RubyMine 3.1. The mysql gem is attached, it''s running off of Bundler.I''m getting this error when running the development environment through RubyMine 3.1. The mysql gem is attached, it''s running off of Bundler.I''m getting this error when running the development environment through RubyMine 3.1. The mysql gem is attached, it''s running off of Bundler.I''m getting this error when running the development environment through RubyMine 3.1. The mysql gem is attached, it''s running off of Bundler.I''m getting this error when running the development environment through RubyMine 3.1. The mysql gem is attached, it''s running off of Bundler.I''m getting this error when running the development environment through RubyMine 3.1. The mysql gem is attached, it''s running off of Bundler.</p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(8, 2, 'Story 7', 'story_7', 'Story', '25', 'Male', NULL, 2013, 'Ahmedabad', NULL, 1, 0, 1, '2013-04-30 10:27:28', '2013-04-30 11:15:04', NULL, '<p>dpa''s war stories, creation, destruction</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>dpa''s war stories, creation, destruction</p>\r\n<p>&nbsp;</p>\r\n<p>dpa''s war stories, creation, destruction</p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(9, 2, 'gistfile1.txt', 'gistfile1txt', 'Story', '25', 'Male', NULL, 2013, 'Ahmedabad', NULL, 1, 0, 1, '2013-04-30 10:30:52', '2013-04-30 11:16:53', NULL, '<div id="file-gistfile1-txt-LC9" class="line">/Users/username/.rvm/gems/ruby-1.8.7-p302/gems/activesupport-2.3.4/lib/active_support/dependencies.rb:440:in `load_missing_constant''</div>\r\n<div id="file-gistfile1-txt-LC10" class="line">/Users/username/.rvm/gems/ruby-1.8.7-p302/gems/activesupport-2.3.4/lib/active_support/dependencies.rb:80:in `const_missing''</div>\r\n<div id="file-gistfile1-txt-LC11" class="line">/Users/username/.rvm/gems/ruby-1.8.7-p302/gems/activerecord-2.3.4/lib/active_record/connection_adapters/mysql_adapter.rb:9:in `define_all_hashes_method!''</div>\r\n<div id="file-gistfile1-txt-LC12" class="line">&nbsp;</div>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(10, 2, 'Rails guide', 'rails_guide', 'Story', '25', 'Male', NULL, 2013, 'Ahmedabad', NULL, 1, 0, 1, '2013-04-30 10:58:38', '2013-04-30 13:05:13', NULL, '<p>As a first priority over CDA/CCD data delivery back to an EHR vendor we need to validate Phase 1 of the API, the ability for a vendor to SSO into HDA, and then the ability for a patient ID if we can establish a 1:1 match to what is in the HDA db, or if not match and provide the search screen to select from a list.&nbsp; I''ve attached the mock-up of that visualization.&nbsp;&nbsp; Please review and advise if you have any questions.&nbsp; I am pursuing several Epic knowledgeable resources to work with us on the vendor side of this equation.&nbsp; I should have information back from them shortly.&nbsp; I''d like to make certain we are on the same page in the behavior expected on the HDA side (attached).&nbsp; Is there any documentation that you can provide for what the vendor would need to know for this level of integration, or will you be working with what they are able to provide?</p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(11, 2, 'Rails, tutorial', 'rails_tutorial', 'Gandhinagar', '24', 'male', NULL, 2012, 'Ahmedabad', NULL, 1, 0, 1, '2013-04-30 11:00:36', '2013-04-30 12:59:17', NULL, '<h2>API - Test of SSO and Patient ID passing</h2>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(12, 2, 'Operator ', 'ternary_operator_', 'Story', '25', 'Male', NULL, 2013, 'Ahmedabad', NULL, 1, 0, 1, '2013-04-30 11:04:30', '2013-04-30 12:58:50', NULL, '<dl class="authored"><dt><span class="parameter">test</span></dt><dd>\r\n<p>Any Boolean expression.</p>\r\n</dd><dt><span class="parameter">expression1</span></dt><dd>\r\n<p>An expression returned if <span class="parameter">test</span> is <span><span class="input">true</span></span>. May be a comma expression.</p>\r\n</dd><dt><span class="parameter">expression2</span></dt><dd>\r\n<p>An expression returned if <span class="parameter">test</span> is <span><span class="input">false</span></span>. More than one expression may be a linked by a comma expression.</p>\r\n</dd></dl>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(13, 2, 'Operator rails ', 'ternary_operator_rails_', '', '', '', NULL, 2013, 'Ahmedabad', NULL, 1, 0, 1, '2013-04-30 11:09:48', '2013-04-30 11:17:26', NULL, '<p>operator operator operator operator operator operator operator</p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(14, 12, 'anonymous story', 'anonymous_story', '', '', '', NULL, 2013, 'ahmedabad', NULL, 1, 1, 1, '2013-05-23 11:36:15', '2013-05-23 11:36:31', NULL, '<p>this is anonymous</p>', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(15, 12, 'Harmony', 'harmony', 'Harmony', '', 'Male', NULL, 2013, 'Ahmedabad', NULL, 1, 0, 0, '2013-07-08 06:01:06', '2013-07-08 06:01:07', NULL, '<p>In <a title="Music" href="http://en.wikipedia.org/wiki/Music">music</a>, <strong>harmony</strong> is the use of simultaneous <a title="Pitch (music)" href="http://en.wikipedia.org/wiki/Pitch_%28music%29">pitches</a> (<a class="mw-redirect" title="Tone (music)" href="http://en.wikipedia.org/wiki/Tone_%28music%29">tones</a>, <a class="mw-redirect" title="Note (music)" href="http://en.wikipedia.org/wiki/Note_%28music%29">notes</a>), or <a title="Chord (music)" href="http://en.wikipedia.org/wiki/Chord_%28music%29">chords</a>.<sup id="cite_ref-1" class="reference"><a href="http://en.wikipedia.org/wiki/Harmony#cite_note-1"><span>[</span>1<span>]</span></a></sup> The study of harmony involves chords and their construction and <a title="Chord progression" href="http://en.wikipedia.org/wiki/Chord_progression">chord progressions</a> and the principles of connection that govern them.<sup id="cite_ref-2" class="reference"><a href="http://en.wikipedia.org/wiki/Harmony#cite_note-2"><span>[</span>2<span>]</span></a></sup> Harmony is often said to refer to the "vertical" aspect of music, as distinguished from <a title="Melody" href="http://en.wikipedia.org/wiki/Melody">melodic line</a>, or the "horizontal" aspect.<sup id="cite_ref-Jamini_3-0" class="reference"><a href="http://en.wikipedia.org/wiki/Harmony#cite_note-Jamini-3"><span>[</span>3<span>]</span></a></sup> <a title="Counterpoint" href="http://en.wikipedia.org/wiki/Counterpoint">Counterpoint</a>, which refers to the interweaving of melodic lines, and <a title="Polyphony" href="http://en.wikipedia.org/wiki/Polyphony">polyphony</a>, which refers to the relationship of separate independent voices, are thus sometimes distinguished from harmony.</p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(16, 12, 'Music', 'music', 'Music', '', 'Male', NULL, 2013, 'Ahmedabad', NULL, 0, 0, 1, '2013-07-08 06:02:30', '2013-07-08 08:49:59', NULL, '<p><strong>Music</strong> is an <a title="Art" href="http://en.wikipedia.org/wiki/Art">art</a> form whose <a class="mw-redirect" title="Media (arts)" href="http://en.wikipedia.org/wiki/Media_%28arts%29">medium</a> is <a title="Sound" href="http://en.wikipedia.org/wiki/Sound">sound</a> and silence. Its common elements are <a title="Pitch (music)" href="http://en.wikipedia.org/wiki/Pitch_%28music%29">pitch</a> (which governs <a title="Melody" href="http://en.wikipedia.org/wiki/Melody">melody</a> and <a title="Harmony" href="http://en.wikipedia.org/wiki/Harmony">harmony</a>), <a title="Rhythm" href="http://en.wikipedia.org/wiki/Rhythm">rhythm</a> (and its associated concepts <a title="Tempo" href="http://en.wikipedia.org/wiki/Tempo">tempo</a>, <a title="Meter (music)" href="http://en.wikipedia.org/wiki/Meter_%28music%29">meter</a>, and <a title="Articulation (music)" href="http://en.wikipedia.org/wiki/Articulation_%28music%29">articulation</a>), <a title="Dynamics (music)" href="http://en.wikipedia.org/wiki/Dynamics_%28music%29">dynamics</a>, and the sonic qualities of <a title="Timbre" href="http://en.wikipedia.org/wiki/Timbre">timbre</a> and <a title="Texture (music)" href="http://en.wikipedia.org/wiki/Texture_%28music%29">texture</a>. The word derives from <a title="Greek language" href="http://en.wikipedia.org/wiki/Greek_language">Greek</a> <em><a class="extiw" title="wikt:&mu;&omicron;&upsilon;&sigma;&iota;&kappa;ή" href="http://en.wiktionary.org/wiki/%CE%BC%CE%BF%CF%85%CF%83%CE%B9%CE%BA%CE%AE#Ancient_Greek">&mu;&omicron;&upsilon;&sigma;&iota;&kappa;ή</a></em> (<em>mousike</em>; "art of the <a class="mw-redirect" title="Muses" href="http://en.wikipedia.org/wiki/Muses">Muses</a>").<sup id="cite_ref-1" class="reference"><a href="http://en.wikipedia.org/wiki/Music#cite_note-1"><span>[</span>1<span>]</span></a></sup></p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(17, 12, 'Software testing', 'software_testing', '', '', '', NULL, 2013, 'Ahmedabad', NULL, 1, 0, 1, '2013-07-08 06:12:37', '2013-07-08 06:15:50', NULL, '<p><strong>Software testing</strong> is an investigation conducted to provide stakeholders with information about the quality of the product or service under test.<sup id="cite_ref-1" class="reference"><a href="http://en.wikipedia.org/wiki/Software_testing#cite_note-1"><span>[</span>1<span>]</span></a></sup> Software testing can also provide an objective, independent view of the software to allow the business to appreciate and understand the risks of software implementation. Test techniques include, but are not limited to, the process of executing a program or application with the intent of finding <a title="Software bug" href="http://en.wikipedia.org/wiki/Software_bug">software bugs</a> (errors or other defects).</p>', 'Gujarat', 'India', NULL, NULL, NULL, NULL),
(18, 12, 'Agile', 'agile', '', '', '', NULL, 2013, 'ahmedabad', NULL, 0, 0, 1, '2013-07-08 06:14:34', '2013-11-13 09:23:25', NULL, '<p><strong>Agile software development</strong> is a group of <a class="mw-redirect" title="Software development methodologies" href="http://en.wikipedia.org/wiki/Software_development_methodologies">software development methods</a> based on <a title="Iterative and incremental development" href="http://en.wikipedia.org/wiki/Iterative_and_incremental_development">iterative and incremental development</a>, where requirements and solutions evolve through collaboration between <a title="Self-organization" href="http://en.wikipedia.org/wiki/Self-organization#Self-organization_in_agile_software_development">self-organizing</a>, <a title="Cross-functional team" href="http://en.wikipedia.org/wiki/Cross-functional_team">cross-functional teams</a>. It promotes adaptive planning, evolutionary development and delivery, a <a title="Timeboxing" href="http://en.wikipedia.org/wiki/Timeboxing">time-boxed</a> iterative approach, and encourages rapid and flexible response to change. It is a conceptual framework that promotes foreseen interactions throughout the development cycle. The <em>Agile Manifesto</em><sup id="cite_ref-Agile_Manifesto_1-0" class="reference"><a href="http://en.wikipedia.org/wiki/Agile_software_development#cite_note-Agile_Manifesto-1"><span>[</span>1<span>]</span></a></sup> introduced the term in 2001.</p>', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(20, 44, 'priya test', 'priya_test', 'test', '25', 'female', NULL, 2013, 'ahmedabad', NULL, 1, 1, 1, '2013-11-11 10:05:35', '2013-11-11 10:05:35', NULL, '<p>hello this is tested by priya</p>', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(31, 12, 'priya test', 'priya_test', '', '', '', NULL, 2013, 'ahmedabad', NULL, 0, 0, 1, '2013-11-11 12:13:33', '2013-11-11 12:13:47', NULL, '', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(32, 12, 'hello test', 'hello_test', '', '', '', NULL, 2013, 'ahmedabad', NULL, 0, 0, 1, '2013-11-11 12:15:49', '2013-11-11 12:15:52', NULL, '', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(33, 47, 'test', 'test', '', '', '', NULL, 2013, 'ahmedabad', NULL, 0, 0, 1, '2013-11-11 12:25:03', '2013-11-11 12:25:10', NULL, '', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(34, 12, 'work story', 'work_story', '', '', '', NULL, 2013, 'Baroda', NULL, 0, 0, 1, '2013-11-13 08:30:55', '2013-11-13 08:30:59', NULL, '<p>work test</p>', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(35, 12, 'loc check', 'loc_check', '', '', '', NULL, 2013, 'Longs Peak', NULL, 0, 0, 1, '2013-11-13 09:12:09', '2013-11-13 09:12:13', NULL, '<p>loc check</p>', 'Colorado', 'USA', NULL, NULL, NULL, NULL),
(36, 12, 'loc check1', 'loc_check1', '', '', '', NULL, 2013, 'Longs Peak', NULL, 0, 0, 1, '2013-11-13 09:14:20', '2013-11-13 09:14:23', NULL, '<p>loc check1</p>', 'Colorado', 'USA', NULL, NULL, NULL, NULL),
(37, 12, 'new loc', 'new_loc', '', '', '', NULL, 2013, 'Gaviota Peak', NULL, 0, 0, 1, '2013-11-13 09:18:27', '2013-11-13 09:18:31', NULL, '<p>new loc</p>', 'California', 'USA', NULL, NULL, NULL, NULL),
(38, 12, 'my test', 'my_test', '', '', '', NULL, 2013, 'Woodruff', NULL, 0, 0, 1, '2013-11-13 09:35:39', '2013-11-13 09:35:43', NULL, '<p>my test</p>', 'UT', 'USA', NULL, NULL, NULL, NULL),
(40, 12, 'sample test', 'sample_test', '', '', '', NULL, 2013, 'Rock', NULL, 0, 0, 1, '2013-11-13 10:56:56', '2013-11-13 10:57:00', NULL, '<p>sample test</p>', 'MI', 'USA', NULL, NULL, NULL, NULL),
(41, 12, 'sample', 'sample', '', '', '', NULL, 2013, 'Seneca', NULL, 0, 0, 1, '2013-11-13 11:00:10', '2013-11-13 11:00:14', NULL, '<p>sample</p>', 'South dakota', 'US', NULL, NULL, NULL, NULL),
(42, 12, 'senta store', 'senta_store', '', '', '', NULL, 2013, 'Santa Barbara', NULL, 0, 0, 1, '2013-11-14 00:00:00', '2013-11-14 11:17:23', NULL, '<p>senta store</p>', 'CA', 'US', NULL, NULL, NULL, NULL),
(43, 12, 'hello new', 'hello_new', '', '', '', NULL, 2013, 'ahmedabad', NULL, 0, 0, 1, '2013-11-15 06:28:40', '2013-11-15 06:28:42', NULL, '<p>hello new</p>', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(44, 12, 'with media test', 'with_media_test', '', '', '', NULL, 2013, 'ahmedabad', NULL, 0, 0, 1, '2013-11-27 05:25:10', '2013-12-18 10:16:43', '2013-12-18 15:46:43', '<p>test</p>', 'gujarat', 'india', 'Garbafinal.mp3', 'audio/mpeg', 5634465, '2013-11-27 10:55:10'),
(45, 12, 'Hetal', 'hetal', '', '25', 'Male', NULL, 1999, 'ahemedabad', NULL, 0, 0, 1, '2013-12-12 07:49:26', '2013-12-12 08:43:31', NULL, '<p><img src="http://s3.amazonaws.com/one-story-0fSDKFJeojg09j/system/srcs/4/large/IMG_6686_zpsf8837942.jpg?1386837757" alt="" width="50" height="50" /><br />&nbsp;</p>\r\n<p><a name="gdfgd"></a></p>\r\n<p>fjhsfhskjdfhskdjfh</p>', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(46, 12, 'jjhjhhhhhh', 'jjhjhhhhhh', '', '', '', NULL, 1922, 'ahemedabad', NULL, 0, 0, 1, '2013-12-12 12:26:47', '2013-12-12 14:25:53', NULL, '<p>&nbsp;</p>\r\n<p><img src="http://s3.amazonaws.com/one-story-0fSDKFJeojg09j/system/srcs/10/large/20080723170044.JPG?1386858222" alt="" width="70" height="70" /></p>', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(48, 12, 'jghjgh', 'jghjgh', '', '', '', NULL, 1234, 'ahemedabad', NULL, 0, 0, 1, '2013-12-13 05:30:23', '2013-12-13 05:30:24', NULL, '<p>jhhhhhh<img src="http://s3.amazonaws.com/one-story-0fSDKFJeojg09j/system/srcs/11/large/om-662.jpg?1386912577" alt="" /></p>', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(50, 12, 'welcome my test', 'welcome_my_test', '', '', '', NULL, 2013, 'ahmedabad', NULL, 0, 0, 1, '2013-12-13 05:37:19', '2013-12-16 10:21:25', NULL, '<p>dfsd</p>', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(51, 12, 'temp work', 'temp_work', '', '', '', NULL, 2013, 'ahmedabad', NULL, 0, 0, 1, '2013-12-17 12:48:31', '2013-12-18 06:35:35', NULL, '', 'gujarat', 'india', NULL, NULL, NULL, NULL),
(52, 12, 'helloindia', 'helloindia', '', '', '', NULL, 2014, 'ahmedabad', NULL, 0, 0, 1, '2014-03-28 10:29:44', '2014-03-28 10:29:45', NULL, '<p>hello india</p>', 'gujarat', 'india', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `taggings`
--

CREATE TABLE IF NOT EXISTS `taggings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) DEFAULT NULL,
  `taggable_id` int(11) DEFAULT NULL,
  `taggable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_taggings_on_tag_id` (`tag_id`),
  KEY `index_taggings_on_taggable_id_and_taggable_type` (`taggable_id`,`taggable_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=88 ;

--
-- Dumping data for table `taggings`
--

INSERT INTO `taggings` (`id`, `tag_id`, `taggable_id`, `taggable_type`, `created_at`) VALUES
(1, 1, 1, 'Story', '2013-04-30 10:08:28'),
(2, 2, 1, 'Story', '2013-04-30 10:08:28'),
(3, 3, 1, 'Story', '2013-04-30 10:08:28'),
(4, 1, 2, 'Story', '2013-04-30 10:09:10'),
(5, 2, 2, 'Story', '2013-04-30 10:09:10'),
(6, 4, 2, 'Story', '2013-04-30 10:09:10'),
(7, 1, 3, 'Story', '2013-04-30 10:10:09'),
(8, 5, 3, 'Story', '2013-04-30 10:10:09'),
(9, 2, 3, 'Story', '2013-04-30 10:10:09'),
(10, 1, 4, 'Story', '2013-04-30 10:10:57'),
(11, 5, 4, 'Story', '2013-04-30 10:10:57'),
(12, 2, 4, 'Story', '2013-04-30 10:10:57'),
(13, 6, 4, 'Story', '2013-04-30 10:10:57'),
(14, 7, 5, 'Story', '2013-04-30 10:11:59'),
(15, 8, 5, 'Story', '2013-04-30 10:11:59'),
(16, 9, 5, 'Story', '2013-04-30 10:11:59'),
(17, 10, 5, 'Story', '2013-04-30 10:11:59'),
(18, 11, 5, 'Story', '2013-04-30 10:11:59'),
(19, 12, 6, 'Story', '2013-04-30 10:15:51'),
(20, 13, 6, 'Story', '2013-04-30 10:15:51'),
(21, 14, 6, 'Story', '2013-04-30 10:15:51'),
(22, 15, 6, 'Story', '2013-04-30 10:15:51'),
(23, 16, 6, 'Story', '2013-04-30 10:15:51'),
(24, 17, 7, 'Story', '2013-04-30 10:24:19'),
(25, 18, 7, 'Story', '2013-04-30 10:24:19'),
(26, 19, 7, 'Story', '2013-04-30 10:24:19'),
(27, 20, 8, 'Story', '2013-04-30 10:27:28'),
(28, 21, 8, 'Story', '2013-04-30 10:27:28'),
(29, 22, 8, 'Story', '2013-04-30 10:27:28'),
(30, 23, 8, 'Story', '2013-04-30 10:27:28'),
(31, 24, 9, 'Story', '2013-04-30 10:30:52'),
(32, 25, 9, 'Story', '2013-04-30 10:30:52'),
(33, 26, 10, 'Story', '2013-04-30 10:58:38'),
(34, 27, 10, 'Story', '2013-04-30 10:58:38'),
(35, 26, 11, 'Story', '2013-04-30 11:00:36'),
(36, 27, 11, 'Story', '2013-04-30 11:00:36'),
(37, 22, 12, 'Story', '2013-04-30 11:04:30'),
(38, 23, 12, 'Story', '2013-04-30 11:04:30'),
(39, 28, 12, 'Story', '2013-04-30 11:04:30'),
(40, 29, 12, 'Story', '2013-04-30 11:04:30'),
(41, 30, 13, 'Story', '2013-04-30 11:09:48'),
(42, 31, 14, 'Story', '2013-05-23 11:36:15'),
(43, 32, 15, 'Story', '2013-07-08 06:01:06'),
(44, 33, 15, 'Story', '2013-07-08 06:01:06'),
(45, 33, 16, 'Story', '2013-07-08 06:02:30'),
(46, 34, 16, 'Story', '2013-07-08 06:02:30'),
(47, 35, 17, 'Story', '2013-07-08 06:12:37'),
(48, 36, 17, 'Story', '2013-07-08 06:12:37'),
(49, 37, 18, 'Story', '2013-07-08 06:14:34'),
(50, 38, 18, 'Story', '2013-07-08 06:14:34'),
(51, 39, 18, 'Story', '2013-07-08 06:14:34'),
(56, 43, 20, 'Story', '2013-11-11 10:05:35'),
(57, 44, 20, 'Story', '2013-11-11 10:05:35'),
(58, 45, 20, 'Story', '2013-11-11 10:05:35'),
(59, 1, 20, 'Story', '2013-11-11 10:05:35'),
(60, 46, 34, 'Story', '2013-11-13 08:30:55'),
(61, 47, 35, 'Story', '2013-11-13 09:12:09'),
(62, 48, 36, 'Story', '2013-11-13 09:14:20'),
(63, 49, 37, 'Story', '2013-11-13 09:18:27'),
(64, 50, 38, 'Story', '2013-11-13 09:35:39'),
(66, 52, 40, 'Story', '2013-11-13 10:56:56'),
(67, 53, 41, 'Story', '2013-11-13 11:00:10'),
(68, 54, 42, 'Story', '2013-11-13 11:05:07'),
(69, 55, 43, 'Story', '2013-11-15 06:28:40'),
(71, 57, 46, 'Story', '2013-12-12 12:26:47'),
(72, 58, 48, 'Story', '2013-12-13 05:30:23'),
(77, 63, 50, 'Story', '2013-12-13 05:37:19'),
(78, 64, 45, 'Story', '2013-12-16 10:05:57'),
(79, 65, 45, 'Story', '2013-12-16 10:05:57'),
(80, 66, 45, 'Story', '2013-12-16 10:05:57'),
(81, 67, 45, 'Story', '2013-12-16 10:05:57'),
(82, 68, 45, 'Story', '2013-12-16 10:05:57'),
(83, 69, 45, 'Story', '2013-12-16 10:05:57'),
(84, 70, 51, 'Story', '2013-12-17 12:48:31'),
(85, 43, 52, 'Story', '2014-03-28 10:29:44'),
(86, 81, 52, 'Story', '2014-03-28 10:29:44'),
(87, 82, 52, 'Story', '2014-03-28 10:29:44');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=83 ;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`) VALUES
(1, 'test'),
(2, 'story'),
(3, '1'),
(4, '2'),
(5, 'again'),
(6, '4'),
(7, '1960''s'),
(8, 'Hawaii'),
(9, 'surfing'),
(10, 'punk rock'),
(11, 'cowb'),
(12, 'Bundler'),
(13, 'rails'),
(14, 'ruby'),
(15, '1.8.7'),
(16, '2.3'),
(17, 'dpa''s war stories'),
(18, 'creation'),
(19, 'destruction'),
(20, '23 years old'),
(21, 'London'),
(22, 'wild fire'),
(23, 'birthday'),
(24, 'gem uninstall mysql'),
(25, 'rvm remove ruby-1.8.7'),
(26, 'API - Test of SSO'),
(27, 'Patient ID passing'),
(28, 'grandpa''s war stories'),
(29, 'creati'),
(30, 'operator'),
(31, 'test keyword'),
(32, 'Harmony'),
(33, 'Music'),
(34, 'Art'),
(35, 'Software'),
(36, 'Testing'),
(37, 'Agile'),
(38, 'Software testing'),
(39, 'Development'),
(43, 'hello'),
(44, 'this'),
(45, 'is'),
(46, 'work test'),
(47, 'loc check'),
(48, 'loc check1'),
(49, 'new loc'),
(50, 'my test'),
(51, 'old test'),
(52, 'sample test'),
(53, 'sample'),
(54, 'senta store'),
(55, 'hello new'),
(56, 'fhfhfghfh'),
(57, 'jhhhhhhhhhh'),
(58, 'cdgdgdg'),
(59, 'a'),
(60, 'b'),
(61, 'c'),
(62, 'welcome'),
(63, 'sadfdf'),
(64, 'abcs'),
(65, 'ghggjh'),
(66, 'hjhgjhgjh'),
(67, 'gfhgfgh'),
(68, 'ggggg'),
(69, 'bbbbbb'),
(70, 'tempo'),
(71, 'asa'),
(72, 'dsa'),
(73, 'DFSHSFFJKSFKHSJJHSDJFHKSFFSDFJSFJSHKDFSJFHSFJHSKJSHFKJSFHSKJFSHFSKFHSKDFJSHFKSJFHSDFKJSDHFKDWJFHSKDJFSHFKJSFSHFJFDFSHSFFJKSFKHSJJHSDJFHKSFFSDFJSFJSHKDFSJFHSFJHSKJSHFKJSFHSKJFSHFSKFHSKDFJSHFKSJFHSDFKJSDHFKDWJFHSKDJFSHFKJSFSHFJF'),
(74, 'DFSHSFFJKSFKHSJJHSDJFHKSFFSDFJSFJSHKDFSJFHSFJHSKJSHFKJSFHSKJFSHFSKFHSKDFJSHFKSJFHSDFKJSDHFKDWJFHSKDJFSHFKJSFSHFJF'),
(75, 'd'),
(76, 'e'),
(77, 'f'),
(78, 'af'),
(79, 's'),
(80, 'dasfjflksajaslashlakjhdlfhalfahsflafhaflajfhalfafhaflajfhasfdasfjflksajaslashlakjhdlfhalfahsflafhaflajfhalfafhaflajfhasfdasfjflksajaslashlakjhdlfhalfahsflafhaflajfhalfafhaflajfhasfdasfjflksajaslashlakjhdlfhalfahsflafhaflajfhalfafhaflajfhasfdasfjflksajasla'),
(81, 'india'),
(82, 'hello india');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dob` datetime DEFAULT NULL,
  `bio` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `interests` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `city` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `state` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `country` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `crypted_password` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip_address` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token_expires_at` datetime DEFAULT NULL,
  `activation_code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activated_at` datetime DEFAULT NULL,
  `agreed` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `password_reset_code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_at` datetime DEFAULT NULL,
  `buzz_me` tinyint(1) DEFAULT '1',
  `buzz_me_mail` tinyint(1) DEFAULT '1',
  `fb_user_id` bigint(20) DEFAULT NULL,
  `fb_access_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_login` (`login`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=60 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `login`, `name`, `email`, `dob`, `bio`, `interests`, `gender`, `city`, `state`, `country`, `latitude`, `longitude`, `crypted_password`, `salt`, `ip_address`, `remember_token`, `remember_token_expires_at`, `activation_code`, `activated_at`, `agreed`, `created_at`, `updated_at`, `password_reset_code`, `reset_at`, `buzz_me`, `buzz_me_mail`, `fb_user_id`, `fb_access_token`) VALUES
(1, 'onestory', '', 'spencer@citrusme.com', NULL, NULL, NULL, NULL, '', '', '', NULL, NULL, 'bd172d142dbda9017e68668ab55f6ea283f166e6', 'bb11b3380eb1da83661fec5167758d3f1eb81937', '68.99.126.86', NULL, NULL, NULL, '2013-04-30 09:49:37', 1, '2013-04-30 09:49:30', '2013-04-30 09:49:37', NULL, NULL, 1, 1, NULL, NULL),
(2, 'sample1', '', 'sample1@onestoryroad.com', NULL, NULL, NULL, NULL, 'New raphael', '', 'Us', NULL, NULL, '8c53566cc855b9d82b7e0e682015485f7a9e2958', '5d3050f8a18e0dda4c1f44b9ccdde551ecdc6cce', NULL, NULL, NULL, NULL, '2013-04-30 10:07:08', 1, '2013-04-30 10:05:41', '2013-04-30 10:07:08', NULL, NULL, 1, 1, NULL, NULL),
(3, 'sample2', '', 'sample2@onestoryroad.com', NULL, NULL, NULL, NULL, 'Richardfort', '', 'Us', NULL, NULL, '89ed75831b5824a081759808eaae7c6f59c78aa9', '137e5f2244dc8b20925e92115c9228a2859f018f', NULL, NULL, NULL, '356794824aa9d98849da3abbea744cc70f785cb8', NULL, 1, '2013-04-30 10:05:45', '2013-04-30 10:05:49', NULL, NULL, 1, 1, NULL, NULL),
(4, 'sample3', '', 'sample3@onestoryroad.com', NULL, NULL, NULL, NULL, 'Flomouth', '', '', NULL, NULL, '7905d6fb2383209edb558a80cd0082710d1a5f6e', 'bf5c7bb1e64bef057ca81a96d5ff99d7d0281809', NULL, NULL, NULL, '72706cdde7935671e7b7cc10ed6460e8c070c9c8', NULL, 1, '2013-04-30 10:05:49', '2013-04-30 10:05:49', NULL, NULL, 1, 1, NULL, NULL),
(5, 'sample4', '', 'sample4@onestoryroad.com', NULL, NULL, NULL, NULL, 'East melyssachester', '', '', NULL, NULL, 'e16a07f8bfd174b62ddaa2ad17eaf4f7590016a8', 'e24a1312f7a313a4903f053b99cbcaeddd0d4423', NULL, NULL, NULL, '9edcbba1dec954c90321526238d006ce1b9446ff', NULL, 1, '2013-04-30 10:05:50', '2013-04-30 10:05:50', NULL, NULL, 1, 1, NULL, NULL),
(6, 'sample5', '', 'sample5@onestoryroad.com', NULL, NULL, NULL, NULL, 'Port jed', '', '', NULL, NULL, '565daa4b4d0f10cb3d165540084eb59d331b45cf', '67bf61def194f37d701a73e43b31fe39109af767', NULL, NULL, NULL, '98665349fde6ad123b273a9d894fc541c6d9faf6', NULL, 1, '2013-04-30 10:05:51', '2013-04-30 10:05:51', NULL, NULL, 1, 1, NULL, NULL),
(7, 'sample6', '', 'sample6@onestoryroad.com', NULL, NULL, NULL, NULL, 'Kerlukeborough', '', '', NULL, NULL, 'cd039b5bef8efaf9d9ebe22bf8d2158c26827a07', 'c13d1dd9b6a71239cb3edcdab46f290d53a94f81', NULL, NULL, NULL, 'fd33dd2bf978eb6993d4cb4d409222dd828d858f', NULL, 1, '2013-04-30 10:05:52', '2013-04-30 10:05:52', NULL, NULL, 1, 1, NULL, NULL),
(8, 'sample7', '', 'sample7@onestoryroad.com', NULL, NULL, NULL, NULL, 'Marcelinoshire', '', '', NULL, NULL, '6034e5d4b992115cb7481eb564fd46c467a02ee6', '410be0674842003484006e0cdb6c3196b57422aa', NULL, NULL, NULL, '1325ce255705534b24d404cfa9d01b4698044201', NULL, 1, '2013-04-30 10:05:54', '2013-04-30 10:05:54', NULL, NULL, 1, 1, NULL, NULL),
(9, 'sample8', '', 'sample8@onestoryroad.com', NULL, NULL, NULL, NULL, 'Port elianport', '', '', NULL, NULL, '0632d0c028f2c291b1ccbe0ab54584850fdaccea', 'b2756a6bdbbbe10fedbf7e667b0f5179e33a0b6a', NULL, NULL, NULL, 'dd2303def9634f6a9e603ed2bc3a0a434eb8cadc', NULL, 1, '2013-04-30 10:05:55', '2013-04-30 10:05:55', NULL, NULL, 1, 1, NULL, NULL),
(10, 'sample9', '', 'sample9@onestoryroad.com', NULL, NULL, NULL, NULL, 'East lucas', '', 'Us', NULL, NULL, '8ba7a8d11cfce5b7cc6092c13812139c45b08a77', '255479cf7ba1d0944825f9536e9668eadaddfefd', NULL, NULL, NULL, '1cc0cc95ad3b967676ef2ebc56ef13f927c15de6', NULL, 1, '2013-04-30 10:05:56', '2013-04-30 10:06:00', NULL, NULL, 1, 1, NULL, NULL),
(11, 'sample10', '', 'sample10@onestoryroad.com', NULL, NULL, NULL, NULL, 'O''keefetown', '', 'Us', NULL, NULL, '53a1554b6a0c6ab3ce7f0cd3b1dbae066f651d68', '9c927c9545d8fe19d35c8c0973122a7fcade23a2', NULL, NULL, NULL, '9878ecfc88a1a3b26a4567c0a86346e10bc56975', NULL, 1, '2013-04-30 10:06:00', '2013-04-30 10:06:03', NULL, NULL, 1, 1, NULL, NULL),
(12, 'mjavia', 'mehul', 'mehul@softwebsolutions.com', NULL, NULL, NULL, 1, 'Ahmedabad', 'Gujarat', 'India', NULL, NULL, '5a027940a81d674bab49c7ed603a6c60807784d0', '4736e7d0492f96774c074fe4be9bac5d554e0431', '127.0.0.1', NULL, NULL, '15628e704f6ff6a8b96e83639a40d7e67f6e4821', '2013-04-30 10:07:08', 1, '2013-05-22 09:15:44', '2013-12-07 05:06:46', '20c13bb5371fad453fc7a21dc4d6c11b6726daf2', NULL, 1, 1, NULL, NULL),
(44, 'rakshit', '', 'rakshit.joshi@softwebsolutions.com', NULL, NULL, NULL, NULL, 'Ahmedabad', 'Gujarat', 'India', NULL, NULL, '5ebf2546d758979c382a1a2e5e46a9f56b75677c', '6791aa1dfc1011b3b3c5c7c999a83f6e78625df1', '192.168.3.94', NULL, NULL, NULL, '2013-11-11 09:53:28', 1, '2013-11-11 09:51:06', '2013-11-11 12:19:40', NULL, NULL, 1, 1, NULL, NULL),
(47, 'dharmik', '', 'dharmik.joshi@softwebsolutions.com', NULL, NULL, NULL, NULL, 'Ahmedabad', 'Gujarat', 'India', NULL, NULL, 'b5ee7606feb9b16b7acb535343ba14ea18e5ad88', 'e36841b004d33388a3b5fbb773c0e1e9eb5a5fa6', '192.168.3.94', NULL, NULL, NULL, '2013-11-11 12:23:54', 1, '2013-11-11 12:21:54', '2013-11-11 12:23:54', NULL, NULL, 1, 1, NULL, NULL),
(48, 'hetal', '', 'hetal.khunti@softwebsolutions.com', NULL, NULL, NULL, NULL, 'Ahemedabad', 'Gujarat', 'India', NULL, NULL, 'e2d3922feff438646279bd6811465c33ae10b7bc', '6d2d574d716cd75c2f46a2f2feb797bc2cf7157c', '192.168.3.2', NULL, NULL, '8d22698f662dbd3dc3ee1760bda25be692ec8671', NULL, 1, '2013-11-27 07:02:34', '2013-11-27 07:02:43', NULL, NULL, 1, 1, NULL, NULL),
(49, 'abcd', '', 'hetal.khunti@yahoo.com', NULL, NULL, NULL, NULL, 'Ahemedabad', 'Gujarat', 'India', NULL, NULL, '3f99cdaa2088da47e0f172b41621411fcaeaad3e', '3b64b4dbd300bcb78c54ad51381f19391a6a0322', '192.168.3.2', NULL, NULL, '4ba8e8ac1bd1c89a0a13d212f97c68d9c5aab37a', NULL, 1, '2013-11-28 08:51:45', '2013-11-28 08:52:10', NULL, NULL, 1, 1, NULL, NULL),
(50, 'yhfg', '', 'hfhfg@yahoo.com', NULL, NULL, NULL, NULL, 'Gfj', 'Hfjfgjgj', 'Jfhfgj', NULL, NULL, '2486025e0cd23ccf80c6bea51187be7ac9ce40ff', 'acdd7a675bfbb1666c892269d6c3611a4a0d6606', '192.168.3.2', NULL, NULL, 'eef55935e92e4a3f82008827d99cffa6db687440', NULL, 1, '2013-11-28 08:56:59', '2013-11-28 08:56:59', NULL, NULL, 1, 1, NULL, NULL),
(51, 'dgdf', '', 'dsgsd@fgdfg.com', NULL, NULL, NULL, NULL, 'Ggs', 'Sgsgd', 'Sgsdg', NULL, NULL, '00e40bc327c952ccfc496e118199ee46db2484b4', 'aaa8e719da9eaccb44951419a39a645d8df58a2b', '192.168.3.2', NULL, NULL, '7f5a9ea3910b42417529a6cb335ad01bb8b61578', NULL, 1, '2013-11-28 09:05:23', '2013-11-28 09:05:23', NULL, NULL, 1, 1, NULL, NULL),
(52, 'fhf', '', 'hbfsj@hgjh.com', NULL, NULL, NULL, NULL, 'Fgfgh', 'Ffgg', 'Hfh', NULL, NULL, '168a20fe630ded1a00d83db5a84eee91ef8a493a', '05de809fa69b54aefff84a73ef4dd7590af66586', '192.168.3.2', NULL, NULL, 'd07a25b4cca140dd50def905edfb87a2267b3fce', NULL, 1, '2013-11-30 09:23:06', '2013-11-30 09:23:06', NULL, NULL, 1, 1, NULL, NULL),
(53, '321', '', 'tt@ff.com', NULL, NULL, NULL, NULL, 'Asd', 'Asd', 'Asd', NULL, NULL, '01a2aa10511145c49d148a0c4aa33bba87505e2f', '55ac2261b10ad100ced3b9344aa40144dc39810a', '127.0.0.1', NULL, NULL, 'b274057ae8e974503ceb191b97c9ea6f512887cc', NULL, 1, '2013-12-02 05:42:16', '2013-12-02 05:42:25', NULL, NULL, 1, 1, NULL, NULL),
(54, 'etrw', '', 'ee@dsd.com', NULL, NULL, NULL, NULL, 'Aaasdc', 'Asdsd', 'Asdf', NULL, NULL, 'e1e7ee52f245b806d3461d9b1075adae09e26ac5', '50bc198e0f167b32cd5733917a499f6bde1f165a', '127.0.0.1', NULL, NULL, 'ee0091480a5887be3db9d5af1d25835eaed61401', NULL, 1, '2013-12-02 05:44:20', '2013-12-02 05:44:20', NULL, NULL, 1, 1, NULL, NULL),
(55, 'dffdgd', '', 'gfag@ghg.com', NULL, NULL, NULL, NULL, 'Gsdfsdf', 'Sfsfsdf', 'Sdfsdfsd', NULL, NULL, '0b72667eb650eb3c4073679a0995720270683cbf', '54b5ed4dba928c4c91ba74359f521b807bee003d', '192.168.3.2', NULL, NULL, '5bd64a3a20a563df74b64a7f905c61fffeddf900', NULL, 1, '2013-12-05 05:51:19', '2013-12-05 05:51:19', NULL, NULL, 1, 1, NULL, NULL),
(56, 'abc', '', 'abcd@fgdfg.com', NULL, NULL, NULL, NULL, 'Abc', 'Abc', 'Abc', NULL, NULL, '09059e46d040434766621154f94748dde73ed9f4', 'aa824fe0ae911542864f076b67b0385eaf38a94a', '192.168.3.2', NULL, NULL, '4c08ddf2058e78502b74f278f7df0c71eb6a3937', NULL, 1, '2013-12-05 07:02:10', '2013-12-05 07:02:10', NULL, NULL, 1, 1, NULL, NULL),
(57, 'hello', '', 'hello@hello.com', NULL, NULL, NULL, NULL, 'Hello', 'Hello', 'Hello', NULL, NULL, 'b96ac531ba18c80c2194281e645ff587c21ef8c3', '9f54039916e94b6871b295eb03c96c5e6ebf4588', '192.168.3.2', NULL, NULL, '8e78d28a41cb2d3033341f00d8d28f2172efc361', NULL, 1, '2013-12-05 07:12:53', '2013-12-05 07:12:53', NULL, NULL, 1, 1, NULL, NULL),
(58, 'test', '', 'test@example.com', NULL, NULL, NULL, NULL, 'Ahmedabad', 'Gujarat', 'India', NULL, NULL, '1e6ea0532cf0a07e53890cc4a017941b6bcc4b72', 'da9c58b1abb01d210140f6036a934db7cb491549', '192.168.3.94', NULL, NULL, 'f00b5db39c636b9a0e289e385224f8a7bbd1704c', NULL, 1, '2013-12-16 05:36:04', '2013-12-16 05:36:13', NULL, NULL, 1, 1, NULL, NULL),
(59, 'how', '', 'how@example.com', NULL, NULL, NULL, NULL, 'Ahmedabad', 'Gujarat', 'India', NULL, NULL, '7d3ae86d2a5800ffc42cdc87af4a8b2ab52d4288', 'f32c14778133e28ce604f38e57f0c045fa0f435d', '192.168.3.94', NULL, NULL, '34e9994a202d5bf2c68c7a048cfe343fd9929d3b', NULL, 1, '2013-12-16 10:44:58', '2013-12-16 10:45:08', NULL, NULL, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `view_counts`
--

CREATE TABLE IF NOT EXISTS `view_counts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `viewable_id` int(11) DEFAULT NULL,
  `viewable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logged_in` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=66 ;

--
-- Dumping data for table `view_counts`
--

INSERT INTO `view_counts` (`id`, `viewable_id`, `viewable_type`, `ip_address`, `logged_in`, `created_at`) VALUES
(1, 4, 'Story', '127.0.0.1', 1, '2013-04-30 10:12:09'),
(2, 5, 'Story', '127.0.0.1', 1, '2013-04-30 10:16:01'),
(3, 9, 'Story', '127.0.0.1', 1, '2013-04-30 10:31:11'),
(4, 6, 'Story', '127.0.0.1', 1, '2013-04-30 10:49:23'),
(5, 10, 'Story', '127.0.0.1', 1, '2013-04-30 10:59:22'),
(6, 12, 'Story', '127.0.0.1', 1, '2013-04-30 11:07:08'),
(7, 13, 'Story', '127.0.0.1', 1, '2013-04-30 11:10:14'),
(8, 11, 'Story', '127.0.0.1', 1, '2013-05-01 11:43:08'),
(9, 7, 'Story', '127.0.0.1', 1, '2013-05-01 11:43:22'),
(10, 8, 'Story', '127.0.0.1', 1, '2013-05-01 11:43:26'),
(11, 3, 'Story', '127.0.0.1', 1, '2013-05-01 13:28:19'),
(12, 14, 'Story', '127.0.0.1', 1, '2013-05-23 11:40:58'),
(13, 16, 'Story', '127.0.0.1', 1, '2013-07-08 06:02:36'),
(14, 17, 'Story', '127.0.0.1', 1, '2013-07-08 06:12:44'),
(15, 15, 'Story', '127.0.0.1', 1, '2013-07-08 06:12:52'),
(16, 18, 'Story', '127.0.0.1', 1, '2013-07-08 06:14:39'),
(17, 18, 'Story', '192.168.3.126', 0, '2013-07-08 10:35:44'),
(18, 20, 'Story', '192.168.3.94', 1, '2013-11-11 10:06:11'),
(19, 33, 'Story', '192.168.3.94', 1, '2013-11-13 09:08:01'),
(20, 18, 'Story', '192.168.3.94', 1, '2013-11-13 09:16:40'),
(21, 38, 'Story', '192.168.3.94', 1, '2013-11-14 11:25:06'),
(22, 43, 'Story', '192.168.3.94', 1, '2013-11-19 09:05:05'),
(23, 34, 'Story', '192.168.3.113', 0, '2013-11-22 13:01:10'),
(24, 41, 'Story', '192.168.3.94', 1, '2013-11-22 13:14:35'),
(25, 32, 'Story', '192.168.3.94', 1, '2013-11-22 13:15:23'),
(26, 35, 'Story', '192.168.3.94', 1, '2013-11-22 13:17:44'),
(27, 36, 'Story', '192.168.3.94', 1, '2013-11-22 13:18:34'),
(28, 42, 'Story', '192.168.3.94', 0, '2013-11-25 04:57:15'),
(29, 44, 'Story', '192.168.3.94', 1, '2013-11-27 05:28:16'),
(30, 44, 'Story', '192.168.3.156', 0, '2013-11-28 05:12:29'),
(31, 44, 'Story', '192.168.3.82', 0, '2013-11-28 05:40:41'),
(32, 44, 'Story', '192.168.3.113', 0, '2013-11-30 05:47:14'),
(33, 44, 'Story', '192.168.3.2', 1, '2013-11-30 12:10:21'),
(34, 36, 'Story', '192.168.3.2', 1, '2013-11-30 12:11:15'),
(35, 34, 'Story', '192.168.3.2', 1, '2013-12-02 07:48:16'),
(36, 44, 'Story', '192.168.3.234', 0, '2013-12-02 11:05:36'),
(37, 34, 'Story', '127.0.0.1', 0, '2013-12-03 09:33:18'),
(38, 44, 'Story', '127.0.0.1', 0, '2013-12-03 09:33:46'),
(39, 31, 'Story', '192.168.3.94', 0, '2013-12-04 06:01:52'),
(40, 34, 'Story', '192.168.3.94', 0, '2013-12-04 07:48:36'),
(41, 36, 'Story', '127.0.0.1', 0, '2013-12-07 08:00:31'),
(42, 45, 'Story', '192.168.3.2', 1, '2013-12-12 07:50:35'),
(43, 45, 'Story', '192.168.3.94', 1, '2013-12-12 07:52:29'),
(44, 46, 'Story', '192.168.3.2', 1, '2013-12-12 12:27:03'),
(45, 48, 'Story', '192.168.3.2', 1, '2013-12-13 05:30:36'),
(46, 36, 'Story', '192.168.3.113', 1, '2013-12-16 07:01:06'),
(47, 45, 'Story', '127.0.0.1', 0, '2013-12-16 09:05:37'),
(48, 45, 'Story', '192.168.3.70', 0, '2013-12-16 09:25:51'),
(49, 46, 'Story', '192.168.3.94', 0, '2013-12-16 10:03:10'),
(50, 50, 'Story', '192.168.3.94', 0, '2013-12-16 10:03:34'),
(51, 50, 'Story', '192.168.3.2', 1, '2013-12-16 12:21:42'),
(52, 45, 'Story', '192.168.3.113', 0, '2013-12-17 08:01:05'),
(53, 51, 'Story', '192.168.3.94', 1, '2013-12-19 05:28:43'),
(54, 51, 'Story', '192.168.3.2', 0, '2013-12-24 07:52:01'),
(55, 31, 'Story', '192.168.3.2', 0, '2013-12-24 07:52:13'),
(56, 43, 'Story', '192.168.3.2', 0, '2013-12-24 08:58:39'),
(57, 18, 'Story', '192.168.3.113', 0, '2013-12-24 09:04:03'),
(58, 18, 'Story', '192.168.3.2', 0, '2013-12-24 11:50:30'),
(59, 32, 'Story', '192.168.3.2', 0, '2013-12-24 12:11:47'),
(60, 46, 'Story', '192.168.3.113', 0, '2014-01-03 11:43:16'),
(61, 46, 'Story', '127.0.0.1', 0, '2014-01-04 08:20:21'),
(62, 43, 'Story', '127.0.0.1', 0, '2014-01-04 08:21:31'),
(63, 48, 'Story', '192.168.3.94', 0, '2014-01-06 06:52:02'),
(64, 43, 'Story', '192.168.3.113', 0, '2014-01-06 12:03:55'),
(65, 52, 'Story', '192.168.3.94', 1, '2014-03-28 10:32:13');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
