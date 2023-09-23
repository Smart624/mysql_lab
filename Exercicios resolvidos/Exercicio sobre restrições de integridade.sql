Exercícios sobre Restrições de Integridade (RIs) – SQL

1) Crie um BD chamado universidade e defina as tabelas a seguir neste BD. Nomeie as restrições de chave primária e estrangeira, como exemplificado:

Professores (matricula, nome, RG, sexo, idade, titulação, categoria, nroTurmas)
•	matrícula é chave primária; 
•	nome é um atributo obrigatório;
•	RG é um atributo que tem valor único para cada professor;
•	sexo pode ser: ‘M’ ou ‘F’;
•	idade deve estar entre 21 e 80 anos;
•	titulação deve ser: ‘graduado’, ‘especialista’, ‘mestre’ ou ‘doutor’;
•	categoria deve ser: ‘auxiliar’, ‘assistente’, ‘adjunto’ ou ‘titular’;
•	nroTurmas deve ser maior ou igual a 0.
Exemplo: criação da tabela Professores
create table Professores (
matricula int primary key,
nome varchar(40) not null,
RG int(10) unique,
sexo char(1) check(sexo in ('M','F')),
idade tinyint check(idade between 21 and 80),
titulacao varchar(15) check(titulacao in ('graduado','especialista', 'mestre', 'doutor')),
categoria varchar(15) check(categoria in ('auxiliar','assistente', 'adjunto', 'titular')),
nroTurmas tinyint check(nroTurmas >= 0))

 

Cursos(código, nome, duração)
•	código é chave primária;
•	nome é um atributo obrigatório;
•	duração deve estar entre 4 e 12 (é o número de fases);
Disciplinas(código, nome, créditos) 
•	código é chave primária;
•	nome é um atributo obrigatório;
•	créditos deve estar entre 2 e 8.
Turmas(código, vagas, professor)
•	código é chave primária;
•	Vagas deve ser maior que zero;

2) INSIRA 2 REGISTROS EM curso (exemplo curso ADS e gestão), 2 disciplinas, 2 turmas e 3 professores

3) CRIE UM SELECT QUE MOSTRE AS INFORMAÇÕES DA TURMA E O NOME DO RESPECTIVO PROFESSOR (mostrando: Nome professor, Nome curso, turma) (INNER JOIN)

4) Crie VIEWs para mostrar todos as disciplinas de ADS; todas de Gestão; professores que estão em ADS; professores que não estão em ADS, número de disciplinas por curso, número de turmas por professor; e professor sem disciplina.

----------------------------------------------------------------------

1.
CREATE DATABASE universidade;
USE universidade;

CREATE TABLE Professores (
    matricula INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    RG INT UNIQUE,
    sexo CHAR(1) CHECK(sexo IN ('M','F')),
    idade TINYINT CHECK(idade BETWEEN 21 AND 80),
    titulacao VARCHAR(15) CHECK(titulacao IN ('graduado','especialista', 'mestre', 'doutor')),
    categoria VARCHAR(15) CHECK(categoria IN ('auxiliar','assistente', 'adjunto', 'titular')),
    nroTurmas TINYINT CHECK(nroTurmas >= 0)
);

CREATE TABLE Cursos (
    codigo INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    duracao TINYINT CHECK(duracao BETWEEN 4 AND 12)
);

CREATE TABLE Disciplinas (
    codigo INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    creditos TINYINT CHECK(creditos BETWEEN 2 AND 8),
    curso_codigo INT,
    FOREIGN KEY (curso_codigo) REFERENCES Cursos(codigo)
);

CREATE TABLE Turmas (
    codigo INT PRIMARY KEY,
    vagas INT CHECK(vagas > 0),
    professor INT,
    disciplina_codigo INT,
    FOREIGN KEY (professor) REFERENCES Professores(matricula),
    FOREIGN KEY (disciplina_codigo) REFERENCES Disciplinas(codigo)
);



2.
INSERT INTO Cursos VALUES (1, 'ADS', 8), (2, 'Gestão', 6);
INSERT INTO Disciplinas VALUES (101, 'Matemática', 4, 1), (102, 'Administração', 3, 2);
INSERT INTO Professores VALUES (1001, 'Alice', 1234567890, 'F', 35, 'mestre', 'adjunto', 2),
                               (1002, 'Bob', 2345678901, 'M', 40, 'doutor', 'titular', 3),
                               (1003, 'Charlie', 3456789012, 'M', 30, 'graduado', 'assistente', 1);
INSERT INTO Turmas VALUES (201, 30, 1001, 101), (202, 25, 1002, 102);



3.
SELECT p.nome AS NomeProfessor, c.nome AS NomeCurso, t.codigo AS Turma
FROM Turmas t
INNER JOIN Professores p ON t.professor = p.matricula
INNER JOIN Disciplinas d ON t.disciplina_codigo = d.codigo
INNER JOIN Cursos c ON d.curso_codigo = c.codigo;


4.
-- Todas as disciplinas de ADS
CREATE VIEW view_disciplinas_ads AS
SELECT d.*
FROM Disciplinas d
WHERE d.curso_codigo = 1;

-- Todas as disciplinas de Gestão
CREATE VIEW view_disciplinas_gestao AS
SELECT d.*
FROM Disciplinas d
WHERE d.curso_codigo = 2;

-- Professores que estão em ADS
CREATE VIEW view_professores_ads AS
SELECT DISTINCT p.*
FROM Professores p
JOIN Turmas t ON p.matricula = t.professor
JOIN Disciplinas d ON t.disciplina_codigo = d.codigo
WHERE d.curso_codigo = 1;

-- Professores que não estão em ADS
CREATE VIEW view_professores_not_ads AS
SELECT DISTINCT p.*
FROM Professores p
LEFT JOIN Turmas t ON p.matricula = t.professor
LEFT JOIN Disciplinas d ON t.disciplina_codigo = d.codigo
WHERE d.curso_codigo != 1 OR d.curso_codigo IS NULL;

-- Número de disciplinas por curso
CREATE VIEW view_disciplinas_por_curso AS
SELECT c.nome AS Curso, COUNT(d.codigo) AS NumeroDisciplinas
FROM Cursos c
LEFT JOIN Disciplinas d ON c.codigo = d.curso_codigo
GROUP BY c.nome;

-- Número de turmas por professor
CREATE VIEW view_turmas_por_professor AS
SELECT p.nome AS Professor, COUNT(t.codigo) AS NumeroTurmas
FROM Professores p
LEFT JOIN Turmas t ON p.matricula = t.professor
GROUP BY p.nome;

-- Professor sem disciplina
CREATE VIEW view_professor_sem_disciplina AS
SELECT p.*
FROM Professores p
LEFT JOIN Turmas t ON p.matricula = t.professor
WHERE t.professor IS NULL;



