DROP DATABASE lab56_qlsp;

CREATE DATABASE lab56_qlsp;
GO

USE lab56_qlsp;
GO
select * from san_pham

CREATE TABLE danh_muc (
    id int IDENTITY(1, 1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL
);

GO

CREATE TABLE san_pham (
    id int IDENTITY(1, 1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL,
    ma_sp NVARCHAR(10) NOT NULL UNIQUE,
    ngay_nhap DATE NOT NULL,
    so_luong int NOT NULL DEFAULT 0,
    danh_muc_id int NOT NULL
);

GO

INSERT INTO danh_muc(ten)
    VALUES
    ('Laptop'),
    ('Smart Phone');

GO

INSERT INTO san_pham(ten, ma_sp, ngay_nhap, so_luong, danh_muc_id)
    VALUES
    ('DELL', 'LT1145', '2020-09-14', 100, 1),
    ('VAIO', 'LT1206', '2020-09-14', 57, 1),
    ('OPPO', 'LT1124', '2020-09-14', 46, 2),
    ('SAMSUNG', 'SP1944', '2020-09-14', 89, 1),
    ('IPHONE', 'LT1700', '2020-09-14', 65, 2);

GO