-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 02, 2026 at 10:29 AM
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
-- Database: `vehicle_inspection`
--

-- --------------------------------------------------------

--
-- Table structure for table `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `authtoken_token`
--

INSERT INTO `authtoken_token` (`key`, `created`, `user_id`) VALUES
('1404068c32b7e032fe4cc0f9ad9e783dae7616eb', '2026-03-02 05:08:48.674479', 2),
('6c0e97c62039a1618145b3105008733655d7f3b2', '2026-03-02 08:25:59.116643', 13),
('916fa3dbdb97d5b72affc471bf50e9cd0e3431a5', '2026-03-02 05:32:36.285820', 1),
('9e15ec56e8a73d97bd9cfd0e32bb1c9637d8ee8e', '2026-03-02 08:19:33.707983', 12),
('b0731b4cc9e12ffc00c375835a90cbcc8cce9a91', '2026-03-02 05:05:24.997610', 7);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(1, 'Customer'),
(2, 'Staff');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add Token', 7, 'add_token'),
(26, 'Can change Token', 7, 'change_token'),
(27, 'Can delete Token', 7, 'delete_token'),
(28, 'Can view Token', 7, 'view_token'),
(29, 'Can add Token', 8, 'add_tokenproxy'),
(30, 'Can change Token', 8, 'change_tokenproxy'),
(31, 'Can delete Token', 8, 'delete_tokenproxy'),
(32, 'Can view Token', 8, 'view_tokenproxy'),
(33, 'Can add checklist item', 9, 'add_checklistitem'),
(34, 'Can change checklist item', 9, 'change_checklistitem'),
(35, 'Can delete checklist item', 9, 'delete_checklistitem'),
(36, 'Can view checklist item', 9, 'view_checklistitem'),
(37, 'Can add Customer', 10, 'add_customer'),
(38, 'Can change Customer', 10, 'change_customer'),
(39, 'Can delete Customer', 10, 'delete_customer'),
(40, 'Can view Customer', 10, 'view_customer'),
(41, 'Can add order', 11, 'add_order'),
(42, 'Can change order', 11, 'change_order'),
(43, 'Can delete order', 11, 'delete_order'),
(44, 'Can view order', 11, 'view_order'),
(45, 'Can add otp', 12, 'add_otp'),
(46, 'Can change otp', 12, 'change_otp'),
(47, 'Can delete otp', 12, 'delete_otp'),
(48, 'Can view otp', 12, 'view_otp'),
(49, 'Can add role', 13, 'add_role'),
(50, 'Can change role', 13, 'change_role'),
(51, 'Can delete role', 13, 'delete_role'),
(52, 'Can view role', 13, 'view_role'),
(53, 'Can add station', 14, 'add_station'),
(54, 'Can change station', 14, 'change_station'),
(55, 'Can delete station', 14, 'delete_station'),
(56, 'Can view station', 14, 'view_station'),
(57, 'Can add vehicle type', 15, 'add_vehicletype'),
(58, 'Can change vehicle type', 15, 'change_vehicletype'),
(59, 'Can delete vehicle type', 15, 'delete_vehicletype'),
(60, 'Can view vehicle type', 15, 'view_vehicletype'),
(61, 'Can add vehicle', 16, 'add_vehicle'),
(62, 'Can change vehicle', 16, 'change_vehicle'),
(63, 'Can delete vehicle', 16, 'delete_vehicle'),
(64, 'Can view vehicle', 16, 'view_vehicle'),
(65, 'Can add Staff', 17, 'add_staff'),
(66, 'Can change Staff', 17, 'change_staff'),
(67, 'Can delete Staff', 17, 'delete_staff'),
(68, 'Can view Staff', 17, 'view_staff'),
(69, 'Can add rating', 18, 'add_rating'),
(70, 'Can change rating', 18, 'change_rating'),
(71, 'Can delete rating', 18, 'delete_rating'),
(72, 'Can view rating', 18, 'view_rating'),
(73, 'Can add pricing', 19, 'add_pricing'),
(74, 'Can change pricing', 19, 'change_pricing'),
(75, 'Can delete pricing', 19, 'delete_pricing'),
(76, 'Can view pricing', 19, 'view_pricing'),
(77, 'Can add payment', 20, 'add_payment'),
(78, 'Can change payment', 20, 'change_payment'),
(79, 'Can delete payment', 20, 'delete_payment'),
(80, 'Can view payment', 20, 'view_payment'),
(81, 'Can add order status history', 21, 'add_orderstatushistory'),
(82, 'Can change order status history', 21, 'change_orderstatushistory'),
(83, 'Can delete order status history', 21, 'delete_orderstatushistory'),
(84, 'Can view order status history', 21, 'view_orderstatushistory'),
(85, 'Can add order checklist', 22, 'add_orderchecklist'),
(86, 'Can change order checklist', 22, 'change_orderchecklist'),
(87, 'Can delete order checklist', 22, 'delete_orderchecklist'),
(88, 'Can view order checklist', 22, 'view_orderchecklist'),
(89, 'Can add system setting', 23, 'add_systemsetting'),
(90, 'Can change system setting', 23, 'change_systemsetting'),
(91, 'Can delete system setting', 23, 'delete_systemsetting'),
(92, 'Can view system setting', 23, 'view_systemsetting'),
(93, 'Can add permission', 24, 'add_permission'),
(94, 'Can change permission', 24, 'change_permission'),
(95, 'Can delete permission', 24, 'delete_permission'),
(96, 'Can view permission', 24, 'view_permission'),
(97, 'Can add chat message', 25, 'add_chatmessage'),
(98, 'Can change chat message', 25, 'change_chatmessage'),
(99, 'Can delete chat message', 25, 'delete_chatmessage'),
(100, 'Can view chat message', 25, 'view_chatmessage'),
(101, 'Can add role permission', 26, 'add_rolepermission'),
(102, 'Can change role permission', 26, 'change_rolepermission'),
(103, 'Can delete role permission', 26, 'delete_rolepermission'),
(104, 'Can view role permission', 26, 'view_rolepermission'),
(105, 'Can add notification', 27, 'add_notification'),
(106, 'Can change notification', 27, 'change_notification'),
(107, 'Can delete notification', 27, 'delete_notification'),
(108, 'Can view notification', 27, 'view_notification');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$HvBRmK55ToQgpCgtpzlOIz$fqkA6n0uGY2M2aMutN1H5qZ8osrFgDZQU4wWgcOAsFg=', '2026-03-02 08:56:09.860507', 1, 'admin', 'Admin', 'System', 'admin@dangkiem.vn', 1, 1, '2026-03-02 00:00:00.000000'),
(2, '!', '2026-03-02 05:08:48.669199', 0, '0912345678', '', '', '', 0, 1, '2026-03-02 00:00:00.000000'),
(3, '!', NULL, 0, '0987654321', '', '', '', 0, 1, '2026-03-02 00:00:00.000000'),
(4, '!', NULL, 0, '0901234567', '', '', 'levanc@gmail.com', 0, 1, '2026-03-02 00:00:00.000000'),
(5, '!', NULL, 0, '0934567890', '', '', '', 0, 1, '2026-03-02 00:00:00.000000'),
(6, '!', NULL, 0, '0945678901', '', '', '', 0, 1, '2026-03-02 00:00:00.000000'),
(7, 'pbkdf2_sha256$600000$HvBRmK55ToQgpCgtpzlOIz$fqkA6n0uGY2M2aMutN1H5qZ8osrFgDZQU4wWgcOAsFg=', '2026-03-02 08:06:12.514364', 0, 'nv001', 'Nguyễn', 'Văn F', 'nvf@dangkiem.vn', 1, 1, '2026-03-02 00:00:00.000000'),
(8, 'pbkdf2_sha256$600000$HvBRmK55ToQgpCgtpzlOIz$fqkA6n0uGY2M2aMutN1H5qZ8osrFgDZQU4wWgcOAsFg=', NULL, 0, 'nv002', 'Trần', 'Văn G', 'nvg@dangkiem.vn', 1, 1, '2026-03-02 00:00:00.000000'),
(9, 'pbkdf2_sha256$600000$HvBRmK55ToQgpCgtpzlOIz$fqkA6n0uGY2M2aMutN1H5qZ8osrFgDZQU4wWgcOAsFg=', NULL, 0, 'nv003', 'Lê', 'Thị H', 'lth@dangkiem.vn', 1, 1, '2026-03-02 00:00:00.000000'),
(10, 'pbkdf2_sha256$600000$HvBRmK55ToQgpCgtpzlOIz$fqkA6n0uGY2M2aMutN1H5qZ8osrFgDZQU4wWgcOAsFg=', NULL, 0, 'nv004', 'Phạm', 'Văn I', 'pvi@dangkiem.vn', 1, 1, '2026-03-02 00:00:00.000000'),
(12, 'pbkdf2_sha256$600000$WB1FkxF0Ac9bqidZonDjrJ$daHJy7f1eRWYczm4HBVf2cfR+jfp6RkiBNC0cYO7XYM=', '2026-03-02 09:13:18.720212', 0, 'customer_0382786317', '', '', '', 0, 1, '2026-03-02 08:19:33.301385'),
(13, 'pbkdf2_sha256$600000$gffnV5ArtvWQUPQnzlAoD0$qP0c7gRfswLrJqyAAZ2XoWmfz7ViPHqTf5lwdWFk5mA=', '2026-03-02 08:25:59.112590', 0, 'customer_0973685142', '', '', '', 0, 1, '2026-03-02 08:25:58.731727');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_user_groups`
--

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 2, 1),
(2, 3, 1),
(3, 4, 1),
(4, 5, 1),
(5, 6, 1),
(6, 7, 2),
(7, 8, 2),
(8, 9, 2),
(9, 10, 2),
(11, 12, 1),
(12, 13, 1);

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` bigint(20) NOT NULL,
  `sender_type` varchar(20) NOT NULL,
  `message_type` varchar(20) NOT NULL,
  `message_text` longtext DEFAULT NULL,
  `media_url` varchar(500) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL,
  `read_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `sender_customer_id` bigint(20) DEFAULT NULL,
  `sender_staff_id` bigint(20) DEFAULT NULL,
  `sender_user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `checklist_items`
--

CREATE TABLE `checklist_items` (
  `id` bigint(20) NOT NULL,
  `item_key` varchar(100) NOT NULL,
  `item_label` varchar(200) NOT NULL,
  `category` varchar(20) NOT NULL,
  `display_order` int(11) NOT NULL,
  `require_photo` tinyint(1) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `checklist_items`
--

INSERT INTO `checklist_items` (`id`, `item_key`, `item_label`, `category`, `display_order`, `require_photo`, `status`, `created_at`, `updated_at`) VALUES
(1, 'brake_system_front', 'Kiểm tra hệ thống phanh trước', 'safety', 1, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(2, 'brake_system_rear', 'Kiểm tra hệ thống phanh sau', 'safety', 2, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(3, 'brake_fluid_level', 'Kiểm tra mức dầu phanh', 'safety', 3, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(4, 'parking_brake', 'Kiểm tra phanh đậu xe', 'safety', 4, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(5, 'steering_wheel_play', 'Kiểm tra độ rơ tay lái', 'safety', 5, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(6, 'steering_linkage', 'Kiểm tra hệ thống liên động lái', 'safety', 6, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(7, 'power_steering_fluid', 'Kiểm tra dầu trợ lực lái', 'safety', 7, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(8, 'front_suspension', 'Kiểm tra hệ thống treo trước', 'safety', 8, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(9, 'rear_suspension', 'Kiểm tra hệ thống treo sau', 'safety', 9, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(10, 'shock_absorbers', 'Kiểm tra giảm xóc', 'safety', 10, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(11, 'tire_front_left', 'Kiểm tra lốp trước trái (độ mòn, áp suất)', 'safety', 11, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(12, 'tire_front_right', 'Kiểm tra lốp trước phải (độ mòn, áp suất)', 'safety', 12, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(13, 'tire_rear_left', 'Kiểm tra lốp sau trái (độ mòn, áp suất)', 'safety', 13, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(14, 'tire_rear_right', 'Kiểm tra lốp sau phải (độ mòn, áp suất)', 'safety', 14, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(15, 'spare_tire', 'Kiểm tra lốp dự phòng', 'safety', 15, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(16, 'wheel_alignment', 'Kiểm tra độ chính xác bánh xe', 'safety', 16, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(17, 'headlights_low_beam', 'Kiểm tra đèn pha cốt thấp', 'safety', 17, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(18, 'headlights_high_beam', 'Kiểm tra đèn pha cốt cao', 'safety', 18, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(19, 'tail_lights', 'Kiểm tra đèn hậu', 'safety', 19, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(20, 'brake_lights', 'Kiểm tra đèn phanh', 'safety', 20, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(21, 'turn_signals', 'Kiểm tra đèn xi-nhan', 'safety', 21, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(22, 'hazard_lights', 'Kiểm tra đèn cảnh báo nguy hiểm', 'safety', 22, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(23, 'reverse_lights', 'Kiểm tra đèn lùi', 'safety', 23, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(24, 'license_plate_lights', 'Kiểm tra đèn biển số', 'safety', 24, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(25, 'windshield_condition', 'Kiểm tra kính chắn gió (nứt, vỡ)', 'safety', 25, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(26, 'windshield_wipers', 'Kiểm tra gạt nước', 'safety', 26, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(27, 'side_mirrors', 'Kiểm tra gương chiếu hậu bên', 'safety', 27, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(28, 'rearview_mirror', 'Kiểm tra gương chiếu hậu trong', 'safety', 28, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(29, 'horn', 'Kiểm tra còi xe', 'safety', 29, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(30, 'seat_belts_front', 'Kiểm tra dây đai an toàn trước', 'safety', 30, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(31, 'seat_belts_rear', 'Kiểm tra dây đai an toàn sau', 'safety', 31, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(32, 'doors_hood_trunk', 'Kiểm tra cửa xe, nắp ca-pô, cốp sau', 'safety', 32, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(33, 'fuel_system_leaks', 'Kiểm tra rò rỉ nhiên liệu', 'safety', 33, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(34, 'radiator_coolant', 'Kiểm tra nước làm mát', 'safety', 34, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(35, 'coolant_hoses', 'Kiểm tra ống dẫn nước làm mát', 'safety', 35, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(36, 'battery_condition', 'Kiểm tra ắc quy', 'safety', 36, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(37, 'electrical_wiring', 'Kiểm tra hệ thống dây điện', 'safety', 37, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(38, 'exhaust_system', 'Kiểm tra hệ thống xả', 'safety', 38, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(39, 'muffler_condition', 'Kiểm tra ống xả/giảm thanh', 'safety', 39, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(40, 'engine_oil_level', 'Kiểm tra mức dầu động cơ', 'safety', 40, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(41, 'engine_oil_leaks', 'Kiểm tra rò rỉ dầu động cơ', 'safety', 41, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(42, 'emission_co_level', 'Đo nồng độ CO (Carbon Monoxide)', 'emission', 101, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(43, 'emission_hc_level', 'Đo nồng độ HC (Hydrocarbons)', 'emission', 102, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(44, 'emission_co2_level', 'Đo nồng độ CO2 (Carbon Dioxide)', 'emission', 103, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(45, 'emission_o2_level', 'Đo nồng độ O2 (Oxygen)', 'emission', 104, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(46, 'emission_lambda_value', 'Đo giá trị Lambda (tỷ lệ không khí/nhiên liệu)', 'emission', 105, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(47, 'emission_smoke_opacity', 'Đo độ đen khói (Diesel)', 'emission', 106, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(48, 'emission_nox_level', 'Đo nồng độ NOx (Nitrogen Oxides)', 'emission', 107, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(49, 'catalytic_converter', 'Kiểm tra bộ xúc tác khí thải', 'emission', 108, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(50, 'egr_system', 'Kiểm tra hệ thống EGR (Exhaust Gas Recirculation)', 'emission', 109, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(51, 'evap_system', 'Kiểm tra hệ thống EVAP (Evaporative Emission Control)', 'emission', 110, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(52, 'vin_verification', 'Xác minh số VIN/số khung', 'both', 201, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(53, 'engine_number_verification', 'Xác minh số máy', 'both', 202, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(54, 'license_plate_verification', 'Xác minh biển số xe', 'both', 203, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(55, 'vehicle_documents', 'Kiểm tra giấy tờ xe', 'both', 204, 0, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000'),
(56, 'overall_vehicle_condition', 'Đánh giá tổng thể tình trạng xe', 'both', 205, 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `avatar_url` varchar(500) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `ward` varchar(100) DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `facebook_id` varchar(255) DEFAULT NULL,
  `apple_id` varchar(255) DEFAULT NULL,
  `phone_verified` tinyint(1) NOT NULL,
  `email_verified` tinyint(1) NOT NULL,
  `total_orders` int(11) NOT NULL,
  `completed_orders` int(11) NOT NULL,
  `total_spent` decimal(12,2) NOT NULL,
  `loyalty_points` int(11) NOT NULL,
  `membership_tier` varchar(20) NOT NULL,
  `preferred_language` varchar(10) NOT NULL,
  `timezone` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `full_name`, `phone`, `avatar_url`, `date_of_birth`, `gender`, `address`, `city`, `district`, `ward`, `google_id`, `facebook_id`, `apple_id`, `phone_verified`, `email_verified`, `total_orders`, `completed_orders`, `total_spent`, `loyalty_points`, `membership_tier`, `preferred_language`, `timezone`, `created_at`, `updated_at`, `user_id`) VALUES
(1, 'Nguyễn Văn A', '0912345678', NULL, '1985-05-15', 'male', '123 Đường ABC, Phường 1', 'Hà Nội', 'Đống Đa', 'Láng Thượng', NULL, NULL, NULL, 1, 0, 3, 3, 1140000.00, 150, 'silver', 'vi', 'Asia/Ho_Chi_Minh', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 2),
(2, 'Trần Thị B', '0987654321', NULL, '1990-08-20', 'female', '456 Đường XYZ, Phường 2', 'TP. Hồ Chí Minh', 'Quận 1', 'Bến Thành', NULL, NULL, NULL, 1, 0, 2, 2, 680000.00, 100, 'bronze', 'vi', 'Asia/Ho_Chi_Minh', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 3),
(3, 'Lê Văn C', '0901234567', NULL, '1988-03-10', 'male', '789 Đường DEF, Phường 3', 'Hà Nội', 'Cầu Giấy', 'Cổ Nhuế', NULL, NULL, NULL, 1, 1, 1, 1, 340000.00, 50, 'bronze', 'vi', 'Asia/Ho_Chi_Minh', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 4),
(4, 'Phạm Thị D', '0934567890', NULL, '1992-11-25', 'female', '321 Đường GHI, Phường 4', 'Đà Nẵng', 'Hải Châu', 'Hòa Thuận Tây', NULL, NULL, NULL, 1, 0, 1, 0, 0.00, 0, 'bronze', 'vi', 'Asia/Ho_Chi_Minh', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 5),
(5, 'Hoàng Văn E', '0945678901', NULL, '1987-07-18', 'male', '555 Đường JKL, Phường 5', 'TP. Hồ Chí Minh', 'Tân Bình', 'Phường 4', NULL, NULL, NULL, 1, 0, 0, 0, 0.00, 0, 'bronze', 'vi', 'Asia/Ho_Chi_Minh', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 6),
(7, 'levanchien', '0382786317', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0.00, 0, 'bronze', 'vi', 'Asia/Ho_Chi_Minh', '2026-03-02 08:19:33.685023', '2026-03-02 08:19:33.685062', 12),
(8, 'lethichien', '0973685142', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0.00, 0, 'bronze', 'vi', 'Asia/Ho_Chi_Minh', '2026-03-02 08:25:59.098734', '2026-03-02 08:25:59.098764', 13);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(25, 'api', 'chatmessage'),
(9, 'api', 'checklistitem'),
(10, 'api', 'customer'),
(27, 'api', 'notification'),
(11, 'api', 'order'),
(22, 'api', 'orderchecklist'),
(21, 'api', 'orderstatushistory'),
(12, 'api', 'otp'),
(20, 'api', 'payment'),
(24, 'api', 'permission'),
(19, 'api', 'pricing'),
(18, 'api', 'rating'),
(13, 'api', 'role'),
(26, 'api', 'rolepermission'),
(17, 'api', 'staff'),
(14, 'api', 'station'),
(23, 'api', 'systemsetting'),
(16, 'api', 'vehicle'),
(15, 'api', 'vehicletype'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(7, 'authtoken', 'token'),
(8, 'authtoken', 'tokenproxy'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-03-02 03:47:16.616692'),
(2, 'auth', '0001_initial', '2026-03-02 03:47:17.210192'),
(3, 'admin', '0001_initial', '2026-03-02 03:47:17.465649'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-03-02 03:47:17.473810'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-03-02 03:47:17.482977'),
(6, 'api', '0001_initial', '2026-03-02 03:47:18.726745'),
(7, 'contenttypes', '0002_remove_content_type_name', '2026-03-02 03:47:18.788189'),
(8, 'auth', '0002_alter_permission_name_max_length', '2026-03-02 03:47:18.840220'),
(9, 'auth', '0003_alter_user_email_max_length', '2026-03-02 03:47:18.861842'),
(10, 'auth', '0004_alter_user_username_opts', '2026-03-02 03:47:18.872898'),
(11, 'auth', '0005_alter_user_last_login_null', '2026-03-02 03:47:18.917560'),
(12, 'auth', '0006_require_contenttypes_0002', '2026-03-02 03:47:18.921441'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2026-03-02 03:47:18.934387'),
(14, 'auth', '0008_alter_user_username_max_length', '2026-03-02 03:47:18.951770'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2026-03-02 03:47:18.967943'),
(16, 'auth', '0010_alter_group_name_max_length', '2026-03-02 03:47:18.994116'),
(17, 'auth', '0011_update_proxy_permissions', '2026-03-02 03:47:19.022647'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2026-03-02 03:47:19.036356'),
(19, 'authtoken', '0001_initial', '2026-03-02 03:47:19.115283'),
(20, 'authtoken', '0002_auto_20160226_1747', '2026-03-02 03:47:19.157435'),
(21, 'authtoken', '0003_tokenproxy', '2026-03-02 03:47:19.162679'),
(22, 'authtoken', '0004_alter_tokenproxy_options', '2026-03-02 03:47:19.169610'),
(23, 'sessions', '0001_initial', '2026-03-02 03:47:19.202670'),
(24, 'api', '0002_orderchecklist_check_type_orderchecklist_checked_by_and_more', '2026-03-02 09:12:41.588481'),
(25, 'api', '0003_permission_systemsetting_notification_chatmessage_and_more', '2026-03-02 09:21:07.026185');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('39f9b4v2s53nggsc094ll97jt1efu0mq', '.eJxVjDsOwyAQRO9CHSF-XiBlep_BWhYITiKQjF1FuXtsyUVSzrw382YTbmuZtp6WaY7syqRkl98yID1TPUh8YL03Tq2uyxz4ofCTdj62mF630_07KNjLvhYYwuCFohyVHRJZL0FC9gMYApNQa2PAArg9oTDCKeUUWZ2yI-GiY58v7-c3Iw:1vwvXa:qwn5u4S0Jh28dCTtWZKx4XIKhzOpQg1NgIv2eFbsWM4', '2026-03-16 05:09:58.769238'),
('3u63zcx6o7ay81xodbetcz3x64caq1hc', '.eJxVjDsOwjAQBe_iGln-e6GkzxmsXX9wANlSnFSIu0OkFNC-mXkvFnBba9hGXsKc2IVJdvrdCOMjtx2kO7Zb57G3dZmJ7wo_6OBTT_l5Pdy_g4qjfmuXCIVzIIyAEqW3woEHKCVb7QkVGlBUNBnwRtozgELUTkirSOcEhb0_xbU3HQ:1vwymF:Kt-4QjnGS0GCMpBTsfI4q2R8ugmFvcy2g5KjjWjy5hg', '2026-03-16 08:37:19.428882'),
('3xandw4owlp8oz2ctpon5iffogmiws4s', '.eJxVjEEOwiAQRe_C2pAyZKC6dO8ZyDAMUjWQlHbVeHdt0oVu_3vvbyrQupSwdpnDlNRFGVCn3zESP6XuJD2o3pvmVpd5inpX9EG7vrUkr-vh_h0U6uVb00icwUSxgskiQQIcz5ac-IRIbAabSUxEGXymGI1ndABgs3dM2an3ByofON0:1vwyV3:6a29grlebES7BDzeZOszvEHSjF6RUJvCO64LKNcK5hQ', '2026-03-16 08:19:33.715202'),
('bqco7z3urvtilruf6p80jeltc7psrl7q', '.eJxVjDsOwjAQBe_iGln-e6GkzxmsXX9wANlSnFSIu0OkFNC-mXkvFnBba9hGXsKc2IVJdvrdCOMjtx2kO7Zb57G3dZmJ7wo_6OBTT_l5Pdy_g4qjfmuXCIVzIIyAEqW3woEHKCVb7QkVGlBUNBnwRtozgELUTkirSOcEhb0_xbU3HQ:1vwupP:YEOc3ukj9uKVmgQIVKVjkusno7EP5LdEJL9w_xES2u0', '2026-03-16 04:24:19.930244'),
('cgdjcfz2o5dl1i8pxg9tjx7anbsr64i3', '.eJxVjEEOwiAQRe_C2pAyZKC6dO8ZyDAMUjWQlHbVeHdt0oVu_3vvbyrQupSwdpnDlNRFGVCn3zESP6XuJD2o3pvmVpd5inpX9EG7vrUkr-vh_h0U6uVb00icwUSxgskiQQIcz5ac-IRIbAabSUxEGXymGI1ndABgs3dM2an3ByofON0:1vwyWR:lSkBSVRADD24Rrv9_DR55sYCPRHjzvbIwirPxrJbtrI', '2026-03-16 08:20:59.248375'),
('eu4bdi7m66493xkxs5mfp1ob1gpvxw4t', '.eJxVjDsOwjAQBe_iGln-e6GkzxmsXX9wANlSnFSIu0OkFNC-mXkvFnBba9hGXsKc2IVJdvrdCOMjtx2kO7Zb57G3dZmJ7wo_6OBTT_l5Pdy_g4qjfmuXCIVzIIyAEqW3woEHKCVb7QkVGlBUNBnwRtozgELUTkirSOcEhb0_xbU3HQ:1vwz4T:m6KWRQL4WaTl9bT73t-bMEGxeD1NWa-o5j5onq_zu-E', '2026-03-16 08:56:09.868662'),
('h9q3cr7tjac4y4344m71q3m1de6mku1f', '.eJxVjDsOwjAQBe_iGln-e6GkzxmsXX9wANlSnFSIu0OkFNC-mXkvFnBba9hGXsKc2IV5dvrdCOMjtx2kO7Zb57G3dZmJ7wo_6OBTT_l5Pdy_g4qjfmuXCIVzIIyAEqW3woEHKCVb7QkVGlBUNBnwRtozgELUTkirSOcEhb0_yUs3Iw:1vwxCP:KXXZsb_4J7TysO2pO8UDhAw-Vde2VbQ4D6pOzQaTwAs', '2026-03-16 06:56:13.246639'),
('ii2if7z5wc4v9fikl9gxee18b5b4t1jk', '.eJxVjDsOwyAQRO9CHSF-XiBlep_BWhYITiKQjF1FuXtsyUVSzrw382YTbmuZtp6WaY7syqRkl98yID1TPUh8YL03Tq2uyxz4ofCTdj62mF630_07KNjLvhYYwuCFohyVHRJZL0FC9gMYApNQa2PAArg9oTDCKeUUWZ2yI-GiY58v7-c3Iw:1vwx7P:Bz5ncHhaRz3DBN2ywEkY3GIBSBbInDTMArBqpCd0AwA', '2026-03-16 06:51:03.310268'),
('juhmczwcypvicuiomyprewn8jq7h89jj', '.eJxVjDsOwjAQBe_iGln-e6GkzxmsXX9wANlSnFSIu0OkFNC-mXkvFnBba9hGXsKc2IVJdvrdCOMjtx2kO7Zb57G3dZmJ7wo_6OBTT_l5Pdy_g4qjfmuXCIVzIIyAEqW3woEHKCVb7QkVGlBUNBnwRtozgELUTkirSOcEhb0_xbU3HQ:1vwvtU:CojLN8JG9F6CbcOuSzOIGZCzIMKU1rR0t9ey1EcZZ-M', '2026-03-16 05:32:36.289884'),
('muvkcbowmfcfrnn8lod5hyahxiyi07zq', '.eJxVjEEOwiAQRe_C2pAyZKC6dO8ZyDAMUjWQlHbVeHdt0oVu_3vvbyrQupSwdpnDlNRFGVCn3zESP6XuJD2o3pvmVpd5inpX9EG7vrUkr-vh_h0U6uVb00icwUSxgskiQQIcz5ac-IRIbAabSUxEGXymGI1ndABgs3dM2an3ByofON0:1vwzL4:7Ccdr0d5Y8x6XEzftrOJER9iwhfDarhoNFDJOJSghnI', '2026-03-16 09:13:18.735289'),
('oeni30tpyogcoasl72mgf89r1q5fj93o', '.eJxVjDsOwjAQBe_iGln-e6GkzxmsXX9wANlSnFSIu0OkFNC-mXkvFnBba9hGXsKc2IV5dvrdCOMjtx2kO7Zb57G3dZmJ7wo_6OBTT_l5Pdy_g4qjfmuXCIVzIIyAEqW3woEHKCVb7QkVGlBUNBnwRtozgELUTkirSOcEhb0_yUs3Iw:1vwyI8:8LtnXjXkinugfSwDXbytYIeIPW3X_iD6vPVRrXZldXM', '2026-03-16 08:06:12.551662'),
('pjetssgwpl2fp3yyot6rima4hzk2wov5', '.eJxVjEEOgjAQRe_StWkoLdMZl-49A5l2BkFNSSisjHdXEha6_e-9_zI9b-vYb1WXfhJzNs6b0--YOD-07ETuXG6zzXNZlynZXbEHrfY6iz4vh_t3MHIdv3WOhAmVOLrgXAQacutDRw00LjAOrQfw4Dx2mrAhEiUFgdSJoo-M5v0B2RM3EA:1vwybH:xSR33kG8XrhSLpq4ntJTOGrDaAC-0g7M9wPS-ytKDzM', '2026-03-16 08:25:59.121407'),
('posyy2d6yjy1si60v5gx11wcol7za684', '.eJxVjDsOwjAQBe_iGln-e6GkzxmsXX9wANlSnFSIu0OkFNC-mXkvFnBba9hGXsKc2IV5dvrdCOMjtx2kO7Zb57G3dZmJ7wo_6OBTT_l5Pdy_g4qjfmuXCIVzIIyAEqW3woEHKCVb7QkVGlBUNBnwRtozgELUTkirSOcEhb0_yUs3Iw:1vwxKj:nDFDW4wDk4exOXoO9xAFUZClx7IwOzG2D4vc6SrMEgc', '2026-03-16 07:04:49.796482'),
('r5ra5oj2gm504xj9ukyk9u0gdfy914ku', '.eJxVjDsOwyAQRO9CHSF-XiBlep_BWhYITiKQjF1FuXtsyUVSzrw382YTbmuZtp6WaY7syqRkl98yID1TPUh8YL03Tq2uyxz4ofCTdj62mF630_07KNjLvhYYwuCFohyVHRJZL0FC9gMYApNQa2PAArg9oTDCKeUUWZ2yI-GiY58v7-c3Iw:1vwxKB:kaA2MSExqokh_aN9uVorQf24BLrlhdzAxC7aidGH8_4', '2026-03-16 07:04:15.198295'),
('rupjysadrgcqc8s9bu0i5mbdz55693l1', '.eJxVjDsOwjAQBe_iGln-e6GkzxmsXX9wANlSnFSIu0OkFNC-mXkvFnBba9hGXsKc2IV5dvrdCOMjtx2kO7Zb57G3dZmJ7wo_6OBTT_l5Pdy_g4qjfmuXCIVzIIyAEqW3woEHKCVb7QkVGlBUNBnwRtozgELUTkirSOcEhb0_yUs3Iw:1vwvTB:ZVNQ3R6jvwCabS0LDoskjuEPY5_X1AYvNqcHJxCpz8k', '2026-03-16 05:05:25.030013'),
('xfcl5p6u0kvg556vql8wsfafekluym0q', '.eJxVjLEOAiEQRP-F2pBlOQ6xtPcbyC5L5NRActxVxn83JFdoM8W8N_NWkfatxL3nNS6iLgrV6bdjSs9cB5AH1XvTqdVtXVgPRR-061uT_Loe7t9BoV7G2mfDEggdegrzdJ4wCRvLPlnvHMKcM4wgB0bQcRAIxnkIHi0kVp8v2Uo3MQ:1vwvWS:_lrX0WU-8rlydlmqIjbAUnz1U3iG7YkscKeIMfrHgjs', '2026-03-16 05:08:48.684259');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) NOT NULL,
  `recipient_type` varchar(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` longtext NOT NULL,
  `notification_type` varchar(30) NOT NULL,
  `related_object_type` varchar(50) DEFAULT NULL,
  `related_object_id` bigint(20) DEFAULT NULL,
  `action_url` varchar(500) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL,
  `read_at` datetime(6) DEFAULT NULL,
  `priority` varchar(20) NOT NULL,
  `scheduled_for` datetime(6) DEFAULT NULL,
  `sent_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `recipient_customer_id` bigint(20) DEFAULT NULL,
  `recipient_staff_id` bigint(20) DEFAULT NULL,
  `recipient_user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `order_code` varchar(30) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time(6) NOT NULL,
  `estimated_amount` decimal(10,2) NOT NULL,
  `additional_amount` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `priority` varchar(20) NOT NULL,
  `inspection_result` varchar(20) NOT NULL,
  `customer_notes` longtext DEFAULT NULL,
  `staff_notes` longtext DEFAULT NULL,
  `cancel_reason` longtext DEFAULT NULL,
  `started_at` datetime(6) DEFAULT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `assigned_staff_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `station_id` bigint(20) NOT NULL,
  `vehicle_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_code`, `appointment_date`, `appointment_time`, `estimated_amount`, `additional_amount`, `status`, `priority`, `inspection_result`, `customer_notes`, `staff_notes`, `cancel_reason`, `started_at`, `completed_at`, `created_at`, `updated_at`, `assigned_staff_id`, `customer_id`, `station_id`, `vehicle_id`) VALUES
(1, 'DK20260115ABC123', '2026-01-15', '09:00:00.000000', 340000.00, 0.00, 'completed', 'normal', 'pass', 'Xe chạy tốt, cần kiểm tra nhanh', 'Xe trong tình trạng tốt', NULL, '2026-01-15 09:05:00.000000', '2026-01-15 10:30:00.000000', '2026-01-10 14:20:00.000000', '2026-01-15 10:30:00.000000', 1, 1, 1, 1),
(2, 'DK20260202DEF456', '2026-02-02', '10:30:00.000000', 340000.00, 0.00, 'completed', 'normal', 'pass', NULL, 'Tất cả ổn', NULL, '2026-02-02 10:35:00.000000', '2026-02-02 11:50:00.000000', '2026-01-28 09:15:00.000000', '2026-02-02 11:50:00.000000', 2, 1, 1, 2),
(3, 'DK20260220GHI789', '2026-02-20', '14:00:00.000000', 450000.00, 50000.00, 'completed', 'high', 'fail', 'Gấp, cần kết quả sớm', 'Cần thay gạt mưa và đèn xi-nhan', NULL, '2026-02-20 14:10:00.000000', '2026-02-20 15:45:00.000000', '2026-02-18 16:30:00.000000', '2026-02-20 15:45:00.000000', 1, 1, 1, 3),
(4, 'DK20260210JKL012', '2026-02-10', '08:00:00.000000', 340000.00, 0.00, 'completed', 'normal', 'pass', NULL, 'OK', NULL, '2026-02-10 08:05:00.000000', '2026-02-10 09:20:00.000000', '2026-02-05 10:00:00.000000', '2026-02-10 09:20:00.000000', 4, 2, 3, 4),
(5, 'DK20260225MNO345', '2026-02-25', '11:00:00.000000', 120000.00, 0.00, 'completed', 'normal', 'pass', NULL, 'Xe máy tình trạng tốt', NULL, '2026-02-25 11:10:00.000000', '2026-02-25 11:45:00.000000', '2026-02-22 13:45:00.000000', '2026-02-25 11:45:00.000000', 4, 2, 3, 5),
(6, 'DK20260228PQR678', '2026-02-28', '09:30:00.000000', 340000.00, 0.00, 'completed', 'normal', 'pass', 'Xe mới mua, cần đăng kiểm lần đầu', 'Xe mới, tình trạng xuất sắc', NULL, '2026-02-28 09:35:00.000000', '2026-02-28 10:50:00.000000', '2026-02-24 08:20:00.000000', '2026-02-28 10:50:00.000000', 3, 3, 2, 6),
(7, 'DK20260302STU901', '2026-03-02', '13:00:00.000000', 420000.00, 0.00, 'confirmed', 'normal', 'not_started', 'Lần đầu đăng kiểm', NULL, NULL, NULL, NULL, '2026-02-28 15:30:00.000000', '2026-03-01 09:00:00.000000', NULL, 4, 5, 7),
(8, 'DK20260305VWX234', '2026-03-05', '10:00:00.000000', 420000.00, 0.00, 'pending', 'normal', 'not_started', NULL, NULL, NULL, NULL, NULL, '2026-03-01 11:20:00.000000', '2026-03-01 11:20:00.000000', NULL, 5, 3, 7);

-- --------------------------------------------------------

--
-- Table structure for table `order_checklist`
--

CREATE TABLE `order_checklist` (
  `id` bigint(20) NOT NULL,
  `result` varchar(20) DEFAULT NULL,
  `measured_value` varchar(100) DEFAULT NULL,
  `photo_url` varchar(500) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `checked_at` datetime(6) DEFAULT NULL,
  `checklist_item_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `check_type` varchar(20) DEFAULT NULL,
  `checked_by_id` bigint(20) DEFAULT NULL,
  `is_checked` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_checklist`
--

INSERT INTO `order_checklist` (`id`, `result`, `measured_value`, `photo_url`, `notes`, `checked_at`, `checklist_item_id`, `order_id`, `check_type`, `checked_by_id`, `is_checked`) VALUES
(1, 'pass', NULL, 'https://example.com/check1.jpg', 'Phanh tốt', '2026-01-15 09:15:00.000000', 1, 1, NULL, NULL, 0),
(2, 'pass', NULL, 'https://example.com/check2.jpg', 'Phanh tốt', '2026-01-15 09:18:00.000000', 2, 1, NULL, NULL, 0),
(3, 'pass', '2.2 bar', 'https://example.com/check3.jpg', 'Lốp còn 70%', '2026-01-15 09:25:00.000000', 11, 1, NULL, NULL, 0),
(4, 'pass', '0.8%', 'https://example.com/check4.jpg', 'CO đạt chuẩn', '2026-01-15 10:00:00.000000', 42, 1, NULL, NULL, 0),
(5, 'pass', '120 ppm', 'https://example.com/check5.jpg', 'HC đạt chuẩn', '2026-01-15 10:05:00.000000', 43, 1, NULL, NULL, 0),
(6, 'pass', NULL, 'https://example.com/check6.jpg', 'Phanh OK', '2026-02-20 14:20:00.000000', 1, 3, NULL, NULL, 0),
(7, 'fail', NULL, 'https://example.com/check7.jpg', 'Đèn xi-nhan phải không sáng', '2026-02-20 14:35:00.000000', 21, 3, NULL, NULL, 0),
(8, 'fail', NULL, NULL, 'Gạt mưa bị mòn', '2026-02-20 14:40:00.000000', 26, 3, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_status_history`
--

