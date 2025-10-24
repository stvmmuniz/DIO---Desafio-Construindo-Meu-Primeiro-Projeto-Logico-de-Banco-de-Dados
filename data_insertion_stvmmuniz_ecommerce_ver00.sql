-- DADOS FICTÍCIOS PARA TESTE

USE ecommerce;
SET FOREIGN_KEY_CHECKS = 0;

-- limpar tabelas
TRUNCATE TABLE payments;
TRUNCATE TABLE clientCards;
TRUNCATE TABLE productOrder;
TRUNCATE TABLE paymentMethod;
TRUNCATE TABLE productSeller;
TRUNCATE TABLE productSupplier;
TRUNCATE TABLE productStorage;
TRUNCATE TABLE stockWarehouse;
TRUNCATE TABLE orders;
TRUNCATE TABLE product;
TRUNCATE TABLE supplier;
TRUNCATE TABLE carrier;
TRUNCATE TABLE carrierOrder;
TRUNCATE TABLE seller;
TRUNCATE TABLE clients;

-- resetar auto_increment
ALTER TABLE clients AUTO_INCREMENT = 1;
ALTER TABLE product AUTO_INCREMENT = 1;
ALTER TABLE supplier AUTO_INCREMENT = 1;
ALTER TABLE seller AUTO_INCREMENT = 1;
ALTER TABLE stockWarehouse AUTO_INCREMENT = 1;
ALTER TABLE orders AUTO_INCREMENT = 1;
ALTER TABLE paymentMethod AUTO_INCREMENT = 1;
ALTER TABLE clientCards AUTO_INCREMENT = 1;
ALTER TABLE payments AUTO_INCREMENT = 1;
ALTER TABLE carrier AUTO_INCREMENT = 1;

-- TABELA CLIENTES (clients)
INSERT INTO clients (Fname, Minit, Lname, CPF, CNPJ, Address, BornDate) VALUES
('João','M.','Silva','12345678901',NULL,'Rua dos Andradas, 120 - Porto Alegre/RS','1985-03-15'),
('Maria','A.','Souza','23456789012',NULL,'Av. Borges de Medeiros, 850 - Porto Alegre/RS','1990-07-22'),
('Carlos','R.','Pereira','34567890123',NULL,'Rua Bento Gonçalves, 45 - Canoas/RS','1982-11-02'),
('Fernanda','L.','Mendes','45678901234',NULL,'Rua Barão do Rio Branco, 200 - Novo Hamburgo/RS','1995-02-14'),
('Ricardo','T.','Oliveira','56789012345',NULL,'Rua Independência, 333 - Pelotas/RS','1980-12-09'),
('Camila','P.','Ribeiro','67890123456',NULL,'Av. Júlio de Castilhos, 500 - Caxias do Sul/RS','1993-05-30'),
('André','S.','Nunes','78901234567',NULL,'Rua São Pedro, 70 - Santa Maria/RS','1988-09-10'),
('Patrícia','D.','Fagundes','89012345678',NULL,'Rua Dom Pedro II, 89 - Gravataí/RS','1991-01-27'),
('Eduardo','C.','Lopes','90123456789',NULL,'Rua Pinheiro Machado, 240 - Passo Fundo/RS','1979-06-18'),
('Tatiane','E.','Costa','01234567890',NULL,'Rua XV de Novembro, 18 - Erechim/RS','1996-08-04');

-- TESTE DE INSERÇÃO DE UM CLIENTE COM DADOS DE CPF E CNPJ
-- INSERT INTO clients (Fname, Minit, Lname, CPF, CNPJ, Address, BornDate) VALUES
-- ('João','M.','Silva','12345678901','1234568901234','Rua dos Andradas, 120 - Porto Alegre/RS','1985-03-15');

-- TABELA PRODUTOS (product)
INSERT INTO product (Pdescription, classification_kids, category, avaliação, Pvalue) VALUES
('Smartphone Android 128GB', false, 'Eletrônicos', 4.5, 1899.90),
('Camiseta Algodão Gremista', false, 'Vestuário', 4.8, 89.90),
('Boneca de Pano Tradicional', true, 'Brinquedos', 4.2, 59.90),
('Chocolate Artesanal 70%', true, 'Alimentos', 4.9, 24.50),
('Mesa de Madeira Imbuia', false, 'Móveis', 4.7, 799.00),
('Fone de Ouvido Bluetooth', false, 'Eletrônicos', 4.3, 249.00),
('Jaqueta de Couro Gaúcha', false, 'Vestuário', 4.6, 590.00),
('Carrinho de Controle Remoto', true, 'Brinquedos', 4.4, 199.90),
('Erva-mate Tradicional 1kg', true, 'Alimentos', 4.9, 19.90),
('Cadeira de Escritório Giratória', false, 'Móveis', 4.5, 499.00);

