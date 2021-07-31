CREATE DATABASE hunghoang

IF OBJECT_ID('MatHang') IS NOT NULL 
DROP TABLE MatHang 
GO
 CREATE TABLE MatHang
 (
 maMH NVARCHAR(20) NOT NULL,
 tenMH NVARCHAR(20) NULL,
 donGia FLOAT NULL,
 CONSTRAINT pk_MatHang PRIMARY KEY(maMH)
 )
 IF OBJECT_ID('chiTietDonHang') IS NOT NULL 
DROP TABLE chiTietDonHang
GO
 CREATE TABLE chiTietDonHang
 (
 maDH NVARCHAR(20) NOT NULL,
 maMH NVARCHAR(20) NOT NULL,
 soLuong INT,
 CONSTRAINT pk_chiTietDonHang PRIMARY KEY(maDH),
 CONSTRAINT fk_chiTietDonHang FOREIGN KEY(maMH) REFERENCES dbo.MatHang
 )
 --1.
if OBJECT_ID('kt11') is not null
	drop procedure kt11
go
ALTER PROCEDURE kt11
@maMH  nvarchar(20),
     @tenMH  NVARCHAR(20),
   @donGia  FLOAT
   AS
BEGIN
    IF EXISTS(SELECT * FROM dbo.MatHang WHERE maMH=@maMH ) OR @maMH IS NULL
	BEGIN
	    PRINT 'ma khong hop le';
		RETURN;
	END
	ELSE 
	BEGIN
	    INSERT dbo.MatHang
	    VALUES(@maMH,@tenMH,@donGia)
	    PRINT 'chen thanh cong'
	END
END
EXEC dbo.kt11 N'p1', N'banh mi', 234440.0 
EXEC dbo.kt11 N'p3', N'banh gao', 25440.0 
--
if OBJECT_ID('kt12') is not null
	drop procedure kt12
go
CREATE PROCEDURE kt12
@maMH  nvarchar(20),
     @maDH  NVARCHAR(20),
   @soLuong  INT
   AS
BEGIN
    IF EXISTS(SELECT * FROM dbo.chiTietDonHang WHERE maDH=@maDH ) 
	BEGIN
	    PRINT 'ma khong hop le';
		RETURN;
	END
	ELSE 
	BEGIN
	    INSERT INTO dbo.chiTietDonHang 
	    VALUES(@maDH,@maMH,@soLuong)
	    PRINT 'chen thanh cong'
	END
END
 EXEC dbo.kt12 N' p1', N'se', 2
EXEC dbo.kt12 N'a1', N'p3', 25 

--3
if OBJECT_ID('ham1') is not null
	drop function ham1
go
CREATE FUNCTION ham1 (@ma NVARCHAR(20))
RETURNS INT 
AS
BEGIN
    RETURN (SELECT soLuong FROM dbo.chiTietDonHang WHERE maMH=@ma )
END
SELECT dbo.ham1(' a1')
--4
if OBJECT_ID('kt13') is not null
	drop procedure kt13
go
CREATE PROCEDURE kt13
@maMH  nvarchar(20)
  AS
BEGIN
    BEGIN TRY
        begin TRANSACTION
		DELETE FROM dbo.chiTietDonHang WHERE maMH=@maMH
		DELETE FROM dbo.MatHang WHERE maMH=@maMH
        commit TRANSACTION
        PRINT 'thanh cong'
    END TRY
	BEGIN CATCH
	PRINT 'xoa that bai';
	ROLLBACK TRANSACTION;
	END CATCH
END
exec kt13 ' a1'
--5
ALTER PROCEDURE kt14
@maMH  nvarchar(20)
  AS
  BEGIN
      SELECT chiTietDonHang.maMH  ma,tenMH  ten ,SUM(soLuong) ,IIF(SUM(soLuong)>3,'ban chay','khong ban chay') AS trangthai 
	  FROM dbo.MatHang INNER JOIN dbo.chiTietDonHang ON chiTietDonHang.maMH = MatHang.maMH
	  WHERE dbo.chiTietDonHang.maMH=@maMH
	  GROUP BY chiTietDonHang.maMH ,tenMH 

  END
  EXEC kt14 ' p3'
  SELECT * FROM dbo.chiTietDonHang 
SELECT * FROM dbo.MatHang