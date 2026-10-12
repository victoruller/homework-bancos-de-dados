
	
-- Database: Aula3Exemplos

	
	-- PARA ESTA ATIVIDADE, EFETUE AS SEGUINTES ETAPAS:
--XXX1. EFETUE A CRIAÇÃO DAS TABELAS, LINHAS 5 A 62
--XXX2. EFETUE A INSERÇÃO DOS REGISTROS, LINAS 66 A 114
-- 	3. EFETUE A CRIAÇÃO DE FUNÇÕES PARA CADA UM DOS EXERCICIOS A PARTIR DA LINHA 120

/* clinica veterinaria lógico */

CREATE TABLE Endereco (
    cod integer PRIMARY KEY,
    logradouro varchar(100),
    numero integer,
    complemento varchar(50),
    cep varchar(12),
    cidade varchar(50),
    uf varchar(2)
);

CREATE TABLE Responsavel (
    cod integer PRIMARY KEY,
    nome varchar(100) NOT NULL,
    cpf varchar(12) NOT NULL,
    fone varchar(50) NOT NULL,
    email varchar(100) NOT NULL,
    cod_end integer,
    UNIQUE (cpf, email),
    FOREIGN KEY (cod_end) REFERENCES Endereco (cod) 
);

CREATE TABLE Pet (
    cod integer PRIMARY KEY,
    nome varchar(100),
    raca varchar(50),
    peso decimal(5,2),
    data_nasc date,
    cod_resp integer,
    FOREIGN KEY (cod_resp) REFERENCES Responsavel (cod) 
);

CREATE TABLE Veterinario (
    cod integer PRIMARY KEY,
    nome varchar(100),
    crmv numeric(10),
    especialidade varchar(50),
    fone varchar(50),
    email varchar(100),
    cod_end integer,
	FOREIGN KEY (cod_end) REFERENCES Endereco (cod) 
);