CREATE TABLE `order_status_history` (
  `id` bigint(20) NOT NULL,
  `from_status` varchar(20) NOT NULL,
  `to_status` varchar(20) NOT NULL,
  `notes` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_status_history`
--

INSERT INTO `order_status_history` (`id`, `from_status`, `to_status`, `notes`, `created_at`, `changed_by_id`, `order_id`) VALUES
(1, 'pending', 'confirmed', 'Đã xác nhận lịch hẹn', '2026-01-10 14:25:00.000000', 2, 1),
(2, 'confirmed', 'assigned', 'Đã phân công cho NV001', '2026-01-12 10:00:00.000000', 2, 1),
(3, 'assigned', 'in_progress', 'Bắt đầu kiểm tra', '2026-01-15 09:05:00.000000', 7, 1),
(4, 'in_progress', 'completed', 'Hoàn thành - Đạt', '2026-01-15 10:30:00.000000', 7, 1),
(5, 'pending', 'confirmed', 'Xác nhận', '2026-01-28 10:00:00.000000', 2, 2),
(6, 'confirmed', 'assigned', 'Phân công NV002', '2026-01-30 09:00:00.000000', 2, 2),
(7, 'assigned', 'in_progress', 'Bắt đầu', '2026-02-02 10:35:00.000000', 8, 2),
(8, 'in_progress', 'completed', 'Hoàn thành', '2026-02-02 11:50:00.000000', 8, 2),
(9, 'pending', 'confirmed', 'Xác nhận lịch hẹn', '2026-03-01 09:00:00.000000', 2, 7);

-- --------------------------------------------------------

--
-- Table structure for table `otp_verification`
--

CREATE TABLE `otp_verification` (
  `id` bigint(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `otp_code` varchar(6) NOT NULL,
  `purpose` varchar(50) NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `expires_at` datetime(6) NOT NULL,
  `verified_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `otp_verification`
--

INSERT INTO `otp_verification` (`id`, `phone`, `otp_code`, `purpose`, `is_verified`, `expires_at`, `verified_at`, `created_at`) VALUES
(1, '0912345678', '123456', 'login', 1, '2026-03-02 12:00:00.000000', '2026-03-02 11:55:00.000000', '2026-03-02 11:50:00.000000'),
(2, '0987654321', '654321', 'register', 1, '2026-03-02 12:00:00.000000', '2026-03-02 11:58:00.000000', '2026-03-02 11:53:00.000000'),
(3, '0912345678', '332739', 'login', 1, '2026-03-02 05:13:43.619404', '2026-03-02 05:08:48.656015', '2026-03-02 05:08:43.620072'),
(5, '0382786317', '401455', 'register', 1, '2026-03-02 05:14:53.457596', '2026-03-02 05:09:58.750938', '2026-03-02 05:09:53.457789'),
(6, '0912345678', '699176', 'login', 0, '2026-03-02 05:28:08.233196', NULL, '2026-03-02 05:23:08.233581'),
(8, '0382786317', '613470', 'login', 1, '2026-03-02 06:56:01.995830', '2026-03-02 06:51:03.285928', '2026-03-02 06:51:01.996194'),
(9, '0382786317', '498986', 'login', 1, '2026-03-02 07:09:06.155812', '2026-03-02 07:04:15.165900', '2026-03-02 07:04:06.156179'),
(11, '0382786317', '425530', 'login', 0, '2026-03-02 07:31:11.130180', NULL, '2026-03-02 07:26:11.130644'),
(16, '0382786317', '493314', 'register', 0, '2026-03-02 08:24:16.574187', NULL, '2026-03-02 08:19:16.575148'),
(17, '0973685142', '880023', 'register', 0, '2026-03-02 08:30:32.669466', NULL, '2026-03-02 08:25:32.669877');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) NOT NULL,
  `transaction_code` varchar(100) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(30) NOT NULL,
  `status` varchar(20) NOT NULL,
  `payment_proof_url` varchar(500) DEFAULT NULL,
  `paid_at` datetime(6) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `payment_type` varchar(20) DEFAULT NULL,
  `qr_content` longtext DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `vietqr_code_url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `transaction_code`, `amount`, `payment_method`, `status`, `payment_proof_url`, `paid_at`, `notes`, `created_at`, `updated_at`, `order_id`, `payment_type`, `qr_content`, `transaction_id`, `vietqr_code_url`) VALUES
(1, 'PAY20260115103000A1B2C3', 340000.00, 'cash', 'paid', NULL, '2026-01-15 10:30:00.000000', 'Thanh toán tiền mặt tại quầy', '2026-01-15 10:30:00.000000', '2026-01-15 10:30:00.000000', 1, NULL, NULL, NULL, NULL),
(2, 'PAY20260202115000D4E5F6', 340000.00, 'bank_transfer', 'paid', 'https://example.com/proof2.jpg', '2026-02-02 11:50:00.000000', 'Chuyển khoản ngân hàng', '2026-02-02 11:50:00.000000', '2026-02-02 11:50:00.000000', 2, NULL, NULL, NULL, NULL),
(3, 'PAY20260220154500G7H8I9', 500000.00, 'momo', 'paid', NULL, '2026-02-20 15:45:00.000000', 'Thanh toán qua Momo', '2026-02-20 15:45:00.000000', '2026-02-20 15:45:00.000000', 3, NULL, NULL, NULL, NULL),
(4, 'PAY20260210092000J0K1L2', 340000.00, 'vietqr', 'paid', 'https://example.com/proof4.jpg', '2026-02-10 09:20:00.000000', 'Quét VietQR', '2026-02-10 09:20:00.000000', '2026-02-10 09:20:00.000000', 4, NULL, NULL, NULL, NULL),
(5, 'PAY20260225114500M3N4O5', 120000.00, 'cash', 'paid', NULL, '2026-02-25 11:45:00.000000', 'Tiền mặt', '2026-02-25 11:45:00.000000', '2026-02-25 11:45:00.000000', 5, NULL, NULL, NULL, NULL),
(6, 'PAY20260228105000P6Q7R8', 340000.00, 'vnpay', 'paid', NULL, '2026-02-28 10:50:00.000000', 'VNPay', '2026-02-28 10:50:00.000000', '2026-02-28 10:50:00.000000', 6, NULL, NULL, NULL, NULL),
(7, 'PAY20260302000000S9T0U1', 420000.00, 'bank_transfer', 'pending', NULL, NULL, 'Chờ xác nhận chuyển khoản', '2026-03-02 13:00:00.000000', '2026-03-02 13:00:00.000000', 7, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) NOT NULL,
  `permission_code` varchar(100) NOT NULL,
  `permission_name` varchar(150) NOT NULL,
  `module` varchar(50) NOT NULL,
  `description` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pricings`
