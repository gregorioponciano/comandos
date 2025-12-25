/*
 Navicat Premium Data Transfer

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 50736 (5.7.36)
 Source Host           : localhost:3306
 Source Schema         : MarioBET

 Target Server Type    : MySQL
 Target Server Version : 50736 (5.7.36)
 File Encoding         : 65001

 Date: 02/02/2024 13:58:09
*/
CREATE DATABASE IF NOT EXISTS `MarioBET` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `MarioBET`;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for affiliate_histories
-- ----------------------------
DROP TABLE IF EXISTS `affiliate_histories`;
CREATE TABLE `affiliate_histories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `inviter` int(10) UNSIGNED NOT NULL,
  `commission` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `commission_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `deposited` tinyint(4) NULL DEFAULT 0,
  `deposited_amount` decimal(10, 2) NULL DEFAULT 0.00,
  `losses` bigint(20) NULL DEFAULT 0,
  `losses_amount` decimal(10, 2) NULL DEFAULT 0.00,
  `commission_paid` decimal(10, 2) NULL DEFAULT 0.00,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `affiliate_histories_user_id_index`(`user_id`) USING BTREE,
  INDEX `affiliate_histories_inviter_index`(`inviter`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of affiliate_histories
-- ----------------------------

-- ----------------------------
-- Table structure for banners
-- ----------------------------
DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'home',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of banners
-- ----------------------------
INSERT INTO `banners` VALUES (8, '#', '01HKZCGDG7CHX190CEG5D2AYTX.png', 'carousel', '...', '2024-01-12 14:46:23', '2024-01-12 14:46:23');
INSERT INTO `banners` VALUES (9, '#', '01HKZCJ3GTDYYBE4V4QN0AKW9F.png', 'carousel', '...', '2024-01-12 14:47:18', '2024-01-12 14:47:18');
INSERT INTO `banners` VALUES (6, '#', '01HKZCD0HTKCXM9FHT62QVY3R6.png', 'carousel', '...', '2024-01-12 14:44:31', '2024-01-12 14:45:10');
INSERT INTO `banners` VALUES (7, '#', '01HKZCFRC1KTYZ150YC4FPMNK7.png', 'carousel', '...\n', '2024-01-12 14:46:01', '2024-01-12 14:46:01');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(249) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `slug` varchar(249) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `slug`(`slug`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Recomendados', 'Todos os jogos recomendados', 'uploads/WVLcCZ4gGDgP1OPcv3M9y1BAnmOqU6-metadGVzb3VyZS5wbmc=-.png', 'recomendados', '2023-12-29 15:57:17', '2023-12-29 15:57:17');
INSERT INTO `categories` VALUES (2, 'Jogos da Fortuna', 'Lista de Jogos da fortuna', 'uploads/TXQREUiwee0dFOlYYUul0luttRMvWb-metadGlnZXItMi5wbmc=-.png', 'jogos-da-fortuna', '2023-12-29 15:58:34', '2023-12-29 15:58:34');

----------------------------
-- Tabela customizations
----------------------------
DROP TABLE IF EXISTS `customizations`;
CREATE TABLE `customizations` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    card_type VARCHAR(100),
    header_type VARCHAR(100),
    side_type VARCHAR(100),
    footer_type VARCHAR(100),
    primary_color VARCHAR(20),
    primary_border_color VARCHAR(20),
    primary_text VARCHAR(255),
    secondary_color VARCHAR(20),
    background_color VARCHAR(20),
    footer_color VARCHAR(20),
    expanded_layout TINYINT(1) DEFAULT 0, -- 0 = padrão, 1 = expandido
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- ----------------------------
-- Records of customizations
-- ----------------------------
INSERT INTO customizations (
    card_type,  header_type,  side_type,  footer_type,  primary_color,  primary_border_color,  primary_text,  secondary_color,  background_color,  footer_color,  expanded_layout
) VALUES (
    'standard', 'simple', 'left', 'simple', '#3B82F6', '#1D4ED8', '#FFFFFF', '#22149cff', '#490eebff', '#b2b7c0ff', 0
);

-- ----------------------------
-- Table structure for debug
-- ----------------------------
DROP TABLE IF EXISTS `debug`;
CREATE TABLE `debug`  (
  `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of debug
-- ----------------------------

-- ----------------------------
-- Table structure for deposits
-- ----------------------------
DROP TABLE IF EXISTS `deposits`;
CREATE TABLE `deposits`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `proof` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `deposits_user_id_foreign`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of deposits
-- ----------------------------

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for game_exclusives
-- ----------------------------
DROP TABLE IF EXISTS `game_exclusives`;
CREATE TABLE `game_exclusives`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `winLength` bigint(20) NOT NULL DEFAULT 3,
  `loseLength` bigint(20) NOT NULL DEFAULT 20,
  `influencer_winLength` bigint(20) NOT NULL DEFAULT 20,
  `influencer_loseLength` bigint(20) NOT NULL DEFAULT 1,
  `iconsJson` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(4) NULL DEFAULT 1,
  `views` bigint(20) NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `game_exclusives_category_id_foreign`(`category_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of game_exclusives
-- ----------------------------
INSERT INTO `game_exclusives` (
  `id`, `category_id`, `uuid`, `name`, `description`, `cover`, `icon`, 
  `winLength`, `loseLength`, `influencer_winLength`, `influencer_loseLength`, 
  `iconsJson`, `active`, `views`, `created_at`, `updated_at`
) VALUES 
-- Jogo 1: Fortune Tiger
(
  1, 1, 'fortunetiger', 'Fortune Tiger', 
  '<p>Jogo Fortune Tiger - Caça-níquel com tema de tigre chinês da sorte</p>', 
  '01HKZETNNTS3KNQ5W6VPX52420.png', 
  'Lq6sofAr3rU4AvAbUaw2dazLpOhoFD-metadGlnZXItMi5wbmc=-.png', 
  1, 20, 30, 1, 
  '{
    \"success\": true,
    \"data\": [
      {\"icon_name\": \"Symbol_0\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_1\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_2\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 50, \"win_4\": 250, \"win_5\": 2500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_3\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 20, \"win_4\": 100, \"win_5\": 1000, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_4\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 15, \"win_4\": 50, \"win_5\": 500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_5\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 25, \"win_5\": 200, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_6\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 20, \"win_5\": 100, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_7\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 4, \"win_4\": 15, \"win_5\": 75, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_8\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 3, \"win_4\": 10, \"win_5\": 50, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null}
    ],
    \"message\": \"List icons success\"
  }', 
  1, 1878, '2023-10-07 16:18:46', '2024-01-28 14:44:57'
),

-- Jogo 2: Fortune OX
(
  2, 1, 'fortuneox', 'Fortune OX', 
  '<p>Jogo Fortune OX - Caça-níquel com tema do boi da fortuna chinesa</p>', 
  '01HKZFFTCB8FNAPXP7MVTSY3Q1.png', 
  'eSwugWYqXBDiRKo4V3a93fivawpzqc-metab3gucG5n-.png', 
  1, 30, 20, 1, 
  '{
    \"success\": true,
    \"data\": [
      {\"icon_name\": \"Symbol_0\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_1\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_2\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 50, \"win_4\": 250, \"win_5\": 2500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_3\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 20, \"win_4\": 100, \"win_5\": 1000, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_4\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 15, \"win_4\": 50, \"win_5\": 500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_5\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 25, \"win_5\": 200, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_6\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 20, \"win_5\": 100, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_7\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 4, \"win_4\": 15, \"win_5\": 75, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_8\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 3, \"win_4\": 10, \"win_5\": 50, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null}
    ],
    \"message\": \"List icons success\"
  }', 
  1, 474, '2023-10-07 16:58:11', '2024-01-12 15:38:29'
),

-- Jogo 3: Fortune Mouse
(
  3, 1, 'fortunemouse', 'Fortune Mouse', 
  '<p>Jogo Fortune Mouse - Caça-níquel com tema do rato da sorte asiático</p>', 
  '01HKZFNW17EVQ6S8CWG1QFGH3P.png', 
  'BsJCiMUt4sLYcvRUaw4zqAjsUW4oqk-metabW91c2UucG5n-.png', 
  1, 30, 20, 1, 
  '{
    \"success\": true,
    \"data\": [
      {\"icon_name\": \"Symbol_0\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_1\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_2\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 50, \"win_4\": 250, \"win_5\": 2500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_3\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 20, \"win_4\": 100, \"win_5\": 1000, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_4\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 15, \"win_4\": 50, \"win_5\": 500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_5\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 25, \"win_5\": 200, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_6\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 20, \"win_5\": 100, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_7\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 4, \"win_4\": 15, \"win_5\": 75, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_8\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 3, \"win_4\": 10, \"win_5\": 50, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null}
    ],
    \"message\": \"List icons success\"
  }', 
  1, 516, '2023-10-07 17:06:52', '2024-01-12 15:41:47'
),

