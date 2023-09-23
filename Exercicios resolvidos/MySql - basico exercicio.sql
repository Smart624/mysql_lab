Verifique com atenção o nome dos campos e os dados para resolução da Atividade.

1 - Crie e acesse um Banco de Dados chamado empresa.

2 - Crie a tabela produtos conforme informações abaixo:
Create table produtos
	(id int key auto_increment,
	produto varchar(60),
	estoque int,
	valor float(8,2)
	tipo varchar(60),
	unidade varchar(10),
	marca varchar(25),
	data_fabricacao date);


3 - Faça os Inserts abaixo na tabela, você pode copiar e colar.

insert into produtos values (null, 'Arroz Integral',100,15.00,'Alimentos','KG','Tio João','2016-01-20');
insert into produtos values (null, 'Blu-Ray Player',25,550.00,'Eletrônico','Peça','Sony','2015-10-25');
insert into produtos values (null, 'Notebook i7',10,2850.00,'Eletrônico','Peça','Samsung','2015-05-30');
insert into produtos values (null, 'Iphone 5',30,2500.00,'Eletrônico','Peça','Apple','2016-02-10');
insert into produtos values (null, 'Sabão em Pó',2000,8.00,'Produtos de Limpeza','Kilo','Omo','2015-04-15');
insert into produtos values (null, 'Detergente',800,5.00,'Produtos de Limpeza','Litro','Limpol','2013-03-30');
insert into produtos values (null, 'Palha de Aço',3000,4.00,'Produtos de Limpeza','Grama','Bombril','2016-02-15');
insert into produtos values (null, 'Arroz',12,15.00,'Alimentos','Kilo','Panela de Ferro','2014-04-25');
insert into produtos values (null, 'Feijão',30,18.00,'Alimentos','Kilo','Caldão','2014-05-02');
insert into produtos values (null, 'Shampoo Anti Caspa',600,12.00,'Cosmeticos','Litro','Palmolive','2014-05-12');
insert into produtos values (null, 'Escova de Dentes',1500,15.00,'Cosmeticos','Peça','Oral-B','2015-12-29');
insert into produtos values (null, 'Sabonete',3000,2.00,'Cosmeticos','Unidade','Rexona','2015-12-29');
insert into produtos values (null, 'Geladeira',40,2200.00,'Eletrodomestico','Peça','Brastemp','2013-12-12');
insert into produtos values (null, 'Fogão de Embutir 5 Bocas',15,1600.00,'Eletrodomestico','Peça','Venox','2013-12-12');
insert into produtos values (null, 'Forno Microondas',65,450.00,'Eletrodomestico','Peça','Consul','2013-12-01');

4 -Altere os campos do produto Arroz Integral conforme informações abaixo:
Valor: R$ 13.00          Marca: Panela de Ferro       Fabricação: 05-05-2014               Tipo: Pacote

5 - Altere todos os produtos do tipo Cosméticos para:
valor: R$ 25.00 e fabricação para 30-03-2016

6 - Exiba a média dos preços apenas dos Eletrodomesticos com o apelido Media_Eletro.

7 - Apagar os produtos que tenham o valor acima de R$ 300,00 e id superior a 8.

8 - Listar o nome, estoque e valor de todos os produtos.

9 - Listar as tabelas existentes no Banco de Dados e depois sua Estrutura.

10 - Listar o valor do produto mais caro com o apelido Maior_Valor.

11 - Listar os produtos que custem menos de 18.00 e sejam do tipo Alimentos.

12 - Listar o nome do produto e o valor do produto em ordem Descendente.

13 - Apagar todos os dados da tabela.

------------------------------------------------------------------

1.
CREATE DATABASE empresa;
USE empresa;

2.
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto VARCHAR(60),
    estoque INT,
    valor FLOAT(8,2),
    tipo VARCHAR(60),
    unidade VARCHAR(10),
    marca VARCHAR(25),
    data_fabricacao DATE
);

4.
UPDATE produtos SET valor=13.00, marca='Panela de Ferro', data_fabricacao='2014-05-05', tipo='Pacote' WHERE produto='Arroz Integral';

5.
UPDATE produtos SET valor=25.00, data_fabricacao='2016-03-30' WHERE tipo='Cosmeticos';

6.
SELECT AVG(valor) AS Media_Eletro FROM produtos WHERE tipo='Eletrodomestico';

7.
DELETE FROM produtos WHERE valor > 300 AND id > 8;

8.
SELECT produto, estoque, valor FROM produtos;


9.
SHOW TABLES;
DESCRIBE produtos;


10.
SELECT MAX(valor) AS Maior_Valor FROM produtos;


11.
SELECT * FROM produtos WHERE valor < 18 AND tipo='Alimentos';


12.
SELECT produto, valor FROM produtos ORDER BY valor DESC;

13.
DELETE FROM produtos;
