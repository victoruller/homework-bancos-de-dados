DROP SCHEMA IF EXISTS ControleTubos;
CREATE SCHEMA IF NOT EXISTS ControleTubos;

USE ControleTubos;

CREATE TABLE material(
idMaterial INT Primary Key AUTO_INCREMENT,
nomeMaterial VARCHAR(20)
);

CREATE TABLE lote(
idLote INT Primary Key AUTO_INCREMENT,
pesoLote DECIMAL (10,2),
id_material INT,
FOREIGN KEY (id_material) REFERENCES material (idMaterial),
dataEntrada DATE
);

CREATE TABLE remessa(
idRemessa INT Primary Key AUTO_INCREMENT,
pesoRemessa DECIMAL (10,2),
dataSaida DATE
);

CREATE TABLE lote_remessa(
id_remessa INT,
id_lote INT,
FOREIGN KEY (id_Lote) REFERENCES lote (idLote),
FOREIGN KEY (id_remessa) REFERENCES remessa (idRemessa)
);







INSERT INTO material(nomeMaterial)
VALUES ("Aço Carbono");
INSERT INTO material(nomeMaterial)
VALUES ("INOX");
INSERT INTO material(nomeMaterial)
VALUES ("Cobre");

INSERT INTO lote(pesoLote, id_material, dataEntrada)
VALUES (520, 1, '2023-08-24');
INSERT INTO lote(pesoLote, id_material, dataEntrada)
VALUES (205, 2, '2023-08-06');
INSERT INTO lote(pesoLote, id_material, dataEntrada)
VALUES (507, 3, '2023-09-20');
INSERT INTO lote(pesoLote, id_material, dataEntrada)
VALUES (708, 1, '2020-03-07');
INSERT INTO lote(pesoLote, id_material, dataEntrada)
VALUES (120, 1, '2023-01-10');



INSERT INTO remessa(pesoRemessa, dataSaida)
VALUES (520, '2023-08-30');
INSERT INTO remessa(pesoRemessa, dataSaida)
VALUES (205, '2023-08-13');
INSERT INTO remessa(pesoRemessa, dataSaida)
VALUES (507, '2023-09-27');
INSERT INTO remessa(pesoRemessa, dataSaida)
VALUES (708, '2020-03-14');

INSERT INTO lote_remessa(id_remessa, id_lote)
VALUES (1, 2);
INSERT INTO lote_remessa(id_remessa, id_lote)
VALUES (2, 2);
INSERT INTO lote_remessa(id_remessa, id_lote)
VALUES (3, 1);
INSERT INTO lote_remessa(id_remessa, id_lote)
VALUES (4, 3);
INSERT INTO lote_remessa(id_remessa, id_lote) 
VALUES ((SELECT (MAX(idRemessa)-1) FROM remessa), 2);
SELECT (MAX(idRemessa)-1) FROM remessa;



SELECT SUM(remessa.pesoRemessa), material.nomeMaterial FROM remessa
LEFT JOIN lote_remessa ON(remessa.idRemessa = lote_remessa.id_remessa)
LEFT JOIN lote ON (lote.idLote = lote_remessa.id_lote)
LEFT JOIN material ON(material.idMaterial = lote.id_material) GROUP BY material.nomeMaterial;

SELECT * from lote;
SELECT * FROM material;
SELECT * FROM lote_remessa;
SELECT * FROM remessa;
SELECT (MAX(idRemessa)+1) FROM remessa;

UPDATE material
SET nomeMaterial = "Hubens"
WHERE idMaterial = 9;