-- Jogo 4: Fortune Panda
(
  4, 1, 'fortunepanda', 'Fortune Panda', 
  '<p>Jogo Fortune Panda - Caça-níquel com tema do panda da sorte chinesa</p>', 
  '01HKZFNYZJ6EAYAQZ7SWWPX2VE.png', 
  'x9jw5Eu29n3UIJzr6ud8zhdqiO8u4d-metacGFuZGEucG5n-.png', 
  1, 20, 20, 1, 
  '{
    \"success\": true,
    \"data\": [
      {\"icon_name\": \"Symbol_0\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_1\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_2\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 50, \"win_4\": 250, \"win_5\": 2500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_3\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 20, \"win_4\": 100, \"win_5\": 1000, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_4\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 15, \"win_4\": 50, \"win_5\": 500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_5\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 25, \"win_5\": 200, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_6\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 20, \"win_5\": 100, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_7\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 4, \"win_4\": 15, \"win_5\": 75, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_8\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 3, \"win_4\": 10, \"win_5\": 50, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null}
    ],
    \"message\": \"List icons success\"
  }', 
  1, 513, '2023-10-07 20:18:52', '2024-01-12 15:41:50'
),

-- Jogo 5: Phoenix Rises
(
  5, 1, 'phoenixrises', 'Phoenix Rises', 
  '<p>Jogo Phoenix Rises - Caça-níquel com tema da fênix renascida das cinzas</p>', 
  '01HKZFP24MYHYE57G9VKE7WJCF.png', 
  'x7iN6vEcayfBZIQoy7XC7zbe2UVgns-metaZmVuaXgucG5n-.png', 
  1, 20, 20, 1, 
  '{
    \"success\": true,
    \"data\": [
      {\"icon_name\": \"Symbol_0\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_1\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_2\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 20, \"win_4\": 50, \"win_5\": 120, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_3\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 15, \"win_4\": 45, \"win_5\": 100, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_4\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 45, \"win_5\": 80, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_5\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 6, \"win_4\": 15, \"win_5\": 50, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_6\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 30, \"win_4\": 60, \"win_5\": 150, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_7\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 10, \"win_5\": 40, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_8\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 10, \"win_5\": 40, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_9\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 45, \"win_5\": 80, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null}
    ],
    \"message\": \"List icons success\"
  }', 
  1, 373, '2023-10-07 20:58:18', '2024-01-12 15:41:53'
),

