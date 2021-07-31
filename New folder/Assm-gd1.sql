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
	LIKE_Dislike bit  null,
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
--- DELETE FROM dbo.NHATRO

insert into NHATRO values('NT01',40,1600000,N'Cầu Giấy',N'Thoáng mát','2-1-2018','LN01','QH01'),
						('NT02',50,2500000,N'Hà Nội',N'2 tầng ,an ninh tốt','1-1-2018','LN02','QH02'),
						('NT03',60,500000,N'Hà Nội',N'Chung cư mini','1-5-2018','LN03','QH03'),
						('NT04',80,800000,N'Mỹ Đình',N'An ninh tốt','2-6-2018','LN05','QH05'),
						('NT05',100,9000000,N'Hà Nội',N'An ninh tốt','1-4-2018','LN04','QH04')
go
--select * from NHATRO
---

insert into NGUOIDUNG values('ND01',N'Đặng Đình Vũ','Nam','0123456789',N'Xuân Thủy',N'Cầu Giấy','namqp99@gmail.com'),
							('ND02',N'Nguyễn Thị Lan',N'Nữ','0123456789',N'Mỹ Đình 2',N'Nam Từ Liêm','ductq@gmail.com'),
							('ND03',N'Đinh Công Trường',N'Nam','0123456789',N'Đông Quan',N'Thanh Xuân','hangvt@gmail.com'),
							('ND04',N'Nguyễn Văn Đức','Nam','0123456789',N'Xuân Thủy',N'Cầu Giấy','anhqvph@gmail.com'),
							('ND05',N'Nguyễn Minh Tứ','Nam','0123456789',N'Quan Hoa',N'Cầu Giấy','khaiml@gmail.com'),
							('ND06',N'Nguyễn Đức Thịnh','Nam','0123456789',N'Lê Đức Thọ',N'Bắc Từ Liêm','sang@gmail.com')
go
--select * from NGUOIDUNG
--- DELETE FROM dbo.DANHGIA

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

----- truy vấn

--1. Thêm thông tin vào các bảng
-- Tạo ba Stored Procedure (SP) với các tham số đầu vào phù hợp.
--o SP thứ nhất thực hiện chèn dữ liệu vào bảng NGUOIDUNG
IF OBJECT_ID('SP_NGUOIDUNG') IS NOT NULL
	DROP PROC SP_NGUOIDUNG
GO
CREATE PROC SP_NGUOIDUNG 
		@MaND NVARCHAR(25) = NULL,@TenND NVARCHAR(50) = NULL,
		@GioiTinh NVARCHAR(5) = NULL,@DienThoai NVARCHAR(10) = NULL,
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
		END
END
EXEC dbo.SP_NGUOIDUNG @MaND = N'ND09',      -- nvarchar(25)
                      @TenND = N'TesterNew2',     -- nvarchar(50)
                      @GioiTinh = N'Nam',  -- nvarchar(5)
                      @DienThoai = N'0123456789', -- nvarchar(11)
                      @DiaChi_ND = N'Hà nội', -- nvarchar(30)
                      @QuanND = N'Chương Mỹ',    -- nvarchar(30)
                      @Email = N'abcxyz@gmail.com'      -- nvarchar(100) --- Lỗi

EXEC dbo.SP_NGUOIDUNG @MaND = N'ND010',      -- nvarchar(25)
                      @TenND = N'TesterNew3',     -- nvarchar(50)
                      @GioiTinh = N'Nam',  -- nvarchar(5)
                      @DienThoai = N'0123456789', -- nvarchar(11)
                      @DiaChi_ND = N'Hà nội', -- nvarchar(30)
                      @QuanND = N'Chương Mỹ',    -- nvarchar(30)
                      @Email = N'abcxyz@gmail.com'      -- nvarchar(100) --- Lỗi
SELECT*FROM dbo.NGUOIDUNG
--o SP thứ hai thực hiện chèn dữ liệu vào bảng NHATRO
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
--SELECT * FROM NHATRO
--SELECT * FROM QUANHUYEN
EXEC SP_NHATRO 'NT07', 32, 2500000, N'Mễ Trì', N'Sạch Sẽ', '2020-05-12','ND04', 'LN04','QH06'
GO

--o SP thứ ba thực hiện chèn dữ liệu vào bảng DANHGIA
IF OBJECT_ID('SP_DANHGIA') IS NOT NULL
	DROP PROC SP_DANHGIA