CREATE TABLE Consulta (
    cod integer PRIMARY KEY,
    dt date,
    horario time,
    cod_vet integer,
    cod_pet integer,
    FOREIGN KEY (cod_vet) REFERENCES Veterinario (cod), 
    FOREIGN KEY (cod_pet) REFERENCES Pet (cod) 
	ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- inserindo enderecos
INSERT INTO endereco(cod,logradouro,numero,complemento,cep,cidade,uf) 
	VALUES 	(1, 'Rua Tenente-Coronel Cardoso', '501', 'ap 1001','28035042','Campos dos Goytacazes','RJ'),
			(2, 'Rua Serra de Bragança', '980', null,'03318000','São Paulo','SP'),
			(3, 'Rua Barão de Vitória', '50', 'loja A','09961660','Diadema','SP'),
			(4, 'Rua Pereira Estéfano', '700', 'ap 202 a','04144070','São Paulo','SP'),
			(5, 'Avenida Afonso Pena', '60', null,'30130005','São Paulo','SP'),
			(6, 'Rua das Fiandeiras', '123', 'Sala 501','04545005','São Paulo','SP'),
			(7, 'Rua Cristiano Olsen', '2549', 'ap 506','16015244','Araçatuba','SP'),
			(8, 'Avenida Desembargador Moreira', '908', 'Ap 405','60170001','Fortaleza','CE'),
			(9, 'Avenida Almirante Maximiano Fonseca', '362', null,'88113350','Rio Grande','RS'),
			(10, 'Rua Arlindo Nogueira', '219', 'ap 104','64000290','Teresina','PI');

-- inserindo responsaveis
INSERT INTO responsavel(cod,nome,cpf,email,fone,cod_end) 
	VALUES 	(1, 'Márcia Luna Duarte', '1111111111', 'marcia.luna.duarte@deere.com','(63) 2980-8765',1),
			(2, 'Benício Meyer Azevedo','23101771056', 'beniciomeyer@gmail.com.br','(63) 99931-8289',2),
			(3, 'Ana Beatriz Albergaria Bochimpani Trindade','61426227400','anabeatriz@ohms.com.br', '(87) 2743-5198',3),
			(4, 'Thiago Edson das Neves','31716341124','thiago_edson_dasneves@paulistadovale.org.br','(85) 3635-5560',4),
			(5, 'Luna Cecília Alves','79107398','luna_alves@orthoi.com.br','(67) 2738-7166',5);

-- inserindo veterinarios
INSERT INTO veterinario(cod,nome,crmv,especialidade,email,fone,cod_end) 
	VALUES 	(1, 'Renan Bruno Diego Oliveira','35062','clinico geral','renanbrunooliveira@edu.uniso.br','(67) 99203-9967',6),
			(2, 'Clara Bárbara da Cruz','64121','dermatologista','clarabarbaradacruz@band.com.br','(63) 3973-7873',7),
			(3, 'Heloise Cristiane Emilly Moreira','80079','clinico geral','heloisemoreira@igoralcantara.com.br','(69) 2799-7715',8),
			(4, 'Laís Elaine Catarina Costa','62025','animais selvagens','lais-costa84@campanati.com.br','(79) 98607-4656',9),
			(5, 'Juliana Andrea Cardoso','00491','dermatologista','juliana_cardoso@br.ibn.com','(87) 98439-9604',10);

-- inserindo animais
INSERT INTO pet(cod,cod_resp,nome,peso,raca,data_nasc) 
	VALUES 	(1, 1, 'Mike', 12, 'pincher', '2010-12-20'),
			(2, 1, 'Nike', 20, 'pincher', '2010-12-20'),
			(3, 2, 'Bombom', 10, 'shitzu', '2022-07-15'),
 			(4, 3, 'Niro', 70, 'pastor alemao', '2018-10-12'),
			(5, 4, 'Milorde', 5, 'doberman', '2019-11-16'),
 			(6, 4, 'Laide', 4, 'coker spaniel','2018-02-27'),
 			(7, 4, 'Lorde', 3, 'dogue alemão', '2019-05-15'),
			(8, 5, 'Joe', 50, 'indefinido', '2020-01-01'),
			(9, 5, 'Felicia', 5, 'indefinido', '2017-06-07');

-- inserindo consultas
INSERT INTO consulta(cod,cod_pet, cod_vet, horario, dt) 
	VALUES 	(1,2,1,'14:30','2023-10-05'),
			(2,4,1,'15:00','2023-10-05'),
			(3,5,5,'16:30','2023-10-15'),
			(4,3,4,'14:30','2023-10-12'),
			(5,2,3,'18:00','2023-10-17'),
			(6,5,3,'14:10','2023-10-20'),
			(7,5,3,'10:30','2023-10-28');
			
			
-- EXERCÍCIOS: 
-- CREATE OR REPLACE FUNCTION  RETURNS  AS $$ DECLARE BEGIN RETURN END $$ LANGUAGE PLPGSQL;
-- 1 Crie uma função que insira um novo registro na tabela Endereco e retorne o código do endereço inserido.

CREATE OR REPLACE FUNCTION criaEndereco(logradourox varchar(100),
										numerox integer,
										complementox varchar(50),
										cepx varchar(12),
										cidadex varchar(50),
										ufx varchar(2)) RETURNS integer AS $$
	BEGIN
		INSERT INTO endereco(cod, logradouro,numero,complemento,cep,cidade,uf)
		VALUES((1+(SELECT MAX(cod) FROM endereco)),logradourox,numerox,complementox,cepx,cidadex,ufx);
	RETURN (SELECT cod FROM endereco WHERE cep = cepx AND numero = numerox);
	END
$$ LANGUAGE PLPGSQL;

SELECT criaEndereco('Rua Sereta', '500', 'abc','24224444','Cidade Secretos','RS');




-- 2 Crie um procedimento que atualize o email de um responsável com base no seu código.

CREATE OR REPLACE PROCEDURE atualizaEmail(integer, varchar(100)) AS $$ 
	BEGIN 
	UPDATE responsavel SET email = $2 WHERE cod = $1;
	END 
$$ LANGUAGE PLPGSQL;

CALL atualizaEmail(1, 'email@email.com.br');
CALL atualizaEmail(2, 'numero5@email.com.br');
CALL atualizaEmail(3, 'numero3@email.com.br');
CALL atualizaEmail(2, 'numero2l@email.com.br');
CALL atualizaEmail(4, 'numero4@email.com.br');

SELECT cod, nome, email FROM responsavel ORDER BY cod;


-- 3 Escreva uma função que retorne todos os pets de uma determinada raça.

CREATE OR REPLACE FUNCTION getPetsPorRaca(varchar(50)) RETURNS SETOF pet AS $$ 
	BEGIN
		RETURN QUERY (SELECT * FROM pet WHERE raca = $1);
	END 
$$ LANGUAGE PLPGSQL;

SELECT * FROM getPetsPorRaca('pincher');


-- 4 Faça uma função para excluir um responsável. Excluir seus pets e endereços.

CREATE OR REPLACE PROCEDURE excluiResponsavel(integer) AS $$

DECLARE
	endere integer;
BEGIN
	endere = (SELECT cod_end FROM responsavel WHERE cod = $1);
	
	DELETE FROM pet WHERE cod_resp = $1;
	DELETE FROM responsavel WHERE cod = $1;
	DELETE FROM endereco WHERE cod = endere;
END 
$$ LANGUAGE PLPGSQL;

CALL excluiResponsavel(1);
			  
SELECT * FROM responsavel ORDER BY cod;
SELECT * FROM pet ORDER BY cod;
SELECT * FROM endereco ORDER BY cod;



-- 5 Faça uma função que liste todas as consultas agendadas para uma data específica.

CREATE OR REPLACE FUNCTION getConsultasPorData(DATE) RETURNS SETOF consulta AS $$ 
BEGIN
	RETURN QUeRY (SELECT * FROM consulta WHERE dt = $1);
END 
$$ LANGUAGE PLPGSQL;

SELECT * FROM consulta;
SELECT * FROM getConsultasPorData('2023-10-20');

-- 6 Crie uma função que receba os dados do veterinario por parâmetro, armazene na tabela “veterinario” e retorne todos os dados da tabela.

CREATE OR REPLACE FUNCTION criaVeterinario(varchar(100),
											numeric(10),
											varchar(50),
											varchar(50),
											varchar(100),
											integer) RETURNS SETOF veterinario AS $$ 
BEGIN 
	INSERT INTO veterinario(cod,nome,crmv,especialidade,email,fone,cod_end) 
	VALUES((1+(SELECT MAX(cod) FROM veterinario)), $1, $2, $3, $4, $5, $6);
RETURN QUERY (SELECT * FROM veterinario);
END 
$$ LANGUAGE PLPGSQL;

SELECT * FROM criaVeterinario('Gregório Magno','12345','clinico total','Grego@edu.univali.br','(67) 99888-888',4)

-- 7 Crie uma função para adicionar um novo pet, associando-o a um responsável existente.
DROP FUNCTION criaPet(integer, varchar(100),varchar(50),decimal(5,2),date,integer);
CREATE OR REPLACE FUNCTION criaPet(integer, varchar(100),
									varchar(50),
									decimal(5,2),
									date) RETURNS SETOF pet AS $$ 

BEGIN
	INSERT INTO pet(cod,cod_resp,nome,peso,raca,data_nasc)
	VALUES((1+(SELECT MAX(cod) FROM pet)), $1, $2, $4, $3, $5);
	
RETURN QUERY (SELECT * FROM pet);
END
$$ LANGUAGE PLPGSQL;

SELECT * FROM criaPet(2, 'Mag', 'gato', 2.0, '2022-05-05');


-- 8 Escreva uma função que conte quantos pets um determinado responsável possui.

CREATE OR REPLACE FUNCTION contaPetsDoResponsavel(integer) RETURNS integer AS $$ 
BEGIN
RETURN (SELECT COUNT(cod) FROM pet WHERE cod_resp = $1);
END 
$$ LANGUAGE PLPGSQL;

SELECT * FROM pet;
SELECT * FROM contaPetsDoResponsavel(5);

-- 9 Desenvolva uma função que retorne todos os veterinários com uma determinada especialidade.

CREATE OR REPLACE FUNCTION getVeterinariosPorEspecialidade(VarChar(50)) RETURNS SETOF veterinario AS $$  
BEGIN 
RETURN QUERY (SELECT * FROM veterinario WHERE especialidade = $1);
END 
$$ LANGUAGE PLPGSQL;

SELECT * FROM getVeterinariosPorEspecialidade((SELECT especialidade FROM veterinario WHERE cod = 1));

-- 10 Crie um procedimento que atualize o endereço de um veterinário.

CREATE OR REPLACE PROCEDURE atualizaEnderecoVeterinario(integer, integer) AS $$ 
BEGIN 
	IF (SELECT COUNT(cod) FROM veterinario WHERE cod = $1) < 1 THEN
		RAISE EXCEPTION 'veterinario inexistente';
	END IF;

	IF(SELECT COUNT(cod) FROM endereco WHERE cod = $2) < 1 THEN
		RAISE EXCEPTION 'endereco inexistente';
	END IF;

	UPDATE veterinario SET cod_end = $2 WHERE cod = $1;
END 
$$ LANGUAGE PLPGSQL;

CALL atualizaEnderecoVeterinario(2, 2);
SELECT * FROM veterinario;

-- 11 Faça uma função que calcule a idade atual de um pet.

CREATE OR REPLACE FUNCTION idadeDoPet(integer) RETURNS integer AS $$ 
 
BEGIN 
	IF (SELECT COUNT(cod) FROM pet WHERE cod = $1) < 1 THEN
		RAISE EXCEPTION 'Pet Inexistente';
	END IF;
	RETURN (SELECT EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_nasc)) FROM pet WHERE pet.cod = $1);