-- Jogo 6: Queen of Bounty
(
  6, 1, 'queenofbounty', 'Queen of Bounty', 
  '<p>Jogo Queen of Bounty - Caça-níquel com tema de rainha dos mares e tesouros</p>', 
  '01HKZFP4B13D8K3V9SY9SX4ZWH.png', 
  'D4KfDqMiKGkeNYXnnTNdofzXAuohRj-metadGVzb3VyZS5wbmc=-.png', 
  1, 20, 20, 1, 
  '{
    \"success\": true,
    \"data\": [
      {\"icon_name\": \"Symbol_0\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_1\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_2\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 50, \"win_4\": 250, \"win_5\": 2500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_3\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 20, \"win_4\": 100, \"win_5\": 1000, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_4\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 15, \"win_4\": 50, \"win_5\": 500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_5\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 25, \"win_5\": 200, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_6\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 20, \"win_5\": 100, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_7\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 4, \"win_4\": 15, \"win_5\": 75, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_8\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 3, \"win_4\": 10, \"win_5\": 50, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null}
    ],
    \"message\": \"List icons success\"
  }', 
  1, 4, '2023-10-07 21:43:26', '2024-01-12 15:41:56'
),

-- Jogo 7: Treasures of Aztec
(
  7, 1, 'treasuresofaztec', 'Treasures of Aztec', 
  '<p>Jogo Treasures of Aztec - Caça-níquel com tema asteca e tesouros perdidos</p>', 
  '01HKZFP6QGV1TCVDY68SXXSFTY.png', 
  'SvaQYvS346lt4Qt4UTdAJ5k34Iv6Ew-metaMTM1NzUzOS5wbmc=-.png', 
  1, 20, 20, 1, 
  '{
    \"success\": true,
    \"data\": [
      {\"icon_name\": \"Symbol_0\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_1\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_2\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 50, \"win_4\": 250, \"win_5\": 2500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_3\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 20, \"win_4\": 100, \"win_5\": 1000, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_4\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 15, \"win_4\": 50, \"win_5\": 500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_5\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 25, \"win_5\": 200, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_6\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 20, \"win_5\": 100, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_7\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 4, \"win_4\": 15, \"win_5\": 75, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_8\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 3, \"win_4\": 10, \"win_5\": 50, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null}
    ],
    \"message\": \"List icons success\"
  }', 
  1, 263, '2023-10-07 22:22:00', '2024-01-12 15:41:58'
),