GO
CREATE PROC SP_DANHGIA 
@MaND NVARCHAR(25), @MaNT NVARCHAR(25), @Like_Dislike BIT, @NoiDung NVARCHAR(50)
AS
BEGIN
	IF(@MaNT IS NULL) OR (@MaND IS NULL) OR (@Like_Dislike IS NULL) OR (@NoiDung IS NULL)
		BEGIN
			PRINT N'Vui lòng nhập để thông tin'
		END
	ELSE 
		BEGIN
			INSERT INTO DANHGIA
			VALUES(@MaNT,@MaND,@Like_Dislike,@NoiDung)
			PRINT N'Successfully'
		END
END
EXEC dbo.SP_DANHGIA @MaND = N'ND09',   -- nvarchar(25)
                    @MaNT = N'NT01',   -- nvarchar(25)
                    @Like_Dislike = 'true',  -- bit
                    @NoiDung = N'okoko' -- nvarchar(50)


SELECT * FROM DANHGIA
GO

--Yêu cầu đối với các SP: Trong mỗi SP phải kiểm tra giá trị các tham số đầu vào. Với
--các cột không chấp nhận thuộc tính NULL, nếu các tham số đầu vào tương ứng với
--chúng không được truyền giá trị, thì không thực hiện câu lệnh chèn mà in một thông báo
--yêu cầu người dùng nhập liệu đầy đủ.
-- Với mỗi SP, viết hai lời gọi. Trong đó, một lời gọi thực hiện chèn thành công dữ liệu,
--và một lời gọi trả về thông báo lỗi cho người dùng.
--2. Truy vấn thông tin
--a. Viết một SP với các tham số đầu vào phù hợp. SP thực hiện tìm kiếm thông tin các
--phòng trọ thỏa mãn điều kiện tìm kiếm theo: Quận, phạm vi diện tích, phạm vi ngày đăng
--tin, khoảng giá tiền, loại hình nhà trọ.
--SP này trả về thông tin các phòng trọ, gồm các cột có định dạng sau:
--o Cột thứ nhất: có định dạng ‘Cho thuê phòng trọ tại’ + <Địa chỉ phòng trọ>
--+ <Tên quận/Huyện>
--o Cột thứ hai: Hiển thị diện tích phòng trọ dưới định dạng số theo chuẩn Việt Nam +
--m2. Ví dụ 30,5 m2
--o Cột thứ ba: Hiển thị thông tin giá phòng dưới định dạng số theo định dạng chuẩn
--Việt Nam. Ví dụ 1.700.000
--o Cột thứ tư: Hiển thị thông tin mô tả của phòng trọ
--o Cột thứ năm: Hiển thị ngày đăng tin dưới định dạng chuẩn Việt Nam.
--Ví dụ: 27-02-2012
--o Cột thứ sáu: Hiển thị thông tin người liên hệ dưới định dạng sau:
--▪ Nếu giới tính là Nam. Hiển thị: A. + tên người liên hệ. Ví dụ A. Thắng
--▪ Nếu giới tính là Nữ. Hiển thị: C. + tên người liên hệ. Ví dụ C. Lan
--o Cột thứ bảy: Số điện thoại liên hệ
--o Cột thứ tám: Địa chỉ người liên hệ
-- Viết hai lời gọi cho SP này
IF OBJECT_ID('SP_TIMNT') IS NOT NULL
	DROP PROC SP_TIMNT
GO
CREATE PROC SP_TIMNT
	@MAQH VARCHAR(10), @DTMIN DECIMAL(8,2), @DTMAX DECIMAL(8,2), @NGBD DATETIME, 
	@NGKT DATETIME, @GIAMIN MONEY, @GIAMAX MONEY, @MALN VARCHAR(10)
AS
SELECT DISTINCT N'CHO THUÊ PHÒNG TẠI: ' + nt.Dia_Chi +' '+ TenQH AS DCNT, 
		  REPLACE(CAST(Dien_Tich AS VARCHAR), '.', ',') + 'M2' AS DTICH, 
		  REPLACE(CONVERT(VARCHAR,Gia_Phong,1), ',','.') AS GIAPHONG, 
		  Mo_Ta,
		  CONVERT(NVARCHAR, Ngay_Dang, 105) AS NGAYDT,
		  CASE
			WHEN nd.Gioi_Tinh = 'NAM' THEN 'A.' + nd.Ten_ND
			WHEN nd.Gioi_Tinh = N'NỮ' THEN 'B.' + nd.Ten_ND
			END AS NGUOILH,
		  DT, 
		  nd.Dia_Chi AS DCND

FROM dbo.NHATRO nt 
			JOIN dbo.DANHGIA dg ON dg.MaNT = nt.MaNT
			JOIN dbo.NGUOIDUNG nd ON nd.MaND = dg.MaND
			JOIN dbo.QUANHUYEN qh ON qh.MaQH = nt.MaQH
