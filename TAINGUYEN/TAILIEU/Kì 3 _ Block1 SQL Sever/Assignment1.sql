create database QLNHATRO_Vudd
Go
use QLNHATRO_Vudd
GO

IF OBJECT_ID('LOAINHA') IS NOT NULL
DROP TABLE dbo.LOAINHA
GO
create table LOAINHA(
	MaLN nvarchar(10) not null,
	Loai_thue nvarchar(20)  null,
	CONSTRAINT PK_LOAINHA_MaLN PRIMARY KEY(MaLN)
)
GO

IF OBJECT_ID('QUANHUYEN') IS NOT NULL
DROP TABLE dbo.QUANHUYEN
GO
create table QUANHUYEN(
	MaQH nvarchar(10) not null,
	TenQH nvarchar(20)  null,
	CONSTRAINT PK_QUANHUYEN_MaQH PRIMARY KEY(MaQH)
)
GO

IF OBJECT_ID('NGUOIDUNG') IS NOT NULL
DROP TABLE dbo.NGUOIDUNG
GO
create table NGUOIDUNG (
	MaND nvarchar(10) not null,
	Ten_ND nvarchar(30)  null,
	Gioi_Tinh nvarchar(10)  null,
	DT nvarchar(13)  null,
	Dia_Chi nvarchar(50)  null,
	Quan nvarchar(20)  null,
	Email nvarchar(30)  null,
	CONSTRAINT PK_NGUOIDUNG_MaND PRIMARY KEY(MaND)
)
GO

IF OBJECT_ID('NHATRO') IS NOT NULL
DROP TABLE dbo.NHATRO
GO
create table NHATRO(
	MaNT nvarchar(10) not null,
	Dien_Tich int  null, 
	Gia_Phong money  null,
	Dia_Chi nvarchar(50)  null,
	Mo_Ta nvarchar(50) null,
	Ngay_Dang datetime  null,
	MaLN nvarchar(10) not null,
	MaQH nvarchar(10) not null,
	CONSTRAINT PK_NHATRO_MaNT PRIMARY KEY(MaNT),
	CONSTRAINT FK_NHATRO_MaLN FOREIGN KEY(MaLN) REFERENCES LOAINHA,
	CONSTRAINT FK_QUANHUYEN_MaQH FOREIGN KEY(MaQH) REFERENCES QUANHUYEN
)
GO

IF OBJECT_ID('DANHGIA') IS NOT NULL
DROP TABLE dbo.DANHGIA
GO
create table DANHGIA(
	MaNT nvarchar(10) not null,
	MaND nvarchar(10) not null,	
	Like_Dislike bit  null,
	Noi_Dung nvarchar(50) ,
	CONSTRAINT PK_DANHGIA_MaNT PRIMARY  KEY(MaNT, MaND),
	CONSTRAINT FK_MANT_DANHGIA FOREIGN KEY(MaNT) REFERENCES dbo.NHATRO,
	CONSTRAINT FK_MAND_DANHGIA FOREIGN KEY(MaND) REFERENCES dbo.NGUOIDUNG
)
GO


insert into LOAINHA values('LN01',N'Chung cư'),
							('LN02',N'Khép kín'),
							('LN03',N'Không khép kín'),
							('LN04',N'Biệt thự'),
							('LN05',N'Chung cư mini')
go
--select * from LOAINHA

---
insert into QUANHUYEN values('QH01',N'Cầu Ciấy'),
							('QH02',N'Thanh Xuân'),
							('QH03',N'Chương Mỹ'),
							('QH04',N'Đống Đa'),
							('QH05',N'Quan Hoa'),
							('QH06',N'Hai Bà Trưng')
go
--select * from QUANHUYEN
---

insert into NHATRO values('NT01',40,1600000,N'Cầu Giấy',N'Thoáng mát','2-1-2018','LN01','QH01'),
						('NT02',50,2500000,N'Hà Nội',N'2 tầng ,an ninh tốt','1-1-2018','LN02','QH02'),
						('NT03',60,500000,N'Hà Nội',N'Chung cư mini','1-5-2018','LN03','QH03'),
						('NT04',80,800000,N'Mỹ Đình',N'An ninh tốt','2-6-2018','LN05','QH05'),
						('NT05',100,9000000,N'Hà Nội',N'An ninh tốt','1-4-2018','LN04','QH04')
go
--select * from NHATRO
---

