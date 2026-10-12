-- Database: VictorAndreUllerAtividade4

-- DROP DATABASE IF EXISTS "VictorAndreUllerAtividade4";

CREATE DATABASE "VictorAndreUllerAtividade4"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
	-- SCHEMA: Biblioteca

-- DROP SCHEMA IF EXISTS "Biblioteca" ;

CREATE SCHEMA IF NOT EXISTS "Biblioteca"
    AUTHORIZATION postgres;
	-- Database: Atividade04

-- DROP DATABASE IF EXISTS "Atividade04";


CREATE TABLE IF NOT EXISTS Livro (
id_livro serial PRIMARY KEY,
titulo varchar(100) NOT NULL,
autor varchar(50) NOT NULL,
ano_publicacao integer,
disponivel boolean DEFAULT true
);

CREATE TABLE IF NOT EXISTS Membro(
id_membro serial PRIMARY KEY,
nome varchar(50) NOT NULL,
email varchar(50) NOT NULL,
data_cadastro timestamp NOT NULL
);

CREATE TABLE IF NOT EXISTS Emprestimo(
id_emprestimo serial PRIMARY KEY,
id_livro integer,
id_membro integer,
data_emprestimo timestamp NOT NULL,
data_devolucao timestamp,
FOREIGN KEY (id_livro) REFERENCES Livro (id_livro),
FOREIGN KEY (id_membro) REFERENCES Membro (id_membro)
);


INSERT INTO Livro(titulo, autor, ano_publicacao)
VALUES('Dom Quixote', 'Miguel de Cervantes', 1605),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 1943),
('Hamlet', 'William Shakespeare', 1603),
('Cem Anos de Solidão', 'Gabriel Garcia Márquez', 1967),
('Orgulho e Preconceito', 'Jane Austen', 1813),
('1984', 'George Orwell', 1949),
('O Senhor dos Anéis', 'J.R.R. Tolkien', 1954),
('A Divina Comédia', 'Dante Alighieri', 1320);
INSERT INTO Livro(titulo, autor, ano_publicacao)
VALUES('Categorias', 'Aristóteles', 2024),
('Discurso do Método', 'René Descartes', 1637),
('Os Lusíadas', 'Luís de Camões', 1572);

INSERT INTO Membro(nome, email, data_cadastro)
VALUES('Ana Silva', 'ana.silva@example.com', '2022-01-10'),
('Bruno Gomes', 'bruno.gomes@example.com', '2022-02-15'),
('Carlos Eduardo', 'carlos.eduardo@example.com', '2022-03-20'),
('Daniela Rocha', 'daniela.rocha@example.com', '2022-05-05'),
('Eduardo Lima', 'eduardo.lima@example.com', '2022-06-10'),
('Fernanda Martins', 'fernanda.martins@example.com', '2022-07-15'),
('Gustavo Henrique', 'gustavo.henrique@example.com', '2022-08-20'),
('Helena Souza', 'helena.souza@example.com', '2022-09-25');

INSERT INTO Emprestimo(id_livro, id_membro, data_emprestimo, data_devolucao)
VALUES(1, 1, '2022-04-01', NULL),
(2, 2, '2022-04-03', '2022-04-10'),
(3, 3, '2022-04-05', NULL),
(4, 4, '2022-10-01', NULL),
(5, 5, '2022-10-03', '2022-10-17'),
(2, 3, '2022-10-06', NULL),
(1, 2, '2022-10-08', '2022-10-15'),
(3, 1, '2022-10-10', NULL),
(3, 2, '2022-11-01', NULL),
(2, 3, '2022-11-03', NULL),
(1, 4, '2022-11-05', NULL),
(5, 1, '2022-11-07', '2022-11-21'),
(4, 5, '2022-11-09', '2022-11-23'),
(2, 1, '2022-11-12', NULL),
(3, 4, '2022-11-14', '2022-11-28'),
(1, 3, '2022-11-16', NULL),
(5, 2, '2022-11-18', '2022-11-25'),
(4, 1, '2022-11-20', '2022-12-04');


------------------------------------------------------------------------------------------------------------------------------------------

-- a)--------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION indisponibiliza() RETURNS trigger AS $indisponibiliza$
BEGIN
	UPDATE livro SET disponivel = false WHERE livro.id_livro = NEW.id_livro;
	RETURN NEW;
END;
$indisponibiliza$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER indisponibiliza AFTER INSERT ON Emprestimo FOR EACH ROW EXECUTE FUNCTION indisponibiliza();


