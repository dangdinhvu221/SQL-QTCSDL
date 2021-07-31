use QLDA
go
--Lab2
--1
Begin
Declare @DienTich int,@ChuVi int,@ChieuDai int,@Chieurong int
Set @ChieuDai = 10;
Set @Chieurong = 4;
Set	@ChuVi = (@ChieuDai + @Chieurong) * 2;
Set @DienTich = @ChieuDai * @Chieurong;
Select @ChuVi as ChuVi,@DienTich as DienTich;
end

--2
 begin
 Declare @Max_luong float
 Select @Max_luong = max(LUONG)
 From NHANVIEN
 Print 'Nhan vien co luong lon nhat' + Convert(char(12),@Max_luong)
 end

 --3
 begin 
 Declare @Luong_cao table (HoNV Nvarchar(15), DemNV  Nvarchar(15), TenNV  Nvarchar(15), Luong  Nvarchar(15))
 Insert Into @Luong_cao
 Select HoNV, TENLOT, TENNV, LUONG
 From NHANVIEN
 Select HONV,TENLOT,TENNV,LUONG from NHANVIEN
 Where LUONG >= (
	Select AVG(LUONG) From NHANVIEN
	Where PHG = (
		Select MAPHG From PHONGBAN
		Where TENPHG = N'Nghiên Cứu'
	)
 )
 end
 -----------