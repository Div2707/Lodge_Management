CREATE SCHEMA IF NOT EXISTS `lodge_database` DEFAULT CHARACTER SET utf8 ;
USE `lodge_database` ;

-- -----------------------------------------------------
-- Table `lodge_database`.`addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`addresses` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`addresses` (
  `address_id` INT NOT NULL,
  `address_line1` VARCHAR(100) NULL,
  `address_line2` VARCHAR(100) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `zipcode` VARCHAR(8) NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lodge_database`.`lodge_chain`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`lodge_chain` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`lodge_chain` (
  `lodge_chain_id` INT NOT NULL,
  `lodge_chain_name` VARCHAR(45) NULL,
  `lodge_chain_contact_number` VARCHAR(12) NULL,
  `lodge_chain_email_address` VARCHAR(45) NULL,
  `lodge_chain_website` VARCHAR(45) NULL,
  `lodge_chain_head_office_address_id` INT NOT NULL,
  PRIMARY KEY (`lodge_chain_id`, `lodge_chain_head_office_address_id`),
  CONSTRAINT `fk_lodge_chains_addresses1`
    FOREIGN KEY (`lodge_chain_head_office_address_id`)
    REFERENCES `lodge_database`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_lodge_chains_addresses1_idx` ON `lodge_database`.`lodge_chain` (`lodge_chain_head_office_address_id` ASC);


-- -----------------------------------------------------
-- Table `lodge_database`.`star_ratings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`star_ratings` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`star_ratings` (
  `star_rating` INT NOT NULL,
  `star_rating_image` VARCHAR(100) NULL,
  PRIMARY KEY (`star_rating`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lodge_database`.`lodge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`lodge` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`lodge` (
  `lodge_id` INT NOT NULL,
  `lodge_name` VARCHAR(45) NULL,
  `lodge_contact_number` VARCHAR(12) NULL,
  `lodge_email_address` VARCHAR(45) NULL,
  `lodge_website` VARCHAR(45) NULL,
  `lodge_description` VARCHAR(100) NULL,
  `lodge_floor_count` INT NULL,
  `lodge_room_capacity` INT NULL,
  `lodge_chain_id` INT NULL,
  `addresses_address_id` INT NOT NULL,
  `star_ratings_star_rating` INT NOT NULL,
  `check_in_time` TIME NULL,
  `check_out_time` TIME NULL,
  PRIMARY KEY (`lodge_id`, `addresses_address_id`, `star_ratings_star_rating`),
  CONSTRAINT `fk_lodges_addresses1`
    FOREIGN KEY (`addresses_address_id`)
    REFERENCES `lodge_database`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lodge_star_ratings1`
    FOREIGN KEY (`star_ratings_star_rating`)
    REFERENCES `lodge_database`.`star_ratings` (`star_rating`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '		';

CREATE INDEX `fk_lodges_addresses1_idx` ON `lodge_database`.`lodge` (`addresses_address_id` ASC);

CREATE INDEX `fk_lodge_star_ratings1_idx` ON `lodge_database`.`lodge` (`star_ratings_star_rating` ASC);


-- -----------------------------------------------------
-- Table `lodge_database`.`room_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`room_type` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`room_type` (
  `room_type_id` INT NOT NULL,
  `room_type_name` VARCHAR(45) NULL,
  `room_cost` DECIMAL(10,2) NULL,
  `room_type_description` VARCHAR(100) NULL,
  `smoke_friendly` TINYINT(1) NULL,
  `pet_friendly` TINYINT(1) NULL,
  PRIMARY KEY (`room_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lodge_database`.`rooms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`rooms` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`rooms` (
  `room_id` INT NOT NULL,
  `room_number` INT(4) NULL,
  `rooms_type_rooms_type_id` INT NOT NULL,
  `lodge_lodge_id` INT NOT NULL,
  PRIMARY KEY (`room_id`, `rooms_type_rooms_type_id`, `lodge_lodge_id`),
  CONSTRAINT `fk_rooms_rooms_type1`
    FOREIGN KEY (`rooms_type_rooms_type_id`)
    REFERENCES `lodge_database`.`room_type` (`room_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rooms_lodge1`
    FOREIGN KEY (`lodge_lodge_id`)
    REFERENCES `lodge_database`.`lodge` (`lodge_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_rooms_rooms_type1_idx` ON `lodge_database`.`rooms` (`rooms_type_rooms_type_id` ASC);

CREATE INDEX `fk_rooms_lodge1_idx` ON `lodge_database`.`rooms` (`lodge_lodge_id` ASC);


-- -----------------------------------------------------
-- Table `lodge_database`.`guests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`guests` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`guests` (
  `guest_id` INT NOT NULL,
  `guest_first_name` VARCHAR(45) NULL,
  `guest_last_name` VARCHAR(45) NULL,
  `guest_contact_number` VARCHAR(12) NULL,
  `guest_email_address` VARCHAR(45) NULL,
  `guest_credit_card` VARCHAR(45) NULL,
  `guest_id_proof` VARCHAR(45) NULL,
  `addresses_address_id` INT NOT NULL,
  PRIMARY KEY (`guest_id`, `addresses_address_id`),
  CONSTRAINT `fk_guests_addresses1`
    FOREIGN KEY (`addresses_address_id`)
    REFERENCES `lodge_database`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';

CREATE INDEX `fk_guests_addresses1_idx` ON `lodge_database`.`guests` (`addresses_address_id` ASC);


-- -----------------------------------------------------
-- Table `lodge_database`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`department` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`department` (
  `department_id` INT NOT NULL,
  `department_name` VARCHAR(45) NULL,
  `department_description` VARCHAR(100) NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lodge_database`.`employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`employees` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`employees` (
  `emp_id` INT NOT NULL,
  `emp_first_name` VARCHAR(45) NULL,
  `emp_last_name` VARCHAR(45) NULL,
  `emp_designation` VARCHAR(45) NULL,
  `emp_contact_number` VARCHAR(12) NULL,
  `emp_email_address` VARCHAR(45) NULL,
  `department_department_id` INT NOT NULL,
  `addresses_address_id` INT NOT NULL,
  `lodge_lodge_id` INT NOT NULL,
  PRIMARY KEY (`emp_id`, `department_department_id`, `addresses_address_id`, `lodge_lodge_id`),
  CONSTRAINT `fk_employees_services1`
    FOREIGN KEY (`department_department_id`)
    REFERENCES `lodge_database`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_addresses1`
    FOREIGN KEY (`addresses_address_id`)
    REFERENCES `lodge_database`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_lodge1`
    FOREIGN KEY (`lodge_lodge_id`)
    REFERENCES `lodge_database`.`lodge` (`lodge_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_employees_services1_idx` ON `lodge_database`.`employees` (`department_department_id` ASC);

CREATE INDEX `fk_employees_addresses1_idx` ON `lodge_database`.`employees` (`addresses_address_id` ASC);

CREATE INDEX `fk_employees_lodge1_idx` ON `lodge_database`.`employees` (`lodge_lodge_id` ASC);


-- -----------------------------------------------------
-- Table `lodge_database`.`bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`bookings` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`bookings` (
  `booking_id` INT NOT NULL,
  `booking_date` DATETIME NULL,
  `duration_of_stay` VARCHAR(10) NULL,
  `check_in_date` DATETIME NULL,
  `check_out_date` DATETIME NULL,
  `booking_payment_type` VARCHAR(45) NULL,
  `total_rooms_booked` INT NULL,
  `lodge_lodge_id` INT NOT NULL,
  `guests_guest_id` INT NOT NULL,
  `employees_emp_id` INT NOT NULL,
  `total_amount` DECIMAL(10,2) NULL,
  PRIMARY KEY (`booking_id`, `lodge_lodge_id`, `guests_guest_id`, `employees_emp_id`),
  CONSTRAINT `fk_bookings_lodge1`
    FOREIGN KEY (`lodge_lodge_id`)
    REFERENCES `lodge_database`.`lodge` (`lodge_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookings_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `lodge_database`.`guests` (`guest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookings_employees1`
    FOREIGN KEY (`employees_emp_id` )
    REFERENCES `lodge_database`.`employees` (`emp_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_bookings_lodge1_idx` ON `lodge_database`.`bookings` (`lodge_lodge_id` ASC);

CREATE INDEX `fk_bookings_guests1_idx` ON `lodge_database`.`bookings` (`guests_guest_id` ASC);

CREATE INDEX `fk_bookings_employees1_idx` ON `lodge_database`.`bookings` (`employees_emp_id` ASC);


-- -----------------------------------------------------
-- Table `lodge_database`.`lodge_chain_has_lodge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`lodge_chain_has_lodge` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`lodge_chain_has_lodge` (
  `lodge_chains_lodge_chain_id` INT NOT NULL,
  
  `lodges_lodge_id` INT NOT NULL,
  PRIMARY KEY (`lodge_chains_lodge_chain_id`,  `lodges_lodge_id`),
  CONSTRAINT `fk_lodge_chains_has_lodges_lodge_chains1`
    FOREIGN KEY (`lodge_chains_lodge_chain_id`)
    REFERENCES `lodge_database`.`lodge_chain` (`lodge_chain_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lodge_chains_has_lodges_lodges1`
    FOREIGN KEY (`lodges_lodge_id`)
    REFERENCES `lodge_database`.`lodge` (`lodge_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_lodge_chains_has_lodges_lodges1_idx` ON `lodge_database`.`lodge_chain_has_lodge` (`lodges_lodge_id` ASC);

CREATE INDEX `fk_lodge_chains_has_lodges_lodge_chains1_idx` ON `lodge_database`.`lodge_chain_has_lodge` (`lodge_chains_lodge_chain_id` ASC);


-- -----------------------------------------------------
-- Table `lodge_database`.`room_rate_discount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`room_rate_discount` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`room_rate_discount` (
  `discount_id` INT NOT NULL,
  `discount_rate` DECIMAL(10,2) NULL,
  `start_month` TINYINT(1) NULL,
  `end_month` TINYINT(1) NULL,
  `room_type_room_type_id` INT NOT NULL,
  PRIMARY KEY (`discount_id`, `room_type_room_type_id`),
  CONSTRAINT `fk_room_rate_discount_room_type1`
    FOREIGN KEY (`room_type_room_type_id`)
    REFERENCES `lodge_database`.`room_type` (`room_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_room_rate_discount_room_type1_idx` ON `lodge_database`.`room_rate_discount` (`room_type_room_type_id` ASC);


-- -----------------------------------------------------
-- Table `lodge_database`.`rooms_booked`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`rooms_booked` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`rooms_booked` (
  `rooms_booked_id` INT NOT NULL,
  `bookings_booking_id` INT NOT NULL,
  `rooms_room_id` INT NOT NULL,
  PRIMARY KEY (`rooms_booked_id`, `bookings_booking_id`, `rooms_room_id`),
  CONSTRAINT `fk_rooms_booked_bookings1`
    FOREIGN KEY (`bookings_booking_id`)
    REFERENCES `lodge_database`.`bookings` (`booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rooms_booked_rooms1`
    FOREIGN KEY (`rooms_room_id`)
    REFERENCES `lodge_database`.`rooms` (`room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_rooms_booked_bookings1_idx` ON `lodge_database`.`rooms_booked` (`bookings_booking_id` ASC);

CREATE INDEX `fk_rooms_booked_rooms1_idx` ON `lodge_database`.`rooms_booked` (`rooms_room_id` ASC);


-- -----------------------------------------------------
-- Table `lodge_database`.`lodge_services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`lodge_services` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`lodge_services` (
  `service_id` INT NOT NULL,
  `service_name` VARCHAR(45) NULL,
  `service_description` VARCHAR(100) NULL,
  `service_cost` DECIMAL(10,2) NULL,
  `lodge_lodge_id` INT NOT NULL,
  PRIMARY KEY (`service_id`, `lodge_lodge_id`),
  CONSTRAINT `fk_lodge_services_lodge1`
    FOREIGN KEY (`lodge_lodge_id`)
    REFERENCES `lodge_database`.`lodge` (`lodge_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_lodge_services_lodge1_idx` ON `lodge_database`.`lodge_services` (`lodge_lodge_id` ASC);


-- -----------------------------------------------------
-- Table `lodge_database`.`lodge_services_used_by_guests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lodge_database`.`lodge_services_used_by_guests` ;

CREATE TABLE IF NOT EXISTS `lodge_database`.`lodge_services_used_by_guests` (
  `service_used_id` INT NOT NULL,
  `lodge_services_service_id` INT NOT NULL,
  `bookings_booking_id` INT NOT NULL,
  PRIMARY KEY (`service_used_id`, `lodge_services_service_id`, `bookings_booking_id`),
  CONSTRAINT `fk_lodge_services_has_bookings_lodge_services1`
    FOREIGN KEY (`lodge_services_service_id`)
    REFERENCES `lodge_database`.`lodge_services` (`service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lodge_services_has_bookings_bookings1`
    FOREIGN KEY (`bookings_booking_id`)
    REFERENCES `lodge_database`.`bookings` (`booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_lodge_services_has_bookings_bookings1_idx` ON `lodge_database`.`lodge_services_used_by_guests` (`bookings_booking_id` ASC);

CREATE INDEX `fk_lodge_services_has_bookings_lodge_services1_idx` ON `lodge_database`.`lodge_services_used_by_guests` (`lodge_services_service_id` ASC);
