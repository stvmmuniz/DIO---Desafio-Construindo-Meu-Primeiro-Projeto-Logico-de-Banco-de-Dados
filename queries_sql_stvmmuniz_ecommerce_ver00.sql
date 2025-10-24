use ecommerce;

-- ### RECUPERAÇÕES SIMPLES ###

-- Lista completa de pedidos
SELECT * FROM orders;

-- Lista completa de cliente
SELECT * FROM clients;

-- ### RECUPERAÇÕES COM FILTRO WHERE ###

-- Lista de pedido entregues
SELECT * FROM orders WHERE orderStatus = 'Entregue';

-- Lista de pagamentos pendentes
SELECT * FROM payments WHERE payStatus = 'pendente';

-- ### RECUPERÇÕES COM ATRIBUTO DERIVADO ###
-- Lista de clientes com idade
SELECT 
    Fname,
    bornDate,
    YEAR(CURDATE()) - YEAR(bornDate) AS Idade
FROM clients
;

-- Lista de pedidos com Total geral (Produtos + Frete) ### UTILIZADO TAMBÉM JOIN e ORDER BY
SELECT
	o.idOrder AS Numero_Pedido,
    o.orderDate AS Data_Pedido,
    o.orderDescription AS Descrição,
    o.totalValue AS Total_Produtos,
    co.freight AS Frete,
    (o.totalValue + co.freight) AS Total_Geral
FROM orders o
INNER JOIN carrierOrder co
    ON o.idOrder = co.co_idOrder
ORDER BY o.idOrder
;

-- ### RECUPERAÇÕES COM HAVING STATEMENT ###
-- Lista de clientes com 35 anos ou mais
SELECT 
    Fname,
    bornDate,
    YEAR(CURDATE()) - YEAR(bornDate) AS Idade
    FROM clients
    HAVING Idade >=35
;

-- Lista de pedidos com Total geral (Produtos + Frete) igual ou superior a 1000,00 ### UTILIZADO TAMBÉM JOIN e ORDER BY
SELECT
	o.idOrder AS Numero_Pedido,
    o.orderDate AS Data_Pedido,
    o.orderDescription AS Descrição,
    o.totalValue AS Total_Produtos,
    co.freight AS Frete,
    (o.totalValue + co.freight) AS Total_Geral
FROM orders o
INNER JOIN carrierOrder co
	ON o.idOrder = co.co_idOrder
HAVING Total_Geral >= 1000
ORDER BY Total_Geral DESC  
;  
  
-- ### RESPOSTAS DAS PERGUNTAS DO DESAFIO ####
-- Quantos pedidos foram feitos por cada cliente?
SELECT
	concat(c.Fname,' ', c.Lname) AS Nome_do_Cliente,
    count(o.idOrder) AS Qtd_Pedidos
FROM orders o
INNER JOIN clients c 
	ON o.order_idClient = c.idClient
GROUP BY Nome_do_Cliente
ORDER BY Qtd_Pedidos DESC
    ;

-- Algum vendedor também é fonecedor?
SELECT
	se.SocialName AS Fornecedor,
    se.CNPJ AS CNPJ
FROM seller se
INNER JOIN supplier s
    ON se.CNPJ = s.CNPJ
;

-- Relação de produtos fornecedores e estoques: (Foi acrescentado na consulta o estoque disponível no fornecedor)
SELECT 
    p.idProduct,
    p.Pdescription AS Produto,
    s.CompanyName AS Fornecedor,
    pst.quantity AS Estoque_Próprio,
	sw.warehouseLocation AS Local_Armazém,
    ps.quantity AS Estoque_disponível_no_Fornecedor
FROM product p
LEFT JOIN productSupplier ps 
    ON p.idProduct = ps.idPsProduct
LEFT JOIN supplier s 
    ON ps.idPsSupplier = s.idSupplier
LEFT JOIN productStorage pst 
    ON p.idProduct = pst.idPSproduct
LEFT JOIN stockWarehouse sw
    ON pst.idPSstockWarehouse = sw.idstockWarehouse
ORDER BY p.Pdescription
;