INSERT INTO Emprestimo(id_livro, id_membro, data_emprestimo, data_devolucao)
VALUES(4, 3, '2010-10-01', NULL);

SELECT * FROM livro ORDER BY id_livro;



--b) -------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION redisponibiliza() RETURNS trigger AS $redisponibiliza$
BEGIN
	IF NEW.data_devolucao IS NOT NULL THEN
	UPDATE livro SET disponivel = true WHERE livro.id_livro = NEW.id_livro;
	END IF;
	RETURN NEW;
END;
$redisponibiliza$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER redisponibiliza AFTER INSERT OR UPDATE ON Emprestimo FOR EACH ROW EXECUTE FUNCTION redisponibiliza();


UPDATE Emprestimo SET data_devolucao = '2024-03-27' WHERE id_emprestimo = 4;
SELECT * FROM livro ORDER BY id_livro;
SELECT * FROM Emprestimo ORDER BY id_emprestimo;

--c)------------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Auditoria(
id_auditoria serial PRIMARY KEY,
usuario VarChar(50),
id_emprestimo integer,
data_emprestimo timestamp,
acao VarChar(50)	
);

CREATE OR REPLACE FUNCTION criaAuditoria() RETURNS trigger AS $criaAuditoria$
DECLARE
acao VarChar(50);
BEGIN

IF NEW.data_devolucao IS NULL THEN
acao := 'Emprestimo Realizado';
ELSE
acao := 'Devolucao Realizada';
END IF;

	INSERT INTO auditoria(usuario, id_emprestimo, data_emprestimo, acao)
	VALUES((SELECT nome FROM Membro WHERE membro.id_membro = NEW.id_membro), NEW.id_emprestimo, CURRENT_DATE, acao);

RETURN NEW;
END;
$criaAuditoria$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER criaAuditoria AFTER INSERT OR UPDATE ON Emprestimo
FOR EACH ROW EXECUTE FUNCTION criaAuditoria();

INSERT INTO Emprestimo(id_livro, id_membro, data_emprestimo, data_devolucao)
VALUES(5, 5, '2010-10-01', NULL);
UPDATE Emprestimo SET data_devolucao = '2024-03-27' WHERE id_emprestimo = 4;

SELECT * FROM auditoria;

--d)-----------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION checaDisponibilidade() RETURNS trigger AS $checaDisponibilidade$
BEGIN
IF (SELECT disponivel FROM Livro WHERE id_livro = NEW.id_livro) THEN
ELSE
 RAISE EXCEPTION 'Livro Indisponivel';
END IF;
RETURN NEW;
END;
$checaDisponibilidade$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER checaDisponibilidade BEFORE INSERT ON emprestimo
FOR EACH ROW EXECUTE FUNCTION checaDisponibilidade();

SELECT * FROM livro;

INSERT INTO Emprestimo(id_livro, id_membro, data_emprestimo, data_devolucao)
VALUES(4, 5, '2010-10-01', NULL);


--e)-----------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION verificaLimite() RETURNS trigger AS $verificaLimite$
BEGIN
IF (SELECT (SELECT COUNT(id_emprestimo) FROM emprestimo WHERE id_membro = NEW.id_membro) FROM membro WHERE id_membro = NEW.id_membro) >= 5 THEN
RAISE EXCEPTION 'Limite de emprestimos já atingido.';
END IF;
RETURN NEW;
END;
$verificaLimite$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER verificaLimite BEFORE INSERT ON Emprestimo
FOR EACH ROW EXECUTE FUNCTION verificaLimite();

SELECT Membro.id_membro, Membro.nome, COUNT(Emprestimo.id_emprestimo) FROM Membro 
LEFT JOIN Emprestimo ON Membro.id_membro = Emprestimo.id_membro
GROUP BY Membro.id_membro ORDER BY Membro.id_membro;



INSERT INTO Emprestimo(id_livro, id_membro, data_emprestimo, data_devolucao)
VALUES(9, 6, '2024-05-21', NULL),
(10, 6, '2010-10-01', NULL),
(11, 6, '2010-10-01', NULL),
(1, 1, '2010-10-01', NULL);


--f)----------------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS HistoricoLivros(
id_historico serial PRIMARY KEY,
id_livro integer, 
titulo_antigo varchar(100),
autor_antigo varchar(100),
ano_publicacao_antigo integer,
dataAlteração timestamp
);