insert into NGUOIDUNG values('ND01',N'Đặng Đình Vũ','Nam','0123456789',N'Xuân Thủy',N'Cầu Giấy','namqp99@gmail.com'),
							('ND02',N'Nguyễn Thị Lan','Nữ','0123456789',N'Mỹ Đình 2',N'Nam Từ Liêm','ductq@gmail.com'),
							('ND03',N'Đinh Công Trường',N'Nam','0123456789',N'Đông Quan',N'Thanh Xuân','hangvt@gmail.com'),
							('ND04',N'Nguyễn Văn Đức','Nam','0123456789',N'Xuân Thủy',N'Cầu Giấy','anhqvph@gmail.com'),
							('ND05',N'Nguyễn Minh Tứ','Nam','0123456789',N'Quan Hoa',N'Cầu Giấy','khaiml@gmail.com'),
							('ND06',N'Nguyễn Đức Thịnh','Nam','0123456789',N'Lê Đức Thọ',N'Bắc Từ Liêm','sang@gmail.com')
go
--select * from NGUOIDUNG
---

insert into DANHGIA values('NT01','ND01','true',N'Yên tĩnh trong không gian phố cổ sầm uất'),
							('NT03','ND01','false',N'Máy lạnh không dùng được'),
							('NT02','ND02','false',N'Cách âm chưa tốt'),
							('NT05','ND02','false',N'Vòi sen không hoạt động, không thể tắm'),
							('NT01','ND03','true',N'Chất lượng phục vụ rất tốt'),
							('NT04','ND03','true',N'Giường thoải mái. Nhân viên nhiệt tình'),
							('NT04','ND04','true',N'Thoải mái về thời gian'),
							('NT01','ND06','true',N'Đáng giá tiền'),
							('NT01','ND05','false',N'Không có nước nóng')
go
--select * from DANHGIA


--1.1
IF OBJECT_ID('SP_NGUOIDUNG') IS NOT NULL
	DROP PROC SP_NGUOIDUNG
GO
CREATE PROC SP_NGUOIDUNG 
		@MaND NVARCHAR(25) = NULL,@TenND NVARCHAR(50) = NULL,
		@GioiTinh NVARCHAR(5) = NULL,@DienThoai NVARCHAR(11) = NULL,
		@DiaChi_ND NVARCHAR(30) = NULL, @QuanND NVARCHAR(30) = NULL,
		@Email NVARCHAR(100) = NULL
AS
BEGIN
	IF (@MaND IS NULL) OR (@TenND IS NULL) OR (@GioiTinh IS NULL) OR (@DienThoai IS NULL) OR (@DiaChi_ND IS NULL)
	OR (@QuanND IS NULL) OR (@Email IS NULL)
		BEGIN
			PRINT N'Vui lòng điền đầy đủ thông tin';
		END
	ELSE 
		BEGIN
			INSERT INTO NGUOIDUNG
			VALUES(@MaND,@TenND,@GioiTinh,@DienThoai,@DiaChi_ND,@QuanND,@Email)
			PRINT N'Successfully'
		END
END
EXEC dbo.SP_NGUOIDUNG @MaND = N'ND09',      -- nvarchar(25)
                      @TenND = N'TesterNew2',     -- nvarchar(50)
                      @GioiTinh = N'Nam',  -- nvarchar(5)
                      @DienThoai = N'0123456789', -- nvarchar(11)
                      @DiaChi_ND = N'Hà nội', -- nvarchar(30)
                      @QuanND = N'Chương Mỹ',    -- nvarchar(30)
                      @Email = N'abcxyz@gmail.com'      -- nvarchar(100)

--SELECT*FROM NGUOIDUNG
--1.2

IF OBJECT_ID('SP_NHATRO') IS NOT NULL
	DROP PROC SP_NHATRO
GO
CREATE PROC SP_NHATRO 
		@MaNT NVARCHAR(25), @DienTich INT, @GiaPhong MONEY,
		@DiaChi_NT NVARCHAR(50), @Mota NVARCHAR(50), 
		@NgayDang DATE,@MaND NVARCHAR(25),
		@MaLN NVARCHAR(25),@MaQH NVARCHAR(25)
AS 
BEGIN
	IF(@MaNT IS NULL) OR (@DienTich IS NULL) OR (@GiaPhong IS NULL) OR (@DiaChi_NT IS NULL) 
	OR (@Mota IS NULL) OR (@NgayDang IS NULL)OR (@MaND IS NULL) OR (@MaLN IS NULL) OR (@MaQH IS NULL) 
		BEGIN
			PRINT N'Vui lòng nhập đủ thông tin'
		END
	ELSE 
		BEGIN
			INSERT INTO NHATRO
			VALUES(@MaNT,@DienTich,@GiaPhong,@DiaChi_NT,@Mota,@NgayDang,@MaND,@MaLN,@MaQH)
			PRINT N'Successfully'
		END
