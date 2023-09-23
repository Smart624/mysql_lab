CREATE DATABASE fabrica;
USE fabrica;

CREATE TABLE motor
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    descricao   VARCHAR(20)                                     NOT NULL,
    cilindradas INT CHECK (cilindradas IN (125, 150, 250, 300)) NOT NULL
);

CREATE TABLE moto
(
    cor    VARCHAR(20) CHECK (cor IN ('preto', 'vermelho', 'prata', 'azul')) NOT NULL,
    modelo VARCHAR(20)                                                       NOT NULL,
    id     INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES motor (id)
);

INSERT INTO motor (descricao, cilindradas)
VALUES ('motor 1', 125);
INSERT INTO moto (cor, modelo)
VALUES ('azul', 'modelo 1');

SELECT moto.id, moto.cor, moto.modelo, motor.cilindradas
FROM moto
         INNER JOIN motor ON moto.id = motor.id
WHERE moto.cor = 'vermelho'
  AND motor.cilindradas = 150;

DELIMITER $$

CREATE PROCEDURE insertorupdateMotor(IN motorid INT, IN motorDescricao VARCHAR(20), IN motorCilindradas INT)
BEGIN
    DECLARE var_motorid INT;
    SET var_motorid = (SELECT id FROM motor WHERE id = motorid);
    IF var_motorid IS NULL THEN
        INSERT INTO motor (descricao, cilindradas) VALUES (motorDescricao, motorCilindradas);
    ELSE
        UPDATE motor SET descricao = motorDescricao, cilindradas = motorCilindradas WHERE id = var_motorid;
    END IF;
END $$

CREATE PROCEDURE insertorupdateMoto(IN motoId INT, IN motoCor VARCHAR(20), IN motoModelo VARCHAR(20), IN motorid INT)
BEGIN
    DECLARE var_motoid INT;
    SET var_motoid = (SELECT id FROM moto WHERE id = motoId);
    IF var_motoid IS NULL THEN
        INSERT INTO moto (cor, modelo, id) VALUES (motoCor, motoModelo, motorid);
    ELSE
        UPDATE moto SET cor = motoCor, modelo = motoModelo, id = motorid WHERE id = var_motoid;
    END IF;
END $$

CREATE PROCEDURE selectMotor(IN var_motorid INT)
BEGIN
    IF var_motorid IS NULL THEN
        SELECT * FROM motor;
    ELSE
        SELECT * FROM motor WHERE id = var_motorid;
    END IF;
END $$

CREATE PROCEDURE selectMoto(IN var_motoid INT)
BEGIN
    IF var_motoid IS NULL THEN
        SELECT * FROM moto;
    ELSE
        SELECT * FROM moto WHERE id = var_motoid;
    END IF;
END $$

CREATE PROCEDURE deleteMotor(IN var_motorid INT)
BEGIN
    DELETE FROM motor WHERE id = var_motorid;
END $$

CREATE PROCEDURE deleteMoto(IN var_motoid INT)
BEGIN
    DELETE FROM moto WHERE id = var_motoid;
END $$

DELIMITER ;

CALL insertorupdateMotor(1, 'motor 1', 125);
CALL insertorupdateMoto(1, 'azul', 'modelo 1', 1);
CALL insertorupdateMotor(2, 'motor 2', 150);
CALL insertorupdateMoto(2, 'vermelho', 'modelo 2', 2);
CALL selectMoto(NULL);
CALL selectMotor(NULL);
CALL selectMoto(1);
CALL selectMotor(1);
CALL deleteMoto(1);
CALL deleteMotor(1);
