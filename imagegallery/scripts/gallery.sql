SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema gallery
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `gallery` ;

-- -----------------------------------------------------
-- Schema gallery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gallery` DEFAULT CHARACTER SET utf8 ;
USE `gallery` ;

-- -----------------------------------------------------
-- Table `gallery`.`imageinfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gallery`.`imageinfo` ;


CREATE TABLE `imageinfo` (
  `id` bigint(20) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `details` varchar(300) DEFAULT NULL,
  `image` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Indexes for table `imageinfo`
--
ALTER TABLE `imageinfo`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `imageinfo`
--
ALTER TABLE `imageinfo`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
