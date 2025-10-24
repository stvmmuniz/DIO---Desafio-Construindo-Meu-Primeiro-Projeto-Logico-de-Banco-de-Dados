-- Criação de BD para o cenário de e-commerce - @stvmmuniz - Estevam Muniz
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabela cliente (clients)
create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10) not null,
        Minit char(3),
        Lname varchar(20),
        CPF char(11),
        CNPJ char(15), 
        Address varchar(255),
        BornDate date not null,
        constraint unique_cpf_client unique (CPF),
        constraint chkclient_cpf_cnpj check (
        (CPF is not null and CNPJ is null)
        or (CPF is null and CNPJ is not null)
    )
);
alter table clients auto_increment=1;
desc clients;

-- criar tabela produto (product)
-- acrescentei (por conta própria) a coluna Pvalue nesta tabela e retirei a coluna size
create table product(
		idProduct int auto_increment primary key,
        Pdescription varchar(255) not null,
        classification_kids bool default false,
        category enum('Eletrônicos','Vestuário','Brinquedos','Alimentos','Móveis') not null,
        avaliação float default 0,
		Pvalue decimal(10,2) default 0
);
alter table product auto_increment=1;
desc product;

-- criar tabela pedido (orders)
create table orders(
	idOrder int auto_increment primary key,
    order_idClient int,
    orderDate datetime default now(),
    orderDescription varchar(255),
    totalValue decimal(10,2) not null,
    orderStatus enum('Cancelado', 'Em processamento', 'Enviado', 'Entregue') default 'Em processamento',
    constraint fk_order_client foreign key (order_idClient) references clients(idClient)
			on update cascade
);
alter table orders auto_increment=1;
desc orders;

-- criar tabela metodo de pagamento
create table paymentMethod(
	idPayMethod int auto_increment primary key,
    payMethodName varchar(255) not null unique
);
alter table paymentMethod auto_increment=1;
desc paymentMethod;

-- criar tabela cartões de clientes (Client Cards)
create table clientCards (
    idClientCard int auto_increment primary key,
    card_idClient int not null,
    cardHolderName varchar(100) not null,
    cardNumberMasked varchar(19) not null,
    last4Digits char(4) not null,
    expirationDate char(5) not null,       
    token varchar(255),
    constraint fk_payment_clientCards foreign key (card_idClient) references clients(idClient)
			on update cascade
);
alter table clientCards auto_increment=1;
desc clientCards;

-- criar tabela pagamentos (payments)
create table payments (
    idPayment int auto_increment primary key,
    payment_idOrder int not null,
    paymentDate datetime default now(),
    payment_idPayMethod int not null,
    payment_idClientCard int,        -- se o pagamento for via cartão salvo
    transactionId varchar(100),      -- id da transação (gateway, pix, etc.)
    pixKey varchar(100),
    barcode varchar(100),
    amount decimal(10,2) not null,
    changeGiven decimal(10,2) not null default 0,
    payStatus enum('pendente', 'pago', 'cancelado') default 'pendente',
        constraint fk_payment_order Foreign key (payment_idOrder) references orders(idOrder)
			on update cascade,
		constraint fk_payment_client foreign key (payment_idClientCard) references clientCards(idClientCard)
			on update cascade,
		constraint fk_payment_payMethod foreign key (payment_idPayMethod) references paymentMethod(idPayMethod)
        on update cascade
);
 alter table payments auto_increment=1;
 desc payments;

-- criar tabela armazém de estoque (stockWarehouse)
create table stockWarehouse(
	idstockWarehouse int auto_increment primary key,
    warehouseLocation varchar(255)
);
alter table stockWarehouse auto_increment=1;
desc stockWarehouse;

-- criar tabela fornecedor (supplier)
create table supplier(
	idSupplier int auto_increment primary key,
    CompanyName varchar(255) not null,
    CNPJ char(14) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment=1;
desc supplier;

-- criar tabela vendedor (seller)
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    BusinessName varchar(255),
    CNPJ char(14),
    CPF char(11),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF),
    constraint chkseller_cpf_cnpj check (
        (CPF is not null and CNPJ is null)
        or (CPF is null and CNPJ is not null)
    )
);
alter table seller auto_increment=1;
desc seller;

-- criar tabela da transportadora
create table carrier(
	idcarrier int auto_increment primary key,
    carrierName varchar(255) not null,
    carrierCNPJ char(14) not null,
    carrierContact char(11) not null,
    constraint unique_cnpj_seller unique (carrierCNPJ)
);
alter table carrier auto_increment=1;
desc carrier;

-- tabelas de relacionamentos M:N

-- criar tabela produto do vendedor (product seller)
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_productseller_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_productseller_product foreign key (idPproduct) references product(idProduct)
);
desc productSeller;

-- criar tabela pedido de produto (pdoduct order)
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_order foreign key (idPOorder) references orders(idOrder)
);
desc productOrder;

-- criar tabela estoque de produtos (productStorage)
create table productStorage(
	idPSproduct int,
    idPSstockWarehouse int,
    quantity int default 0,
    primary key (idPSproduct, idPSstockWarehouse),
    constraint fk_productStorage_product foreign key (idPSproduct) references product(idProduct),
    constraint fk_productStorage_stockWarehouse foreign key (idPSstockWarehouse) references stockWarehouse(idstockWarehouse)
);
desc productStorage;

-- criar tabela produto fornecedor (product supplier)
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_prodcut foreign key (idPsProduct) references product(idProduct)
);
desc productSupplier;

-- criar tabela pedido de transporte (carrierOrder)
create table carrierOrder(
	co_idcarrier int,
    co_idOrder int,
    trackingNo varchar(45) not null,
    freight decimal(6,2) default 10,
    primary key (co_idcarrier, co_idOrder),
    constraint fk_carrier_order_carrier foreign key (co_idcarrier) references carrier(idcarrier),
    constraint fk_carrier_order_order foreign key (co_idOrder) references orders(idOrder)
);
desc carrierOrder;


show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';

