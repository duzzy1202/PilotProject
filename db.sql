DROP DATABASE IF EXISTS FootballAround;
CREATE DATABASE FootballAround;

USE FootballAround;

SELECT * FROM `member`;
SELECT * FROM attr;
SELECT * FROM report;
SELECT * FROM `board`;
SELECT * FROM article;
SELECT * FROM club;
SELECT * FROM reply;
SELECT * FROM `file`;
SELECT * FROM punishment;

DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `loginId` CHAR(100) NOT NULL UNIQUE,
    `loginPw` CHAR(255) NOT NULL,
    email CHAR(200) NOT NULL,
    `nickname` CHAR(200) NOT NULL,
    `level` INT(10) UNSIGNED NOT NULL,
    delStatus TINYINT(1) UNSIGNED DEFAULT 0,
    delDate DATETIME,
    redLine INT(10) UNSIGNED NOT NULL DEFAULT 0,
    rating DECIMAL(3,1) UNSIGNED NOT NULL DEFAULT 0
);

DROP TABLE IF EXISTS attr;
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `relTypeCode` CHAR(20) NOT NULL,
    `relId` INT(10) UNSIGNED NOT NULL,
    `typeCode` CHAR(30) NOT NULL,
    `type2Code` CHAR(30) NOT NULL,
    `value` TEXT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
);

## 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `typeCode`, `type2Code`); 

DROP TABLE IF EXISTS `board`;
CREATE TABLE `board` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    `code` CHAR(20) NOT NULL UNIQUE,
	`name` CHAR(20) NOT NULL UNIQUE,
	leagueId INT(10) UNSIGNED NOT NULL
);

# article 테이블 세팅
DROP TABLE IF EXISTS article;
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`boardId` INT(10) UNSIGNED NOT NULL,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`memberId` INT(10) UNSIGNED NOT NULL,
    title CHAR(200) NOT NULL,
    `body` LONGTEXT NOT NULL,
    hit INT(10) UNSIGNED NOT NULL DEFAULT 0,
    recommend INT(10) UNSIGNED NOT NULL DEFAULT 0
);

DROP TABLE IF EXISTS club;
CREATE TABLE club (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    leagueId INT(10) UNSIGNED NOT NULL,
    clubCode CHAR(20) NOT NULL,
	`name` CHAR(20) NOT NULL,
	fullname CHAR(20) NOT NULL,
	location CHAR(20) NOT NULL,
    homeGround CHAR(20) NOT NULL, 
    since CHAR(20) NOT NULL,
    coach CHAR(20) NOT NULL, 
	ranking INT(10) UNSIGNED NOT NULL,
	play INT(10) UNSIGNED NOT NULL,
	points INT(10) UNSIGNED NOT NULL,
	win INT(10) UNSIGNED NOT NULL,
	draw INT(10) UNSIGNED NOT NULL,
	defeat INT(10) UNSIGNED NOT NULL,
	goal INT(10) UNSIGNED NOT NULL,
	goalAgainst INT(10) UNSIGNED NOT NULL
);

DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	relTypeCode CHAR(50) NOT NULL,
	relId INT(10) UNSIGNED NOT NULL,
    originFileName VARCHAR(100) NOT NULL,
    fileExt CHAR(10) NOT NULL,
    typeCode CHAR(20) NOT NULL,
    type2Code CHAR(20) NOT NULL,
    fileSize INT(10) UNSIGNED NOT NULL,
    fileExtTypeCode CHAR(10) NOT NULL,
    fileExtType2Code CHAR(10) NOT NULL,
    fileNo TINYINT(2) UNSIGNED NOT NULL,
    `body` LONGBLOB
);

DROP TABLE IF EXISTS reply;
CREATE TABLE reply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL,
    relId INT(10) UNSIGNED NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    `body` LONGTEXT NOT NULL
);

DROP TABLE IF EXISTS report;
CREATE TABLE report (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    processDate DATETIME,
    reportedType CHAR(50) NOT NULL,
    reportedId INT(10) UNSIGNED NOT NULL,
    reportedCount INT(10) UNSIGNED NOT NULL,
    isProcessed TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    processMemberId INT(10) UNSIGNED NOT NULL DEFAULT 0
);

ALTER TABLE report DROP COLUMN reportedReason;

DROP TABLE IF EXISTS punishment;
CREATE TABLE punishment (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    memberId INT(10) UNSIGNED NOT NULL,
    `count` INT(10) UNSIGNED NOT NULL,
    reason CHAR(200) NOT NULL
);

DROP TABLE IF EXISTS articleRecommend;
CREATE TABLE articleRecommend (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY(id),
  regDate DATETIME NOT NULL,
  articleId INT(10) UNSIGNED NOT NULL,
  memberId INT(10) UNSIGNED NOT NULL,
  `point` TINYINT(1) UNSIGNED NOT NULL
);

DROP TABLE IF EXISTS articleDislike;
CREATE TABLE articleDislike (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY(id),
  regDate DATETIME NOT NULL,
  articleId INT(10) UNSIGNED NOT NULL,
  memberId INT(10) UNSIGNED NOT NULL,
  `point` TINYINT(1) UNSIGNED NOT NULL
);

SELECT A.*, M.nickname
		AS extra__writer,
		IFNULL(SUM(AR.point), 0) AS extra__likePoint,
		IFNULL(SUM(AD.point), 0) AS extra__dislikePoint
		FROM article AS A
		INNER JOIN board AS B
		ON A.boardId = B.id
		INNER JOIN `member` AS M
		ON A.memberId = M.id
		LEFT JOIN articleRecommend AS AR
		ON A.id = AR.articleId
		LEFT JOIN articleDislike AS AD
		ON A.id = AD.articleId
		WHERE A.displayStatus = 1
		AND A.delStatus = 0
		AND body LIKE '%s%'
		GROUP BY A.id
		ORDER BY A.id DESC