END 
$$ LANGUAGE PLPGSQL;

SELECT * FROM pet;
SELECT * FROM idadeDoPet(3);

-- 12 Crie uma função que retorne todos os endereços em uma cidade específica.

CREATE OR REPLACE FUNCTION getEnderecosPorCidade(VarChar(50)) RETURNS SEtOF endereco AS $$ 
BEGIN 
	IF (SELECT COUNT(cod) FROM endereco WHERE cidade = $1) = 0 THEN
		RAISE EXCEPTION 'Nenhum endereco com essa cidade';
	END IF;
	RETURN QUERY(SELECT * FROM endereco WHERE cidade = $1);
END 
$$ LANGUAGE PLPGSQL;


SELECT getEnderecosPorCidade((SELECT cidade FROM endereco WHERE cod = 2));

-- 13 Desenvolva um procedimento que associe um pet existente a um novo responsável.

CREATE OR REPLACE PROCEDURE mudarDono(integer, integer) AS $$ 
BEGIN 
	IF (SELECT COUNT(cod) FROM pet WHERE cod = $1) = 0 OR (SELECT COUNT(cod) FROM responsavel WHERE cod = $2) = 0 THEN
		RAISE EXCEPTION 'O pet ou o responsavel não existe';
	END IF;

	UPDATE pet SET cod_resp = $2 WHERE cod = $1;
