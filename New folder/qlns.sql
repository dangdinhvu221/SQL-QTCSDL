CREATE DATABASE QLNS
GO
USE QLNS
GO

IF OBJECT_ID('PHONGBAN') IS NOT NULL
	DROP TABLE PHONGBAN
GO
CREATE TABLE PHONGBAN
(
	MAPB VARCHAR(15) NOT NULL PRIMARY KEY, 
	TENPB NVARCHAR(30) NOT NULL,
)
GO

IF OBJECT_ID('NHANVIEN') IS NOT NULL
	DROP TABLE NHANVIEN
GO
CREATE TABLE NHANVIEN
(
	MANV VARCHAR(15) NOT NULL,
	HOTEN NVARCHAR(50) NULL,
	GIOITINH NVARCHAR(5) NULL,
	LUONG FLOAT NULL CHECK (LUONG > 0),
	MAPB VARCHAR(15) NOT NULL,
	CONSTRAINT PK_NV PRIMARY KEY(MANV),
	CONSTRAINT FK_NV_PB FOREIGN KEY(MAPB) REFERENCES dbo.PHONGBAN
)
GO

IF OBJECT_ID('CHAMCONG') IS NOT NULL
	DROP TABLE CHAMCONG
GO
CREATE TABLE CHAMCONG
(
	MACONG VARCHAR(15) NOT NULL,
	MANV VARCHAR(15) NOT NULL,
	THANG INT NULL CHECK (THANG > 0),
	SONGAYLV INT NULL CHECK (SONGAYLV >0),
	NGPHEP INT NULL CHECK (NGPHEP > 0),
	NGKPHEP INT NULL CHECK (NGKPHEP > 0),
	CONSTRAINT PK_CC PRIMARY KEY(MACONG),
	CONSTRAINT FK_CC_NV FOREIGN KEY(MANV) REFERENCES dbo.NHANVIEN
)
GO

SELECT*FROM dbo.NHANVIEN
SELECT*FROM dbo.PHONGBAN
SELECT*FROM dbo.CHAMCONG

IF OBJECT_ID('SP_BAI21') IS NOT NULL
	DROP PROCEDURE SP_BAI21
GO
CREATE PROCEDURE SP_BAI21
	@MAPB VARCHAR(15), @TENPB NVARCHAR(30)
AS
INSERT dbo.PHONGBAN

VALUES
(   @MAPB, -- MAPB - varchar(15)
    @TENPB -- TENPB - nvarchar(30)
    )
GO
EXEC dbo.SP_BAI21 @MAPB = 'PB1',  -- varchar(15)
                  @TENPB = N'ĐẶNG ĐÌNH VŨ1' -- nvarchar(30)
EXEC dbo.SP_BAI21 @MAPB = 'PB2',  -- varchar(15)
                  @TENPB = N'ĐẶNG ĐÌNH VŨ2' -- nvarchar(30)
EXEC dbo.SP_BAI21 @MAPB = 'PB3',  -- varchar(15)
                  @TENPB = N'ĐẶNG ĐÌNH VŨ3' -- nvarchar(30)

---C2:
IF OBJECT_ID('SP_BAI2') IS NOT NULL
	DROP PROCEDURE SP_BAI2
GO
CREATE PROCEDURE SP_BAI2
	@MANV VARCHAR(15), @HOTEN NVARCHAR(40), @GIOITINH NVARCHAR(5), @LUONG FLOAT, @MAPB VARCHAR(15)
AS
	IF((@MANV IS NULL) AND (@HOTEN IS NULL) AND (@GIOITINH IS NULL) AND (@LUONG IS NULL) AND (@MAPB IS NULL))
	BEGIN
	    PRINT 'KHÔNG ĐƯỢC ĐỂ NULL';
	END
ELSE
BEGIN
	INSERT dbo.NHANVIEN
			VALUES
			(   @MANV,  -- MANV - varchar(15)
				@HOTEN, -- HOTEN - nvarchar(50)
				@GIOITINH, -- GIOITINH - nvarchar(5)
				@LUONG, -- LUONG - float
				@MAPB   -- MAPB - varchar(15)
				)
	PRINT'THÊM THÀNH CÔNG!!!!'
END
GO

-- GOIJ
EXEC dbo.SP_BAI2 @MANV = 'PH14036',      -- varchar(15)
                 @HOTEN = N'ĐẶNG ĐÌNH VŨ',    -- nvarchar(40)
                 @GIOITINH = N'NAM', -- nvarchar(5)
                 @LUONG = 100000,    -- float
                 @MAPB = 'PB2'       -- varchar(15)
EXEC dbo.SP_BAI2 @MANV = 'PH1403',      -- varchar(15)
                 @HOTEN = N'ĐẶNG ĐÌNH VŨ',    -- nvarchar(40)
                 @GIOITINH = N'NAM', -- nvarchar(5)
                 @LUONG = 100000,    -- float
                 @MAPB = 'PB3'       -- varchar(15)
EXEC dbo.SP_BAI2 @MANV = 'PH140',      -- varchar(15)
                 @HOTEN = N'ĐẶNG ĐÌNH VŨ',    -- nvarchar(40)
                 @GIOITINH = N'NAM', -- nvarchar(5)
                 @LUONG = 100000,    -- float
                 @MAPB = 'PB1'       -- varchar(15)

IF OBJECT_ID('SP_BAI22') IS NOT NULL
	DROP PROCEDURE SP_BAI22
GO
CREATE PROCEDURE SP_BAI22
	@MACONG VARCHAR(15), @MANV VARCHAR(15), @THANG INT, @NGAYLV INT, @NGPHEP INT, @NGKPHEP INT
	AS
	INSERT dbo.CHAMCONG
	VALUES
	(   @MACONG, -- MACONG - varchar(15)
	    @MANV, -- MANV - varchar(15)
	    @THANG,  -- THANG - int
	    @NGAYLV,   -- SONGAYLV - int
		@NGPHEP,
		@NGKPHEP
	    )
