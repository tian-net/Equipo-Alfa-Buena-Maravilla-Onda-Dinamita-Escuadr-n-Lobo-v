USE master;
DROP DATABASE IF EXISTS db_SalesClothes;
GO
CREATE DATABASE db_SalesClothes;
GO
USE db_SalesClothes;
GO
-- Tabla CLIENT
CREATE TABLE Client (
    id INT IDENTITY(1,1) PRIMARY KEY,
    type_document CHAR(3) NOT NULL,
    number_document CHAR(15) NOT NULL,
    names VARCHAR(60) NOT NULL,
    last_name VARCHAR(90) NOT NULL,
    email VARCHAR(80),
    birthdate DATE,
    active BIT NOT NULL DEFAULT 1
);
GO

-- Tabla SELLER
CREATE TABLE Seller (
    id INT IDENTITY(1,1) PRIMARY KEY,
    type_document CHAR(3) NOT NULL,
    number_document CHAR(15) NOT NULL,
    names VARCHAR(60) NOT NULL,
    last_name VARCHAR(90) NOT NULL,
    salary DECIMAL(8,2) NOT NULL,
    cell_phone CHAR(9),
    email VARCHAR(80),
    active BIT NOT NULL DEFAULT 1
);
GO

-- Tabla CLOTHES
CREATE TABLE Clothes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    descriptions VARCHAR(60) NOT NULL,
    brand VARCHAR(60) NOT NULL,
    amount INT NOT NULL,
    size VARCHAR(10),
    price DECIMAL(8,2) NOT NULL,
    active BIT NOT NULL DEFAULT 1
);
GO

-- Tabla SALE
CREATE TABLE Sale (
    id INT IDENTITY(1,1) PRIMARY KEY,
    date_time DATETIME NOT NULL DEFAULT GETDATE(),
    seller_id INT NOT NULL,
    client_id INT NOT NULL,
    active BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Sale_Seller FOREIGN KEY (seller_id) REFERENCES Seller(id),
    CONSTRAINT FK_Sale_Client FOREIGN KEY (client_id) REFERENCES Client(id)
);
GO

-- Tabla SALE_DETAIL
CREATE TABLE Sale_Detail (
    id INT IDENTITY(1,1) PRIMARY KEY,
    sale_id INT NOT NULL,
    clothes_id INT NOT NULL,
    amount INT NOT NULL,
    CONSTRAINT FK_SaleDetail_Sale FOREIGN KEY (sale_id) REFERENCES Sale(id),
    CONSTRAINT FK_SaleDetail_Clothes FOREIGN KEY (clothes_id) REFERENCES Clothes(id)
);
GO

EXEC sp_columns @table_name = "client";
GO
SELECT * FROM INFORMATION_SCHEMA.TABLES;
GO
 
SELECT 
    fk.name AS FK_name,
    tp.name AS ParentTable,
    ref.name AS ReferencedTable,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS ParentColumn,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS ReferencedColumn
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc 
    ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.tables tp 
    ON fk.parent_object_id = tp.object_id
INNER JOIN sys.tables ref 
    ON fk.referenced_object_id = ref.object_id;
GO