CREATE OR REPLACE FUNCTION salvaHistorico() RETURNS trigger AS $salvaHistorico$
BEGIN
IF OLD.disponivel = NEW.disponivel THEN
	INSERT INTO HistoricoLivros(id_livro, titulo_antigo, autor_antigo, ano_publicacao_antigo, dataAlteração)
	VALUES(OLD.id_livro, OLD.titulo, OLD.autor, OLD.ano_publicacao, CURRENT_DATE);
END IF;
RETURN NEW;
END;
$salvaHistorico$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER salvaHistorico BEFORE UPDATE ON Livro
FOR EACH ROW EXECUTE FUNCTION salvaHistorico();

INSERT INTO Emprestimo(id_livro, id_membro, data_emprestimo, data_devolucao)
VALUES(10, 7, '2024-03-29', NULL);
UPDATE Emprestimo SET data_devolucao = CURRENT_DATE WHERE id_livro = 10;
UPDATE Livro SET ano_publicacao = 1638 WHERE titulo = 'Discurso do Método';
UPDATE Livro SET ano_publicacao = 1637 WHERE titulo = 'Discurso do Método';
SELECT * FROM Emprestimo;
SELECT * FROM Livro;
SELECT * FROM HistoricoLivros;


--g)-----------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION verificaEmprestimos() RETURNS trigger AS $verificaEmprestimos$
BEGIN
IF (SELECT COUNT(id_membro) FROM emprestimo WHERE OLD.id_membro = id_membro) > 0 THEN
RAISE EXCEPTION 'Não é possível excluir o membro %, pois possui empréstimos pendentes.', OLD.nome;
END IF;
RETURN OLD;
END;
$verificaEmprestimos$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER verificaEmprestimos BEFORE DELETE ON Membro
FOR EACH ROW EXECUTE FUNCTION verificaEmprestimos();

DELETE FROM Membro WHERE id_membro = 1;



SELECT Membro.id_membro, Membro.nome, COUNT(Emprestimo.id_emprestimo) FROM Membro 
LEFT JOIN Emprestimo ON Membro.id_membro = Emprestimo.id_membro
GROUP BY Membro.id_membro ORDER BY Membro.id_membro;


--h)-----------------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS AuditoriaLivros(
id_audit_livro serial PRIMARY KEY,
operacao VarChar(1),
titulo VarChar(100),
autor VarChar(100),
dataOperacao timestamp
);


CREATE OR REPLACE FUNCTION InsereAuditoriaLivros() RETURNS trigger AS $InsereAuditoriaLivros$
BEGIN
IF TG_OP = 'UPDATE' THEN
	IF OLD.disponivel = NEW.disponivel THEN
	INSERT INTO auditoriaLivros(operacao, titulo, autor, dataOperacao)
	VALUES(SUBStrING(TG_OP, 1, 1), NEW.titulo, NEW.autor, CURRENT_DATE);
	END IF;
ELSIF TG_OP = 'DELETE' THEN
	INSERT INTO auditoriaLivros(operacao, titulo, autor, dataOperacao)
	VALUES(SUBStrING(TG_OP, 1, 1), OLD.titulo, OLD.autor, CURRENT_DATE);
	RETURN OLD;
ELSE
	INSERT INTO auditoriaLivros(operacao, titulo, autor, dataOperacao)
	VALUES(SUBStrING(TG_OP, 1, 1), NEW.titulo, NEW.autor, CURRENT_DATE);

END IF;
RETURN NEW;
END;
$InsereAuditoriaLivros$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER InsereAuditoriaLivros AFTER INSERT OR UPDATE OR DELETE ON livro
FOR EACH ROW EXECUTE FUNCTION InsereAuditoriaLivros();


INSERT INTO Livro(titulo, autor, ano_publicacao)
VALUES('Minidicionário', 'Ruth Rocha', 2005);

SELECT * FROM auditoriaLivros;

--i)-------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION verificaEmprestimosLivro() RETURNS trigger AS $verificaEmprestimosLivro$
BEGIN
IF (SELECT COUNT(id_Livro) FROM emprestimo WHERE OLD.id_Livro = id_Livro) > 0 THEN
RAISE EXCEPTION 'Não é possível excluir o livro %, pois está emprestado.', OLD.titulo;
END IF;
END;
$verificaEmprestimosLivro$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER verificaEmprestimosLivro BEFORE DELETE ON Livro
FOR EACH ROW EXECUTE FUNCTION verificaEmprestimosLivro();

DELETE FROM Livro WHERE titulo = 'Dom Quixote';
DELETE FROM Livro WHERE titulo = 'Minidicionário';


SELECT * FROM Livro ORDER BY id_livro;
