CREATE DATABASE Vudd
GO
USE Vudd
GO

if OBJECT_ID('KHACHHANG') IS NOT NULL
	DROP TABLE KHACHHANG
GO

CREATE TABLE KHACHHANG
(
	 MAKH VARCHAR(10) NOT NULL,
	 TENKH NVARCHAR(30) ,
	 DIACHI NVARCHAR(50) ,
	 DIENTHOAI VARCHAR(15),
	 GIOITINH NVARCHAR(5),
	 CONSTRAINT PK_KHACHHANG PRIMARY KEY(MAKH)

)
GO

if OBJECT_ID('CONGTO') IS NOT NULL
	DROP TABLE CONGTO
GO
CREATE TABLE CONGTO
(
	MACT VARCHAR(10) NOT NULL,
	TENCT NVARCHAR(30),
	SODIENSD INT, 
	MUCGIA MONEY, 
	MAKH VARCHAR(10) NOT NULL,
	CONSTRAINT PK_CONGTO PRIMARY KEY (MACT),
	CONSTRAINT FK_CONGTO_KHACHHANG FOREIGN KEY(MAKH) REFERENCES KHACHHANG
)

--- c2:
if OBJECT_ID('SPKH') IS NOT NULL
	DROP PROC SPKH
GO

CREATE PROC SPKH
	@MAKH VARCHAR(10),
	 @TENKH NVARCHAR(30) ,
	 @DIACHI NVARCHAR(50) ,
	 @DIENTHOAI VARCHAR(15),
	 @GIOITINH NVARCHAR(5)
AS 
	IF @MAKH is null or
	 @TENKH is null or
	 @DIACHI is null or
	 @DIENTHOAI is null or
	 @GIOITINH is null
	 print N'DỮ LIỆU KHÔNG HỢP LỆ'
	 ELSE 
	 INSERT INTO KHACHHANG VALUES(@MAKH ,@TENKH, @DIACHI, @DIENTHOAI , @GIOITINH )
	 print N'THÊM THÀNH CÔNG'

	 -------------GỌI----------
EXEC dbo.SPKH @MAKH = 'KH01',      -- varchar(10)
              @TENKH = N'ĐẶNG ĐÌNH VŨ',    -- nvarchar(30)
              @DIACHI = N'HÀ NỘI',   -- nvarchar(50)
              @DIENTHOAI = '0123456789', -- varchar(15)
              @GIOITINH = N'NAM'  -- nvarchar(5)

EXEC dbo.SPKH @MAKH = 'KH02',      -- varchar(10)
              @TENKH = N'ĐẶNG ĐÌNH VŨ1',    -- nvarchar(30)
              @DIACHI = N'HÀ NỘI',   -- nvarchar(50)
              @DIENTHOAI = '0123456789', -- varchar(15)
              @GIOITINH = N'NAM'  -- nvarchar(5)


if OBJECT_ID('SPCT') IS NOT NULL
	DROP PROC SPCT
GO

CREATE PROC SPCT
	@MACT VARCHAR(10),
	@TENCT NVARCHAR(30),
	@SODIENSD INT, 
	@MUCGIA MONEY, 
	@MAKH VARCHAR(10)
as 
	if @MACT is null or
	@TENCT is null or
	@SODIENSD is null or 
	@MUCGIA is null or 
	@MAKH is null 
	print N'DỮ LIỆU KHÔNG HỢP LỆ'
	 ELSE 
	 INSERT INTO CONGTO values (@MACT ,@TENCT ,@SODIENSD ,@MUCGIA ,@MAKH )
	 print N'THÊM THÀNH CÔNG'
	---------GỌI--------
EXEC dbo.SPCT @MACT = 'CT01',     -- varchar(10)
              @TENCT = N'VŨ',   -- nvarchar(30)
              @SODIENSD =120,  -- int
              @MUCGIA = 454, -- money
              @MAKH = 'KH01'      -- varchar(10)

EXEC dbo.SPCT @MACT = 'CT02',     -- varchar(10)
              @TENCT = N'VŨ2',   -- nvarchar(30)
              @SODIENSD =120,  -- int
              @MUCGIA = 454, -- money
              @MAKH = 'KH02'      -- varchar(10)


-- c3:
IF OBJECT_ID('FNTT') IS NOT NULL
   DROP FUNCTION FNTT
GO
CREATE FUNCTION FNTT
(
   @MAKH VARCHAR(10) 
)
RETURNS INT
AS 
  BEGIN
       RETURN (SELECT SUM(SODIENSD) AS TONGSODIENTT
	   FROM CONGTO JOIN KHACHHANG ON KHACHHANG.MAKH = CONGTO.MAKH
	   WHERE KHACHHANG.MAKH = @MAKH
	   GROUP BY CONGTO.MAKH) 
  END
 ---GỌI
 DECLARE @DTT INT
 SET @DTT = DBO.FNTT('KH01')
 SELECT @DTT AS TONGDTT


-- c4:
if OBJECT_ID('SPBAI4') IS NOT NULL
	DROP PROC SPBAI4
GO
CREATE PROC SPBAI4
	@MAKH VARCHAR(10)

AS
	BEGIN TRY
		BEGIN TRAN
			DELETE FROM CONGTO
			WHERE MAKH IN(SELECT MAKH FROM CONGTO WHERE MAKH = @MAKH)
			print N'XOÁ THÀNH CÔNG'
			DELETE KHACHHANG 
			WHERE MAKH = @MAKH
			print N'XOÁ THÀNH CÔNG'
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH

EXEC SPBAI4 'KH01'

------câu 5------
if OBJECT_ID('SPBAI5') IS NOT NULL
	DROP view SPBAI5
GO
CREATE view SPBAI5
as
	select KHACHHANG.MAKH, TENKH, DIACHI, MACT,SODIENSD, MUCGIA, SODIENSD*MUCGIA AS THANHTIEN,
			IIF(SODIENSD >300, N'Dùng nhiều', N'Dùng vừa đủ') as TRANGTHAI
	from KHACHHANG JOIN CONGTO ON KHACHHANG.MAKH = CONGTO.MAKH
GO
select*from SPBAI5