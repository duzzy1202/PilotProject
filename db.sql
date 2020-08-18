DROP DATABASE IF EXISTS FootballAround;
CREATE DATABASE FootballAround;
USE FootballAround;

DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `loginId` CHAR(100) NOT NULL UNIQUE,
    `loginPw` CHAR(255) NOT NULL,
    `name` CHAR(100) NOT NULL,
    email CHAR(200) NOT NULL,
    `nickname` CHAR(200) NOT NULL,
    `level` INT(10) UNSIGNED NOT NULL,
    delStatus TINYINT(1) UNSIGNED,
    delDate DATETIME
);

SELECT * FROM `member`