WHERE qh.MaQH = @MAQH
			AND nt.Dien_Tich BETWEEN @DTMIN AND @DTMAX
			AND nt.Ngay_Dang BETWEEN @NGBD AND @NGKT
			AND nt.Gia_Phong BETWEEN @GIAMIN AND @GIAMAX
			AND nt.MaLN = @MALN
--- GỌI
EXEC dbo.SP_TIMNT @MAQH = 'QH05',                    -- varchar(10)
                  @DTMIN = 10,                 -- decimal(8, 2)
                  @DTMAX = 100,                 -- decimal(8, 2)
                  @NGBD = '01-01-2018', -- datetime
                  @NGKT = '04-04-2018', -- datetime
                  @GIAMIN = 0,                -- money
                  @GIAMAX = 50000000,                -- money
                  @MALN = 'LN05'                     -- varchar(10)
SELECT*FROM dbo.QUANHUYEN
SELECT*FROM dbo.NHATRO
--b. Viết một hàm có các tham số đầu vào tương ứng với tất cả các cột của bảng
--NGUOIDUNG. Hàm này trả về mã người dùng (giá trị của cột khóa chính của bảng
--NGUOIDUNG) thỏa mãn các giá trị được truyền vào tham số.
IF OBJECT_ID('FNND') IS NOT NULL
DROP  FUNCTION FNND
GO
CREATE FUNCTION FNND
(
	@TENND NVARCHAR(20), @GTINH NVARCHAR(5), @DTHOAI VARCHAR(15), 
	@DCHI NVARCHAR(50), @QUAN NVARCHAR(50), @EMAIL VARCHAR(50)
)
RETURNS VARCHAR(10)
BEGIN
	RETURN (SELECT MaND FROM dbo.NGUOIDUNG WHERE Ten_ND = @TENND
			 AND Gioi_Tinh = @GTINH AND DT = @DTHOAI AND Dia_Chi = @DCHI
			 AND Quan = @QUAN AND Email = @EMAIL)
END
--- GỌI
DECLARE @MAND VARCHAR(10)
SET @MAND = dbo.FNND(N'Đặng Đình Vũ','Nam','0123456789',N'Xuân Thủy',N'Cầu Giấy','namqp99@gmail.com');
SELECT @MAND AS MANGDUNG

--6
--COM2034 – Quản trị CSDL với SQL
--Server
--Assignment
--c. Viết một hàm có tham số đầu vào là mã nhà trọ (cột khóa chính của bảng
--NHATRO). Hàm này trả về tổng số LIKE và DISLIKE của nhà trọ này.
SELECT *FROM dbo.DANHGIA
IF OBJECT_ID('FNTKE') IS NOT NULL
	DROP  FUNCTION FNTKE
GO
CREATE FUNCTION FNTKE
(
	@MANTRO VARCHAR(10)
)
RETURNS @THONGKE TABLE ([LIKE] INT, [DISLIKE] INT)
BEGIN
	-- CÂU LỆNH SQL
	--- TỔNG SL NGUOI DANH GIA
	DECLARE @SL INT
	SET @SL = (SELECT COUNT(*) FROM dbo.DANHGIA 
	WHERE MaNT = @MANTRO)

	-- TỔNG SỐ LIKE
	DECLARE @LIKE INT
	SET @LIKE = (SELECT COUNT(*) FROM dbo.DANHGIA 
	WHERE MaNT = @MANTRO AND Like_Dislike = 1)

	-- IN RA
	INSERT @THONGKE
	VALUES
	(   @LIKE, -- LIKE - int
	    @SL - @LIKE  -- DISLIKE - int
	    )
		-- RETURN
		RETURN
END
-- demo
SELECT * FROM dbo.FNTKE('NT01')

--d. Tạo một View lưu thông tin của TOP 10 nhà trọ có số người dùng LIKE nhiều nhất gồm
--các thông tin sau:
-- Diện tích
-- Giá
-- Mô tả
-- Ngày đăng tin
-- Tên người liên hệ
-- Địa chỉ
-- Điện thoại
-- Email
IF OBJECT_ID('top10_W') IS NOT NULL
	DROP VIEW top10_W
GO
CREATE VIEW top10_W
AS
	SELECT TOP 2 Dien_Tich, Gia_Phong, Mo_Ta, Ngay_Dang, Ten_ND, NGUOIDUNG.Dia_Chi, DT, Email,
			COUNT(Like_Dislike) AS SOLIKE
		FROM dbo.NHATRO JOIN dbo.DANHGIA ON DANHGIA.MaNT = NHATRO.MaNT
						JOIN dbo.NGUOIDUNG ON NGUOIDUNG.MaND = DANHGIA.MaND
		WHERE Like_Dislike = 1
		GROUP BY Dien_Tich, Gia_Phong, Mo_Ta, Ngay_Dang, Ten_ND, NGUOIDUNG.Dia_Chi, DT, Email
		ORDER BY SOLIKE DESC