GO
EXEC dbo.SP_BAI22 @MACONG = 'MC1', -- varchar(15)
                  @MANV = 'PH14036',   -- varchar(15)
                  @THANG = 1,   -- int
                  @NGAYLV = 12,  -- int
                  @NGPHEP = 0,  -- int
                  @NGKPHEP = 23  -- int
EXEC dbo.SP_BAI22 @MACONG = 'MC2', -- varchar(15)
                  @MANV = 'PH1403',   -- varchar(15)
                  @THANG = 1,   -- int
                  @NGAYLV = 12,  -- int
                  @NGPHEP = 20,  -- int
                  @NGKPHEP = 23  -- int
 EXEC dbo.SP_BAI22 @MACONG = 'MC3', -- varchar(15)
                  @MANV = 'PH140',   -- varchar(15)
                  @THANG = 1,   -- int
                  @NGAYLV = 12,  -- int
                  @NGPHEP = 30,  -- int
                  @NGKPHEP = 23  -- int

---C3:
IF OBJECT_ID('SP_BAI5') IS NOT NULL
	DROP PROCEDURE SP_BAI5
GO
CREATE PROCEDURE SP_BAI5
	@NGPHEP INT
AS
	BEGIN TRY
	    BEGIN TRAN
			DELETE dbo.CHAMCONG
			WHERE NGPHEP IN (SELECT NGPHEP FROM dbo.CHAMCONG WHERE NGPHEP = @NGPHEP)
			DELETE dbo.NHANVIEN
			WHERE MANV IN (SELECT CHAMCONG.MANV FROM dbo.NHANVIEN JOIN dbo.CHAMCONG ON CHAMCONG.MANV = NHANVIEN.MANV
								WHERE NHANVIEN.MANV = CHAMCONG.MANV)
		COMMIT TRAN
		PRINT N' XOÁ THÀNH CÔNG'
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		PRINT N'LỖI!!!!'
	END CATCH
GO
EXEC dbo.SP_BAI5 @NGPHEP = 20 -- int



-- cau 5
IF OBJECT_ID('SPCau5') IS NOT NULL
DROP PROC SPCau5
GO
CREATE PROC SPCau5
@ngayphep INT
AS
BEGIN TRY
	BEGIN TRAN
	DELETE dbo.chamcong
	WHERE MANV IN (SELECT MANV FROM dbo.CHAMCONG WHERE (NGPHEP + NGKPHEP) > @ngayphep)
	DELETE dbo.nhanvien 
	WHERE manv IN (SELECT dbo.nhanvien.manv FROM dbo.chamcong JOIN dbo.nhanvien ON nhanvien.manv = chamcong.manv 
	WHERE nhanvien.manv =  chamcong.manv)
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRAN
END CATCH

EXEC dbo.SPCau5 @ngayphep = 20 -- int



IF OBJECT_ID ('B5') IS NOT NULL
DROP PROC B5
GO
CREATE PROC B5(@NGPHEP INT)
AS
BEGIN TRY
	--BANG TAM
	DECLARE @TAM TABLE (MA VARCHAR(10))
	INSERT INTO @TAM
	SELECT MANV FROM CHAMCONG WHERE SUM(ngayphep) > @NGPHEP GROUP BY MANV
	BEGIN TRAN
		--KHOA NGOAI
		DELETE CHAMCONG
		WHERE MANV IN (SELECT * FROM @TAM)
		--KHOA CHINH
		DELETE NHANVIEN
		WHERE MANV IN (SELECT * FROM @TAM)
	COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
END CATCH
--
EXEC B5 1

IF OBJECT_ID('Cau51') IS NOT NULL
DROP PROC Cau51
GO
CREATE PROC Cau51
@ngayphep INT
AS
BEGIN TRY
DECLARE @V TABLE
(
	manv VARCHAR(10)
)
INSERT INTO @V
SELECT manv FROM dbo.chamcong WHERE @ngayphep = NGPHEP AND (ngphep + NGKPHEP) > @ngayphep
BEGIN TRAN
DELETE dbo.chamcong
WHERE manv IN (SELECT * FROM @V)
DELETE dbo.nhanvien
WHERE manv IN (SELECT * FROM @V)
COMMIT TRAN
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

EXEC dbo.Cau51 @ngayphep = 20-- int

-- Câu 5:  Viết một SP nhận một tham số đầu vào là số ngày công và tháng, SP này thực hiện thao tác
-- xóa thông tin chấm công và nhân viên tương ứng nếu tổng số ngày phép lớn hơn giá trị tham số đầu vào. (2 điểm)
-- Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi một thao tác xóa thực hiện không thành công.

if (OBJECT_ID('spDeleteChamCong')) is not null
    drop proc spDeleteChamCong
go
create proc spDeleteChamCong(
    @soNgayCong int
) as 
BEGIN try
    begin transaction
        declare @tableTemp table (
            maNV nvarchar(10),
            soNgayCong int
       )
        insert into @tableTemp select N.MANV,sum(NGPHEP) as TongSoNgayCong from CHAMCONG
            inner join NHANVIEN N on N.MANV = CHAMCONG.MANV
        group by N.MANV
        having sum(NGPHEP) > @soNgayCong
        delete from CHAMCONG where MANV in (select MANV from @tableTemp)
        delete from NHANVIEN where MANV in (select MANV from @tableTemp)
        commit
end try
begin catch
    print N'Fail!!'
    rollback
end CATCH

---
EXEC dbo.spDeleteChamCong @soNgayCong = 19 -- int