--

CREATE TABLE `pricings` (
  `id` bigint(20) NOT NULL,
  `inspection_fee` decimal(10,2) NOT NULL,
  `document_fee` decimal(10,2) NOT NULL,
  `stamp_fee` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `effective_from` date NOT NULL,
  `effective_to` date DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `vehicle_type_id` bigint(20) NOT NULL,
  `emission_test_fee` decimal(10,2) NOT NULL,
  `sticker_fee` decimal(10,2) NOT NULL,
  `vat_percent` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pricings`
--

INSERT INTO `pricings` (`id`, `inspection_fee`, `document_fee`, `stamp_fee`, `total_amount`, `effective_from`, `effective_to`, `status`, `created_at`, `updated_at`, `vehicle_type_id`, `emission_test_fee`, `sticker_fee`, `vat_percent`) VALUES
(1, 100000.00, 10000.00, 10000.00, 120000.00, '2026-01-01', '2026-12-31', 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 1, 0.00, 0.00, 10.00),
(2, 150000.00, 15000.00, 15000.00, 180000.00, '2026-01-01', '2026-12-31', 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 2, 0.00, 0.00, 10.00),
(3, 300000.00, 20000.00, 20000.00, 340000.00, '2026-01-01', '2026-12-31', 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 3, 0.00, 0.00, 10.00),
(4, 370000.00, 25000.00, 25000.00, 420000.00, '2026-01-01', '2026-12-31', 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 4, 0.00, 0.00, 10.00),
(5, 400000.00, 25000.00, 25000.00, 450000.00, '2026-01-01', '2026-12-31', 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 5, 0.00, 0.00, 10.00),
(6, 520000.00, 30000.00, 30000.00, 580000.00, '2026-01-01', '2026-12-31', 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 6, 0.00, 0.00, 10.00),
(7, 700000.00, 40000.00, 40000.00, 780000.00, '2026-01-01', '2026-12-31', 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 7, 0.00, 0.00, 10.00),
(8, 1080000.00, 60000.00, 60000.00, 1200000.00, '2026-01-01', '2026-12-31', 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 8, 0.00, 0.00, 10.00),
(9, 850000.00, 50000.00, 50000.00, 950000.00, '2026-01-01', '2026-12-31', 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 9, 0.00, 0.00, 10.00),
(10, 1350000.00, 75000.00, 75000.00, 1500000.00, '2026-01-01', '2026-12-31', 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 10, 0.00, 0.00, 10.00);

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` bigint(20) NOT NULL,
  `overall_rating` int(11) NOT NULL,
  `service_rating` int(11) DEFAULT NULL,
  `staff_rating` int(11) DEFAULT NULL,
  `facility_rating` int(11) DEFAULT NULL,
  `comment` longtext DEFAULT NULL,
  `photos_url` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `staff_id` bigint(20) NOT NULL,
  `admin_response` longtext DEFAULT NULL,
  `cons` longtext DEFAULT NULL,
  `pros` longtext DEFAULT NULL,
  `responded_at` datetime(6) DEFAULT NULL,
  `responded_by_id` bigint(20) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`id`, `overall_rating`, `service_rating`, `staff_rating`, `facility_rating`, `comment`, `photos_url`, `created_at`, `customer_id`, `order_id`, `staff_id`, `admin_response`, `cons`, `pros`, `responded_at`, `responded_by_id`, `status`, `updated_at`) VALUES
