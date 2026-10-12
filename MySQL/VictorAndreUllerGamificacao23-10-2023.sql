/*
1 - Diagrama: 

Doadores (id_doad PRIMARY KEY, nome, sobrenome, nascimento, peso, altura, sangue)
Doacoes(id_doac, dt_doacao, ml_doados, id_doad_FK)
Contato (id_cont, email, telefone, endereco, cidade, estado)

2: apresente todos os doadores e respectivos contatos, ordenados pelo estado
*/
SELECT nome, sobrenome, email, telefone FROM doadores
	LEFT JOIN contato ON(id_doad = id_cont) ORDER BY estado;
    

/*
3: apresente os doadores e suas respectivas doações
*/

SELECT nome, sobrenome, dt_doacao, ml_doados FROM doadores
	LEFT JOIN doacoes ON(id_doad = id_doad_FK);
    
    
    
-- 4. qual foi a quantidade máxima doada e o respectivo tipo sanguineo?

SELECT max(ml_doados), sangue FROM doacoes
	INNER JOIN doadores ON(id_doad_FK = id_doad);
    
    
    
-- 5. qual é o peso médio dos doadores de acordo com o grupo sanguineo?

SELECT sangue, avg(peso) FROM doadores GROUP BY sangue;



-- 6. quantos doadores de cada tipo sanguineo?


SELECT sangue, count(id_doad) FROM doadores GROUP BY sangue;



-- 7. quantos doadores do tipo B-?

SELECT count(id_doad) FROM doadores WHERE sangue = 'B-';



-- 8. numero de doadores B- do estado do AC?

SELECT count(id_doad) FROM doadores
	INNER JOIN contato ON(id_doad = id_cont)
		WHERE sangue = 'B-' AND estado = 'AC';



-- 9. qual é o peso mimino e máximo dos doadores?

SELECT MAX(peso) from doadores UNION
SELECT MIN(peso) from doadores;



-- 10. qual é a quantidade [máxima(?)] de ml doados por tipo sanguineo?

SELECT sangue, MAX(ml_doados) FROM doacoes
	LEFT JOIN doadores ON(id_doad_FK = id_doad) GROUP BY sangue;



-- 11. qual é a quantidade total de sangue doados por tipo sanguineo?

SELECT sangue, SUM(ml_doados) FROM doacoes
	LEFT JOIN doadores ON(id_doad_FK = id_doad) GROUP BY sangue;