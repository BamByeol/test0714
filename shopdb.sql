-- --------------------------------------------------------
-- 호스트:                          211.183.3.111
-- 서버 버전:                        10.4.30-MariaDB-1:10.4.30+maria~ubu1804 - mariadb.org binary distribution
-- 서버 OS:                        debian-linux-gnu
-- HeidiSQL 버전:                  12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- shopdb 데이터베이스 구조 내보내기
DROP DATABASE IF EXISTS `shopdb`;
CREATE DATABASE IF NOT EXISTS `shopdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `shopdb`;

-- 테이블 shopdb.deletedMemberTBL 구조 내보내기
DROP TABLE IF EXISTS `deletedMemberTBL`;
CREATE TABLE IF NOT EXISTS `deletedMemberTBL` (
  `memberID` char(8) DEFAULT NULL,
  `memberName` char(5) DEFAULT NULL,
  `memberAddress` char(20) DEFAULT NULL,
  `deletedDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 shopdb.deletedMemberTBL:~1 rows (대략적) 내보내기
INSERT INTO `deletedMemberTBL` (`memberID`, `memberName`, `memberAddress`, `deletedDate`) VALUES
	('Dang', '당탕이', '경기 부천시', '2023-06-19');

-- 테이블 shopdb.membertbl 구조 내보내기
DROP TABLE IF EXISTS `membertbl`;
CREATE TABLE IF NOT EXISTS `membertbl` (
  `memberID` char(8) NOT NULL,
  `membername` char(5) NOT NULL,
  `memberaddress` char(20) DEFAULT NULL,
  PRIMARY KEY (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 shopdb.membertbl:~1 rows (대략적) 내보내기
INSERT INTO `membertbl` (`memberID`, `membername`, `memberaddress`) VALUES
	('Han', '한주연', '인천 남구'),
	('Jee', '지운이', '서울 은평구');

-- 테이블 shopdb.producttbl 구조 내보내기
DROP TABLE IF EXISTS `producttbl`;
CREATE TABLE IF NOT EXISTS `producttbl` (
  `productName` char(4) NOT NULL,
  `cost` int(11) NOT NULL,
  `makeDate` date DEFAULT NULL,
  `company` char(5) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`productName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 shopdb.producttbl:~3 rows (대략적) 내보내기
INSERT INTO `producttbl` (`productName`, `cost`, `makeDate`, `company`, `amount`) VALUES
	('냉장고', 5, '2019-02-01', '대우', 22),
	('세탁기', 20, '2018-09-01', 'LG', 3),
	('컴퓨터', 10, '2017-01-01', '삼성', 17);

-- 뷰 shopdb.v_membertbl 구조 내보내기
DROP VIEW IF EXISTS `v_membertbl`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `v_membertbl` (
	`이름` CHAR(5) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`주소` CHAR(20) NULL COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 트리거 shopdb.trg_deletedMemberTBL 구조 내보내기
DROP TRIGGER IF EXISTS `trg_deletedMemberTBL`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER trg_deletedMemberTBL
	AFTER DELETE
   ON membertbl
   FOR EACH ROW
BEGIN
	INSERT INTO deletedMemberTBL
   	VALUES(OLD.memberID, OLD.membername, OLD.memberaddress, CURDATE() );
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 뷰 shopdb.v_membertbl 구조 내보내기
DROP VIEW IF EXISTS `v_membertbl`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `v_membertbl`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_membertbl` AS select `membertbl`.`membername` AS `이름`,`membertbl`.`memberaddress` AS `주소` from `membertbl`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