-- Jogo 8: Bikini Paradise
(
  8, 1, 'bikiniparadise', 'Bikini Paradise', 
  '<p>Jogo Bikini Paradise - Caça-níquel com tema tropical e praias paradisíacas</p>', 
  '01HKZFP9PV8CZWAWVZ0WSBJGA4.jpg', 
  'zSBdC8WTBkhpKWeL1qBv4ZU5NR3bdY-metaMjc5MzkzMy5wbmc=-.png', 
  1, 20, 20, 1, 
  '{
    \"success\": true,
    \"data\": [
      {\"icon_name\": \"Symbol_0\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_1\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_2\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 50, \"win_4\": 250, \"win_5\": 2500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_3\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 20, \"win_4\": 100, \"win_5\": 1000, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_4\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 15, \"win_4\": 50, \"win_5\": 500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_5\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 25, \"win_5\": 200, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_6\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 20, \"win_5\": 100, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_7\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 4, \"win_4\": 15, \"win_5\": 75, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_8\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 3, \"win_4\": 10, \"win_5\": 50, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null}
    ],
    \"message\": \"List icons success\"
  }', 
  1, 28, '2023-10-08 22:57:29', '2024-01-12 15:42:01'
),

-- Jogo 9: Hood VS Wolf
(
  9, 1, 'hoodvswoolf', 'Hood VS Wolf', 
  '<p>Jogo Hood VS Wolf - Caça-níquel com tema de confronto entre lobo e capuz vermelho</p>', 
  '01HKZFPCM5X4QJ72E51HTZGG20.png', 
  'llnN2dNJTN2FAyFYDvoW4pGhX6mQkQ-metadHJhbnNmZXJpci5wbmc=-.png', 
  1, 20, 20, 1, 
  '{
    \"success\": true,
    \"data\": [
      {\"icon_name\": \"Symbol_0\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_1\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_2\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 50, \"win_4\": 250, \"win_5\": 2500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_3\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 20, \"win_4\": 100, \"win_5\": 1000, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_4\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 15, \"win_4\": 50, \"win_5\": 500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_5\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 25, \"win_5\": 200, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_6\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 20, \"win_5\": 100, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_7\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 4, \"win_4\": 15, \"win_5\": 75, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_8\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 3, \"win_4\": 10, \"win_5\": 50, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null}
    ],
    \"message\": \"List icons success\"
  }', 
  1, 18, '2023-10-08 23:07:30', '2024-01-12 15:42:04'
),

-- Jogo 10: Jack Frost's
(
  10, 1, 'jackfrost', 'Jack Frost´s', 
  '<p>Jogo Jack Frost´s - Caça-níquel com tema de inverno e rei do gelo</p>', 
  '01HKZFPF0ZEM7QG9B1MWV3567Q.png', 
  'ciJKswrHRTZocwtMtDfIjerQp7y8od-metaMjQ5MjAyNi5wbmc=-.png', 
  1, 20, 20, 1, 
  '{
    \"success\": true,
    \"data\": [
      {\"icon_name\": \"Symbol_0\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_1\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_2\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 50, \"win_4\": 250, \"win_5\": 2500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_3\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 20, \"win_4\": 100, \"win_5\": 1000, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_4\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 15, \"win_4\": 50, \"win_5\": 500, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_5\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 25, \"win_5\": 200, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_6\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 20, \"win_5\": 100, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_7\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 4, \"win_4\": 15, \"win_5\": 75, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_8\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 3, \"win_4\": 10, \"win_5\": 50, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null}
    ],
    \"message\": \"List icons success\"
  }', 
  1, 10, '2023-10-09 20:23:13', '2024-01-12 15:42:07'
),

