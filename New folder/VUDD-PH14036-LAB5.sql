USE QLDA
GO
-- bai3:
IF OBJECT_ID('UCLN') IS NOT NULL
	DROP PROCEDURE UCLN
GO
CREATE PROCEDURE UCLN
	@A INT, @B INT
AS
BEGIN
	WHILE (@A != @B)
		IF(@A > @B)
		SET @A -= @B
		ELSE
		SET @B -= @A
		RETURN @A
END
DECLARE @C INT
EXEC @C = dbo.UCLN @A = 124, -- int
                   @B = 50  -- int
SELECT @C AS UCLN


-- BAI4:
IF OBJECT_ID('BAI4') IS NOT NULL
	DROP PROCEDURE BAI4
GO
CREATE PROCEDURE BAI4
	@TENPHG VARCHAR(30)
AS
		BEGIN
			UPDATE dbo.PHONGBAN
			SET TENPHG = @TENPHG
			WHERE TENPHG LIKE 'CNTT'
		END
EXEC dbo.BAI4 @TENPHG = IT -- varchar(30)


-- BAI1:
IF OBJECT_ID('BAI1') IS NOT NULL
	DROP PROCEDURE BAI1
GO
CREATE PROCEDURE BAI1
	@MADA INT, @STT INT, @TEN_CONG_VIEC NVARCHAR(50)
AS
	BEGIN TRY
		IF (@MADA IS NULL)OR(@STT IS NULL)OR(@TEN_CONG_VIEC IS NULL)
		BEGIN
			PRINT N'NULL KHOÁ CHÍNH, KHOÁ NGOẠI'
		END;

		ELSE
		BEGIN
		INSERT INTO dbo.CONGVIEC
		VALUES(@MADA, @STT, @TEN_CONG_VIEC)
			PRINT 'THÊM THÀNH CÔNG'
		END
	END TRY

	BEGIN CATCH
		PRINT N'LỖI!!!!'
	END CATCH

EXEC dbo.BAI1 @MADA = NULL,           -- int
              @STT = 4,            -- int
              @TEN_CONG_VIEC = N'THÊM DỮ LIỆU MỚI' -- nvarchar(50) -- LỖI DỮ LIỆU

			-- @MADA = 1,           -- int
            -- @STT = 5,            -- int
            -- @TEN_CONG_VIEC = N'ỨNG DỤNG PHẦN MỀM' -- nvarchar(50) -- THÊM THÀNH CÔNG

--SELECT * FROM dbo.CONGVIEC

-- BAI2:
IF OBJECT_ID('SPBai_2') IS NOT NULL
    DROP PROC SPBai_2;
GO
CREATE PROC SPBai_2 @MaDa INT
AS
BEGIN
	DECLARE @MD INT = 3
	SELECT *
    FROM dbo.CONGVIEC
    WHERE MADA = @MD
	END

BEGIN
    SELECT *
    FROM dbo.CONGVIEC
    WHERE MADA = @MaDa
	END

EXEC dbo.SPBai_2 @MaDa = 2