(1, 5, 5, 5, 5, 'Dịch vụ tuyệt vời, nhân viên nhiệt tình!', NULL, '2026-01-15 11:00:00.000000', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 'pending', '2026-03-02 09:12:41.221224'),
(2, 4, 4, 4, 4, 'Tốt, hài lòng', NULL, '2026-02-02 12:30:00.000000', 1, 2, 2, NULL, NULL, NULL, NULL, NULL, 'pending', '2026-03-02 09:12:41.221224'),
(3, 5, 5, 5, 5, 'Rất chuyên nghiệp, phát hiện lỗi kỹ', NULL, '2026-02-20 16:15:00.000000', 1, 3, 1, NULL, NULL, NULL, NULL, NULL, 'pending', '2026-03-02 09:12:41.221224'),
(4, 5, 5, 5, 4, 'Nhanh gọn, chính xác', NULL, '2026-02-10 10:00:00.000000', 2, 4, 4, NULL, NULL, NULL, NULL, NULL, 'pending', '2026-03-02 09:12:41.221224'),
(5, 4, 4, 5, 4, 'OK', NULL, '2026-02-25 12:00:00.000000', 2, 5, 4, NULL, NULL, NULL, NULL, NULL, 'pending', '2026-03-02 09:12:41.221224'),
(6, 5, 5, 5, 5, 'Xe mới, dịch vụ rất tốt!', '[\"https://example.com/rating1.jpg\"]', '2026-02-28 11:30:00.000000', 3, 6, 3, NULL, NULL, NULL, NULL, NULL, 'pending', '2026-03-02 09:12:41.221224');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(50) NOT NULL,
  `description` longtext DEFAULT NULL,
  `level` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `color` varchar(20) NOT NULL,
  `priority` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `code`, `description`, `level`, `status`, `created_at`, `updated_at`, `color`, `priority`) VALUES