END 
$$ LANGUAGE PLPGSQL;

CALL mudarDono(3, 4);
SELECT * FROM pet;

-- 14 Elabore uma função que retorne todas as consultas agendadas de um determinado veterinário.

CREATE OR REPLACE FUNCTION getConsultasPorVeterinario(integer) RETURNS SETOF consulta AS $$ 

BEGIN 
	IF (SELECT COUNT(cod) FROM veterinario WHERE cod = $1) = 0 THEN
		RAISE EXCEPTION 'Veterinário Inexistente';
	END IF;

	RETURN QUERY (SELECT * FROM consulta WHERE cod_vet = $1); 
END 
$$ LANGUAGE PLPGSQL;

SELECT * FROM getConsultasPorVeterinario(3);


-- 15 Função para Buscar Responsável pelo Nome do Pet: Desenvolva uma função que retorne o nome do responsável pelo nome do pet.

CREATE OR REPLACE FUNCTION getResponsavelPorPetNome(VarChar(100)) RETURNS VarChar(100) AS $$ 

BEGIN 

IF (SELECT COUNT(cod) FROM pet WHERE nome = $1) = 0 THEN
	RAISE EXCEPTION 'O pet não existe';
END IF;

RETURN (SELECT responsavel.nome FROM responsavel 
		LEFT JOIN pet ON responsavel.cod = pet.cod_resp 
		WHERE pet.nome = $1);
END 
$$ LANGUAGE PLPGSQL;

SELECT * FROM getResponsavelPorPetNome((SELECT nome FROM pet WHERE cod = 4));


-- 16 Desenvolva uma função que recebe o CPF de um responsável e retorna seu nome se ele existir na base de dados; caso contrário, retorna uma mensagem "Responsável não encontrado".
CREATE OR REPLACE FUNCTION checarCPF(varchar(12)) RETURNS VarChar(50) AS $$  
BEGIN 
IF (SELECT COUNT(cod) FROM responsavel WHERE CPF = $1) = 0 THEN
	RAISE EXCEPTION 'Responsável não encontrado';
END IF;
RETURN (SELECT nome FROM responsavel WHERE cpf = $1);
END 
$$ LANGUAGE PLPGSQL;

SELECT checarCPF((SELECT cpf FROM responsavel WHERE cod = 2));

-- 17 Crie uma função que receba um código de veterinário e retorne o total de consultas realizadas por ele, utilizando um loop WHILE.
CREATE OR REPLACE FUNCTION numeroDeConsultasVet(integer) RETURNS integer AS $$ 
DECLARE
cont integer = 0;
maximo integer;
BEGIN
maximo = (SELECT MAX(cod) FROM consulta);
WHILE maximo > 0 LOOP
IF (SELECT cod_vet FROM consulta WHERE cod = maximo) = $1 THEN
cont := cont + 1;
END IF;
maximo:= maximo - 1;
END LOOP;
	
RETURN cont;
END 
$$ LANGUAGE PLPGSQL;

SELECT * FROM numeroDeConsultasVet(3);
SELECT * FROM consulta ORDER BY cod_vet;