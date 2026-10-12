-- PARA ESTA ATIVIDADE, EFETUE AS SEGUINTES ETAPAS:
--	1. EFETUE A CRIAÇÃO DAS TABELAS, LINHAS 5 A 62
-- 	2. EFETUE A INSERÇÃO DOS REGISTROS, LINAS 66 A 114
-- 	3. EFETUE A CRIAÇÃO DE FUNÇÕES PARA CADA UM DOS EXERCICIOS A PARTIR DA LINHA 120

/* clinica veterinaria lógico */
CREATE SCHEMA IF NOT EXISTS clinica_vet;

-- DROP SCHEMA clinica_vet;
-- DROP TABLE Endereco;

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
			
-- 	3. EFETUE A CRIAÇÃO DE FUNÇÕES PARA CADA UM DOS EXERCICIOS A PARTIR DA LINHA 120

-- EXERCÍCIOS:

-- 1. Calcular Idade do Pet: Escreva uma função que calcule a idade atual de um pet com base em sua data de nascimento.-------------------------------

CREATE OR REPLACE FUNCTION calcularIdade(x integer) RETURNS integer AS $$
SELECT EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_nasc)) FROM pet WHERE pet.cod = x;
$$
LANGUAGE SQL;

SELECT * FROM calcularIdade(1);
SELECT * FROM calcularIdade(2);
SELECT * FROM calcularIdade(3);


-- 2. Contar Pets por Raça: Crie uma função que retorne a quantidade de pets de uma determinada raça.-------------------------------------------------

CREATE OR REPLACE FUNCTION contarPetPorRaca(x varchar(50)) RETURNS integer AS $$
	SELECT COUNT(cod) FROM pet WHERE pet.raca = x;
$$
LANGUAGE SQL;

SELECT * FROM contarPetPorRaca('pincher');
SELECT * FROM contarPetPorRaca('shitzu');
SELECT * FROM contarPetPorRaca('indefinido');

-- 3. Listar Pets por Responsável: Desenvolva uma função que liste todos os pets associados a um responsável específico.------------------------------

CREATE OR REPLACE FUNCTION listarPetsPorResponsavel(x integer) RETURNS SETOF varchar(100) AS $$
	SELECT pet.nome FROM pet WHERE pet.cod_resp = x;
$$
LANGUAGE SQL;

SELECT * FROM listarPetsPorResponsavel(1);
SELECT * FROM listarPetsPorResponsavel(2);
SELECT * FROM listarPetsPorResponsavel(3);


-- 4. Validar CPF: Implemente uma função que valide o CPF dos responsáveis.---------------------------------------------------------------------------

-- DROP FUNCTION validaCPF(integer);
CREATE OR REPLACE FUNCTION validaCPF(x integer) RETURNS boolean AS $$
	SELECT (SELECT CHAR_LENGTH(responsavel.cpf) FROM responsavel WHERE responsavel.cod = x) = 11 
	AND	NOT((SELECT responsavel.cpf FROM responsavel WHERE responsavel.cod = x) NOT LIKE '%[0-9]%');
$$
LANGUAGE SQL;

SELECT * FROM validaCPF(1);
SELECT * FROM validaCPF(2);
SELECT * FROM validaCPF(3);
SELECT * FROM validaCPF(6);




-- 5. Formatar Telefone: Escreva uma função para formatar o número de telefone dos responsáveis e veterinários.

-- 6. Encontrar Endereço do Responsável: Crie uma função que retorne o endereço completo de um responsável.

CREATE OR REPLACE FUNCTION acharEndereco(x integer) RETURNS TABLE(logradouro varchar(100), numero integer , cidade varchar(50), uf varchar(2)) 
AS $$

SELECT endereco.logradouro, endereco.numero, endereco.cidade, endereco.uf FROM endereco 
RIGHT JOIN responsavel ON responsavel.cod_end = endereco.cod
WHERE responsavel.cod = x;

$$
LANGUAGE SQL;

SELECT * FROM acharEndereco(1);
SELECT * FROM acharEndereco(2);
SELECT * FROM acharEndereco(3);


-- 7. Obter Média de Peso por Raça: Implemente uma função que calcule a média de peso dos pets por raça.

CREATE OR REPLACE FUNCTION mediaDePesoRaca(x varChar) RETURNS integer AS $$

SELECT AVG(peso) FROM pet WHERE raca = x;

$$
LANGUAGE SQL;

Select * FROM mediaDePesoRaca('pincher');


