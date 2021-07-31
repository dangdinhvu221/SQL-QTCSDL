create database qldh

if OBJECT_ID('KhachHang') is not null
	drop table KhachHang
go
create table KhachHang
(
	maKH	nvarchar(9) not null,
	tenKH	nvarchar(20),
	diaChi	nvarchar(50),
	dienThoai	nvarchar(10),
	gioiTinh nvarchar(3),
	constraint pk_KhachHang primary key(maKH)
)

if OBJECT_ID('DonDH') is not null
	drop table DonDH
go
create table DonDH
(
	maDH	nvarchar(9) not null,
	ngayDH	datetime,
	ngayGH	datetime,
	maKH	nvarchar(9) not null,
	constraint pk_DonDH primary key(maDH),
	constraint fk_KhachHang_DonDH foreign key(maKH) references KhachHang
)

select * from KhachHang
insert into KhachHang values('KH1', N'Nguy?n Công Minh', N'Long Biên', '0987654321', N'N?')
insert into KhachHang values('KH2', N'Chu V?n ?ài', N'Hà Tây', '0983217654', N'Nam')
insert into KhachHang values('KH3', N'Lê Ng?c Minh', N'Hà Nam', '0954387621', N'Nam')

select * from DonDH
insert into DonDH values('DH1', '2021-02-12', '2021-02-20', 'KH2')
insert into DonDH values('DH2', '2021-01-09', '2021-02-01', 'KH3')
insert into DonDH values('DH3', '2021-01-25', '2021-01-31', 'KH1')


---câu 2
---1.1 sp cho khachhang
if OBJECT_ID('USP_ThemKhachHang') is not null
	drop procedure USP_ThemKhachHang
go
create proc USP_ThemKhachHang
	@maKH	nvarchar(9),
	@tenKH	nvarchar(20),
	@diaChi	nvarchar(50),
	@dienThoai	nvarchar(10),
	@gioiTinh nvarchar(3)
as
begin
	if @maKH is null
		print N'Chèn d? li?u không h?p lí'
	else
		begin
			insert into KhachHang values(@maKH, @tenKH, @diaChi, @dienThoai, @gioiTinh)
			print N'Chèn d? li?u thành công'
		end
end
--g?i thành công
exec USP_ThemKhachHang 'KH4', N'V? Xuân Tân', N'B?c T? Liêm', '0366202468', 'Nam'
exec USP_ThemKhachHang 'KH5', N'Hà Anh Tu?n', N'B?c Giang', '0386888888', 'Nam' 

---sp for DonDH
if OBJECT_ID('USP_ThemDon') is not null
	drop proc USP_ThemDon
go
create proc USP_ThemDon
	@maDH	nvarchar(9),
	@ngayDH	datetime,
	@ngayGH	datetime,
	@maKH	nvarchar(9)
as
begin
	if @maDH is null or @maKH is null
		print N'Chèn d? li?u không h?p l?'
	else
		begin
			insert into DonDH values(@maDH, @ngayDH, @ngayGH, @maKH)
			print N'Chèn d? li?u thành công'
		end
end

--g?i sp
exec USP_ThemDon 'DH4', '2020-12-24', '2021-01-01', 'KH1'
exec USP_ThemDon 'DH5', '2020-12-20', '2020-12-31', 'KH1'

--bài 3
if OBJECT_ID('fn_SoLanMuaHang') is not null
	drop function fn_SoLanMuaHang
go
create function fn_SoLanMuaHang(@maKH nvarchar(9))
returns int
as
begin
	declare @slmh int
	select @slmh = COUNT(maDH) from DonDH where maKH = @maKH
	return @slmh
end

--g?i hàm
select dbo.fn_SoLanMuaHang('KH1') as CôngMinhmuahàng

--bài 4
if OBJECT_ID('USP_XoaThongTin') is not null
	drop proc USP_XoaThongTin
go
create proc USP_XoaThongTin @maKH nvarchar(9)
as
begin
	begin try
		begin transaction
			delete from DonDH where maKH = @maKH
			delete from KhachHang where maKH = @maKH
		commit transaction
	end try

	begin catch
		print N'Xóa th?t b?i'
		rollback transaction
	end catch
end

--g?i sp
exec USP_XoaThongTin 'KH5'


--bài 5
if OBJECT_ID('USP_TimKiemThongTin') is not null
	drop proc USP_TimKiemThongTin
go
create proc USP_TimKiemThongTin
	@ngayDH datetime
as
begin
	select a.maKH, 
	tenKH = case gioiTinh
	when 'Nam' then N'Anh ' + tenKH
	when N'N?' then N'Ch? ' + tenKH
	end ,
	diaChi, maDH, 
	CONVERT(varchar, ngayDH, 103) as NgayDatHang, 
	CONVERT(varchar, ngayGH, 103) as NgayGiaoHang
	from KhachHang a
	inner join DonDH b on a.maKH = b.maKH
	where b.ngayDH = @ngayDH
end

select * from DonDH
exec USP_TimKiemThongTin '2021-01-01'