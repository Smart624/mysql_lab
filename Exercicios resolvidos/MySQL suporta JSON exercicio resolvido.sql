1. Crie uma tabela funcionario com: id, nome e dados (dados é json)

2. Armazene em dados para 3 administrativos e 3 docentes
> administrativo deve guardar salario_mensal, ocupacao 
> docente deverá guardar salario_horaaula, titulacao_maxima e disciplina_acesso

3. Atualize hora aula de 1 docente

4. atualize a ocupação de 2 administrativos

5. Selecione os docentes mestres

------------------------------------------------------------

1.
CREATE TABLE funcionario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    dados JSON
);


2.
-- Administrativos
INSERT INTO funcionario (nome, dados) VALUES ('Administrativo 1', '{"salario_mensal": 5000, "ocupacao": "Gerente"}');
INSERT INTO funcionario (nome, dados) VALUES ('Administrativo 2', '{"salario_mensal": 4000, "ocupacao": "Contador"}');
INSERT INTO funcionario (nome, dados) VALUES ('Administrativo 3', '{"salario_mensal": 3500, "ocupacao": "Assistente"}');

-- Docentes
INSERT INTO funcionario (nome, dados) VALUES ('Docente 1', '{"salario_horaaula": 30, "titulacao_maxima": "Doutor", "disciplina_acesso": ["Matemática", "Física"]}');
INSERT INTO funcionario (nome, dados) VALUES ('Docente 2', '{"salario_horaaula": 25, "titulacao_maxima": "Mestre", "disciplina_acesso": ["Literatura", "História"]}');
INSERT INTO funcionario (nome, dados) VALUES ('Docente 3', '{"salario_horaaula": 20, "titulacao_maxima": "Especialista", "disciplina_acesso": ["Química", "Biologia"]}');


3.
UPDATE funcionario
SET dados = JSON_SET(dados, '$.salario_horaaula', 35)
WHERE nome = 'Docente 1';

4.
UPDATE funcionario
SET dados = JSON_SET(dados, '$.ocupacao', 'Gerente Financeiro')
WHERE nome = 'Administrativo 1';

UPDATE funcionario
SET dados = JSON_SET(dados, '$.ocupacao', 'Assistente Executivo')
WHERE nome = 'Administrativo 3';


5.
SELECT nome, dados
FROM funcionario
WHERE JSON_UNQUOTE(JSON_EXTRACT(dados, '$.titulacao_maxima')) = 'Mestre';
