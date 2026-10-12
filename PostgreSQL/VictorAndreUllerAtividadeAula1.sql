CREATE DATABASE "Teste"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
	
	DROP TABLE IF EXISTS Cliente;
	CREATE TABLE IF NOT EXISTS Cliente(
	ID_Cliente SERIAL PRIMARY KEY NOT NULL,
	Nome VARCHAR(40) NOT NULL,
	Endereco VARCHAR(100) NOT NULL,
	Data_Nascimento DATE NOT NULL,
	Telefone VARCHAR(20),
	Email VARCHAR(30)
	);
	
	
	
	CREATE TABLE IF NOT EXISTS Pedido(
	ID_Pedido SERIAL PRIMARY KEY NOT NULL,
	DataHora TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	ID_Cliente INTEGER NOT NULL REFERENCES Cliente(ID_Cliente) ON DELETE CASCADE ON UPDATE CASCADE,
	Status VARCHAR(20) NOT NULL,
	Total DECIMAL(6,2)
	);
	
	DROP TABLE IF EXISTS Item_Cardapio;
	CREATE TABLE IF NOT EXISTS Item_Cardapio(
	ID_Item SERIAL PRIMARY KEY NOT NULL,
	Nome VARCHAR(30),
	Descricao VARCHAR(100),
	Preco DECIMAL(6,2)
	);
	DROP TABLE IF EXISTS Item_Pedido;
	CREATE TABLE IF NOT EXISTS Item_Pedido(
	ID_Pedido INTEGER REFERENCES Pedido(ID_Pedido) ON DELETE CASCADE ON UPDATE CASCADE,
	ID_Item INTEGER REFERENCES Item_Cardapio(ID_ITEM) ON DELETE CASCADE ON UPDATE CASCADE,
	Quantidade INTEGER NOT NULL
	);
	
	INSERT INTO Cliente(ID_Cliente, Nome, Data_Nascimento, Endereco,  Telefone, Email) VALUES(1,'Anna Briggs','2023-11-06','Lawson Square, 13356','732-864-7316','martinpatricia@cain-smith.com'),
	(2,'Jeremy Thompson','1998-05-04','USS Medina, 21470','523-272-4776','kimberlycannon@quinn.info'),
	(3,'Dakota Lloyd','1976-10-27','Reed Ferry, 305','01-566-218-0500','wmoore@gutierrez-cole.com'),
	(4,'Danny Potter','1958-03-18','USS Gibson, 424','01-441-053-3778','joel28@thomas-rosales.org'),
	(5,'Carolyn Stevens','1948-07-07', 'Willie Walks Suite 019','001-183-448-8354','williamgreen@gmail.com'),
	(6,'Kara Perkins','1992-08-07','Esparza Pines, 86115','001-372.224.2758','melodyholt@yahoo.com'),
	(7,'Luis Evans','1968-02-23','John Island Suite, 074','+1-894-341-5025','qtucker@gmail.com'),
	(8,'Amber West','1999-07-10', 'Peters Mountain Suite, 063','(164)470-2706','rhorton@wright-reed.biz'),
	(9,'Stephanie Fox','1998-05-04','Myers Field, 385','001-391-492-3087','halljessica@yahoo.com'),
	(10,'Tamara Schwartz','2010-01-20','USNS Long, 58200','+1-942-840-1333','charlotte91@gmail.com');
	
	INSERT INTO Item_Cardapio(ID_Item, Nome, Descricao, Preco) VALUES(1,'Pizza Margherita','Tradicional pizza com molho de tomate, queijo mozzarella e manjericão',44.21),
	(2,'Hambúrguer Gourmet','Hambúrguer de carne bovina com queijo, alface, tomate e molho especial',16.95),
	(3,'Salada Caesar','Salada com alface romana, croutons, queijo parmesão e molho Caesar', 47.67),
	(4,'Sushi Sashimi','Variedade de sashimi de salmão, atum e peixe branco',14.70),
	(5,'Spaghetti Carbonara','Espaguete com molho cremoso de ovos, queijo parmesão, bacon e pimenta preta',20.92),
	(6,'Frango Assado','Frango assado com ervas e especiarias, servido com vegetais',45.45),
	(7,'Tacos Mexicanos','Tacos com carne moída, alface, queijo, tomate e molho picante',19.79),
	(8,'Sorvete de Baunilha','Sorvete cremoso de baunilha com opções de cobertura',35.38),
	(9,'Lasanha à Bolonhesa','Camadas de massa, carne moída, molho de tomate e queijo',40.56),
	(10,'Pad Thai','Macarrão tailandês frito com camarões, amendoim, broto de feijão e limão',46.65);
	
	INSERT INTO Pedido(ID_Pedido, DataHora, ID_Cliente, Status, Total) VALUES(1,'2024-02-14 03:53:23.704596',4,'Cancelado',45.76),
	(2,'2024-01-31 19:50:23.704699',10,'Finalizado',57.11),
	(3,'2024-01-28 11:32:23.704728',4,'Finalizado',25.19),
	(4,'2024-02-20 10:08:23.704749',2,'Cancelado',88.64),
	(5,'2024-02-11 10:40:23.704769',3,'Finalizado',54.01),
	(6,'2024-02-10 02:06:23.704789',5,'Pendente',63.14),
	(7,'2024-02-13 10:44:23.704807',10,'Finalizado',33.45),
	(8,'2024-02-01 07:15:23.704826',3,'Pendente',20.43),
	(9,'2024-02-01 02:02:23.704845',9,'Pendente',87.72),
	(10,'2024-02-04 04:23:23.704864',2,'Cancelado',21.87);
	
	INSERT INTO Item_Pedido(ID_Pedido, ID_Item, Quantidade) VALUES(1,8,2),(2,1,5),(3,2,1),(4,6,4),(5,1,5),(6,1,5),(7,6,1),
	(8,3,1),(9,9,2),(10,4,1),(2,2,3),(2,7,2),(5,2,3),(5,7,3),
	(7,5,2),(7,10,4),(8,5,3),(8,10,5),(8,9,1),(7,4,1);

	-- Exercício a)
	SELECT Nome FROM Cliente ORDER BY Nome;
	
	-- Exercício b)
	ALTER TABLE Cliente ADD UNIQUE(Telefone);
	
	-- Exercício c)
	SELECT Nome FROM Item_Cardapio WHERE Nome NOT LIKE '%QUEIJO%';
	
	-- Exercício d)
	SELECT Item_Cardapio.Nome, Cliente.nome FROM Item_Cardapio 
	INNER JOIN Item_Pedido ON Item_Pedido.ID_Item = Item_Cardapio.ID_ITEM
	INNER JOIN Pedido ON Item_Pedido.ID_Pedido = Pedido.ID_Pedido
	INNER JOIN Cliente ON Cliente.ID_Cliente = Pedido.ID_Cliente;
	
	-- Exercício e)
	DELETE FROM Pedido WHERE ID_Pedido = 5;
	SELECT ID_Pedido, Total FROM Pedido;
	
	-- Exercício f)
	SELECT NOME, EXTRACT(YEAR FROM AGE(CURRENT_DATE, Data_Nascimento)) FROM Cliente ORDER BY Nome;
	
	-- Exercício g)
	DELETE FROM Cliente WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE, Data_Nascimento)) < 18;
	
	-- Exercício h)
	ALTER TABLE Cliente ADD COLUMN Data_Cadastro DATE DEFAULT CURRENT_DATE;
	SELECT Nome, Data_Cadastro FROM Cliente;
	
	-- Exercício i)
	ALTER TABLE Item_Cardapio ADD COLUMN Gluten_Free BOOLEAN DEFAULT FALSE;
	ALTER TABLE Item_Cardapio ADD COLUMN Is_Vegan BOOLEAN DEFAULT FALSE;
	
	-- Exercício j) 
	SELECT Pedido.Total, Cliente.nome, Item_Cardapio.nome, Item_Pedido.Quantidade, (Item_Cardapio.Preco * Item_Pedido.Quantidade) 
	FROM Pedido
	INNER JOIN Item_Pedido ON Item_Pedido.ID_Pedido = Pedido.ID_Pedido
	INNER JOIN Item_Cardapio ON Item_Cardapio.ID_Item = Item_Pedido.ID_Item
	INNER JOIN Cliente ON Pedido.ID_Cliente = Cliente.ID_Cliente ORDER BY Pedido.ID_Pedido;
	
	-- Exercício k)
	WITH Total_Real AS (SELECT (Item_Cardapio.Preco * Item_Pedido.Quantidade) AS Total_Preco, Item_Pedido.ID_Pedido AS ID_Pedido FROM Item_Pedido
	INNER JOIN Item_Cardapio ON Item_Cardapio.ID_Item = Item_Pedido.ID_Item) 
	
	UPDATE Pedido SET (Total) = (SELECT SUM(Total_Real.Total_Preco) 
	FROM Total_Real	
	GROUP BY Total_Real.ID_Pedido
	HAVING Total_Real.ID_Pedido = Pedido.ID_Pedido
	ORDER BY Total_Real.ID_Pedido);
	
	
	
	
	
	
	