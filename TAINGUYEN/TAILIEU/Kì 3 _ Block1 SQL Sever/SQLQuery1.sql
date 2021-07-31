use QLDA
go
/*Tinh dien tich hinh chu nhat voi tham so a,b nhap vao */
create procedure sp_dienTich_chuvi_HCN
@dai float, @rong float
as
begin
	declare @dientich float,@chuvi float;
	set @chuvi = (@dai+@rong)*2;
	set @dientich = @dai * @rong;
	print N'Chu vi hình chữ nhật là: '+ cast(@chuvi as varchar);
	print N'Diện tích hình chữ nhật là: '+ cast(@dientich as varchar);
end
--Dịch chương trình: Chọn các dòng của thủ tục, bấm phím F5 hoặc bấm nút Execute
--Chạy chương trình : EXEC Tên thủ tục Danh_sách_đối_số
exec sp_dienTich_chuvi_HCN 10,20

/*Tinh dien tich hinh chu nhat voi tham so a,b nhap vao va dau ra */
create procedure sp_DT_CV_HCN1
@dai float, @rong float ,@dientich float out,@chuvi float out
as
begin
	set @chuvi = (@dai+@rong)*2;
	set @dientich = @dai * @rong;
end
--Dịch chương trình: Chọn các dòng của thủ tục, bấm phím F5 hoặc bấm nút Execute
--Chạy chương trình : EXEC Tên thủ tục Danh_sách_đối_số
declare @dt float,@cv float
exec sp_DT_CV_HCN1 15,40,@dt out,@cv out
print cast(@dt as char)
print @cv

--Thủ tục có giá trị trả về----
create proc sp_proc_trave
@a int,@b int
as
begin
	declare @s int
	set @s = @a + @b;
	return @s;
end
declare @s1 int
exec @s1 = sp_proc_trave 100,200
print @s1
-- In ra danh sách nhân viên với tham số đầu vào là mã nhân viên
drop proc sp_danhsach_manhanvien
create proc sp_danhsach_manhanvien
@manv Nvarchar(15)
as
begin
	select * from NHANVIEN where MANV = @manv
end
exec sp_danhsach_manhanvien '003'

--Viết store nhận vào tham số là năm sinh, xuất ra tên các nhân viên
create proc sp_danhsach_manhanvien
@namsinh int
as
begin
	select TENNV from NHANVIEN where YEAR(NGSINH) = @namsinh
end
exec sp_danhsach_manhanvien 1967

----------------------
alter proc sp_danhsach_manhanvien
@manv int
as
begin
	select COUNT(MA_NVIEN) as 'so luong' from THANNHAN where MA_NVIEN = @manv
end
exec sp_danhsach_manhanvien 001

-------------------
alter proc sp_nhanvien_thannhan 
@manv int
AS
BEGIN
	SELECT nv. TENNV as N'Họ và tên', 
	COUNT (MA_NVIEN) as N'Số lượng thân nhân'
	FROM NHANVIEN as nv inner join THANNHAN as tn 
	ON nv.MANV = tn.MA_NVIEN 
	WHERE nv.MANV = @manv 
	GROUP BY nv.TENNV
END
EXEC sp_nhanvien_thannhan 005

-----------
--Tìm min max 2 số
Create proc max_min
@a int, @b int
as
begin
	Declare @max int ,@min int
	if @a > @b
		begin
			set @max =@a;
			set @min = @b;
		end
	else
		begin
			set @max = @b;
			set @min = @a;
		end
	print N'Max = ' + convert(char,@max)
	print N'Min = ' + convert(char,@min)
end

exec max_min 150,100
------------------
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
exec sp_tongN 100