(1, 'Quản trị viên', 'ADMIN', 'Quản lý toàn bộ hệ thống', 1, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 'blue', 0),
(2, 'Nhân viên kiểm định', 'INSPECTOR', 'Thực hiện kiểm tra và đăng kiểm xe', 2, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 'blue', 0),
(3, 'Lễ tân', 'RECEPTIONIST', 'Tiếp nhận khách hàng và tạo lịch hẹn', 3, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 'blue', 0),
(4, 'Kế toán', 'ACCOUNTANT', 'Quản lý thanh toán và tài chính', 4, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 'blue', 0),
(5, 'Kỹ thuật viên', 'TECHNICIAN', 'Hỗ trợ kỹ thuật và bảo trì thiết bị', 5, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 'blue', 0);

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` bigint(20) NOT NULL,
  `employee_code` varchar(20) NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `avatar_url` varchar(500) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `tasks_total` int(11) NOT NULL,
  `tasks_completed` int(11) NOT NULL,
  `rating_average` decimal(3,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `station_id` bigint(20) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `employee_code`, `full_name`, `phone`, `avatar_url`, `position`, `hire_date`, `birth_date`, `gender`, `address`, `tasks_total`, `tasks_completed`, `rating_average`, `status`, `created_at`, `updated_at`, `role_id`, `station_id`, `user_id`) VALUES
(1, 'NV001', 'Nguyễn Văn F', '0911111111', NULL, 'Nhân viên kiểm định chính', '2023-01-15', '1985-04-10', 'male', '111 Đường NV1, Hà Nội', 150, 145, 4.85, 'active', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 2, 1, 7),
(2, 'NV002', 'Trần Văn G', '0922222222', NULL, 'Nhân viên kiểm định', '2023-06-20', '1990-09-05', 'male', '222 Đường NV2, Hà Nội', 98, 95, 4.70, 'active', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 2, 1, 8),
(3, 'NV003', 'Lê Thị H', '0933333333', NULL, 'Lễ tân trưởng', '2022-08-10', '1988-12-15', 'female', '333 Đường NV3, Hà Nội', 200, 198, 4.92, 'active', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 3, 2, 9),
(4, 'NV004', 'Phạm Văn I', '0944444444', NULL, 'Nhân viên kiểm định', '2024-01-05', '1992-06-22', 'male', '444 Đường NV4, TP.HCM', 45, 43, 4.65, 'active', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 2, 3, 10);

-- --------------------------------------------------------

--
-- Table structure for table `stations`
--

CREATE TABLE `stations` (
  `id` bigint(20) NOT NULL,
  `station_code` varchar(20) NOT NULL,
  `station_name` varchar(200) NOT NULL,
  `address` longtext NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `open_time` time(6) DEFAULT NULL,
  `close_time` time(6) DEFAULT NULL,
  `daily_capacity` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `capacity` int(11) NOT NULL,
  `working_hours` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stations`
