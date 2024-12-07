CREATE DATABASE orders;
go

USE orders;
go

DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('CPU');
INSERT INTO category(categoryName) VALUES ('Motherboard');
INSERT INTO category(categoryName) VALUES ('Memory');
INSERT INTO category(categoryName) VALUES ('Operating System');
INSERT INTO category(categoryName) VALUES ('Monitor');
INSERT INTO category(categoryName) VALUES ('Case');
INSERT INTO category(categoryName) VALUES ('Power Supply');
INSERT INTO category(categoryName) VALUES ('Keyboards, Speaker, Mice');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('AMD Ryzen 7 800X3D', 1, 'Core Count: 8',470);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('MSI B550 Gaming Gen 3',2,'Memory Max: 128GB',99.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Corsair Vengeance 32 GB',3,'Modules: 2x16GB',90.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Corsair Vengeance RGB 32 GB',3,'Modules: 2x16GB',120.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Corsair Vengeance LPX 16 GB',3,'Modules: 2x8GB',35.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Windows 11 Home OEM',4,'DVD 64-bit',109.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Windows 11 Pro OEM',4,'DVD 64-bit',139.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Windows 11 Pro Retail',4,'USB 64-bit',189.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('MSI G255F',5,'Screen Size: 24.5',109.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sceptre E205W-16003R',5,'Screen Size: 19.5',50.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Montech XR',6,'Black',70.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('NZXT H9 Flow',6,'White',129.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Corsair RM650 (2023)',7,'650W',87.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Corsair RM1000e (2023)',7,'1000W',157.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Logitech K120',8,'Standard',12.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Razor Huntsman V3 Pro',8,'Gaming',199.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Logitech G Pro',8,'Optical',34.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Logitech Z623',8,'42W',116.99);


INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , '304Arnold!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , '304Bobby!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , '304Candace!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , '304Darren!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , '304Beth!');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/a.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/b.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/c.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/d.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/aa.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/e.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/f.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/g.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/h.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/i.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/j.jpg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/k.jpg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/l.jpg' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'img/m.jpg' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/n.jpg' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'img/o.jpg' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/p.jpg' WHERE ProductId = 17;
UPDATE Product SET productImageURL = 'img/q.jpg' WHERE ProductId = 18;