-- Relação de produtos fornecedores ordenado por fronecedor: 
SELECT 
    s.CompanyName AS Fornecedor,
    p.Pdescription AS Produto
FROM product p
LEFT JOIN productSupplier ps 
    ON p.idProduct = ps.idPsProduct
LEFT JOIN supplier s 
    ON ps.idPsSupplier = s.idSupplier
ORDER BY Fornecedor
;

-- Relação de produtos fornecedores ordenado por fronecedor: 
SELECT 
    p.Pdescription AS Produto,
    s.CompanyName AS Fornecedor
FROM product p
LEFT JOIN productSupplier ps 
    ON p.idProduct = ps.idPsProduct
LEFT JOIN supplier s 
    ON ps.idPsSupplier = s.idSupplier
ORDER BY Produto
;

-- ### QUERIES ADICIONAIS ###
-- lista de pedidos realizados por cliente
SELECT concat(Fname,' ', Lname) AS Nome_do_Cliente, idOrder, orderDate, orderDescription, totalValue, orderStatus
FROM clients, orders
WHERE order_idClient = idClient
ORDER BY Nome_do_Cliente;

-- lista de pedidos realizados por cliente - usando JOIN
SELECT concat(Fname,' ', Lname) AS Nome_do_Cliente, idOrder, orderDate, orderDescription, totalValue, orderStatus
FROM orders
INNER JOIN clients
    ON order_idClient = idClient
ORDER BY Nome_do_Cliente;

-- Lista de produtos comprados por cliente com descrição do fornecedor e agrupado por cliente 
SELECT
    concat(c.Fname,' ', c.Lname) AS Nome_do_Cliente,
	p.Pdescription AS Produto,
    p.Pvalue AS ValorUnit,
    po.poQuantity AS Quantidade,
    s.CompanyName AS Fornecedor,
    o.idOrder AS NúmeroPedido
FROM orders AS o
INNER JOIN clients AS c 
    ON o.order_idClient = c.idClient
INNER JOIN productOrder AS po 
    ON o.idOrder = po.idPOorder
INNER JOIN product AS p 
    ON po.idPOproduct = p.idProduct
INNER JOIN productSupplier AS ps 
    ON p.idProduct = ps.idPsProduct
INNER JOIN supplier AS s 
    ON ps.idPsSupplier = s.idSupplier
ORDER BY Nome_do_Cliente
;
-- Lista de rastreio dos pedidos enviados e entregues
SELECT
	ca.carrierName AS Transportadora,
    ca.carrierContact AS Contato,
    co.trackingNo AS CodRastreio,
    o.idOrder AS PedidoNo,
    o.orderDate AS DataPedido,
    o.orderStatus AS Situação     
FROM orders o
INNER JOIN carrierOrder co
    ON o.idOrder = co.co_idOrder and (o.orderStatus = 'Enviado' OR  o.orderStatus = 'Entregue')
INNER JOIN carrier ca
    ON co.co_idcarrier = ca.idcarrier
ORDER BY ca.carrierName ASC, o.idOrder DESC -- usei e ASC e DESC somente para simular o uso de ambos.
    ;

-- Ranking de compra dos cliente
SELECT
	concat(c.Fname,' ', c.Lname) AS Nome_do_Cliente,
    count(o.idOrder) AS Qtd_Pedidos,
    sum(o.totalValue) AS ValorTotal,
    ROUND(avg(o.totalValue),2) AS TicketMédio
FROM orders o
INNER JOIN clients c 
    ON o.order_idClient = c.idClient
GROUP BY Nome_do_Cliente
ORDER BY ValorTotal DESC
    ;
    
-- Ranking dos vendedores,
SELECT
	s.socialName AS Vendedor,
    SUM(o.totalValue) AS Valor_Total_Geral,
    ROUND(avg(o.totalValue),2) AS TicketMédio
FROM orders o
LEFT JOIN productOrder po ON po.idPOorder = o.idOrder
LEFT JOIN productSeller ps ON ps.idPproduct = po.idPOproduct
LEFT JOIN seller s ON s.idSeller = ps.idPseller
GROUP BY s.socialName
ORDER BY Valor_Total_Geral DESC
;
