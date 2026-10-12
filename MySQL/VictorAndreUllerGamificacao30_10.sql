DROP SCHEMA IF EXISTS Mundo;
CREATE SCHEMA IF NOT EXISTS Mundo;

USE Mundo;

CREATE TABLE continente (
idContinente INT Primary Key AUTO_INCREMENT, 
nome_continente VARCHAR(50)
);

CREATE TABLE pais (
idPais INT Primary Key AUTO_INCREMENT,
id_continente INT NOT NULL,
nome_pais VARCHAR(50),
populacaoPais DECIMAL(6,3), 
pib DECIMAL(6,3),
FOREIGN KEY (id_continente) REFERENCES continente(idContinente)
);

CREATE TABLE estado (
idEstado INT Primary Key AUTO_INCREMENT,
nome_estado VARCHAR(50),
id_pais INT NOT NULL,
FOREIGN KEY (id_pais) REFERENCES pais(idPais)
);


CREATE TABLE cidade (
idCidade INT Primary Key AUTO_INCREMENT,
id_estado INT NOT NULL,
FOREIGN KEY (id_estado) REFERENCES estado(idEstado),
nome_cidade VARCHAR (50),
populacaoCidade DECIMAL(6,3),
capital_nacional TINYINT(1)
);


 -- QUESTAO 2
INSERT INTO continente(nome_continente)
VALUES("America do Norte");
INSERT INTO continente(nome_continente)
VALUES("America do Sul");


INSERT INTO pais(id_continente, nome_pais, populacaoPais, pib)
VALUES(1, "Canadá", 38.250, 1.991);
INSERT INTO pais(id_continente, nome_pais, populacaoPais, pib)
VALUES(1, "Estados Unidos da América", 331.900, 23.885);
INSERT INTO pais(id_continente, nome_pais, populacaoPais, pib)
VALUES (2, "Brasil", 214.010, 1.609);
INSERT INTO pais(id_continente, nome_pais, populacaoPais, pib)
VALUES (2, "Argentina", 45.810, 0.491);


INSERT INTO estado(id_pais, nome_estado)
VALUES (1, "Ontário");
INSERT INTO estado(id_pais, nome_estado)
VALUES (1, "Colúmbia Britânica");
INSERT INTO estado(id_pais, nome_estado)
VALUES (2, "Distrito de Colúmbia");
INSERT INTO estado(id_pais, nome_estado)
VALUES (2, "Califórnia");
INSERT INTO estado(id_pais, nome_estado)
VALUES (3, "Distrito Federal");
INSERT INTO estado(id_pais, nome_estado)
VALUES (3, "São Paulo");
INSERT INTO estado(id_pais, nome_estado)
VALUES (4, "Buenos Aires");
INSERT INTO estado(id_pais, nome_estado)
VALUES (4, "Río Negro");


INSERT INTO cidade(id_estado, nome_cidade, populacaoCidade, capital_nacional)
VALUES(1, "Ottawa", 0.994, 1);
INSERT INTO cidade(id_estado, nome_cidade, populacaoCidade, capital_nacional)
VALUES (2, "Vancouver", 0.675, 0);
INSERT INTO cidade(id_estado, nome_cidade, populacaoCidade, capital_nacional)
VALUES (3, "Washington, D.C.", 0.712, 1);
INSERT INTO cidade(id_estado, nome_cidade, populacaoCidade, capital_nacional)
VALUES (4, "Los Angeles", 3.849, 0);
INSERT INTO cidade(id_estado, nome_cidade, populacaoCidade, capital_nacional)
VALUES (5, "Brasília", 3.094, 1);
INSERT INTO cidade(id_estado, nome_cidade, populacaoCidade, capital_nacional)
VALUES (6, "São Paulo", 12.330, 0);
INSERT INTO cidade(id_estado, nome_cidade, populacaoCidade, capital_nacional)
VALUES (7, "Buenos Aires", 16.529, 1);
INSERT INTO cidade(id_estado, nome_cidade, populacaoCidade, capital_nacional)
VALUES (8, "Bariloche", 0.110, 0);



 -- QUESTAO 3
SELECT nome_estado, nome_pais FROM estado
LEFT JOIN pais ON(id_pais = idPais);

Select nome_pais, nome_cidade FROM pais
LEFT JOIN estado ON(idPais = id_pais)
LEFT JOIN cidade ON(idEstado = id_estado)
WHERE capital_nacional = 1;



SELECT nome_pais, populacaoPais FROM pais
WHERE pib > 1;


SELECT AVG(populacaoCidade) FROM cidade
WHERE capital_nacional = 0;


Select nome_continente, AVG(pib) FROM continente
LEFT JOIN pais ON(idContinente = id_continente) GROUP BY nome_continente;


SELECT nome_pais FROM pais
WHERE pib > ( SELECT pib FROM pais WHERE nome_pais = "Canadá")
