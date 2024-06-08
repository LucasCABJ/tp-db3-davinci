-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Colegio-TP
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ColegioTP` ;

-- -----------------------------------------------------
-- Schema Colegio-TP
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ColegioTP` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;

USE `ColegioTP` ;

-- -----------------------------------------------------
-- Table `Colegio-TP`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`usuario` ;

-- Tabla usuario
CREATE TABLE IF NOT EXISTS `ColegioTP`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,  -- Aumentar tamaño para hashes
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `is_active` TINYINT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `idx_nombre` (`nombre`),
  INDEX `idx_apellido` (`apellido`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `Colegio-TP`.`docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`docente` ;

-- Crear tabla docente
CREATE TABLE IF NOT EXISTS `ColegioTP`.`docente` (
  `id_docente` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `fec_ingreso` DATE NOT NULL,
  `fec_salida` DATE NULL,
  `is_active` TINYINT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_docente`),
  CONSTRAINT `fk_docente_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ColegioTP`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`curso` ;

-- Crear tabla curso
CREATE TABLE IF NOT EXISTS `ColegioTP`.`curso` (
  `id_curso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `cant_alumnos` INT NOT NULL,
  `id_tutor` INT NOT NULL,
  `id_preceptor` INT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_curso`),
  CONSTRAINT `fk_curso_docente1`
    FOREIGN KEY (`id_tutor`)
    REFERENCES `ColegioTP`.`docente` (`id_docente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_docente2`
    FOREIGN KEY (`id_preceptor`)
    REFERENCES `ColegioTP`.`docente` (`id_docente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



-- -----------------------------------------------------
-- Table `Colegio-TP`.`alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`alumno` ;

-- Crear tabla alumno
CREATE TABLE IF NOT EXISTS `ColegioTP`.`alumno` (
  `id_alumno` INT NOT NULL AUTO_INCREMENT,
  `fec_nacimiento` DATE NOT NULL,
  `fec_ingreso` DATE NOT NULL,
  `fec_salida` DATE NULL,
  `id_usuario` INT NOT NULL,
  `is_active` TINYINT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_alumno`),
  CONSTRAINT `fk_alumno_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ColegioTP`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`alumno_curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`alumno_curso` ;

-- Crear tabla alumno_curso
CREATE TABLE IF NOT EXISTS `ColegioTP`.`alumno_curso` (
  `id_alumno_curso` INT NOT NULL AUTO_INCREMENT,
  `id_curso` INT NOT NULL,
  `id_alumno` INT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_alumno_curso`),
  CONSTRAINT `fk_alumno_curso_curso`
    FOREIGN KEY (`id_curso`)
    REFERENCES `ColegioTP`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_curso_alumno`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `ColegioTP`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`asistencia_alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`asistencia_alumno` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`asistencia_alumno` (
  `id_asistencia_alumno` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `id_alumno` INT NOT NULL,
  `is_presente` TINYINT NOT NULL,
  PRIMARY KEY (`id_asistencia_alumno`),
  CONSTRAINT `fk_asistencia_alumno_alumno1`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `ColegioTP`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`rol` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`rol` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ColegioTP`.`usuario_rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`usuario_rol` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`usuario_rol` (
  `id_usuario_rol` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `id_rol` INT NOT NULL,
  `is_active` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_usuario_rol`),
  CONSTRAINT `fk_usuario_rol_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ColegioTP`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_rol_rol1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `ColegioTP`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`cargo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`cargo` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`cargo` (
  `id_cargo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `descripción` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_cargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`docente_cargo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`docente_cargo` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`docente_cargo` (
  `id_docente_cargo` INT NOT NULL AUTO_INCREMENT,
  `id_docente` INT NOT NULL,
  `id_cargo` INT NOT NULL,
  PRIMARY KEY (`id_docente_cargo`),
  CONSTRAINT `fk_docente_cargo_docente1`
    FOREIGN KEY (`id_docente`)
    REFERENCES `ColegioTP`.`docente` (`id_docente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_docente_cargo_cargo1`
    FOREIGN KEY (`id_cargo`)
    REFERENCES `ColegioTP`.`cargo` (`id_cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`asistencia_docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`asistencia_docente` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`asistencia_docente` (
  `id_asistencia_docente` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `is_presente` TINYINT NOT NULL,
  `id_docente` INT NOT NULL,
  PRIMARY KEY (`id_asistencia_docente`),
  CONSTRAINT `fk_asistencia_docente_docente1`
    FOREIGN KEY (`id_docente`)
    REFERENCES `ColegioTP`.`docente` (`id_docente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`materia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`materia` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`materia` (
  `id_materia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_materia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`curso_materia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`curso_materia` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`curso_materia` (
  `id_curso_materia` INT NOT NULL AUTO_INCREMENT,
  `id_curso` INT NOT NULL,
  `id_materia` INT NOT NULL,
  PRIMARY KEY (`id_curso_materia`),
  CONSTRAINT `fk_curso_materia_curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `ColegioTP`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_materia_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `ColegioTP`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`tema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`tema` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`tema` (
  `id_tema` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripción` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_tema`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`materia_tema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`materia_tema` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`materia_tema` (
  `id_materia_tema` INT NOT NULL AUTO_INCREMENT,
  `id_materia` INT NOT NULL,
  `id_tema` INT NOT NULL,
  PRIMARY KEY (`id_materia_tema`),
  CONSTRAINT `fk_materia_tema_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `ColegioTP`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_tema_tema1`
    FOREIGN KEY (`id_tema`)
    REFERENCES `ColegioTP`.`tema` (`id_tema`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`libro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`libro` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`libro` (
  `id_libro` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `autor` VARCHAR(45) NOT NULL,
  `imagen_referencia` VARCHAR(45) NOT NULL,
  `editorial` VARCHAR(45) NULL,
  PRIMARY KEY (`id_libro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`materia_libro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`materia_libro` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`materia_libro` (
  `id_materia_libro` INT NOT NULL AUTO_INCREMENT,
  `id_materia` INT NOT NULL,
  `id_libro` INT NOT NULL,
  PRIMARY KEY (`id_materia_libro`),
  CONSTRAINT `fk_materia_libro_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `ColegioTP`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_libro_libro1`
    FOREIGN KEY (`id_libro`)
    REFERENCES `ColegioTP`.`libro` (`id_libro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`docente_materia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`docente_materia` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`docente_materia` (
  `id_docente_materia` INT NOT NULL AUTO_INCREMENT,
  `id_materia` INT NOT NULL,
  `id_docente` INT NOT NULL,
  `id_docente_auxiliar` INT NULL,
  PRIMARY KEY (`id_docente_materia`),
  CONSTRAINT `fk_docente_materia_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `ColegioTP`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_docente_materia_docente1`
    FOREIGN KEY (`id_docente`)
    REFERENCES `ColegioTP`.`docente` (`id_docente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_docente_materia_docente2`
    FOREIGN KEY (`id_docente_auxiliar`)
    REFERENCES `ColegioTP`.`docente` (`id_docente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`permiso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`permiso` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`permiso` (
  `id_permiso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_permiso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`rol_has_permiso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`rol_has_permiso` ;

CREATE TABLE IF NOT EXISTS `ColegioTP`.`rol_has_permiso` (
  `id_rol_has_permiso` INT NOT NULL AUTO_INCREMENT,
  `id_rol` INT NOT NULL,
  `id_permiso` INT NOT NULL,
  PRIMARY KEY (`id_rol_has_permiso`),
  CONSTRAINT `fk_rol_has_permiso_permiso1`
    FOREIGN KEY (`id_permiso`)
    REFERENCES `ColegioTP`.`permiso` (`id_permiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rol_has_permiso_rol1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `ColegioTP`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Colegio-TP`.`auditoria_abm_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ColegioTP`.`usuario_audit` ;

-- Crear tabla de auditoría para usuario
CREATE TABLE IF NOT EXISTS `ColegioTP`.`usuario_audit` (
  `audit_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `operation` ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
  `username_old` VARCHAR(45),
  `password_old` VARCHAR(255),
  `nombre_old` VARCHAR(45),
  `apellido_old` VARCHAR(45),
  `is_active_old` TINYINT,
  `username_new` VARCHAR(45),
  `password_new` VARCHAR(255),
  `nombre_new` VARCHAR(45),
  `apellido_new` VARCHAR(45),
  `is_active_new` TINYINT,
  `changed_by` VARCHAR(25),
  `changed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`audit_id`),
  INDEX `idx_user_id` (`user_id` ASC),
  CONSTRAINT `fk_usuario_audit_usuario1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ColegioTP`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- #####################################################
-- CURSOR
-- #####################################################

DELIMITER $$

CREATE PROCEDURE calcular_promedio_notas_alumno(
    IN p_id_alumno INT
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id_materia INT;
    DECLARE v_nota FLOAT;
    DECLARE v_promedio_total FLOAT DEFAULT 0;
    DECLARE v_contador INT DEFAULT 0;

    -- Cursor para obtener las materias en las que está inscrito el alumno
    DECLARE cur_materias CURSOR FOR 
        SELECT id_materia FROM nota WHERE id_alumno = p_id_alumno;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_materias;

    read_loop: LOOP
        FETCH cur_materias INTO v_id_materia;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calcular promedio de notas para cada materia
        SELECT AVG(nota) INTO v_nota FROM nota WHERE id_alumno = p_id_alumno AND id_materia = v_id_materia;
        
        -- Acumular promedio de notas para el promedio total
        SET v_promedio_total = v_promedio_total + v_nota;
        SET v_contador = v_contador + 1;
    END LOOP;

    CLOSE cur_materias;

    -- Calcular promedio total
    IF v_contador > 0 THEN
        SET v_promedio_total = v_promedio_total / v_contador;
    END IF;

    -- Mostrar resultado
    SELECT v_promedio_total AS promedio_total;
END

$$DELIMITER ;

-- #####################################################
-- TRIGGERS 
-- #####################################################

DELIMITER $$
-- Trigger para INSERT en usuario
CREATE TRIGGER `trg_after_usuario_insert`
AFTER INSERT ON `usuario`
FOR EACH ROW
BEGIN
	-- usar NEW
  INSERT INTO `usuario_audit` VALUES (NULL, NEW.id_usuario, 'INSERT', NULL, NULL, NULL, NULL, NULL, NEW.`username`, NEW.`password`, NEW.`nombre`, NEW.`apellido`, NEW.`is_active`, USER(), CURRENT_TIMESTAMP());
END;
$$;

DELIMITER $$
-- Trigger para UPDATE en usuario
CREATE TRIGGER `trg_after_usuario_update`
AFTER UPDATE ON `usuario`
FOR EACH ROW
BEGIN
  IF NOT (OLD.is_active = NEW.is_active) OR (OLD.username <> NEW.username OR OLD.password <> NEW.password OR OLD.nombre <> NEW.nombre OR OLD.apellido <> NEW.apellido) THEN
	  INSERT INTO `usuario_audit` (`user_id`, `operation`, `username_old`, `password_old`, `nombre_old`, `apellido_old`, `is_active_old`, `username_new`, `password_new`, `nombre_new`, `apellido_new`, `is_active_new`, `changed_by`)
	  VALUES (OLD.`id_usuario`, 'UPDATE', OLD.`username`, OLD.`password`, OLD.`nombre`, OLD.`apellido`, OLD.`is_active`, NEW.`username`, NEW.`password`, NEW.`nombre`, NEW.`apellido`, NEW.`is_active`, USER());
  END IF;
  
  IF OLD.is_active = 1 AND NEW.is_active = 0 THEN
	  INSERT INTO `usuario_audit` (`user_id`, `operation`, `username_old`, `password_old`, `nombre_old`, `apellido_old`, `is_active_old`, `username_new`, `password_new`, `nombre_new`, `apellido_new`, `is_active_new`, `changed_by`)
	  VALUES (OLD.`id_usuario`, 'DELETE', OLD.`username`, OLD.`password`, OLD.`nombre`, OLD.`apellido`, OLD.`is_active`, NEW.`username`, NEW.`password`, NEW.`nombre`, NEW.`apellido`, NEW.`is_active`, USER());
  ELSEIF OLD.is_active = 0 AND NEW.is_active = 1 THEN
	  INSERT INTO `usuario_audit` (`user_id`, `operation`, `username_old`, `password_old`, `nombre_old`, `apellido_old`, `is_active_old`, `username_new`, `password_new`, `nombre_new`, `apellido_new`, `is_active_new`, `changed_by`)
	  VALUES (OLD.`id_usuario`, 'ACTIVATE', OLD.`username`, OLD.`password`, OLD.`nombre`, OLD.`apellido`, OLD.`is_active`, NEW.`username`, NEW.`password`, NEW.`nombre`, NEW.`apellido`, NEW.`is_active`, USER());
  END IF;
END
$$;

-- #####################################################
-- PROCEDIMIENTOS
-- #####################################################

-- INSERT usuario
DELIMITER //

CREATE PROCEDURE sp_insertar_usuario(
    IN p_username VARCHAR(45),
    IN p_password VARCHAR(255),
    IN p_nombre VARCHAR(45),
    IN p_apellido VARCHAR(45)
)
BEGIN
    INSERT INTO usuario(username, password, nombre, apellido, is_active)
    VALUES (p_username, p_password, p_nombre, p_apellido, 1);
    commit;
END //

DELIMITER ;

-- UPDATE USUARIO

DELIMITER //

CREATE PROCEDURE sp_actualizar_usuario(
    IN p_id_usuario INT,
    IN p_username VARCHAR(45),
    IN p_password VARCHAR(255),
    IN p_nombre VARCHAR(45),
    IN p_apellido VARCHAR(45)
)
BEGIN
    UPDATE usuario
    SET username = p_username,
        password = p_password,
        nombre = p_nombre,
        apellido = p_apellido
    WHERE id_usuario = p_id_usuario;
    commit;
END //

DELIMITER ;

-- DELETE USUARIO

DELIMITER //

CREATE PROCEDURE sp_baja_logica_usuario(
    IN p_id_usuario INT
)
BEGIN
    UPDATE usuario
    SET is_active = 0
    WHERE id_usuario = p_id_usuario;
    commit;
END //
DELIMITER ;

-- #####################################################
-- FIN
-- #####################################################
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- PRUEBAS

USE colegiotp;

-- INSERTAR USUARIOS
call sp_insertar_usuario("LucasCaraballo", "12345678", "Lucas", "Caraballo");
call sp_insertar_usuario("AgusMontalvo", "85858585", "Agustina", "Montalvo");
call sp_insertar_usuario("LucasSain", "75757575", "Lucas", "Sain");
call sp_insertar_usuario("VictorElias", "basededatos3", "Victor Elias", "Gomez");
call sp_insertar_usuario("JuaniP", "123123123", "Juan", "Pardo");

-- call sp_baja_logica_usuario(8);
-- call sp_actualizar_usuario(8, "VictorElias", "basededatos3", "Victor Elias Test", "Gomez Ibañez");

-- SELECT * FROM usuario_audit;
-- SELECT * FROM usuario;