-- TABELA FORNECEDORES (supplier)
INSERT INTO supplier (CompanyName, CNPJ, contact) VALUES
('Móveis Serra Gaúcha Ltda','12345678000111','51999990001'),
('Alimentos do Sul S/A','22345678000122','51999990002'),
('Brinque Bem Distribuidora','32345678000133','51999990003'),
('Eletrônicos Pampas','42345678000144','51999990004'),
('Vestuário Gaúcho Ltda','52345678000155','51999990005'),
('Tech RS Comércio','62345678000166','51999990006'),
('Ervateira do Chimarrão','72345678000177','51999990007'),
('Delícias da Colônia','82345678000188','51999990008'),
('Moveis Bento Ltda','92345678000199','51999990009'),
('Fábrica de Brinquedos Feliz','10345678000100','51999990010'),
('Moveis do Pampa','77788899000107','51988880008');

-- TABELA VENDEDORES (seller)
INSERT INTO seller (SocialName, BusinessName, CNPJ, CPF, location, contact) VALUES
('Comercial Silveira Ltda','Silveira Comércio','11122233000101',NULL,'Porto Alegre/RS','51988880001'),
('Loja da Serra','Serra Vendas','22233344000102',NULL,'Caxias do Sul/RS','51988880002'),
('Brinquedos RS','Distribuidora BRINQ','33344455000103',NULL,'Novo Hamburgo/RS','51988880003'),
('Mercado Central','Mercado Porto','44455566000104',NULL,'Pelotas/RS','51988880004'),
('Eletrônica Sul','TechSul','55566677000105',NULL,'Canoas/RS','51988880005'),
('João Pereira',NULL,NULL,'12345678900','Santa Maria/RS','51988880006'),
('Moda Gaúcha Ltda','ModaSul','66677788000106',NULL,'Bento Gonçalves/RS','51988880007'),
('Moveis do Pampa','Pampa Moveis','77788899000107',NULL,'Uruguaiana/RS','51988880008'),
('Carlos Fernandes',NULL,NULL,'23456789011','Gravataí/RS','51988880009'),
('Delícias do Vale','Delícias Vale Ltda','88899900000108',NULL,'Lajeado/RS','51988880010');

-- TABELA ARMAZÉM DE ESTOQUE (stockWarehouse)
INSERT INTO stockWarehouse (warehouseLocation) VALUES
('Depósito Central - Porto Alegre'),
('Centro de Distribuição - Caxias do Sul'),
('Armazém Novo Hamburgo'),
('Galpão Pelotas'),
('Centro de Distribuição - Canoas'),
('Depósito Bento Gonçalves'),
('Estoque Lajeado'),
('Galpão Uruguaiana'),
('Centro de Distribuição - Passo Fundo'),
('Estoque Erechim');

-- TABELA ESTOQUE DE PRODUTOS (productStorage)
INSERT INTO productStorage (idPSproduct, idPSstockWarehouse, quantity) VALUES
(1,1,200),(1,6,100),
(2,2,150),(2,7,75),
(3,3,80),(3,8,40),
(4,4,100),(4,9,50),
(5,5,120),(5,10,60),
(6,1,90),(6,6,45),
(7,2,60),(7,7,30),
(8,3,70),(8,8,35),
(9,4,110),(9,9,55),
(10,5,95),(10,10,50);

