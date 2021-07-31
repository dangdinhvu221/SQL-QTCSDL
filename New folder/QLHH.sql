CREATE DATABASE QLHH
GO
USE QLHH
GO

IF OBJECT_ID('KHACHHANG') IS NOT NULL
	DROP TABLE KHACHHANG
GO
CREATE TABLE KHACHHANG
(
	MAKH VARCHAR(10) NOT NULL PRIMARY KEY(MAKH),
	TENKH NVARCHAR(30) NULL,
	DCHI NVARCHAR(50),
	DTHOAI VARCHAR(11),
	GIOITINH NVARCHAR(5),
)
GO

IF OBJECT_ID('MATHANG') IS NOT NULL
	DROP TABLE MATHANG
GO
CREATE TABLE MATHANG
(
	MAMH VARCHAR(10) NOT NULL PRIMARY KEY(MAMH),
	TENMH NVARCHAR(30),
	DONGIA MONEY
)
GO

IF OBJECT_ID('DONDH') IS NOT NULL
	DROP TABLE DONDH
GO
CREATE TABLE DONDH
(
	MAKH VARCHAR(10) NOT NULL ,
	MAMH VARCHAR(10) NOT NULL,
	NGAYDH DATETIME,
	NGAYGH DATETIME,
	SOLUONG INT,
	CONSTRAINT PK_DDH PRIMARY KEY(MAKH,MAMH),
	CONSTRAINT FK_DDH_KH FOREIGN KEY(MAKH) REFERENCES dbo.KHACHHANG,
	CONSTRAINT FK_MTH_KH FOREIGN KEY(MAMH) REFERENCES dbo.MATHANG
)
GO

--c2
IF OBJECT_ID('SPBai2_1') IS NOT NULL
DROP PROC SPBai2_1
GO
CREATE PROC SPBai2_1
@makh VARCHAR(10),
@tenkh NVARCHAR(50),
@diachi NVARCHAR(50),
@dienthoai VARCHAR(15),
@gioitinh NVARCHAR(5)
AS
IF(@makh IS NULL OR @tenkh IS NULL OR @diachi IS NULL OR @dienthoai IS NULL OR @gioitinh IS NULL)
BEGIN
    PRINT N'Thieu Thong Tin'
END
ELSE
BEGIN
    INSERT INTO dbo.khachhang
    VALUES
    (   @makh,  -- makh - varchar(10)
       @tenkh, -- tenkh - nvarchar(50)
        @diachi, -- diachia - nvarchar(50)
        @dienthoai,  -- dienthoai - varchar(15)
        @gioitinh  -- gioitinh - nvarchar(5)
        )
		PRINT N'Thanh Cong'
END
GO
EXEC dbo.SPBai2_1 @makh = 'vuddph14036',      -- varchar(10)
                  @tenkh = N'ĐẶNG ĐÌNH VŨ',    -- nvarchar(50)
                  @diachi = N'Hà Nội',   -- nvarchar(50)
                  @dienthoai = '0123456789', -- varchar(15)
                  @gioitinh = N'Nam'  -- nvarchar(5)

				  EXEC dbo.SPBai2_1 @makh = 'KH02',      -- varchar(10)
                  @tenkh = N'ĐẶNG ĐINH VŨ1',    -- nvarchar(50)
                  @diachi = N'Hà Nội',   -- nvarchar(50)
                  @dienthoai = '0123457899', -- varchar(15)
                  @gioitinh = N'Nam'

				  EXEC dbo.SPBai2_1 @makh = 'KH03',      -- varchar(10)
                  @tenkh = N'ĐẶNG ĐINH VŨ2',    -- nvarchar(50)
                  @diachi = N'Hà Nội',   -- nvarchar(50)
                  @dienthoai = '0332429178', -- varchar(15)
                  @gioitinh = N'Nam'

				  EXEC dbo.SPBai2_1 @makh = 'KH04',      -- varchar(10)
                  @tenkh = N'ĐẶNG ĐINH VŨ3',    -- nvarchar(50)
                  @diachi = N'Hà Nội',   -- nvarchar(50)
                  @dienthoai = '0332429178', -- varchar(15)
                  @gioitinh = N'Nam'


IF OBJECT_ID('SPBai2_2') IS NOT NULL
DROP PROC SPBai2_2
GO 
CREATE PROC SPBai2_2
@mamh VARCHAR(10),
@tenmh NVARCHAR(50),
@dongia MONEY
AS
IF(@mamh IS NULL OR @tenmh IS NULL OR @dongia IS NULL)
BEGIN
    PRINT N'Thieu Thong Tin'
END
ELSE
BEGIN
    INSERT INTO dbo.mathang
    VALUES
    (   @mamh,  -- mamh - varchar(10)
        @tenmh, -- tenmh - nvarchar(50)
        @dongia -- dongia - money
        )
		PRINT N'Thanh Cong'
END
GO
EXEC dbo.SPBai2_2 @mamh = 'MH02',    -- varchar(10)
                  @tenmh = N'ĐƯỢC',  -- nvarchar(50)
                  @dongia = 1000 -- money

