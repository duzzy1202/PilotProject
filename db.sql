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

SELECT * FROM `member`;
SELECT * FROM attr;
SELECT * FROM `board`;
SELECT * FROM article;
SELECT * FROM club;
SELECT * FROM reply;
SELECT * FROM `file`;

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

# attr 유니크 인덱스 걸기
## 중복변수 생성금지
## 변수찾는 속도 최적화
ALTER TABLE `attr` ADD UNIQUE INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`); 

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

INSERT INTO `board`
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'notice',
leagueId = 0,
`name` = '공지사항';

INSERT INTO `board`
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'national',
leagueId = 0,
`name` = '국내축구';

INSERT INTO `board`
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'foreign',
leagueId = 0,
`name` = '해외축구';

INSERT INTO `board`
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'kl1',
leagueId = 1,
`name` = 'K리그 1';

INSERT INTO `board`
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'kl2',
leagueId = 2,
`name` = 'K리그 2';

INSERT INTO `board`
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'kl3',
leagueId = 3,
`name` = 'K3 리그';

INSERT INTO `board`
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'kl4',
leagueId = 4,
`name` = 'K4 리그';

INSERT INTO `board`
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'wkl',
leagueId = 5,
`name` = 'WK 리그';

INSERT INTO `board`
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'free',
leagueId = 0,
`name` = '자유';

# article 테이블 세팅
DROP TABLE IF EXISTS article
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
    `body` LONGTEXT NOT NULL
);

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1',
displayStatus = 1,
`memberId` = 1;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2',
displayStatus = 1,
`memberId` = 1;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3',
displayStatus = 1,
`memberId` = 1;

DROP TABLE IF EXISTS club;
CREATE TABLE club (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    leagueId INT(10) UNSIGNED NOT NULL,
	`name` CHAR(20) NOT NULL,
	ranking INT(10) UNSIGNED NOT NULL,
	play INT(10) UNSIGNED NOT NULL,
	points INT(10) UNSIGNED NOT NULL,
	win INT(10) UNSIGNED NOT NULL,
	defeat INT(10) UNSIGNED NOT NULL,
	draw INT(10) UNSIGNED NOT NULL,
	goal INT(10) UNSIGNED NOT NULL,
	goalAgainst INT(10) UNSIGNED NOT NULL
);

INSERT INTO club
SET regDate = NOW(),
updateDate = NOW(),
leagueId = 0,
`name` = '팀이름',
ranking = 0,
play = 0,
points = 0,
win = 0,
defeat = 0,
draw = 0,
goal = 0,
goalAgainst = 0;

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
