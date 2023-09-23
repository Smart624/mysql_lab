/*Procedure Consulta

Utilizando o BD criado (última tarefa teams) para a procedure salvar/editar, faça:

1) Crie 2 Procedures para disparar consulta por id, geral e por like em 2 tabelas (a sua escolha - )

2) Crie 2 Procedures insert/update/delete (crud) em 2 tabelas (a sua escolha) – você deverá chamar o procedure do enunciado 1 dentro do crud

Postar prints no TEAMS/tarefa */


create database bdteatro;

USE bdteatro;

CREATE TABLE integrantes
(
    id_integrante     int         not null auto_increment,
    nome              varchar(50) not null,
    id_evento         int         not null,
    tipo_profissional varchar(50) not null,
    primary key (id_integrante)
);

CREATE TABLE categoria
(
    id_categoria int         not null auto_increment,
    nome         varchar(50) not null,
    id_evento    int         not null,
    description  varchar(50) not null,
    primary key (id_categoria)
);

CREATE TABLE usuario
(
    id_usuario int         not null auto_increment,
    nome       varchar(50) not null,
    email      varchar(50) not null,
    senha      varchar(50) not null,
    primary key (id_usuario)
);

CREATE TABLE evento
(
    id_evento   int         not null auto_increment,
    nome        varchar(50) not null,
    data_evento date        not null,
    hora_evento time        not null,
    primary key (id_evento),
    FOREIGN KEY (id_evento) REFERENCES integrantes (id_evento),
    FOREIGN KEY (id_evento) REFERENCES categoria (id_evento)
);

CREATE TABLE ingresso
(
    id_ingresso int            not null auto_increment,
    id_evento   int            not null,
    id_usuario  int            not null,
    valor       decimal(10, 2) not null,
    primary key (id_ingresso),
    foreign key (id_evento) references evento (id_evento),
    foreign key (id_usuario) references usuario (id_usuario)
);


USE bdteatro;

DELIMITER $$
CREATE PROCEDURE listar_integrantes(IN var_id INT)
BEGIN
    IF var_id IS NULL THEN
        SELECT * FROM integrantes ORDER BY nome;
    ELSE
        SELECT * FROM integrantes WHERE id_integrante = var_id;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE listar_categorias(IN var_id INT, IN var_nome VARCHAR(50))
BEGIN
    IF (var_id IS NOT NULL) AND (var_nome IS NOT NULL) THEN
        SELECT 'Aviso, informe o id ou nome' AS mensagem;
    ELSE
        SELECT *
        FROM categoria
        WHERE (id_categoria = var_id OR var_id IS NULL)
          AND (nome LIKE CONCAT('%', var_nome, '%') OR var_nome IS NULL);
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE crud_evento(IN var_id INT, var_nome VARCHAR(50), var_data DATE, var_hora TIME, var_opcao VARCHAR(1))
BEGIN
    IF (EXISTS(SELECT e.id_evento FROM evento e WHERE e.id_evento = var_id)) THEN
        IF (var_opcao = 'u') THEN
            UPDATE evento SET nome = var_nome, data_evento = var_data, hora_evento = var_hora WHERE id_evento = var_id;
        ELSEIF (var_opcao = 'd') THEN
            DELETE FROM evento WHERE id_evento = var_id;
        END IF;
    ELSE
        INSERT INTO evento (nome, data_evento, hora_evento) VALUES (var_nome, var_data, var_hora);
    END IF;
    CALL listar_integrantes(NULL);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE crud_usuario(IN var_id INT, var_nome VARCHAR(50), var_email VARCHAR(50), var_senha VARCHAR(50),
                              var_opcao VARCHAR(1))
BEGIN
    IF (EXISTS(SELECT u.id_usuario FROM usuario u WHERE u.id_usuario = var_id)) THEN
        IF (var_opcao = 'u') THEN
            UPDATE usuario SET nome = var_nome, email = var_email, senha = var_senha WHERE id_usuario = var_id;
        ELSEIF (var_opcao = 'd') THEN
            DELETE FROM usuario WHERE id_usuario = var_id;
        END IF;
    ELSE
        INSERT INTO usuario (nome, email, senha) VALUES (var_nome, var_email, var_senha);
    END IF;
    CALL listar_categorias(NULL, NULL);
END$$
DELIMITER ;

call listar_integrantes(NULL);
call listar_integrantes(1);

call listar_categorias(NULL, NULL);
call listar_categorias(1, NULL);
call listar_categorias(NULL, 'a');
call listar_categorias(1, 'a');

call crud_evento(NULL, 'evento 1', '2021-10-10', '10:10:10', 'c');
call crud_evento(1, 'evento 1', '2021-10-10', '10:10:10', 'u');
call crud_evento(1, NULL, NULL, NULL, 'd');

call crud_usuario(NULL, 'Maria', 'maria@gmail.com', '123', 'c');
call crud_usuario(1, 'João', 'joao@email.com', '123');
call crud_usuario(1, NULL, NULL, NULL, 'd');
call crud_usuario(1, 'Lucas', 'lucas@email.com', 123, 'u');
