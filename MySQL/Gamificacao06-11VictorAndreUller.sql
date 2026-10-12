SET SQL_SAFE_UPDATES = 0;
-- a)Criar uma View para mostrar todas as consultas agendadas, a partir da data atual 
-- ordenados por data. Apresentando os seguintes dados: da tabela responsavel nome e 
-- telefone; da tabela pet nome, raça e peso; da tabela veterinario nome, crm, 
-- especialidade e fone

CREATE OR REPLACE VIEW consultasAgendadas AS 
SELECT dt, Responsavel.nome NomeResponsavel, Responsavel.fone, Pet.nome NomePet, Pet.raca, Pet.peso, Veterinario.nome NomeVet, Veterinario.crmv
FROM Consulta, Responsavel, Pet, Veterinario
WHERE Pet.cod_resp = Responsavel.cod AND Consulta.cod_pet = Pet.cod AND Consulta.cod_vet = Veterinario.cod AND dt > CURDATE()
ORDER BY dt;

SELECT * FROM consultasAgendadas;


-- b) Criar uma View para mostrar os responsáveis e seus respectivos endereços. 
-- Apresentando os campos: todos os dados de ambas as tabelas.

CREATE OR REPLACE VIEW enderecoClientes AS
SELECT Responsavel.nome NomeResponsavel, uf, cidade, logradouro, numero, complemento, cep
FROM Responsavel, Endereco
WHERE Responsavel.cod_end IN(Endereco.cod)
ORDER BY Responsavel.nome ASC;

SELECT * FROM enderecoClientes;




-- c) Criar uma View para mostrar o histórico de consultas (consulta data inferior a data 
-- atual), ordenado por data apresentado os campos: da tabela pet o nome, raca e peso; da 
-- tabela responsabel o nome e telefone; da tabela vetrerinario o nome, crmv e o telefone;

CREATE OR REPLACE VIEW historicoConsultas AS
SELECT dt, Pet.nome NomePet, Pet.raca, Pet.peso, Responsavel.nome NomeResponsavel, Responsavel.fone foneResponsavel, Veterinario.nome NomeVeterinario, Veterinario.crmv, Veterinario.fone FoneVet
FROM Consulta, Responsavel, Pet, Veterinario
WHERE Pet.cod_resp = Responsavel.cod AND Consulta.cod_pet = Pet.cod AND Consulta.cod_vet = Veterinario.cod AND dt < CURDATE()
ORDER BY dt;

SELECT * FROM historicoConsultas;




-- d) Criar coluna idade na tabela pet, calculando-a a partir da data de nascimento.
ALTER TABLE Pet ADD idade INT(3);

UPDATE Pet SET idade =
YEAR(CURDATE())-YEAR(Pet.data_nasc);

SELECT idade FROM Pet;



-- e) Pesquisar e apresentar como pesquisar pelo nome do responsável, ignorando case 
-- sensitive, acentos e ‘ç’.

SELECT nome FROM Responsavel WHERE nome NOT LIKE '%m%';



-- f) Modificar o peso dos pets cuja raça igual a pincher para 5. 

UPDATE Pet SET peso = 5
WHERE raca LIKE 'pincher';
SELECT * from Pet;


-- g) Selecionar os veterinarios e responsávies cujo complemento do endereço seja igual a 
-- null.




-- h) Criar uma nova tabela apresentando os responsaves (nome, telefone, email) e 
-- veterinários(nome, telefone, email) e seus respectivos endereços (rua, numero e -
-- complemento).Criar uma coluna tipo para identificar se é um responsavel ou 
-- veterinario.
-- i) Deletar as consultas com a data inferior a 10-10-2023.
-- j) Criar 3 novos responsáveis, com seus respectivos endereços, e adicione 2 pets sob sua 
-- responsabilidade.
-- k) Criar 2 novos veterinários, com seus respectivos endereços.
-- l) Agendar consultas para os novos pets com os novos veterinários.
-- m) Executar a view criada no item A, para verificar se as consultas adicionadas no item 
-- “l” foram adicionadas corretamente