EXEC dbo.SPBai2_2 @mamh = 'MH03',    -- varchar(10)
                  @tenmh = N'ĐƯỢC',  -- nvarchar(50)
                  @dongia = 2000 -- money

EXEC dbo.SPBai2_2 @mamh = 'MH04',    -- varchar(10)
                  @tenmh = N'ĐƯỢC',  -- nvarchar(50)
                  @dongia = 100 -- money


IF OBJECT_ID('SPBai2_3') IS NOT NULL
DROP PROC SPBai2_3
GO 
CREATE PROC SPBai2_3
@mamh VARCHAR(10),
@makh VARCHAR(10),
@ngaydh DATETIME,
@ngaygh DATETIME,
@soluong INT
AS
IF(@mamh IS NULL OR @makh IS NULL OR @ngaydh IS NULL OR @ngaygh IS NULL OR @soluong IS NULL)
BEGIN
    PRINT N'Thanh Cong'
END
ELSE
BEGIN
    INSERT INTO dbo.dondh

    VALUES
    (   @mamh,        -- mamh - varchar(10)
        @makh,        -- makh - varchar(10)
        @ngaydh, -- ngadh - datetime
        @ngaygh, -- ngaygh - datetime
        @soluong          -- soluong - int
        )
END
GO

EXEC dbo.SPBai2_3 @mamh = 'MH02',                      -- varchar(10)
                  @makh = 'KH02',                      -- varchar(10)
                  @ngaydh = '2021-06-16 00:46:57', -- datetime
                  @ngaygh = '2021-06-22 00:46:57', -- datetime
                  @soluong = 12

EXEC dbo.SPBai2_3 @mamh = 'MH03',                      -- varchar(10)
                  @makh = 'KH03',                      -- varchar(10)
                  @ngaydh = '2021-06-16 00:46:57', -- datetime
                  @ngaygh = '2021-06-22 00:46:57', -- datetime
                  @soluong = 2

EXEC dbo.SPBai2_3 @mamh = 'MH04',                      -- varchar(10)
                  @makh = 'KH04',                      -- varchar(10)
                  @ngaydh = '2021-06-16 00:46:57', -- datetime
                  @ngaygh = '2021-06-22 00:46:57', -- datetime
                  @soluong = 1


SELECT*FROM dbo.DONDH
SELECT*FROM dbo.KHACHHANG
SELECT*FROM dbo.MATHANG

--- C3:
SELECT*FROM dbo.KHACHHANG
IF OBJECT_ID('SP_BAI3') IS NOT NULL
	DROP FUNCTION SP_BAI3
GO
CREATE FUNCTION SP_BAI3
	(@MAKH VARCHAR(10), @TENKH NVARCHAR(30), @DCHI NVARCHAR(50), @DTHOAI VARCHAR(11), @GIOITINH NVARCHAR(5))
RETURNS VARCHAR(10)
AS
	BEGIN
	    RETURN (SELECT MAKH
		FROM dbo.KHACHHANG
		WHERE MAKH = @MAKH AND TENKH = @TENKH AND DCHI = @DCHI 
		AND DTHOAI = @DTHOAI AND GIOITINH = @GIOITINH
		)
	END
GO
--GOIJ
DECLARE @HT VARCHAR(10)
SET @HT = dbo.SP_BAI3('vuddph14036', N'ĐẶNG ĐÌNH VŨ', N'HÀ NỘI', '0123456789', N'NAM');
SELECT @HT AS N'HIỂN THỊ'

--- C4:
IF OBJECT_ID('SP_BAI4') IS NOT NULL
	DROP VIEW SP_BAI4
GO
CREATE VIEW SP_BAI41
AS
	SELECT TOP 2 TENKH, TENMH, NGAYDH, NGAYGH, SOLUONG, DONGIA, (SOLUONG*DONGIA) AS THANHTIEN
	FROM dbo.DONDH JOIN dbo.MATHANG ON MATHANG.MAMH = DONDH.MAMH
					JOIN dbo.KHACHHANG ON KHACHHANG.MAKH = DONDH.MAKH
	ORDER BY THANHTIEN DESC
GO
SELECT*FROM dbo.SP_BAI4

-- C5;
IF OBJECT_ID('SP_BAI5') IS NOT NULL
	DROP PROC SP_BAI5
GO
CREATE PROC SP_BAI5
	@MAMH VARCHAR(10)
AS
	BEGIN TRY
		BEGIN TRAN
			DELETE FROM dbo.DONDH
				WHERE MAMH IN (SELECT MAMH FROM dbo.DONDH WHERE MAMH = @MAMH)
				PRINT 'XOÁ THÀNH CÔNG!!!'
			DELETE FROM dbo.MATHANG
				WHERE MAMH IN (SELECT MAMH FROM dbo.MATHANG WHERE MAMH = @MAMH)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		PRINT 'XOÁ KO THÀNH CÔNG';
	END CATCH
--GỌI
EXEC dbo.SP_BAI5 @MAMH = 'MH02' -- varchar(10)