-- Jogo 11: Song Kran Party
(
  11, 1, 'songkranparty', 'Song Kran Party', 
  '<p>Jogo Song Kran Party - Caça-níquel com tema do festival tailandês da água</p>', 
  '01HKZFQVH73942P58EGST41K41.jpg', 
  '6li5RylQgxWOwFaKx5ijUbfG8GJ2x7-metaMTQ3MTQzNS0yMDAucG5n-.png', 
  1, 20, 20, 1, 
  '{
    \"success\": true,
    \"data\": [
      {\"icon_name\": \"Symbol_0\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_1\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 0, \"win_4\": 0, \"win_5\": 0, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_2\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 20, \"win_4\": 50, \"win_5\": 120, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_3\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 15, \"win_4\": 45, \"win_5\": 100, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_4\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 45, \"win_5\": 80, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_5\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 6, \"win_4\": 15, \"win_5\": 50, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_6\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 30, \"win_4\": 60, \"win_5\": 150, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_7\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 10, \"win_5\": 40, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_8\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 5, \"win_4\": 10, \"win_5\": 40, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null},
      {\"icon_name\": \"Symbol_9\", \"win_1\": 0, \"win_2\": 0, \"win_3\": 10, \"win_4\": 45, \"win_5\": 80, \"win_6\": 0, \"wild_card\": null, \"free_spin\": null, \"free_num\": 0, \"scaler_spin\": null}
    ],
    \"message\": \"List icons success\"
  }', 
  1, 19, '2023-10-09 20:25:21', '2024-01-12 15:42:52'
),

-- Jogo 12: Fortune Rabbit
(
  12, 1, 'fortunerabbit', 'Fortune Rabbit', 
  '<p>Jogo Fortune Rabbit - Caça-níquel com tema do coelho da sorte</p>', 
  '01HKZFPHAT5Q5EMWVZJMV9D3YC.png', 
  'G6c2v0xJxlqTdY3nPMhk4MsyF0cuem-metacmFiaWl0aWNvbi5wbmc=-.png', 
  1, 20, 20, 1, 
  '[]', 
  1, 970, '2023-10-10 20:45:45', '2024-01-12 15:42:09'
);

-- ----------------------------
-- Table structure for games_hashes
-- ----------------------------
DROP TABLE IF EXISTS `games_hashes`;
CREATE TABLE `games_hashes`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `hash` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `games_hashes_user_id_foreign`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of games_hashes
-- ----------------------------

-- ----------------------------
-- Table structure for gateways
-- ----------------------------
DROP TABLE IF EXISTS `gateways`;
CREATE TABLE `gateways`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `suitpay_uri` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `suitpay_cliente_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `suitpay_cliente_secret` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `stripe_production` tinyint(4) NULL DEFAULT 0,
  `stripe_public_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `stripe_secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `stripe_webhook_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bspay_uri` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bspay_cliente_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bspay_cliente_secret` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sqala_app_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sqala_app_secret` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sqala_access_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gateways
-- ----------------------------
INSERT INTO `gateways` VALUES (1, 'https://ws.suitpay.app/api/v1/', NULL, NULL, 0, NULL, NULL, NULL, '2023-11-30 18:05:51', '2024-01-14 21:52:08', 'https://api.bspay.co/v1/', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for ggr_games_fivers
-- ----------------------------
DROP TABLE IF EXISTS `ggr_games_fivers`;
CREATE TABLE `ggr_games_fivers`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `provider` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `game` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance_bet` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `balance_win` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `currency` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRL',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ggr_games_fivers_user_id_index`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ggr_games_fivers
-- ----------------------------


