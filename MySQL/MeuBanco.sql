SET SQL_SAFE_UPDATES = 0;
DROP SCHEMA IF EXISTS Guardas;
CREATE SCHEMA IF NOT EXISTS Guardas;
USE Guardas;

CREATE TABLE Pessoa(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
nascimento DATE,
forca INT(3),
defesa INT(3)
);

CREATE TABLE Especie(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(20),
familia VARCHAR(20)
);

CREATE TABLE Animal(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
especieId INT NOT NULL
);

CREATE TABLE DonoAnimal(
donoId INT NOT NULL,
animalId INT NOT NULL
);

INSERT INTO Pessoa(nome, nascimento, forca, defesa)
VALUES("Victor André Uller", "2004-08-24", 998, 998);
INSERT INTO Pessoa(nome, nascimento, forca, defesa)
VALUES("Gabrielly Rodrigues Coelho", "2007-02-08", 8, 9);

ALTER TABLE Pessoa ADD idade INT;

UPDATE Pessoa SET idade = (
(YEAR(CURDATE())-YEAR(nascimento))
);

INSERT INTO Especie(nome, familia)
VALUES("cachorro", "canina");
INSERT INTO Especie(nome, familia)
VALUES("gato", "felina");


INSERT INTO Animal(nome, especieId)
VALUES("Zoe", (SELECT id FROM Especie Where (nome = "cachorro")));
INSERT INTO DonoAnimal (donoId, animalId)
VALUES((SELECT id FROM Pessoa WHERE (nome = "Victor André Uller")), (SELECT id FROM Animal WHERE (nome = "Zoe")));

INSERT INTO Animal(nome, especieId)
VALUES("Mag", (SELECT id FROM Especie WHERE (nome = "gato")));
INSERT INTO DonoAnimal (donoId, animalId)
VALUES((SELECT id FROM Pessoa WHERE (nome = "Gabrielly Rodrigues Coelho")), (SELECT id FROM Animal WHERE (nome = "Mag")));


SELECT * FROM Pessoa;

SELECT Animal.nome, Especie.nome AS especie, Especie.familia FROM Animal
LEFT JOIN Especie ON(Animal.especieId = Especie.id);

SELECT Pessoa.nome, Animal.nome, Especie.nome AS especie FROM Pessoa
LEFT JOIN DonoAnimal ON(DonoAnimal.donoId = Pessoa.Id)
LEFT JOIN Animal ON(DonoAnimal.animalId = Animal.Id)
LEFT JOIN Especie ON(Animal.especieId = especie.id);
