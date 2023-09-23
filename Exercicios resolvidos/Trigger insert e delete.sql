CREATE DATABASE bdfinanceiro;
USE bdfinanceiro;

CREATE TABLE conta(
    numero INT PRIMARY KEY,
    agencia INT,
    cpf INT(11),
    saldo DOUBLE(10,2)
);

INSERT INTO conta (numero, agencia, cpf, saldo) VALUES
(12345, 101, 12345678901, 1000.00),
(67890, 102, 23456789012, 2000.00),
(11122, 103, 34567890123, 3000.00);

CREATE TABLE saque(
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor DOUBLE(10,2),
    nrconta INT,
    FOREIGN KEY(nrconta) REFERENCES conta(numero)
);

CREATE TABLE deposito(
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor DOUBLE(10,2),
    nrconta INT,
    FOREIGN KEY(nrconta) REFERENCES conta(numero)
);

DELIMITER $$
CREATE TRIGGER tr_after_saque AFTER INSERT ON saque
FOR EACH ROW
BEGIN
    UPDATE conta SET saldo = saldo - NEW.valor WHERE numero = NEW.nrconta;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tr_after_deposito AFTER INSERT ON deposito
FOR EACH ROW
BEGIN
    UPDATE conta SET saldo = saldo + NEW.valor WHERE numero = NEW.nrconta;
END $$
DELIMITER ;


INSERT INTO saque (valor, nrconta) VALUES
(100.00, 12345),
(200.00, 67890);

INSERT INTO deposito (valor, nrconta) VALUES
(300.00, 12345),
(400.00, 67890),
(500.00, 11122);

SELECT * FROM conta;


DELIMITER $$
CREATE TRIGGER tr_after_delete_saque AFTER DELETE ON saque
FOR EACH ROW
BEGIN
    UPDATE conta SET saldo = saldo + OLD.valor WHERE numero = OLD.nrconta;
END $$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER tr_after_delete_deposito AFTER DELETE ON deposito
FOR EACH ROW
BEGIN
    UPDATE conta SET saldo = saldo - OLD.valor WHERE numero = OLD.nrconta;
END $$
DELIMITER ;

DELETE FROM saque WHERE id IN (1, 2, 3);

DELETE FROM deposito WHERE id IN (1, 2, 3);

CREATE VIEW saques_view AS
SELECT c.numero AS numero_conta, c.agencia AS agencia, s.valor AS valor_saque
FROM conta c
JOIN saque s ON c.numero = s.nrconta;

CREATE VIEW depositos_view AS
SELECT c.numero AS numero_conta, c.agencia AS agencia, d.valor AS valor_deposito
FROM conta c
JOIN deposito d ON c.numero = d.nrconta;

SELECT * FROM saques_view;

SELECT * FROM depositos_view;

	