END
GO
SELECT * FROM NHATRO
SELECT * FROM QUANHUYEN
EXEC SP_NHATRO 'NT07', 32, 2500000, N'Mễ Trì', N'Sạch Sẽ', '2020-05-12','ND04', 'LN04','QH06'
GO
--1.3
IF OBJECT_ID('SP_DANHGIA') IS NOT NULL
	DROP PROC SP_DANHGIA
GO
CREATE PROC SP_DANHGIA 
@MaND NVARCHAR(25), @MaNT NVARCHAR(25), @Like BIT, @NoiDung NVARCHAR(50)
AS
BEGIN
	IF(@MaNT IS NULL) OR (@MaND IS NULL) OR (@Like IS NULL) OR (@NoiDung IS NULL)
		BEGIN
			PRINT N'Vui lòng nhập để thông tin'
		END
	ELSE 
		BEGIN
			INSERT INTO DANHGIA
			VALUES(@MaNT,@MaND,@Like,@NoiDung)
			PRINT N'Successfully'
		END
END
EXEC SP_DANHGIA 'ND03', 'NT04', 'true', 'Thoáng mát, đi lại tự do'
GO
SELECT * FROM DANHGIA
--2.a

--2.b
SELECT * FROM NGUOIDUNG
CREATE FUNCTION FC_NGUOIDUNG (@TenND NVARCHAR(50) = N'%', @GioiTinh NVARCHAR(5) = N'%',
@Dienthoai NVARCHAR(11) = N'%', @DiaChi_ND NVARCHAR(50) = N'%', @QuanND NVARCHAR(30) = N'%', @EMAIL NVARCHAR(100) = N'%')
RETURNS TABLE
AS
		RETURN (SELECT MaND FROM NGUOIDUNG
		WHERE (Ten_ND LIKE @TenND) AND (Gioi_Tinh LIKE @GioiTinh) AND (DT LIKE @Dienthoai) AND
		(Dia_Chi LIKE @QuanND) AND (Email LIKE @EMAIL)
		)
GO
SELECT  * FROM FC_NGUOIDUNG (N'%Nguyễn%',DEFAULT, DEFAULT,DEFAULT,DEFAULT,DEFAULT)
GO
--2.c
--Tong Like
SELECT * FROM DANHGIA
CREATE FUNCTION FC_DANHGIA_LIKE (@MaNT NVARCHAR(25))
RETURNS INT
AS
	BEGIN
		RETURN(
			SELECT COUNT(DANHGIA.Like_Dislike)  AS N'Tổng Like'FROM DANHGIA WHERE MaNT = @MaNT AND Like_Dislike =  1
		)
	END
GO
PRINT N'Số lượng like: ' + CONVERT(VARCHAR,dbo.FC_DANHGIA_LIKE('NT04'))
GO
---tong dislike
CREATE FUNCTION SP_DANHGIA_DISLIKE (@MaNT NVARCHAR(25))
RETURNS INT
AS
	BEGIN
		RETURN(
			SELECT COUNT(DANHGIA.Like_Dislike)  AS N'Tổng Dislike'FROM DANHGIA WHERE MaNT = @MaNT AND Like_Dislike = 0
		)
	END
GO
PRINT N'Số lượng Dislike: ' + CONVERT(VARCHAR,dbo.SP_DANHGIA_DISLIKE('NT02'))
GO
--Chi tiết đánh giá tổng like và dislike về nhà trọ
SELECT * FROM NHATRO
SELECT NHATRO.MaNT AS N'Mã Nhà Trọ', LOAINHA.Loai_thue AS 'Loại Nhà',
	REPLACE(CONVERT(VARCHAR,NHATRO.Dien_Tich,103),'.',',') + ' m2' AS N'Diện Tích', 
	LEFT(CONVERT(VARCHAR,NHATRO.Gia_Phong,1),
	LEN(CONVERT(VARCHAR,NHATRO.Gia_Phong,1)) - 3) AS N'Giá Phòng', NGUOIDUNG.Dia_Chi +', '  + NGUOIDUNG.Quan AS N'Địa Chỉ', dbo.FC_DANHGIA_LIKE(MaNT) AS N'Like', dbo.SP_DANHGIA_DISLIKE(MaNT) AS N'Dislike'
FROM NHATRO INNER JOIN LOAINHA ON LOAINHA.MaLN = NHATRO.MaLN 
			INNER JOIN NGUOIDUNG ON NGUOIDUNG.MaND = NHATRO.MaND
