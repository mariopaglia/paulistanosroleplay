CREATE TABLE `ps_phone_insta_account` (
	`id` INT(11) NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	`username` VARCHAR(50) NOT NULL,
	`password` VARCHAR(50) NOT NULL,
	`avatar` TEXT NULL DEFAULT NULL,
	`description` TEXT NULL DEFAULT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_insta_followers` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(50) NOT NULL,
	`followed` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_insta_stories` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(50) NOT NULL,
	`image` TEXT NOT NULL,
	`description` VARCHAR(255) NULL,
	`location` VARCHAR(255) NULL DEFAULT NULL,
	`filter` VARCHAR(255) NULL DEFAULT NULL,
	`created` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_insta_posts` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(50) NOT NULL,
	`image` TEXT NOT NULL,
	`description` TEXT NULL DEFAULT NULL,
	`location` VARCHAR(255) NULL DEFAULT NULL,
	`filter` VARCHAR(255) NULL DEFAULT NULL,
	`created` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_contacts` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`user_id` INT(11) NOT NULL,
	`number` VARCHAR(50) NOT NULL,
	`display` VARCHAR(50) NOT NULL,
	`bank` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ps_phone_calls` (
  	`id` int(11) NOT NULL AUTO_INCREMENT,
  	`phone` varchar(50) NOT NULL,
  	`number` varchar(50) NOT NULL,
  	`type` varchar(50) NOT NULL,
  	`status` int(11) NOT NULL,
  	`created` DATETIME NULL DEFAULT NULL,
  	PRIMARY KEY (`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ps_phone_messages` (
  	`id` int(11) NOT NULL AUTO_INCREMENT,
  	`phone` varchar(50) NOT NULL,
  	`number` varchar(50) NOT NULL,
  	`owner` varchar(50) NOT NULL,
  	`message` TEXT NOT NULL,
  	`type` varchar(50) NOT NULL,
	`read` TINYINT(4) NOT NULL DEFAULT '0',
  	`created` DATETIME NULL DEFAULT NULL,
  	PRIMARY KEY (`id`) USING BTREE
)ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_whatsapp_account` (
	`id` INT(11) NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	`phone` VARCHAR(50) NOT NULL,
	`password` VARCHAR(50) NOT NULL,
	`avatar` TEXT NULL DEFAULT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_whatsapp_stories` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`phone` VARCHAR(50) NOT NULL,
	`image` TEXT NOT NULL,
	`description` VARCHAR(255) NULL,
	`location` VARCHAR(255) NULL DEFAULT NULL,
	`filter` VARCHAR(255) NULL DEFAULT NULL,
	`created` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ps_phone_whatsapp_calls` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`phone` varchar(50) NOT NULL,
	`number` varchar(50) NOT NULL,
	`type` varchar(50) NOT NULL,
	`status` int(11) NOT NULL,
	`created` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ps_phone_whatsapp_chats` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`phone` varchar(50) NOT NULL,
	`number` varchar(50) NULL DEFAULT NULL,
	`created` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_whatsapp_messages` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`id_chat` INT(11) NOT NULL,
	`owner` VARCHAR(50) NOT NULL,
  	`type` varchar(50) NOT NULL,
	`message` TEXT NOT NULL,
	`created` DATETIME NOT NULL,
	`read` TINYINT(4) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `FK_messages` (`id_chat`) USING BTREE,
	CONSTRAINT `FK_messages` FOREIGN KEY (`id_chat`) REFERENCES `ps_phone_whatsapp_chats` (`id`) ON UPDATE RESTRICT ON DELETE RESTRICT
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ps_phone_whatsapp_groups` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`phone` varchar(50) NOT NULL,
	`number` varchar(50) NULL DEFAULT NULL,
	`type` varchar(50) NOT NULL,
	`name` varchar(50) NULL DEFAULT NULL,
	`image` varchar(255) NULL DEFAULT NULL,
	`created` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_whatsapp_groups_users` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`number_group` varchar(50) NOT NULL,
	`admin` TINYINT(4) NOT NULL DEFAULT '0',
	`phone` varchar(50) NOT NULL,
	PRIMARY KEY (`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_whatsapp_groups_messages` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`id_group` INT(11) NOT NULL,
	`owner` VARCHAR(50) NOT NULL,
  	`type` varchar(50) NOT NULL,
	`message` TEXT NOT NULL,
	`created` DATETIME NOT NULL,
	`read` TINYINT(4) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `FK_groups_messages` (`id_group`) USING BTREE,
	CONSTRAINT `FK_groups_messages` FOREIGN KEY (`id_group`) REFERENCES `ps_phone_whatsapp_groups` (`id`) ON UPDATE RESTRICT ON DELETE RESTRICT
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_settings` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`user_id` INT(11) NOT NULL,
	`option` VARCHAR(50) NOT NULL,
	`value` varchar(255) NOT NULL,
	PRIMARY KEY (`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_twiiter_account` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL,
	`username` VARCHAR(50) NOT NULL,
	`password` VARCHAR(50) NOT NULL,
	`avatar` TEXT NULL DEFAULT NULL,
	`description` TEXT NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_twiiter_tweets` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(50) NOT NULL,
	`message` TEXT NOT NULL,
	`hashtags` TEXT DEFAULT NULL,
	`mentions` TEXT DEFAULT NULL,
  	`image` varchar(255) NULL DEFAULT NULL,
	`created` DATETIME NOT NULL,
	PRIMARY KEY (`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_twiiter_hashtags` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL,
	`created` DATETIME NOT NULL,
	PRIMARY KEY (`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ps_phone_twiiter_mentions` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`id_tweet` INT(11) NOT NULL,
	`username` VARCHAR(50) NOT NULL,
	`mentioned` VARCHAR(50) NOT NULL,
	`created` DATETIME NOT NULL,
	PRIMARY KEY (`id`) USING BTREE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