-- 8. Listar Veterinários por Especialidade: Desenvolva uma função que liste veterinários por uma especialidade específica.

CREATE OR REPLACE FUNCTION listarEspecialistas(x varchar(50)) RETURNS SETOF varchar(50) AS $$

SELECT nome FROM veterinario WHERE especialidade = x;

$$
LANGUAGE SQL;
SELECT * FROM listarEspecialistas('clinico geral');



-- 9. Contar Consultas por Veterinário: Escreva uma função que conte o número de consultas realizadas por um veterinário específico.

CREATE OR REPLACE FUNCTION contarConsultasVet(x integer) RETURNS integer AS $$

SELECT COUNT(consulta.cod) FROM consulta WHERE cod_vet = x;

$$
LANGUAGE SQL;
SELECT * FROM contarConsultasVet(1);




-- 10. Verificar Disponibilidade de Veterinário: Crie uma função que verifique a disponibilidade de um veterinário em uma data e horário específicos.

CREATE OR REPLACE FUNCTION checarDisponibilidade(vetx integer, horariox time, datax date) RETURNS boolean AS $$

SELECT vetx IN(SELECT cod FROM veterinario)
AND horariox > '07:00'
AND horariox < '18:00'
AND horariox NOT IN(SELECT consulta.horario FROM veterinario 
				   LEFT JOIN consulta ON consulta.cod_vet = veterinario.cod
				   WHERE veterinario.cod = vetx AND dt = datax);

$$
LANGUAGE SQL;

SELECT * FROM checarDisponibilidade(1,'14:30','2023-10-05')
-- UMA CONSULTA DURA UM MINUTO.

-- 11. Obter Histórico de Consultas do Pet: Implemente uma função que retorne todas as consultas de um pet específico.

CREATE OR REPLACE FUNCTION historicoPet(x integer) RETURNS TABLE(dt date, vet varchar(50)) AS $$

SELECT consulta.dt, veterinario.especialidade FROM pet
LEFT JOIN consulta ON consulta.cod_pet = pet.cod
LEFT JOIN veterinario ON consulta.cod_vet = veterinario.cod
WHERE pet.cod = x;

$$
LANGUAGE SQL;

SELECT * FROM historicoPet(1);
SELECT * FROM historicoPet(2);
SELECT * FROM historicoPet(5);


-- 12. Calcular Total de Consultas em um Período: Desenvolva uma função que calcule o total de consultas realizadas em um intervalo de datas.

CREATE OR REPLACE FUNCTION verConsultasPeriodo(iniciox date, fimx date) RETURNS TABLE(dia date, horas time, profissional varchar) AS $$

SELECT consulta.dt, consulta.horario, veterinario.nome FROM consulta
LEFT JOIN veterinario ON consulta.cod_vet = veterinario.cod
WHERE consulta.dt > iniciox AND consulta.dt < fimx;

$$
LANGUAGE SQL;

SELECT * FROM verConsultasPeriodo('2020-01-01', '2020-12-31');


-- 13. Verificar Email Único: Escreva uma função que verifique se um email já está cadastrado no sistema.

CREATE OR REPLACE FUNCTION checaEmail(x varchar) RETURNS boolean AS $$

SELECT x IN(SELECT email FROM responsavel) OR x IN(SELECT email FROM veterinario);

$$
LANGUAGE SQL;

SELECT * FROM checaEmail('victor@email.com.br');
SELECT * FROM checaEmail('renanbrunooliveira@edu.uniso.br');
SELECT * FROM checaEmail('marcia.luna.duarte@deere.com');

-- 14. Listar Pets Sem Consulta: Crie uma função que liste todos os pets que nunca tiveram uma consulta.

-- 15. Atualizar Peso do Pet: Implemente uma função para atualizar o peso de um pet.

-- 16. Encontrar Veterinário com Mais Consultas: Desenvolva uma função que encontre o veterinário com o maior número de consultas.

-- 17. Excluir Pets Sem Responsável: Escreva uma função que exclua todos os pets que não têm um responsável associado.

-- 18. Gerar Relatório de Consultas por Cidade: Crie uma função que gere um relatório de consultas realizadas em uma determinada cidade.

-- 19. Calcular Taxa de Crescimento do Pet: Implemente uma função que calcule a taxa de crescimento do peso do pet entre duas consultas.

-- 20. Listar Endereços de Veterinários por Cidade: Desenvolva uma função que liste os endereços de todos os veterinários em uma cidade específica.