--2.d
SELECT * FROM NGUOIDUNG
DROP VIEW view_Top10
CREATE VIEW view_Top10
AS
SELECT TOP 10 MaNT, LOAINHA.Loai_thue, REPLACE(CONVERT(VARCHAR,NHATRO.Dien_Tich,103),'.',',') + ' m2' AS N'Diện Tích', 
	LEFT(CONVERT(VARCHAR,NHATRO.Gia_Phong,1),
	LEN(CONVERT(VARCHAR,NHATRO.Gia_Phong,1)) - 3) AS N'Giá Phòng', NHATRO.Mo_Ta AS N'Mô Tả', 
	CONVERT(VARCHAR,Ngay_Dang,105) AS N'Ngày Đăng', Ten_ND, NHATRO.Dia_Chi + ', ' +  Quan AS N'DiaChi', DT, Email, dbo.FC_DANHGIA_LIKE(NHATRO.MaNT) AS N'Tổng Like' FROM NHATRO
	INNER JOIN LOAINHA ON LOAINHA.MaLN = NHATRO.MaLN
	INNER JOIN NGUOIDUNG ON NGUOIDUNG.MaND = NHATRO.MaND
ORDER BY N'Tổng Like' DESC
SELECT * FROM view_Top10
GO
--2.e
ALTER PROC SP_DANHGIA_NHATRO (@MaNT NVARCHAR(25))
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM NHATRO WHERE MaNT = @MaNT)
		BEGIN			
			PRINT N'Không tồn tại mã nhà trọ  !!!!'
		END
	ELSE 
		BEGIN
			IF NOT EXISTS(SELECT * FROM DANHGIA WHERE MaNT = @MaNT)
				BEGIN
					PRINT N'Chưa có đánh giá cho mã nhà trọ này !!!'
				END
			ELSE 
				BEGIN
					SELECT DANHGIA.MaNT AS N'Mã Nhà Trọ', NGUOIDUNG.Ten_ND AS N'Tên nhà trọ', 
					CASE DANHGIA.Like_Dislike 
					WHEN 1 THEN 'Like'
					WHEN 0 THEN 'Dislike' END AS N'Đánh Giá',
					DanhGia.Noi_Dung AS N'Nội dung'  
					FROM DANHGIA
					INNER JOIN NGUOIDUNG ON NGUOIDUNG.MaND = DANHGIA.MaND
					WHERE DANHGIA.MaNT = @MaNT
				END
		END
END
GO
EXEC SP_DANHGIA_NHATRO 'NT02'
GO
--3.1
SELECT * FROM NHATRO
ALTER PROC SP_DELETE_DISLIKE (@SoLuong INT )
AS
BEGIN TRY
	BEGIN TRAN
 		DECLARE @Temptable TABLE (MaNT NVARCHAR(25))
		INSERT INTO @Temptable
		SELECT NHATRO.MaNT FROM NHATRO
		WHERE  dbo.SP_DANHGIA_DISLIKE(NHATRO.MaNT) > 0
		DELETE FROM DANHGIA
		WHERE DANHGIA.MaNT IN (SELECT * FROM @Temptable)
		DELETE FROM NHATRO
		WHERE NHATRO.MaNT IN (SELECT * FROM @Temptable)
		PRINT N'Xóa thành công !!!'
	COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN 
	PRINT N'Xóa thất bại!!!'
END CATCH
GO
EXEC SP_DELETE_DISLIKE 0
GO
---3.2
ALTER PROC SP_DELETE_NGAYDANG (@NgayDangMin DATE = NULL, @NgayDangMax DATE = NULL)
AS
BEGIN TRY
	BEGIN TRAN
		IF @NgayDangMin = NULL 
			BEGIN
				SELECT @NgayDangMin = MIN(Ngay_Dang) FROM NHATRO
			END
		IF @NgayDangMax = NULL 
			BEGIN
				SELECT @NgayDangMax = Max(Ngay_Dang) FROM NHATRO
			END
		DECLARE @Temptable TABLE (MaNT NVARCHAR(25))
		INSERT INTO @Temptable
		SELECT NHATRO.MaNT FROM NHATRO
		WHERE  Ngay_Dang BETWEEN @NgayDangMin AND @NgayDangMax
		DELETE FROM DANHGIA
		WHERE DANHGIA.MaNT IN (SELECT * FROM @Temptable)
		DELETE FROM NHATRO
		WHERE NHATRO.MaNT IN (SELECT * FROM @Temptable)
		PRINT N'Xóa thành công !!!'
	COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	PRINT N'Xóa thất bại!!!'
END CATCH
EXEC SP_DELETE_NGAYDANG '2018-06-21','2019-06-21'