-- TABELA PEDIDOS (orders)
INSERT INTO orders (order_idClient, orderDate, orderDescription, totalValue, orderStatus) VALUES
(1,'2025-09-01 14:33:00','Smartphone e Fone Bluetooth',2148.90,'Entregue'),
(2,'2025-09-03 09:12:00','Camisetas Gremistas',179.80,'Enviado'),
(3,'2025-09-04 18:55:00','Mesa de Madeira',859.00,'Em processamento'),
(4,'2025-09-05 12:40:00','Boneca e Carrinho',259.80,'Entregue'),
(5,'2025-09-07 17:10:00','Chocolate e Erva-mate',44.40,'Entregue'),
(6,'2025-09-09 10:05:00','Jaqueta de Couro',608.00,'Em processamento'),
(7,'2025-09-10 15:45:00','Cadeira de Escritório',539.00,'Em processamento'),
(8,'2025-09-12 19:22:00','Smartphone e Fone',2148.90,'Enviado'),
(9,'2025-09-14 08:33:00','Brinquedos infantis',259.80,'Entregue'),
(10,'2025-09-16 20:12:00','Mesa e Cadeira',1298.00,'Em processamento'),
(10,'2025-10-01 14:33:00','Smartphone e Fone Bluetooth',2148.90,'Entregue'),
(9,'2025-10-03 09:12:00','Camisetas Gremistas',179.80,'Enviado'),
(7,'2025-10-04 18:55:00','Mesa de Madeira',859.00,'Em processamento'),
(6,'2025-10-05 12:40:00','Boneca e Carrinho',259.80,'Entregue'),
(4,'2025-10-07 17:10:00','Chocolate e Erva-mate',44.40,'Entregue'),
(1,'2025-10-09 10:05:00','Jaqueta de Couro',608.00,'Em processamento'),
(3,'2025-10-10 15:45:00','Cadeira de Escritório',539.00,'Em processamento'),
(3,'2025-10-12 19:22:00','Smartphone e Fone',2148.90,'Enviado'),
(10,'2025-10-14 08:33:00','Brinquedos infantis',259.80,'Entregue'),
(8,'2025-10-16 20:12:00','Mesa e Cadeira',1298.00,'Em processamento');

-- TABELA METODOS DE PAGAMENTO (paymentMethod)
INSERT INTO paymentMethod (payMethodName) VALUES
('Dinheiro'),
('Boleto'),
('Cartão'),
('Chave Pix');

-- TABELA CARTÕES DE CLIENTES (clientCards)
INSERT INTO clientCards (card_idClient, cardHolderName, cardNumberMasked, last4Digits, expirationDate, token) VALUES
(1,'João Silva','**** **** **** 1234','1234','12/25','tok_abc123'),
(2,'Maria Souza','**** **** **** 2345','2345','08/26','tok_def234'),
(3,'Carlos Pereira','**** **** **** 3456','3456','11/24','tok_ghi345'),
(4,'Fernanda Mendes','**** **** **** 4567','4567','02/27','tok_jkl456'),
(5,'Ricardo Oliveira','**** **** **** 5678','5678','12/26','tok_mno567'),
(6,'Camila Ribeiro','**** **** **** 6789','6789','05/25','tok_pqr678'),
(7,'André Nunes','**** **** **** 7890','7890','09/26','tok_stu789'),
(8,'Patrícia Fagundes','**** **** **** 8901','8901','01/27','tok_vwx890'),
(9,'Eduardo Lopes','**** **** **** 9012','9012','06/25','tok_yza901'),
(10,'Tatiane Costa','**** **** **** 0123','0123','08/26','tok_bcd012');

-- TABELA PAGAMENTOS (payments)
INSERT INTO payments 
(payment_idOrder, paymentDate, payment_idPayMethod, payment_idClientCard, transactionId, pixKey, barcode, amount, changeGiven, payStatus) 
VALUES
(1, '2025-10-01 14:40:00', 3, 1, 'TRX20251001A', NULL, NULL, 2148.90, 0, 'pago'),
(2, '2025-10-03 09:20:00', 4, NULL, NULL, 'pix-3049-ABCD', NULL, 179.80, 0, 'pago'),
(3, '2025-10-04 19:00:00', 2, NULL, NULL, NULL, '34191750090012345678900001234567890123456789', 859.00, 0, 'pendente'),
(4, '2025-10-05 12:50:00', 3, 4, 'TRX20251005B', NULL, NULL, 259.80, 0, 'pago'),
(5, '2025-10-07 17:20:00', 1, NULL, NULL, NULL, NULL, 44.40, 0, 'pago'),
(6, '2025-10-09 10:15:00', 3, 6, 'TRX20251009C', NULL, NULL, 608.00, 0, 'pendente'),
(7, '2025-10-10 15:50:00', 2, NULL, NULL, NULL, '03391960090098765432100004567890123456789012', 539.00, 0, 'pendente'),
(8, '2025-10-12 19:30:00', 4, NULL, NULL, 'pix-4411-ZYXW', NULL, 2148.90, 0, 'pago'),
(9, '2025-10-14 08:40:00', 1, NULL, NULL, NULL, NULL, 259.80, 0, 'pago'),
(10, '2025-10-16 20:20:00', 3, 10, 'TRX20251016D', NULL, NULL, 1298.00, 0, 'pendente');

-- TABELA PRODUTO-VENDEDOR (productSeller)
INSERT INTO productSeller (idPseller, idPproduct, prodQuantity) VALUES
(1,1,5),(1,6,3),
(2,2,10),(2,7,2),
(3,3,8),(3,8,5),
(4,4,12),(4,9,7),
(5,5,4),(5,10,6),
(6,1,2),(6,6,1),
(7,2,3),(7,7,2),
(8,3,1),(8,8,3),
(9,4,2),(9,9,1),
(10,5,2),(10,10,1);

