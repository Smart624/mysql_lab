1.	CRIE A TABLE FORNECEDOR COM OS CAMPOS: ID, descrição, email
2.	Insira 3 fornecedores
3.	Crie a view de fornecedor
4.	CRIE A TABLE PRODUTO COM OS CAMPOS: Id, descrição, quantidade, vlUnitario, Categoria (ouro ou prata) e id_fornecedor (fk)
5.	Insira 4 registros.
6.	Crie uma visão com Código, Descrição do Produto, Estoque, Valor Unitário e Categoria.
7.	Execute a visão
8.	Altere a visão para mostrar somente produto com estoque acima de 100
9.	Execute a visão
10.	Altere a visão para mostrar somente produto ouro
11.	Exclua a visão
12.	Crie uma visão com Descrição do Produto, Nome do Fornecedor e E-mail do Forncedor
13.	Execute a visão
Poste todos os códigos SQL gerados
------------------------------------------------------------------

1.
CREATE TABLE fornecedor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255),
    email VARCHAR(255)
);


2.
INSERT INTO fornecedor (descricao, email) VALUES ('Fornecedor 1', 'fornecedor1@example.com');
INSERT INTO fornecedor (descricao, email) VALUES ('Fornecedor 2', 'fornecedor2@example.com');
INSERT INTO fornecedor (descricao, email) VALUES ('Fornecedor 3', 'fornecedor3@example.com');


3.
CREATE VIEW view_fornecedor AS
SELECT * FROM fornecedor;


4.
CREATE TABLE produto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255),
    quantidade INT,
    vlUnitario DECIMAL(10,2),
    categoria ENUM('ouro', 'prata'),
    id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id)
);


5.
INSERT INTO produto (descricao, quantidade, vlUnitario, categoria, id_fornecedor) VALUES ('Produto 1', 100, 150.50, 'ouro', 1);
INSERT INTO produto (descricao, quantidade, vlUnitario, categoria, id_fornecedor) VALUES ('Produto 2', 200, 100.25, 'prata', 2);
INSERT INTO produto (descricao, quantidade, vlUnitario, categoria, id_fornecedor) VALUES ('Produto 3', 50, 300.75, 'ouro', 3);
INSERT INTO produto (descricao, quantidade, vlUnitario, categoria, id_fornecedor) VALUES ('Produto 4', 150, 250.00, 'prata', 1);


6.
CREATE VIEW view_produto AS
SELECT id AS Codigo, descricao AS Produto, quantidade AS Estoque, vlUnitario AS ValorUnitario, categoria AS Categoria
FROM produto;


7.
SELECT * FROM view_produto;


8.
ALTER VIEW view_produto AS
SELECT id AS Codigo, descricao AS Produto, quantidade AS Estoque, vlUnitario AS ValorUnitario, categoria AS Categoria
FROM produto
WHERE quantidade > 100;


9.
SELECT * FROM view_produto;


10.
ALTER VIEW view_produto AS
SELECT id AS Codigo, descricao AS Produto, quantidade AS Estoque, vlUnitario AS ValorUnitario, categoria AS Categoria
FROM produto
WHERE categoria = 'ouro';


11.
DROP VIEW view_produto;


12.
CREATE VIEW view_produto_fornecedor AS
SELECT p.descricao AS Produto, f.descricao AS Fornecedor, f.email AS Email
FROM produto p
JOIN fornecedor f ON p.id_fornecedor = f.id;


13.
SELECT * FROM view_produto_fornecedor;

