/*STORED PROCEDURE – INSERÇÃO / EDIÇÃO – EXERCÍCIOS
Um evento (peça, espetáculo ou algo assim) poderá ter 1 ou vários integrantes, ou seja, um ou vários profissionais na apresentação/preparação e esse mesmo evento poderá ser classificado em uma ou várias categorias: como comédia, terror, musical...
Já o ingresso será vinculado a um evento e a um usuário. Resumindo, o usuário poderá adquirir um ingresso para um evento.
1) Crie o BD -> create database bdteatro e as tables conforme DER. No mínimo 4 campos por table (isso inclui pk e fk)
2) Após criar as tabelas crie 4 procedures para inserção/edição para as tabelas evento, ingresso, usuario e categoria
3) Faça as chamadas de cada procedure
4) Em uma das chamadas, implemente em um método em qualquer linguagem de programação (é só postar o código do método)
*/


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


DELIMITER $$
CREATE PROCEDURE salvar_evento(IN var_id_evento int, var_nome varchar(50), var_data_evento date, var_hora_evento time)

BEGIN
    IF (EXISTS(SELECT e.id_evento FROM evento e WHERE id_evento = var_id_evento)) THEN
        UPDATE evento
        SET nome        = var_nome,
            data_evento = var_data_evento,
            hora_evento = var_hora_evento
        WHERE id_evento = var_id_evento;
    ELSE
        INSERT INTO evento (nome, data_evento, hora_evento) VALUES (var_nome, var_data_evento, var_hora_evento);
    end if;
end $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE salvar_categoria(IN var_id_categoria int, var_nome varchar(50), var_id_evento int,
                                  var_description varchar(50))
BEGIN
    IF (EXISTS(SELECT c.id_categoria FROM categoria c WHERE var_id_categoria = id_categoria)) THEN
        UPDATE categoria
        SET nome        = var_nome,
            id_evento   = var_id_evento,
            description = var_description
        where id_categoria = var_id_categoria;
    ELSE
        INSERT INTO categoria (nome, id_evento, description)
        values (var_nome, var_id_evento, var_description); /* nao foi inserido o id_categoria porque é auto_increment */
    END IF;
END $$;
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE salvar_ingresso(IN var_id_ingresso int, var_id_evento int, var_id_usuario int,
                                 var_valor decimal(10, 2))
begin
    IF (EXISTS(SELECT i.id_ingresso FROM ingresso i WHERE var_id_ingresso = id_ingresso)) THEN
        update ingresso
        SET id_evento  = var_id_evento,
            id_usuario = var_id_usuario,
            valor      = var_valor
        where id_ingresso = var_id_ingresso;
    ELSE
        INSERT INTO ingresso (id_evento, id_usuario, valor) values (var_id_evento, var_id_usuario, var_valor);
    END IF;
end $$
DELIMITER ;


DELIMITER $$
CREATE procedure salvar_usuario(IN var_id_usuario int, var_nome varchar(50), var_email varchar(50),
                                var_senha varchar(50))
BEGIN
    IF (EXISTS(SELECT u.id_usuario FROM usuario u WHERE id_usuario = var_id_usuario)) THEN
        UPDATE usuario SET nome = var_nome, email = var_email, senha = var_senha WHERE id_usuario = var_id_usuario;
    ELSE
        INSERT INTO usuario (nome, email, senha) values (var_nome, var_email, var_senha);
    end if;
end $$
DELIMITER ;

CALL salvar_evento(null, 'O Fantasma da Ópera', '2021-10-10', '20:00:00');
CALL salvar_evento(null, 'O Rei Leão', '2021-10-10', '20:00:00');
CALL salvar_evento(null, 'O Fantasma da Ópera', '2021-10-10', '20:00:00');

CALL salvar_categoria(null, 'Comédia', 1, 'Comédia');
CALL salvar_categoria(null, 'Terror', 2, 'Terror');
CALL salvar_categoria(null, 'Musical', 3, 'Musical');

CALL salvar_ingresso(NULL, 1, 1, 100.00);
CALL salvar_ingresso(null, 2, 2, 200.00);
CALL salvar_ingresso(null, 3, 3, 300.00);

CALL salvar_usuario(null, 'João', 'joao.alencar@gmail.com');
CALL salvar_usuario(null, 'Maria', 'maria@gmail.com');
CALL salvar_usuario(null, 'José', 'jose@gmail.com');

/* import java.sql.*;

public void salvarIngresso(int idIngresso, int idEvento, int idUsuario, double valor) {
    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://host/bdteatro", "user", "password");
        CallableStatement cs = conn.prepareCall("{call salvar_ingresso(?, ?, ?, ?)}");
        cs.setInt(1, idIngresso);
        cs.setInt(2, idEvento);
        cs.setInt(3, idUsuario);
        cs.setDouble(4, valor);
        cs.execute();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
 */

/* const mysql = require('mysql');

const salvarIngresso = (idIngresso, idEvento, idUsuario, valor) => {
   const connection = mysql.createConnection({
       host: 'host',
       user: 'user',
       password: 'password',
       database: 'bdteatro'
   });

   connection.connect();

   connection.query('CALL salvar_ingresso(?, ?, ?, ?)', [idIngresso, idEvento, idUsuario, valor], (error, results, fields) => {
       if (error) throw error;
   });

   connection.end();
};
*/