--

INSERT INTO `stations` (`id`, `station_code`, `station_name`, `address`, `phone`, `email`, `latitude`, `longitude`, `open_time`, `close_time`, `daily_capacity`, `status`, `created_at`, `updated_at`, `capacity`, `working_hours`) VALUES
(1, 'HN01', 'Trạm Đăng Kiểm Hà Nội 1 - Đống Đa', '123 Đường Láng, Phường Láng Thượng, Quận Đống Đa, Hà Nội', '024-3514-2233', 'hanoi1@dangkiem.vn', 21.0285000, 105.8048000, '07:00:00.000000', '17:00:00.000000', 50, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 10, NULL),
(2, 'HN02', 'Trạm Đăng Kiểm Hà Nội 2 - Cầu Giấy', '456 Phạm Văn Đồng, Phường Cổ Nhuế, Quận Cầu Giấy, Hà Nội', '024-3795-4422', 'hanoi2@dangkiem.vn', 21.0378000, 105.7804000, '07:00:00.000000', '17:00:00.000000', 60, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 10, NULL),
(3, 'HCM01', 'Trạm Đăng Kiểm TP.HCM 1 - Quận 1', '789 Lê Lợi, Phường Bến Thành, Quận 1, TP. Hồ Chí Minh', '028-3829-3344', 'hcm1@dangkiem.vn', 10.7756000, 106.7019000, '07:00:00.000000', '17:00:00.000000', 70, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 10, NULL),
(4, 'HCM02', 'Trạm Đăng Kiểm TP.HCM 2 - Tân Bình', '321 Hoàng Văn Thụ, Phường 4, Quận Tân Bình, TP. Hồ Chí Minh', '028-3844-5566', 'hcm2@dangkiem.vn', 10.7991000, 106.6544000, '07:00:00.000000', '17:00:00.000000', 65, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 10, NULL),
(5, 'DN01', 'Trạm Đăng Kiểm Đà Nẵng 1 - Hải Châu', '555 Nguyễn Văn Linh, Phường Hòa Thuận Tây, Quận Hải Châu, Đà Nẵng', '023-6384-7788', 'danang1@dangkiem.vn', 16.0544000, 108.2022000, '07:00:00.000000', '17:00:00.000000', 40, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 10, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` bigint(20) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_group` varchar(50) NOT NULL,
  `setting_name` varchar(200) NOT NULL,
  `setting_value` longtext DEFAULT NULL,
  `default_value` longtext DEFAULT NULL,
  `value_type` varchar(20) NOT NULL,
  `description` longtext DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `is_editable` tinyint(1) NOT NULL,
  `validation_rule` longtext DEFAULT NULL,
  `allowed_values` longtext DEFAULT NULL,
  `display_order` int(11) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `updated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` bigint(20) NOT NULL,
  `license_plate` varchar(20) NOT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `manufacture_year` int(11) DEFAULT NULL,
  `chassis_number` varchar(100) DEFAULT NULL,
  `engine_number` varchar(100) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `last_inspection_date` date DEFAULT NULL,
  `next_inspection_date` date DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `vehicle_type_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`id`, `license_plate`, `brand`, `model`, `color`, `manufacture_year`, `chassis_number`, `engine_number`, `registration_date`, `last_inspection_date`, `next_inspection_date`, `status`, `created_at`, `updated_at`, `customer_id`, `vehicle_type_id`) VALUES
(1, '29A-12345', 'Toyota', 'Vios', 'Trắng', 2018, 'VIN001ABC123', 'ENG001XYZ', '2018-03-15', '2025-03-15', '2026-03-15', 'active', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 1, 3),
(2, '30G-67890', 'Honda', 'City', 'Xám', 2020, 'VIN002DEF456', 'ENG002ABC', '2020-07-20', '2025-07-20', '2026-07-20', 'active', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 1, 3),
(3, '29C-11111', 'Ford', 'Ranger', 'Đen', 2019, 'VIN003GHI789', 'ENG003DEF', '2019-11-10', '2025-11-10', '2026-11-10', 'active', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 1, 5),
(4, '51F-22222', 'Mazda', 'CX-5', 'Đỏ', 2021, 'VIN004JKL012', 'ENG004GHI', '2021-05-05', '2025-05-05', '2026-05-05', 'active', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 2, 3),
(5, '51H-33333', 'Honda', 'Wave Alpha', 'Xanh', 2017, 'VIN005MNO345', 'ENG005JKL', '2017-08-08', '2025-08-08', '2026-08-08', 'active', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 2, 1),
(6, '30A-44444', 'Hyundai', 'Accent', 'Trắng', 2022, 'VIN006PQR678', 'ENG006MNO', '2022-01-12', '2025-01-12', '2026-01-12', 'active', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 3, 3),
(7, '43A-55555', 'Toyota', 'Fortuner', 'Bạc', 2020, 'VIN007STU901', 'ENG007PQR', '2020-09-20', NULL, NULL, 'active', '2026-03-02 00:00:00.000000', '2026-03-02 00:00:00.000000', 4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_types`
--

CREATE TABLE `vehicle_types` (
  `id` bigint(20) NOT NULL,
  `type_code` varchar(50) NOT NULL,
  `type_name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `display_order` int(11) NOT NULL,
  `icon_url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicle_types`
--

INSERT INTO `vehicle_types` (`id`, `type_code`, `type_name`, `description`, `base_price`, `status`, `created_at`, `updated_at`, `display_order`, `icon_url`) VALUES
(1, 'MOTO', 'Xe máy', 'Xe mô tô, xe gắn máy dưới 175cc', 120000.00, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 0, NULL),
(2, 'MOTO_HEAVY', 'Xe máy phân khối lớn', 'Xe mô tô từ 175cc trở lên', 180000.00, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 0, NULL),
(3, 'CAR_4S', 'Xe con dưới 9 chỗ', 'Xe ô tô con (sedan, hatchback, SUV) dưới 9 chỗ ngồi', 340000.00, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 0, NULL),
(4, 'CAR_7S', 'Xe 7-9 chỗ', 'Xe ô tô 7-9 chỗ ngồi (MPV, SUV 7 chỗ)', 420000.00, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 0, NULL),
(5, 'PICKUP', 'Xe bán tải', 'Xe bán tải (pickup truck)', 450000.00, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 0, NULL),
(6, 'TRUCK_LIGHT', 'Xe tải nhẹ (dưới 3.5 tấn)', 'Xe tải có tải trọng dưới 3.5 tấn', 580000.00, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 0, NULL),
(7, 'TRUCK_MEDIUM', 'Xe tải trung (3.5 - 8 tấn)', 'Xe tải có tải trọng từ 3.5 đến 8 tấn', 780000.00, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 0, NULL),
(8, 'TRUCK_HEAVY', 'Xe tải nặng (trên 8 tấn)', 'Xe tải có tải trọng trên 8 tấn', 1200000.00, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 0, NULL),
(9, 'BUS_SMALL', 'Xe khách dưới 30 chỗ', 'Xe buýt, xe khách dưới 30 chỗ ngồi', 950000.00, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 0, NULL),
(10, 'BUS_LARGE', 'Xe khách trên 30 chỗ', 'Xe buýt, xe khách từ 30 chỗ ngồi trở lên', 1500000.00, 'active', '2026-03-02 11:07:20.000000', '2026-03-02 11:07:20.000000', 0, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_messages_order_id_dc732baf_fk_orders_id` (`order_id`),
  ADD KEY `chat_messages_sender_customer_id_f8654ea3_fk_customers_id` (`sender_customer_id`),
  ADD KEY `chat_messages_sender_staff_id_f58e3653_fk_staff_id` (`sender_staff_id`),
  ADD KEY `chat_messages_sender_user_id_e15320d5_fk_auth_user_id` (`sender_user_id`);

--
-- Indexes for table `checklist_items`
--
ALTER TABLE `checklist_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `item_key` (`item_key`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `google_id` (`google_id`),
  ADD UNIQUE KEY `facebook_id` (`facebook_id`),
  ADD UNIQUE KEY `apple_id` (`apple_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_recipient_customer_id_bf3f4365_fk_customers_id` (`recipient_customer_id`),
  ADD KEY `notifications_recipient_staff_id_e6cf48cd_fk_staff_id` (`recipient_staff_id`),
  ADD KEY `notifications_recipient_user_id_42f935ff_fk_auth_user_id` (`recipient_user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_code` (`order_code`),
  ADD KEY `orders_assigned_staff_id_8050b97b_fk_staff_id` (`assigned_staff_id`),
  ADD KEY `orders_customer_id_b7016332_fk_customers_id` (`customer_id`),
  ADD KEY `orders_station_id_426ce7c9_fk_stations_id` (`station_id`),
  ADD KEY `orders_vehicle_id_59612d64_fk_vehicles_id` (`vehicle_id`);

--
-- Indexes for table `order_checklist`
--
ALTER TABLE `order_checklist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_checklist_checklist_item_id_731ce924_fk_checklist_items_id` (`checklist_item_id`),
  ADD KEY `order_checklist_order_id_141a1b53_fk_orders_id` (`order_id`),
  ADD KEY `order_checklist_checked_by_id_d61a1420_fk_staff_id` (`checked_by_id`);

--
-- Indexes for table `order_status_history`
--
ALTER TABLE `order_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_status_history_changed_by_id_f13feb0a_fk_auth_user_id` (`changed_by_id`),
  ADD KEY `order_status_history_order_id_d33fdfde_fk_orders_id` (`order_id`);

--
-- Indexes for table `otp_verification`
--
ALTER TABLE `otp_verification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaction_code` (`transaction_code`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permission_code` (`permission_code`);

--
-- Indexes for table `pricings`
--
ALTER TABLE `pricings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pricings_vehicle_type_id_283ae16b_fk_vehicle_types_id` (`vehicle_type_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`),
  ADD KEY `ratings_customer_id_5e571b3b_fk_customers_id` (`customer_id`),
  ADD KEY `ratings_staff_id_b80bbf11_fk_staff_id` (`staff_id`),
  ADD KEY `ratings_responded_by_id_99a95be0_fk_staff_id` (`responded_by_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_permissions_role_id_permission_id_04f77df0_uniq` (`role_id`,`permission_id`),
  ADD KEY `role_permissions_permission_id_ad343843_fk_permissions_id` (`permission_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_code` (`employee_code`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `staff_role_id_f8da7ae2_fk_roles_id` (`role_id`),
  ADD KEY `staff_station_id_d622d25d_fk_stations_id` (`station_id`);

--
-- Indexes for table `stations`
--
ALTER TABLE `stations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `station_code` (`station_code`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `system_settings_updated_by_id_cf1dfbba_fk_staff_id` (`updated_by_id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `license_plate` (`license_plate`),
  ADD KEY `vehicles_customer_id_04e6bf00_fk_customers_id` (`customer_id`),
  ADD KEY `vehicles_vehicle_type_id_45741935_fk_vehicle_types_id` (`vehicle_type_id`);

--
-- Indexes for table `vehicle_types`
--
ALTER TABLE `vehicle_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type_code` (`type_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `checklist_items`
--
ALTER TABLE `checklist_items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `order_checklist`
--
ALTER TABLE `order_checklist`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `order_status_history`
--
ALTER TABLE `order_status_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `otp_verification`
--
ALTER TABLE `otp_verification`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pricings`
--
ALTER TABLE `pricings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `stations`
--
ALTER TABLE `stations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `vehicle_types`
--
ALTER TABLE `vehicle_types`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD CONSTRAINT `chat_messages_order_id_dc732baf_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `chat_messages_sender_customer_id_f8654ea3_fk_customers_id` FOREIGN KEY (`sender_customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `chat_messages_sender_staff_id_f58e3653_fk_staff_id` FOREIGN KEY (`sender_staff_id`) REFERENCES `staff` (`id`),
  ADD CONSTRAINT `chat_messages_sender_user_id_e15320d5_fk_auth_user_id` FOREIGN KEY (`sender_user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_user_id_28f6c6eb_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_recipient_customer_id_bf3f4365_fk_customers_id` FOREIGN KEY (`recipient_customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `notifications_recipient_staff_id_e6cf48cd_fk_staff_id` FOREIGN KEY (`recipient_staff_id`) REFERENCES `staff` (`id`),
  ADD CONSTRAINT `notifications_recipient_user_id_42f935ff_fk_auth_user_id` FOREIGN KEY (`recipient_user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_assigned_staff_id_8050b97b_fk_staff_id` FOREIGN KEY (`assigned_staff_id`) REFERENCES `staff` (`id`),
  ADD CONSTRAINT `orders_customer_id_b7016332_fk_customers_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `orders_station_id_426ce7c9_fk_stations_id` FOREIGN KEY (`station_id`) REFERENCES `stations` (`id`),
  ADD CONSTRAINT `orders_vehicle_id_59612d64_fk_vehicles_id` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`);

--
-- Constraints for table `order_checklist`
--
ALTER TABLE `order_checklist`
  ADD CONSTRAINT `order_checklist_checked_by_id_d61a1420_fk_staff_id` FOREIGN KEY (`checked_by_id`) REFERENCES `staff` (`id`),
  ADD CONSTRAINT `order_checklist_checklist_item_id_731ce924_fk_checklist_items_id` FOREIGN KEY (`checklist_item_id`) REFERENCES `checklist_items` (`id`),
  ADD CONSTRAINT `order_checklist_order_id_141a1b53_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `order_status_history`
--
ALTER TABLE `order_status_history`
  ADD CONSTRAINT `order_status_history_changed_by_id_f13feb0a_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `order_status_history_order_id_d33fdfde_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_order_id_6086ad70_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `pricings`
--
ALTER TABLE `pricings`
  ADD CONSTRAINT `pricings_vehicle_type_id_283ae16b_fk_vehicle_types_id` FOREIGN KEY (`vehicle_type_id`) REFERENCES `vehicle_types` (`id`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_customer_id_5e571b3b_fk_customers_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `ratings_order_id_2d75e230_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `ratings_responded_by_id_99a95be0_fk_staff_id` FOREIGN KEY (`responded_by_id`) REFERENCES `staff` (`id`),
  ADD CONSTRAINT `ratings_staff_id_b80bbf11_fk_staff_id` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`);

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_permission_id_ad343843_fk_permissions_id` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  ADD CONSTRAINT `role_permissions_role_id_216516f2_fk_roles_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_role_id_f8da7ae2_fk_roles_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `staff_station_id_d622d25d_fk_stations_id` FOREIGN KEY (`station_id`) REFERENCES `stations` (`id`),
  ADD CONSTRAINT `staff_user_id_e6242ba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD CONSTRAINT `system_settings_updated_by_id_cf1dfbba_fk_staff_id` FOREIGN KEY (`updated_by_id`) REFERENCES `staff` (`id`);

--
-- Constraints for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `vehicles_customer_id_04e6bf00_fk_customers_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `vehicles_vehicle_type_id_45741935_fk_vehicle_types_id` FOREIGN KEY (`vehicle_type_id`) REFERENCES `vehicle_types` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
