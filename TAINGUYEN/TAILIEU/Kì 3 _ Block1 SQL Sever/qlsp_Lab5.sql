
CREATE DATABASE qlsp;
GO

USE qlsp;
GO
select * from san_pham


CREATE TABLE san_pham (
    id int IDENTITY(1, 1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL,
    ma_sp NVARCHAR(10) NOT NULL UNIQUE,
    ngay_nhap DATE NOT NULL,
    so_luong int NOT NULL DEFAULT 0,
);

GO


INSERT INTO san_pham(ten, ma_sp, ngay_nhap, so_luong)
    VALUES
    ('DELL', 'LT1145', '2020-09-14', 100),
    ('VAIO', 'LT1206', '2020-09-14', 57),
    ('OPPO', 'LT1124', '2020-09-14', 46),
    ('SAMSUNG', 'SP1944', '2020-09-14', 89),
    ('IPHONE', 'LT1700', '2020-09-14', 65);

GO