#EXERCÍCIO:
CRIE O BANCO LOJA COM AS TABELAS  MOTO E MOTOR
MOTO: ID, MODELO, COR, ID_MOTOR
MOTOR: ID, CILINDRADAS

- CRIE UMA TRIGGER QUE PERMITA APENAS CILINDRADAS DE 150, 250, 350 e 500, SENDO:
-> SE CILINDRADAS <= 150 => MANTER 150
-> SE CILINDRADAS <= 250 => MANTER 250
-> SE CILINDRADAS <= 350 => MANTER 350
-> SE CILINDRADAS > 350 => MANTER 500

----------------------------------------------------------------------------

CREATE DATABASE LOJA;
USE LOJA;

CREATE TABLE motor (
    id_Motor INT PRIMARY KEY AUTO_INCREMENT,
    cilindradas int
);

CREATE TABLE moto (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    modelo VARCHAR(20),
    cor VARCHAR(20),
    id_Motor INT,
    FOREIGN KEY(id_Motor) REFERENCES motor(id_Motor)
);

DELIMITER $$
CREATE TRIGGER arredondar BEFORE INSERT ON motor
FOR EACH ROW
BEGIN
    IF NEW.cilindradas <= 150 THEN
        SET NEW.cilindradas = 150;
    ELSEIF NEW.cilindradas <= 250 THEN
        SET NEW.cilindradas = 250;
    ELSEIF NEW.cilindradas <= 350 THEN
        SET NEW.cilindradas = 350;
    ELSEIF NEW.cilindradas > 350 THEN
        SET NEW.cilindradas = 500;
    END IF;
END $$
DELIMITER ;

INSERT INTO motor (cilindradas) VALUES
(3),
(200),
(300),
(400);
