USE QLDA
GO

--- Câu 1:
SELECT MANV, TENNV, PHAI AS gioiTinh, NGSINH, DATEDIFF(YEAR, NGSINH, GETDATE()) AS Tuoi,
	IIF(PHAI = N'Nam', 'Mr.' + TENNV,'Ms.'+ TENNV) AS TenNV,
	'Trạng Thái' = CASE
	WHEN DATEDIFF(YEAR, NGSINH, GETDATE()) < 18 THEN N'Trẻ em.'
	WHEN DATEDIFF(YEAR, NGSINH, GETDATE()) < 60 THEN N'Lao động.'
	ELSE N'Tuổi già.'
	END
FROM dbo.NHANVIEN

--- câu 2:
SELECT * FROM dbo.THANNHAN
BEGIN TRY
	INSERT dbo.THANNHAN 
			 VALUES (N'001', N'Lan',  N'Nữ', '1996-03-27',N'Chị gái') -- thêm sai
			--VALUES (N'001', N'Long',  N'Nam', '1996-03-27',N'Anh trai') -- thành công
		PRINT N'Thêm thành công';
END TRY

BEGIN CATCH
	PRINT N'Thêm thất bại!!!';
END CATCH

--- câu 3:
DECLARE @a int, @n INT, @sum int
SET @a = 1
SET @n = 10
SET @sum = 0

WHILE(@a < @n)
BEGIN
	SET @a += 1
	IF(@a % 2 = 0)
	SET @sum += @a
	END
	SELECT @sum AS TongSoChan