-- ----------------------------
-- Table structure for model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions`  (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_permissions_model_id_model_type_index`(`model_id`, `model_type`) USING BTREE,
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of model_has_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles`  (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_roles_model_id_model_type_index`(`model_id`, `model_type`) USING BTREE,
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of model_has_roles
-- ----------------------------
INSERT INTO `model_has_roles` VALUES (1, 'App\\Models\\User', 1);
INSERT INTO `model_has_roles` VALUES (1, 'App\\Models\\User', 134);

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications`  (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `notifications_notifiable_type_notifiable_id_index`(`notifiable_type`, `notifiable_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notifications
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `session_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `transaction_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `game` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `game_uuid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_money` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `providers` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `refunded` tinyint(4) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `round_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `orders_user_id_foreign`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `permissions_name_guard_name_unique`(`name`, `guard_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES (1, 'games-exclusive-edit', 'web', '2023-10-12 16:23:45', '2023-10-12 18:12:28');
INSERT INTO `permissions` VALUES (2, 'games-exclusive-view', 'web', '2023-10-12 16:23:56', '2023-10-12 18:11:25');
INSERT INTO `permissions` VALUES (3, 'games-exclusive-create', 'web', '2023-10-12 16:25:06', '2023-10-12 18:11:10');
INSERT INTO `permissions` VALUES (4, 'admin-view', 'web', '2023-10-12 17:56:35', '2023-10-12 17:56:35');
INSERT INTO `permissions` VALUES (5, 'admin-create', 'web', '2023-10-12 18:56:02', '2023-10-12 18:56:02');
INSERT INTO `permissions` VALUES (6, 'admin-edit', 'web', '2023-10-12 18:56:27', '2023-10-12 18:56:27');
INSERT INTO `permissions` VALUES (7, 'admin-delete', 'web', '2023-10-12 18:56:55', '2023-10-12 18:56:55');
INSERT INTO `permissions` VALUES (8, 'category-view', 'web', '2023-10-12 19:01:31', '2023-10-12 19:01:31');
INSERT INTO `permissions` VALUES (9, 'category-create', 'web', '2023-10-12 19:01:46', '2023-10-12 19:01:46');
INSERT INTO `permissions` VALUES (10, 'category-edit', 'web', '2023-10-12 19:01:59', '2023-10-12 19:01:59');
INSERT INTO `permissions` VALUES (11, 'category-delete', 'web', '2023-10-12 19:02:09', '2023-10-12 19:02:09');
INSERT INTO `permissions` VALUES (12, 'game-view', 'web', '2023-10-12 19:02:27', '2023-10-12 19:02:27');
INSERT INTO `permissions` VALUES (13, 'game-create', 'web', '2023-10-12 19:02:36', '2023-10-12 19:02:36');
INSERT INTO `permissions` VALUES (14, 'game-edit', 'web', '2023-10-12 19:02:44', '2023-10-12 19:02:44');
INSERT INTO `permissions` VALUES (15, 'game-delete', 'web', '2023-10-12 19:02:54', '2023-10-12 19:02:54');
INSERT INTO `permissions` VALUES (16, 'wallet-view', 'web', '2023-10-12 19:05:49', '2023-10-12 19:05:49');
INSERT INTO `permissions` VALUES (17, 'wallet-create', 'web', '2023-10-12 19:06:01', '2023-10-12 19:06:01');
INSERT INTO `permissions` VALUES (18, 'wallet-edit', 'web', '2023-10-12 19:06:11', '2023-10-12 19:06:11');
INSERT INTO `permissions` VALUES (19, 'wallet-delete', 'web', '2023-10-12 19:06:18', '2023-10-12 19:06:18');
INSERT INTO `permissions` VALUES (20, 'deposit-view', 'web', '2023-10-12 19:06:44', '2023-10-12 19:06:44');
INSERT INTO `permissions` VALUES (21, 'deposit-create', 'web', '2023-10-12 19:06:56', '2023-10-12 19:06:56');
INSERT INTO `permissions` VALUES (22, 'deposit-edit', 'web', '2023-10-12 19:07:05', '2023-10-12 19:07:05');
INSERT INTO `permissions` VALUES (23, 'deposit-update', 'web', '2023-10-12 19:08:00', '2023-10-12 19:08:00');
INSERT INTO `permissions` VALUES (24, 'deposit-delete', 'web', '2023-10-12 19:08:11', '2023-10-12 19:08:11');
INSERT INTO `permissions` VALUES (25, 'withdrawal-view', 'web', '2023-10-12 19:09:31', '2023-10-12 19:09:31');
INSERT INTO `permissions` VALUES (26, 'withdrawal-create', 'web', '2023-10-12 19:09:40', '2023-10-12 19:09:40');
INSERT INTO `permissions` VALUES (27, 'withdrawal-edit', 'web', '2023-10-12 19:09:51', '2023-10-12 19:09:51');
INSERT INTO `permissions` VALUES (28, 'withdrawal-update', 'web', '2023-10-12 19:10:00', '2023-10-12 19:10:00');
INSERT INTO `permissions` VALUES (29, 'withdrawal-delete', 'web', '2023-10-12 19:10:09', '2023-10-12 19:10:09');
INSERT INTO `permissions` VALUES (30, 'order-view', 'web', '2023-10-12 19:12:36', '2023-10-12 19:12:36');
INSERT INTO `permissions` VALUES (31, 'order-create', 'web', '2023-10-12 19:12:47', '2023-10-12 19:12:47');
INSERT INTO `permissions` VALUES (32, 'order-edit', 'web', '2023-10-12 19:12:56', '2023-10-12 19:12:56');
INSERT INTO `permissions` VALUES (33, 'order-update', 'web', '2023-10-12 19:13:06', '2023-10-12 19:13:06');
INSERT INTO `permissions` VALUES (34, 'order-delete', 'web', '2023-10-12 19:13:19', '2023-10-12 19:13:19');
INSERT INTO `permissions` VALUES (35, 'admin-menu-view', 'web', '2023-10-12 20:26:06', '2023-10-12 20:26:06');
INSERT INTO `permissions` VALUES (36, 'setting-view', 'web', '2023-10-12 21:25:46', '2023-10-12 21:25:46');
INSERT INTO `permissions` VALUES (37, 'setting-create', 'web', '2023-10-12 21:25:57', '2023-10-12 21:25:57');
INSERT INTO `permissions` VALUES (38, 'setting-edit', 'web', '2023-10-12 21:26:06', '2023-10-12 21:26:06');
INSERT INTO `permissions` VALUES (39, 'setting-update', 'web', '2023-10-12 21:26:19', '2023-10-12 21:26:19');
INSERT INTO `permissions` VALUES (40, 'setting-delete', 'web', '2023-10-12 21:26:33', '2023-10-12 21:26:33');

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token`) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type`, `tokenable_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for role_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions`  (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `role_id`) USING BTREE,
  INDEX `role_has_permissions_role_id_foreign`(`role_id`) USING BTREE,
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of role_has_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `roles_name_guard_name_unique`(`name`, `guard_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'admin', 'web', '2023-10-12 16:20:41', '2023-10-12 16:20:41');
INSERT INTO `roles` VALUES (2, 'afiliado', 'web', '2023-10-12 16:21:08', '2023-10-12 16:21:08');

-- ----------------------------
-- Table structure for setting_mails
-- ----------------------------
DROP TABLE IF EXISTS `setting_mails`;
CREATE TABLE `setting_mails`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `software_smtp_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `software_smtp_mail_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `software_smtp_mail_port` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `software_smtp_mail_username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `software_smtp_mail_password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `software_smtp_mail_encryption` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `software_smtp_mail_from_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `software_smtp_mail_from_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of setting_mails
-- ----------------------------

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `software_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `software_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `software_favicon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `software_logo_white` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `software_logo_black` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `currency_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRL',
  `decimal_format` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'dot',
  `currency_position` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'left',
  `revshare_percentage` bigint(20) NULL DEFAULT 20,
  `ngr_percent` bigint(20) NULL DEFAULT 20,
  `soccer_percentage` bigint(20) NULL DEFAULT 30,
  `prefix` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'R$',
  `storage` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local',
  `initial_bonus` bigint(20) NULL DEFAULT 0,
  `min_deposit` decimal(10, 2) NULL DEFAULT 20.00,
  `max_deposit` decimal(10, 2) NULL DEFAULT 0.00,
  `min_withdrawal` decimal(10, 2) NULL DEFAULT 20.00,
  `max_withdrawal` decimal(10, 2) NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `maintenance_mode` tinyint(4) NULL DEFAULT 0,
  `rollover` bigint(20) NULL DEFAULT 1,
  `rollover_deposit` bigint(20) NULL DEFAULT 1,
  `instagram` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `discord` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `telegram` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `twitter` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tiktok` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `whatsapp` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `active_gateway` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'bspay',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO `settings` VALUES (1, 'MarioBET', 'MarioBET plataforma de Cassino', 'uploads/V83e4sf9QFOrhuMEa2jn8JjIsfFKkHBdIBeCl8s7.png', 'uploads/77HurxHeGIwbNfvJYzR4BTuQiNVEBlVIPdNGKYij.png', 'uploads/fEm7xUQjyUPJmhotqVQrnsSHfZoDD7o6pwrJUqcB.png', 'BRL', 'dot', 'left', 20, 20, 30, 'R$', 'local', 100, 20.00, 50000.00, 20.00, 50000.00, '2023-09-24 17:40:05', '2024-01-13 22:44:53', 0, 10, 1, 'https://www.instagram.com/gpwebsolution/',  NULL, NULL, NULL, 'https://www.tiktok.com/login?redirect_url=https%3A%2F%2Fwww.tiktok.com%2Fpt-BR%2F&lang=en&enter_method=mandatory', 'https://api.whatsapp.com/send/?phone=5514991761256&text=Ol%C3%A1%2C+Td+bem%3F+Como+posso+ajudar%3F&type=phone_number&app_absent=0', 'sqala');

-- ----------------------------
-- Table structure for suit_pay_payments
-- ----------------------------
DROP TABLE IF EXISTS `suit_pay_payments`;
CREATE TABLE `suit_pay_payments`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `withdrawal_id` bigint(20) NULL DEFAULT NULL,
  `pix_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `pix_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `amount` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `observation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` tinyint(4) NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `suit_pay_payments_user_id_foreign`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of suit_pay_payments
-- ----------------------------

-- ----------------------------
-- Table structure for system_wallets
-- ----------------------------
DROP TABLE IF EXISTS `system_wallets`;
CREATE TABLE `system_wallets`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `label` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(27, 12) NOT NULL DEFAULT 0.000000000000,
  `balance_min` decimal(27, 12) NOT NULL DEFAULT 10000.100000000000,
  `pay_upto_percentage` decimal(4, 2) NOT NULL DEFAULT 45.00,
  `mode` enum('balance_min','percentage') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'percentage',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of system_wallets
-- ----------------------------
INSERT INTO `system_wallets` VALUES (1, 'system', 261.800000000000, 10000.100000000000, 45.00, 'percentage', '2023-10-11 16:11:15', '2023-10-16 18:42:00');

-- ----------------------------
-- Table structure for team_user
-- ----------------------------
DROP TABLE IF EXISTS `team_user`;
CREATE TABLE `team_user`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `team_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `team_user_team_id_index`(`team_id`) USING BTREE,
  INDEX `team_user_user_id_index`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of team_user
-- ----------------------------

-- ----------------------------
-- Table structure for teams (equipes)
-- ----------------------------
DROP TABLE IF EXISTS `teams`;
CREATE TABLE `teams`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teams
-- ----------------------------

-- ----------------------------
-- Table structure for transactions
-- ----------------------------
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `payment_method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `price` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `currency` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'usd',
  `status` tinyint(4) NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `transactions_user_id_index`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of transactions
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` tinyint(4) NULL DEFAULT 3,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cpf` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `token_time` bigint(20) NULL DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `logged_in` tinyint(4) NULL DEFAULT 0,
  `banned` tinyint(4) NULL DEFAULT 0,
  `inviter` int(10) UNSIGNED NULL DEFAULT NULL,
  `affiliate_revenue_share` decimal(20, 2) NULL DEFAULT 40.00,
  `affiliate_cpa` decimal(20, 2) NULL DEFAULT 20.00,
  `affiliate_baseline` decimal(20, 2) NULL DEFAULT 0.00,
  `is_demo_agent` tinyint(4) NULL DEFAULT 0,
  `oauth_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `oauth_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `kscinus` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 136 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 0, 'Admin', 1, NULL, NULL, NULL, 'admin@demo.com', NULL, '$2y$10$8IViREJTQIAXRY7n9D3UDuhes4bNjBTSaz0E/in5uNb1LX6ZWgNQq', '25F1JeK1ZziZ1KWnoYU1iCLFT6rgXJYZj5a8SiKLEE5A5uC5ZrFksg5qUgxE', 1696659991, 'ff8e95055e285d0e5d0cbd733a6ffb20b042c539d61ab8b2b28358a152cdc09e', 0, 0, 10, 40.00, 20.00, 0.00, 1, NULL, NULL, 'active', '2023-09-24 18:13:49', '2024-01-03 12:21:20', 1);
