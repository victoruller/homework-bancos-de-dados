DROP SCHEMA IF EXISTS ControleTubos;
CREATE SCHEMA IF NOT EXISTS ControleTubos;

USE ControleTubos;

CREATE TABLE material(
idMaterial INT Primary Key AUTO_INCREMENT,
nomeMaterial VARCHAR(20)
);

CREATE TABLE lote(
idLote INT Primary Key AUTO_INCREMENT,
pesoLote DECIMAL (6,3),
id_material INT,
FOREIGN KEY (id_material) REFERENCES material (idMaterial),
dataEntrada DATE
);

CREATE TABLE remessa(
idRemessa INT Primary Key AUTO_INCREMENT,
pesoRemessa DECIMAL (6,3),
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
VALUES (708, '020-03-14');


SELECT SUM(pesoRemessa), nomeMaterial FROM remessa
LEFT JOIN lote_remessa ON(idRemessa = id_remessa)
LEFT JOIN lote ON (idLote = id_lote)
LEFT JOIN material ON(idMaterial = id_material) GROUP BY pesoRemessa;