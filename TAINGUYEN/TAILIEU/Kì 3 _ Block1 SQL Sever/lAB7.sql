﻿--Lab7
USE QLDA
GO 
--1.1
IF OBJECT_ID('Age_NV') IS NOT NULL
	DROP FUNCTION Age_NV
GO
CREATE FUNCTION Age_NV (@MaNV INT)
RETURNS INT
AS
BEGIN
	RETURN (SELECT DATEDIFF(YEAR, NGSINH, GETDATE()) FROM NHANVIEN WHERE MANV = @MaNV)
END
GO
PRINT 'Tuoi cua nhan vien la: '+ CONVERT(VARCHAR ,dbo.Age_NV(006))
SELECT * FROM NHANVIEN

--1.2
IF OBJECT_ID('fSoLuong_Dean') IS NOT NULL
	DROP FUNCTION fSoLuong_Dean
GO
CREATE FUNCTION fSoLuong_Dean(@MaNV INT)
RETURNS INT
AS
BEGIN
	RETURN(SELECT COUNT(MADA) FROM PHANCONG WHERE MA_NVIEN=@MaNV)
END
GO
--GỌI
PRINT N'Tổng số đề án mà nhân viên đã tham gia là: ' + CONVERT(VARCHAR, dbo.fSoLuong_Dean(004))
GO
--1.3
IF OBJECT_ID('fDem_NV_GT') IS NOT NULL
	DROP FUNCTION fDem_NV_GT
GO
CREATE FUNCTION fDem_NV_GT
(
	@gioiTinh NVARCHAR(5)
)
RETURNS INT 
AS
BEGIN
	RETURN
		(SELECT COUNT(PHAI) FROM NHANVIEN WHERE PHAI = @gioiTinh)
END
--GỌI
PRINT N'Tổng số nhân viên Nam của cơ quan:'+ CAST(dbo.fDem_NV_GT(N'Nam')AS VARCHAR)
PRINT N'Tổng số nhân viên Nữ của cơ quan:'+ CAST(dbo.fDem_NV_GT(N'Nữ')AS VARCHAR)
--1.4
IF OBJECT_ID('fLuong_tb1') IS NOT NULL
	DROP FUNCTION fLuong_tb1
GO
CREATE FUNCTION fLuong_tb1
(
	@tenPhong NVARCHAR(20)
)
RETURNS @HT TABLE (HONV NVARCHAR(30), TENLOT NVARCHAR(30), TENNV NVARCHAR(30))
AS
	BEGIN
	INSERT INTO @HT
	SELECT HONV,TENLOT,TENNV FROM NHANVIEN
		WHERE LUONG > (SELECT AVG(LUONG) FROM NHANVIEN
						INNER JOIN PHONGBAN ON NHANVIEN.PHG=PHONGBAN.MAPHG
						WHERE PHONGBAN.TENPHG = @tenPhong)
			RETURN
	END
GO
-- GỌI
select*from fLuong_tb1(N'NGHIÊN CỨU')
select * from PHONGBAN
select * from NHANVIEN
select * from DEAN
--1.5
IF OBJECT_ID('PB_TP_DA') IS NOT NULL
	DROP FUNCTION PB_TP_DA
GO
CREATE FUNCTION PB_TP_DA
(
	@maPhong varchar(15)
)
RETURNS @HT TABLE (TENPHG NVARCHAR(30), HOVATEN NVARCHAR(50), SLDA INT)
AS	
BEGIN
	INSERT INTO @HT
		SELECT TENPHG,HONV +' '+ TENLOT+ ' '+ TENNV ,COUNT(DEAN.MADA) 
		FROM NHANVIEN INNER JOIN PHONGBAN ON NHANVIEN.PHG=PHONGBAN.MAPHG
					  INNER JOIN DEAN ON PHONGBAN.MAPHG=DEAN.PHONG
		WHERE NHANVIEN.MANV = (SELECT TRPHG FROM PHONGBAN
							   WHERE MAPHG = @maPhong)
		GROUP BY TENPHG, HONV,TENLOT,TENNV
		RETURN
END	
GO
-- GỌI
SELECT * FROM DBO.PB_TP_DA(4)

--2.1
IF OBJECT_ID('NVPBDA') IS NOT NULL
	DROP VIEW NVPBDA
GO
CREATE VIEW NVPBDA
AS
SELECT HONV, TENNV, PHONGBAN.TENPHG,DIADIEM_PHG.DIADIEM 
FROM NHANVIEN INNER JOIN PHONGBAN ON NHANVIEN.PHG = PHONGBAN.MAPHG
			  INNER JOIN DIADIEM_PHG ON DIADIEM_PHG.MAPHG = PHONGBAN.MAPHG
GO
--gọi
SELECT * FROM NVPBDA
GO
--2.2
IF OBJECT_ID('NV') IS NOT NULL
	DROP VIEW NV
GO
CREATE VIEW NV
AS 
SELECT TENNV, LUONG, YEAR(GETDATE()) - YEAR(NGSINH) AS TUOI FROM NHANVIEN
GO
--gọi
SELECT * FROM NV

--2.3
IF OBJECT_ID('PBNVDN') IS NOT NULL
	DROP VIEW PBNVDN
GO
CREATE VIEW PBNVDN
AS
SELECT  TOP 1 PHONGBAN.TENPHG, HONV + ' ' + TENLOT + ' ' + TENNV AS 'HOTENTRUONGPHG'  
FROM NHANVIEN INNER JOIN PHONGBAN ON PHONGBAN.MAPHG = NHANVIEN.PHG
WHERE MAPHG = (SELECT TOP 1 TRPHG FROM PHONGBAN
					INNER JOIN NHANVIEN ON PHONGBAN.MAPHG = NHANVIEN.PHG
					GROUP BY  TRPHG
					ORDER BY COUNT(MANV) DESC
				)
GO
-- GỌI
SELECT * FROM PBNVDN

SELECT*FROM dbo.PHONGBAN
SELECT*FROM dbo.NHANVIEN