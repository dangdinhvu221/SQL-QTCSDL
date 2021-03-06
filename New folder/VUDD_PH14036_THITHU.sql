create database QLVP
GO
USE QLVP
GO 

IF OBJECT_ID('VANPHONG') IS NOT NULL
	DROP TABLE VANPHONG
GO
CREATE TABLE VANPHONG 
(
	MAVP VARCHAR(10) not null,
	TENVP NVARCHAR(30) null,
	DIENTHOAI VARCHAR(15) null,
	EMAIL NVARCHAR(30) null,
	TRUONGPHONG NVARCHAR(30) null,
	CONSTRAINT PK_VANPHONG PRIMARY KEY(MAVP)
)

IF OBJECT_ID('BDS') IS NOT NULL
	DROP TABLE BDS
GO
CREATE TABLE BDS
(
	MABDS VARCHAR(10) NOT NULL,
	TENBDS NVARCHAR(30) null,
	DIACHI NVARCHAR(50) null,
	MACSH VARCHAR(10) null,
	MAVP VARCHAR(10) NOT NULL,
	CONSTRAINT PK_BDS PRIMARY KEY (MABDS),
	CONSTRAINT FK_BDS_VANPHONG FOREIGN KEY(MAVP) REFERENCES VANPHONG
)
GO


-- truy vana
-- c2:
IF OBJECT_ID('SP_BAI2VP') IS NOT NULL
	DROP PROCEDURE SP_BAI2VP
GO
CREATE PROCEDURE SP_BAI2VP
	@MAVP VARCHAR(10), @TENVP NVARCHAR(30), @DTHOAI VARCHAR(11), @EMAIL VARCHAR(50), @TRUONGPHG VARCHAR(30)

AS
	IF((@MAVP IS NULL) OR (@TENVP IS NULL) OR (@DTHOAI IS NULL) OR (@EMAIL IS NULL) OR (@TRUONGPHG IS NULL))
		BEGIN
			PRINT N'KHONG DUOC DE NULL'
		END
	ELSE
		BEGIN
			INSERT dbo.VANPHONG
				VALUES
				(   @MAVP,   -- MAVP - varchar(10)
					@TENVP, -- TENVP - nvarchar(30)
					@DTHOAI, -- DIENTHOAI - varchar(15)
					@EMAIL, -- EMAIL - nvarchar(30)
					@TRUONGPHG  -- TRUONGPHONG - nvarchar(30)
				)
				PRINT N'THEM THANH CONG';
		END
-- GOI
-- KHONG THANH CONG
EXEC dbo.SP_BAI2VP @MAVP = NULL,     -- varchar(10)
                 @TENVP = NULL,   -- nvarchar(30)
                 @DTHOAI = '0123456789',   -- varchar(11)
                 @EMAIL = 'abc@gmail.com',    -- varchar(50)
                 @TRUONGPHG = 'DV1' -- varchar(30) 

-- THANH CONG
EXEC dbo.SP_BAI2VP @MAVP = 'VP01',     -- varchar(10)
                 @TENVP =  N'ĐẶNG ĐÌNH VŨ',   -- nvarchar(30)
                 @DTHOAI = '0123456789',   -- varchar(11)
                 @EMAIL = 'abc@gmail.com',    -- varchar(50)
                 @TRUONGPHG = 'DV1' -- varchar(30) 
				 
SELECT * FROM dbo.VANPHONG
SELECT*FROM dbo.BDS

IF OBJECT_ID('SP_BAI2BDS') IS NOT NULL
	DROP PROCEDURE SP_BAI2BDS
GO
CREATE PROCEDURE SP_BAI2BDS
	@MABDS VARCHAR(10), @TENBDS NVARCHAR(30), @DCHI NVARCHAR(50), @MACSH VARCHAR(10), @MAVP NVARCHAR(10)
AS
	IF((@MABDS IS NULL) OR (@TENBDS IS NULL) OR (@DCHI IS NULL) OR (@MACSH IS NULL) OR (@MACSH IS NULL))
		BEGIN
			PRINT N'KHONG DUOC DE NULL'
		END
	ELSE
		BEGIN
			INSERT dbo.BDS
			VALUES
			(   @MABDS,   -- MABDS - varchar(10)
			    @TENBDS, -- TENBDS - nvarchar(30)
			    @DCHI, -- DIACHI - nvarchar(50)
			    @MACSH, -- MACSH - varchar(10)
			    @MAVP    -- MAVP - varchar(10)
			    )
				PRINT N'THEM THANH CONG';
		END
-- GOI
-- THÀNH CÔNG
EXEC dbo.SP_BAI2BDS @MABDS = 'BDS01',   -- varchar(10)
                  @TENBDS = N'BẤT ĐỘNG SẢN ', -- nvarchar(30)
                  @DCHI = N'chương mỹ - hà nội',   -- nvarchar(50)
                  @MACSH = N'CSH01',   -- varchar(10)
                  @MAVP = N'VP01'    -- nvarchar(10)

---KO THÀNH CÔNG
EXEC dbo.SP_BAI2BDS @MABDS = NULL,   -- varchar(10)
                  @TENBDS = NULL, -- nvarchar(30)
                  @DCHI = N'v..vv..Ha noi',   -- nvarchar(50)
                  @MACSH = N'CSH01',   -- varchar(10)
                  @MAVP = N'VO02'    -- nvarchar(10)

--- C3:
IF OBJECT_ID('SP_BAI3GH') IS NOT NULL
	DROP FUNCTION SP_BAI3GH
GO
CREATE FUNCTION SP_BAI3GH
(
	@MAVP VARCHAR(10)
)
RETURNS @HT TABLE (MAVP VARCHAR(10), TENVP NVARCHAR(30),TENBDS NVARCHAR(30), DIACHI NVARCHAR(50))
	AS
	BEGIN
		INSERT INTO @HT
			SELECT BDS.MAVP, TENVP, TENBDS, DIACHI 
				FROM BDS JOIN dbo.VANPHONG ON VANPHONG.MAVP = BDS.MAVP
				WHERE BDS.MAVP = @MAVP
				RETURN 
	END
-- GỌI
SELECT * FROM dbo.SP_BAI3GH('VP01')

---C4:
IF OBJECT_ID('BAI4') IS NOT NULL
	DROP PROCEDURE BAI4
GO
CREATE PROCEDURE BAI4
	@MAVP VARCHAR(10)
AS
	BEGIN TRY
		BEGIN TRAN
			DELETE FROM dbo.BDS
				WHERE MAVP = @MAVP

			DELETE FROM dbo.VANPHONG
				WHERE MAVP = @MAVP
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH

-- GỌI
EXEC dbo.BAI4 @MAVP = 'VP01' -- varchar(10)

SELECT*FROM dbo.VANPHONG
SELECT*FROM dbo.BDS

---- c5:
IF OBJECT_ID('BAI5_W') IS NOT NULL
	DROP VIEW BAI5_W
GO
CREATE VIEW BAI5_W
	AS
	SELECT TOP 2 VANPHONG.MAVP, TENBDS, COUNT(MABDS) AS MABDS
	FROM dbo.VANPHONG JOIN dbo.BDS ON BDS.MAVP = VANPHONG.MAVP
	GROUP BY VANPHONG.MAVP, TENBDS
	ORDER BY COUNT(MABDS) DESC
--- GỌI
SELECT * FROM BAI5_W