-- TABELA PRODUTO-PEDIDO (productOrder)
INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus) VALUES
(1,1,1,'Disponível'),(6,1,1,'Disponível'),
(2,2,2,'Disponível'),
(5,3,1,'Disponível'),
(3,4,1,'Disponível'),(8,4,1,'Disponível'),
(4,5,1,'Disponível'),(9,5,1,'Disponível'),
(7,6,1,'Disponível'),
(10,7,1,'Disponível'),
(1,8,1,'Disponível'),(6,8,1,'Disponível'),
(3,9,1,'Disponível'),(8,9,1,'Disponível'),
(5,10,1,'Disponível'),(10,10,1,'Disponível'),
(1,11,1,'Disponível'),(6,11,1,'Disponível'),
(2,12,2,'Disponível'),
(5,13,1,'Disponível'),
(3,14,1,'Disponível'),(8,14,1,'Disponível'),
(4,15,1,'Disponível'),(9,15,1,'Disponível'),
(7,16,1,'Disponível'),
(10,17,1,'Disponível'),
(1,18,1,'Disponível'),(6,18,1,'Disponível'),
(3,19,1,'Disponível'),(8,19,1,'Disponível'),
(5,20,1,'Disponível'),(10,20,1,'Disponível');

-- TABELA PRODUTO-FORNECEDOR (productSupplier)
INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity) VALUES
(6,1,50),(6,6,30),
(5,2,100),(5,7,20),
(10,3,40),(10,8,25),
(2,4,200),(7,9,150),
(1,5,10),(9,10,15),
(3,3,20),(3,7,10),
(4,1,20),(4,6,30),
(8,4,50); 

-- TABELA TRANSPORTADORAS (carrier)
INSERT INTO carrier (carrierName, carrierCNPJ, carrierContact) VALUES
('TransGaúcha Logística LTDA',         '92458736000121', '51983451234'),
('SulCargas Transportes Eireli',       '87894523000165', '51997234567'),
('Transporte SerraSul LTDA',           '91234567000145', '54996341212'),
('Gaúcha Express Distribuição',        '86954123000198', '51984672345'),
('Rodoviária Pampas LTDA',             '89541278000132', '5132245678'),
('LogSul Transporte e Cargas',         '90123456000187', '51995873456'),
('Planalto Logística Integrada',       '88954712000144', '54998451236'),
('TransPorto Alegre Distribuições',    '87654321000155', '51997231145'),
('Fronteira Oeste Transportes',        '91234789000122', '5534257789'),
('TransMissões Cargas Rápidas LTDA',   '93451278000133', '55998455678');

-- TABELA PEDIDO DE TRANSPORTE (carrier)
INSERT INTO carrierOrder (co_idcarrier, co_idOrder, trackingNo, freight) VALUES
(1, 1, 'TGL-274931', 25.00),
(2, 2, 'SCT-580247', 15.00),
(3, 3, 'TSS-913604', 60.00),
(4, 4, 'GEX-046822', 20.00),
(5, 5, 'RPL-198753', 12.00),
(6, 6, 'LST-872140', 18.00),
(7, 7, 'PLI-530916', 40.00),
(8, 8, 'TPA-762485', 30.00),
(9, 9, 'FOT-604279', 22.00),
(10, 10, 'TMC-385097', 70.00),
(1, 11, 'TGL-951320', 25.00),
(2, 12, 'SCT-027654', 15.00),
(3, 13, 'TSS-764209', 60.00),
(4, 14, 'GEX-312890', 20.00),
(5, 15, 'RPL-508671', 12.00),
(6, 16, 'LST-690428', 18.00),
(7, 17, 'PLI-174953', 40.00),
(8, 18, 'TPA-832617', 30.00),
(9, 19, 'FOT-945062', 22.00),
(10, 20, 'TMC-256781', 70.00);

SET FOREIGN_KEY_CHECKS = 1;

-- limpar tabelas
SELECT * FROM payments;
SELECT * FROM clientCards;
SELECT * FROM productOrder;
SELECT * FROM paymentMethod;
SELECT * FROM productSeller;
SELECT * FROM productSupplier;
SELECT * FROM productStorage;
SELECT * FROM stockWarehouse;
SELECT * FROM orders;
SELECT * FROM product;
SELECT * FROM supplier;
SELECT * FROM carrier;
SELECT * FROM carrierOrder;
SELECT * FROM seller;
SELECT * FROM clients;


