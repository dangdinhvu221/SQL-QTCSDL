--Lab5
--1.1
IF OBJECT_ID('xin_chao') IS NOT NULL
	DROP PROCEDURE xin_chao
GO
CREATE PROCEDURE xin_chao
	@ten nvarchar(50)
as
--begin
	--set @ten=CAST(@ten as varchar) 	
	print'Xin chào '+@ten
--end
EXEC  xin_chao N'Vũ đẹp trai';
EXEC dbo.xin_chao N'Đặng Đình Vũ'

--1.2
IF OBJECT_ID('Tong') IS NOT NULL
	DROP PROCEDURE Tong
	go
CREATE PROCEDURE Tong 
@So1 int =3, @So2 int=2
AS 
Begin 
	Declare @Tong int;  
	SET @Tong = @So1 + @So2; 
	Print @Tong;
End 
exec Tong
-- cách 2:
-- Kiểm tra sự tồn tại của bảng
IF OBJECT_ID('Tong') IS NOT NULL
	DROP PROCEDURE Tong
	GO
CREATE PROCEDURE Tong
	@N INT
AS
DECLARE @A INT =1, @tong INT = 0;
WHILE @A <= @N
BEGIN
SELECT @tong += @A
SET @A += 2
END
PRINT N'tổng các số chẵn: ' + CAST(@tong AS VARCHAR(30))
-- gọi
EXEC Tong 10


--1.3
drop proc sp_tongN
create proc sp_tongN
@n int, @i int = 0
as
begin
	Declare @s int = 0;
	while @i < @n
		begin
			set @s += @i;
			set @i = @i+1;
		end
	print N'Sum = '+ convert(varchar, @s)
end
exec sp_tongN 10
--1.4
create proc sp_UC_Max
@a int,@b int
as
begin
	while(@a!=@b)
		if(@a>@b)
			set @a=@a-@b
		else
			set @b=@b-@a
	return @a
end
Declare @c int
exec  @c=sp_UC_Max 124,50
select @c as 'UCLN'	

use QLDA
go
--2.1
ALTER proc sp_danhsach_manhanvien1
@manv INT
as
begin
	select * from NHANVIEN where MANV = @manv
end
exec sp_danhsach_manhanvien 005
SELECT * FROM NHANVIEN
--2.2
drop proc sp_soluong_madean_nhanvien
create proc sp_soluong_madean_nhanvien
@MaDa Nvarchar(15)
as
begin
	select PHANCONG.MADA , DEAN.TENDEAN,COUNT(PHANCONG.MA_NVIEN) as 'Số luong nhân viên'
	from DEAN inner join PHANCONG 
	on DEAN.MADA = PHANCONG.MADA
	where DEAN.MADA= @MaDa
	group by PHANCONG.MADA,DEAN.TENDEAN
end
select * from DEAN
exec sp_soluong_madean_nhanvien 20
--2.3
create proC sp_MANV_DD_DUAN @MADA int, @DD_DUAN nvarchar(25)
as
begin
	select count(MA_NVIEN) as 'slnv' from PHANCONG
	inner join DEAN on PHANCONG.MADA = DEAN.MADA
	where DEAN.MADA = @MADA and DEAN.DDIEM_DA = convert(nvarchar(25), @DD_DUAN)
	
end

exec sp_MANV_DD_DUAN 10, N'Hà Nội'
--2.4
drop proc sp_slnvtp
create proc sp_slnvtp
@MATP varchar(15)
as
begin
	select NHANVIEN.MANV,NHANVIEN.TENNV, NHANVIEN.PHG from NHANVIEN
	inner join PHONGBAN on PHONGBAN.TRPHG = NHANVIEN.MANV
	inner join THANNHAN on THANNHAN.MA_NVIEN = NHANVIEN.MANV
	where PHONGBAN.TRPHG = 006
	group by NHANVIEN.MANV, NHANVIEN.TENNV, NHANVIEN.PHG
	having count(THANNHAN.MA_NVIEN) = 0
end
exec sp_slnvtp '005'
select * from NHANVIEN
select * from PHONGBAN
--2.5
drop proc sp_kiemtra
create proc sp_kiemtra @MANV int, @MAPHG int
as
--if exists(select * from NHANVIEN where PHG = @MAPHG and MANV = @MANV)
IF @manv NOT IN (SELECT MANV FROM dbo.NHANVIEN WHERE PHG = @MAPHG)
PRINT N'Mã nhân viên: ' + CAST(@manv AS varchar) + 
N'Ko thuộc: ' + CAST(@MAPHG AS VARCHAR)
else 
begin
	print N'Không thuộc'
end
exec sp_kiemtra 001, 5

--3.1
drop proc sp_thempb
create proc sp_thempb
@TENPHG nvarchar(25), @MAPHG int, @TRPHG int, @NG_NHANCHUC date
as
	if exists(select * from NHANVIEN where PHG = @MAPHG)
begin
	print N'Thêm thất bại'
end
else 
begin
	insert into PHONGBAN
	values(@TENPHG,@MAPHG,@TRPHG,@NG_NHANCHUC)
end
exec sp_thempb 'CNTT', 1, 001, '1990-08-23' 

--3.2
IF OBJECT_ID('sp_update') IS NOT NULL
drop proc sp_update
go
create proc sp_update 
	@TENPHG nvarchar(25)
as
	if exists(select * from PHONGBAN where TENPHG = @TENPHG)
begin
	update PHONGBAN
	set TENPHG = @TENPHG
	where TENPHG = 'IT'
end
	else
begin
	print N'Không có phòng ban nào tên IT'
end

EXEC dbo.sp_update @TENPHG = N'CNTT' -- nvarchar(25)


SELECT * FROM dbo.PHONGBAN
