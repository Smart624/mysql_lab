CREATE TABLE produto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50),
    quantidade INT,
    vlUnitario DOUBLE(10,2),
    dataValidade DATE
);

-- Insira 6 registros
INSERT INTO produto (descricao, quantidade, vlUnitario, dataValidade) VALUES
('Produto A', 50, 5.00, '2024-12-01'),
('Produto B', 150, 15.00, '2023-11-20'),
('Produto C', 250, 55.00, '2023-09-15'),
('Produto D', 90, 9.50, '2023-10-01'),
('Produto E', 180, 30.00, '2023-08-30'),
('Produto F', 210, 60.00, '2024-01-01');


DELIMITER $$
CREATE FUNCTION situacaoEstoque(quantidade INT)
RETURNS VARCHAR(15)
BEGIN
    IF quantidade < 100 THEN
        RETURN 'reestabelecer';
    ELSEIF quantidade BETWEEN 100 AND 200 THEN
        RETURN 'normal';
    ELSE
        RETURN 'liquidar';
    END IF;
END$$
DELIMITER ;

CREATE VIEW viewSituacao AS
SELECT id, descricao, quantidade, vlUnitario, situacaoEstoque(quantidade) AS situacao FROM produto;


DELIMITER $$
CREATE FUNCTION categoriaProduto(vlUnitario DOUBLE)
RETURNS VARCHAR(25)
BEGIN
    IF vlUnitario < 10 THEN
        RETURN 'miudezas';
    ELSEIF vlUnitario BETWEEN 10 AND 50 THEN
        RETURN 'produtos do dia a dia';
    ELSE
        RETURN 'muito caro';
    END IF;
END$$
DELIMITER ;

CREATE VIEW viewClassificacao AS
SELECT id, descricao, vlUnitario, categoriaProduto(vlUnitario) AS categoria FROM produto;


DELIMITER $$
CREATE FUNCTION statusVencimento(dataValidade DATE)
RETURNS VARCHAR(20)
BEGIN
    IF dataValidade < CURDATE() THEN
        RETURN 'vencido';
    ELSEIF dataValidade BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 20 DAY) THEN
        RETURN 'próximo ao vencimento';
    ELSE
        RETURN 'ok';
    END IF;
END$$
DELIMITER ;

CREATE VIEW viewVencimento AS
SELECT id, descricao, dataValidade, statusVencimento(dataValidade) AS status FROM produto;


SELECT REVERSE(descricao) FROM produto;
SELECT RIGHT(descricao, 3) FROM produto;
SELECT LEFT(descricao, 3) FROM produto;
SELECT CONCAT('Produto: ', descricao) FROM produto;
SELECT CONCAT(LEFT(descricao, 3), RIGHT(descricao, 3)) FROM produto;
SELECT UPPER(descricao), LOWER(descricao) FROM produto;
SELECT TRIM(descricao) FROM produto;
SELECT SUBSTRING(descricao, 3, 5) FROM produto;
SELECT LENGTH(descricao) FROM produto;
SELECT REPLACE(descricao, 'A', 'Z') FROM produto;
UPDATE produto SET descricao = REPLACE(descricao, 'A', 'Z');