-- ----------------------------

-- ----------------------------
-- Table structure for wallet_changes (mudanças na carteira)
-- ----------------------------
DROP TABLE IF EXISTS `wallet_changes`;
CREATE TABLE `wallet_changes`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `change` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `value_bonus` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `value_total` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `value_roi` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `value_entry` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `game` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wallet_changes
-- ----------------------------

-- ----------------------------
-- Table structure for wallets
-- ----------------------------
DROP TABLE IF EXISTS `wallets`;
CREATE TABLE `wallets`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `balance` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `balance_bonus` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `balance_bonus_rollover` decimal(20, 2) NULL DEFAULT 0.00,
  `anti_bot` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `total_bet` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `total_won` decimal(20, 2) NULL DEFAULT 0.00,
  `total_lose` decimal(20, 2) NULL DEFAULT 0.00,
  `last_won` decimal(20, 2) NULL DEFAULT 0.00,
  `last_lose` decimal(20, 2) NULL DEFAULT 0.00,
  `hide_balance` tinyint(4) NULL DEFAULT 0,
  `refer_rewards` decimal(20, 2) NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `wallets_user_id_foreign`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 130 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of wallets
-- ----------------------------
INSERT INTO `wallets` VALUES (1, 1, 1000.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, '2023-09-24 17:31:42', '2024-01-14 22:27:36');

-- ----------------------------
-- Table structure for withdrawals (reiradas)
-- ----------------------------
DROP TABLE IF EXISTS `withdrawals`; 
CREATE TABLE `withdrawals`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `proof` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `chave_pix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tipo_chave` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `document` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `withdrawals_user_id_foreign`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of withdrawals
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
