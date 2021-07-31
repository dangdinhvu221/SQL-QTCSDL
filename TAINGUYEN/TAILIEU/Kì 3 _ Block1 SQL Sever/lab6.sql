use QLDA
go
--1.1 Ràng buộc khi thêm mới nhân viên thì mức lương phải lớn hơn 15000, nếu vi phạm thì
--xuất thông báo “luong phải >15000’
IF OBJECT_ID('kt_luongNV_moi') IS NOT NULL
	DROP TRIGGER kt_luongNV_moi
GO
CREATE TRIGGER kt_luongNV_moi ON NHANVIEN
FOR INSERT 
AS
IF(SELECT LUONG FROM inserted) < 15000
	BEGIN
		PRINT('Tien luong toi thieu phai lon hon 15000')
	END
--không thành công
INSERT INTO NHANVIEN
VALUES (N'b', N'b', N'b', N'00', '2002', N'hn', N'Nữ', 7000, N'005', 4,null)
-- thành công
INSERT INTO NHANVIEN
VALUES (N'b', N'b', N'b', N'0042', '2002', N'hn', N'Nữ', 7000000, N'005', 4,null)

SELECT*FROM dbo.NHANVIEN

--1.2 Ràng buộc khi thêm mới nhân viên thì độ tuổi phải nằm trong khoảng 18 <= tuổi <=65.
ALTER TRIGGER kt_tuoiNV1 ON NHANVIEN
FOR INSERT 
AS
DECLARE @AGE INT
SELECT @AGE = (YEAR(GETDATE()) - YEAR(NGSINH)) FROM NHANVIEN
IF(@AGE <18 or @AGE >65)
	BEGIN
		PRINT('Tuoi cua nhan vien phai trong khoang 18-65')
		ROLLBACK TRANSACTION
	END
ELSE 
		PRINT('Ban da ghi thanh cong')
INSERT INTO NHANVIEN
VALUES (N'Kim', N'Thanh', N'Thế', N'046', '2019-02-01', N'291 Hồ Văn Huê, TP HCM', N'Nữ', 7000, N'005', 4)

SELECT * FROM NHANVIEN

--1.3 Ràng buộc khi cập nhật nhân viên thì không được cập nhật những nhân viên ở TP HCM
ALTER TRIGGER kt_khongsua_HCM ON NHANVIEN
FOR UPDATE
AS
IF(SELECT DCHI FROM inserted) LIKE '%HCM%'
	BEGIN
		PRINT('Khong the cap nhat nhan vien o HCM')
		ROLLBACK TRANSACTION
	END
ELSE
		PRINT('OKE LA ')
	UPDATE NHANVIEN SET DCHI = N'221 Nguyễn Văn Cừ,Tp HCM ' WHERE MANV LIKE '005'

--2.1 Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động
--thêm mới nhân viên.
DROP TRIGGER kt_tong_nvnamnu
CREATE TRIGGER kt_tong_nvnamnu ON NHANVIEN
AFTER INSERT
AS
BEGIN
DECLARE @a int,@b int
SELECT @a = COUNT(PHAI) FROM inserted WHERE PHAI = 'Nam'
SELECT @b = COUNT(PHAI) FROM inserted WHERE PHAI = N'Nữ'
PRINT N'Nam: ' + CONVERT(NVARCHAR, @a)
PRINT N'Nữ: ' + CONVERT(NVARCHAR, @b)
END
INSERT INTO NHANVIEN
VALUES (N'Kim', N'Thanh', N'Thế', N'046', '1999-02-01', N'291 Hồ Văn Huê, TP HCM', N'Nữ', 7000, N'005', 4)

--2.2 Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động
--cập nhật phần giới tính nhân viên
CREATE TRIGGER kt_tong_nvnamnu1 ON NHANVIEN
AFTER UPDATE
AS
BEGIN
DECLARE @a int,@b int
SELECT @a = COUNT(PHAI) FROM inserted WHERE PHAI = 'Nam'
SELECT @b = COUNT(PHAI) FROM inserted WHERE PHAI = N'Nữ'
PRINT 'Nam : ' + CONVERT(NVARCHAR, @a)
PRINT N'Nữ: ' + CONVERT(NVARCHAR, @b)
END
--2.3 Hiển thị tổng số lượng đề án mà mỗi nhân viên đã làm khi có hành động xóa trên bảng
--DEAN
SELECT * FROM DEAN
SELECT * FROM PHANCONG
CREATE TRIGGER Xoa_DA ON DEAN
AFTER DELETE
AS
BEGIN
DECLARE @NUM nchar
SELECT @NUM = COUNT(*) FROM deleted
PRINT N'Số lượng đề án = ' + @NUM
END
DELETE FROM DEAN WHERE MADA = '10'
--3.1 Xóa các thân nhân trong bảng thân nhân có liên quan khi thực hiện hành động xóa nhân
--viên trong bảng nhân viên
ALTER TRIGGER Delete_NV_NT ON NHANVIEN
INSTEAD OF DELETE
AS
BEGIN
DELETE FROM THANNHAN WHERE MA_NVIEN IN
(SELECT MA_NVIEN FROM deleted)
DELETE FROM NHANVIEN WHERE MANV IN 
(SELECT MANV FROM deleted)
END

DELETE FROM NHANVIEN WHERE MANV LIKE '017'
--3.2 Khi thêm một nhân viên mới thì tự động phân công cho nhân viên làm đề án có MADA
--là 1
CREATE TRIGGER Insert_NV ON NHANVIEN
INSTEAD OF INSERT
AS
BEGIN