--- gọi
SELECT*FROM top10_W

--e. Viết một Stored Procedure nhận tham số đầu vào là mã nhà trọ (cột khóa chính của
--bảng NHATRO). SP này trả về tập kết quả gồm các thông tin sau:
-- Mã nhà trọ
--- Tên người đánh giá
-- Trạng thái LIKE hay DISLIKE
-- Nội dung đánh giá
IF OBJECT_ID('SP_2E') IS NOT NULL
	DROP PROC SP_2E
GO
CREATE PROC SP_2E
	@MANTR VARCHAR(15)
AS
BEGIN
	IF @MANTR IS NULL
		PRINT N'DỮ LIỆU KHÔNG HỢP LỆ'
	ELSE
		SELECT DISTINCT MaNT, Ten_ND, Like_Dislike, Noi_Dung
		FROM dbo.DANHGIA JOIN dbo.NGUOIDUNG ON NGUOIDUNG.MaND = DANHGIA.MaND
		WHERE MaNT = @MANTR
END
-- THÀNH CÔNG
EXEC dbo.SP_2E @MANTR = 'NT02' -- varchar(15)
-- KHÔNG THÀNH CÔNG
EXEC dbo.SP_2E @MANTR = NULL -- varchar(15)

--3. Xóa thông tin
/*1. Viết một SP nhận một tham số đầu vào kiểu int là số lượng DISLIKE. SP này thực hiện
thao tác xóa thông tin của các nhà trọ và thông tin đánh giá của chúng, nếu tổng số lượng
DISLIKE tương ứng với nhà trọ này lớn hơn giá trị tham số được truyền vào.
Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi một thao tác
xóa thực hiện không thành công.*/
IF OBJECT_ID('SP_XOANT') IS NOT NULL
	DROP PROC SP_XOANT
GO
CREATE PROC SP_XOANT
	@DIS INT
AS
	BEGIN TRY
		BEGIN TRAN
			DECLARE @BANG TABLE (MANT VARCHAR(10), DIS INT)
			INSERT @BANG
				SELECT MANT, COUNT(Like_Dislike) AS SOLIKE FROM dbo.DANHGIA
				WHERE Like_Dislike = 0
				GROUP BY MaNT
				DELETE dbo.DANHGIA
				WHERE MaNT = (SELECT MaNT FROM @BANG
								WHERE DIS > @DIS)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH
	---- THỰC HIỆN VIỆC XOÁ
	EXEC dbo.SP_XOANT @DIS = 1 -- int
	SELECT * FROM dbo.DANHGIA
/*2. Viết một SP nhận hai tham số đầu vào là khoảng thời gian đăng tin. SP này thực hiện
thao tác xóa thông tin những nhà trọ được đăng trong khoảng thời gian được truyền vào
qua các tham số.
Lưu ý: SP cũng phải thực hiện xóa thông tin đánh giá của các nhà trọ này.
Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi một thao tác
xóa thực hiện không thành công.*/
IF OBJECT_ID('SP_XOATT') IS NOT NULL
	DROP PROC SP_XOATT
GO
CREATE PROC SP_XOATT
	@NgayBD DATETIME, @ngayKT DATETIME
AS
BEGIN TRY
	BEGIN TRAN
		-- Xoá khoá ngoại FK
		DELETE dbo.DANHGIA
		WHERE MaNT IN (SELECT MaNT FROM dbo.NHATRO
						WHERE Ngay_Dang BETWEEN @NgayBD AND @ngayKT)
		-- Xoá khoá chính FK
		DELETE dbo.NHATRO
		WHERE Ngay_Dang BETWEEN @NgayBD AND @ngayKT
	COMMIT TRAN
	END TRY
	BEGIN CATCH
	ROLLBACK
	END CATCH
--- GỌI
EXEC dbo.SP_XOATT @NgayBD = '2018-02-01', -- datetime
                  @ngayKT = '2018-04-04'  -- datetime

SELECT *FROM dbo.NHATRO
SELECT*FROM dbo.DANHGIA

--Y4. Yêu cầu quản trị CSDL
--- Tạo hai người dùng CSDL.

/*Một người dùng với vai trò nhà quản trị CSDL. Phân quyền cho người dùng
này chỉ được phép thao tác trên CSDL quản lý nhà trọ cho thuê và có toàn
quyền thao tác trên CSDL đó*/

/*o Một người dùng thông thường. Phân cho người dùng này toàn bộ quyền thao
tác trên các bảng của CSDL và quyền thực thi các SP và các hàm được tạo ra từ
các yêu cầu trên*/

-- Kết nối tới Server bằng tài khoản của người dùng thứ nhất. Thực hiện tạo một bản sao CSDL.