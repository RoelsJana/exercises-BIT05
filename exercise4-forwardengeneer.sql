-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `idDoctor` INT NOT NULL,
  `Name` VARCHAR(100) NULL,
  `Date_of_birth` DATE NULL,
  `Adress` VARCHAR(150) NULL,
  `PhoneNo` INT NULL,
  PRIMARY KEY (`idDoctor`),
  UNIQUE INDEX `idDoctor_UNIQUE` (`idDoctor` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `idMedical` INT NOT NULL AUTO_INCREMENT,
  `overtime_rate` INT NULL,
  `doctor_id` INT NOT NULL,
  PRIMARY KEY (`idMedical`),
  UNIQUE INDEX `idMedical_UNIQUE` (`idMedical` ASC) VISIBLE,
  UNIQUE INDEX `doctor_id_UNIQUE` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Medical_Doctor`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `idSpecialist` INT NOT NULL AUTO_INCREMENT,
  `Field_area` VARCHAR(45) NULL,
  `doctor_id` INT NOT NULL,
  PRIMARY KEY (`idSpecialist`),
  UNIQUE INDEX `idSpecialist_UNIQUE` (`idSpecialist` ASC) VISIBLE,
  UNIQUE INDEX `doctor_id_UNIQUE` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Specialist_Doctor`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `idPatient` INT NOT NULL,
  `Name` VARCHAR(100) NULL,
  `Date_of_birth` DATE NULL,
  `Adress` INT NULL,
  `PhoneNo` INT NULL,
  PRIMARY KEY (`idPatient`),
  UNIQUE INDEX `idPatient_UNIQUE` (`idPatient` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `idAppointment` INT NOT NULL,
  `Date` DATE NULL,
  `Time` INT NULL,
  `doctor_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`idAppointment`),
  UNIQUE INDEX `idAppointment_UNIQUE` (`idAppointment` ASC) VISIBLE,
  UNIQUE INDEX `doctor_id_UNIQUE` (`doctor_id` ASC) VISIBLE,
  UNIQUE INDEX `patient_id_UNIQUE` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Doctor`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `idPayment` INT NOT NULL,
  `details` VARCHAR(45) NULL,
  `Method` VARCHAR(45) NULL,
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`idPayment`),
  UNIQUE INDEX `idPayment_UNIQUE` (`idPayment` ASC) VISIBLE,
  UNIQUE INDEX `patient_id_UNIQUE` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `idBill` INT NOT NULL,
  `total` INT NULL,
  `doctor_id` INT NOT NULL,
  PRIMARY KEY (`idBill`),
  UNIQUE INDEX `idBill_UNIQUE` (`idBill` ASC) VISIBLE,
  UNIQUE INDEX `doctor_id_UNIQUE` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_Doctor`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`crossreference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`crossreference` (
  `idcrossreference` INT NOT NULL,
  `bil_id` INT NOT NULL,
  `paymeny_id` INT NOT NULL,
  PRIMARY KEY (`idcrossreference`),
  UNIQUE INDEX `idcrossreference_UNIQUE` (`idcrossreference` ASC) VISIBLE,
  UNIQUE INDEX `bil_id_UNIQUE` (`bil_id` ASC) VISIBLE,
  UNIQUE INDEX `paymeny_id_UNIQUE` (`paymeny_id` ASC) VISIBLE,
  CONSTRAINT `fk_crossreference_1`
    FOREIGN KEY (`bil_id`)
    REFERENCES `mydb`.`Bill` (`idBill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_crossreference_2`
    FOREIGN KEY (`paymeny_id`)
    REFERENCES `mydb`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
