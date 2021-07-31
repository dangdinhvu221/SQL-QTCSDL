--b1
	SELECT HONV + ' ' + TENLOT +' ' + TENNV AS N'Họ và tên'  
	FROM NHANVIEN
	WHERE LUONG > (
		SELECT AVG(LUONG) FROM NHANVIEN
		INNER JOIN PHONGBAN ON NHANVIEN.PHG = PHONGBAN.MAPHG
		WHERE PHONGBAN.TENPHG = N'Nghiên cứu'
	)
--b2
alter proc dt_nhap
@a int , @b int
as
begin
	declare @dt int
	set @dt = @a * @b
		if((@a < 0) or (@b <0))
		print N'Đây không phải hai cạnh của hình chữ nhật'
	else 	
		print N'Diện tích là:' + convert(varchar,@dt);		
end
exec dt_nhap 0,6
--b3

--b4
select * from DEAN
select * from NHANVIEN
create proc sl_Da
@MaDa int ,@Ddiem_Da nvarchar(20)
as
begin
	select COUNT(NHANVIEN.PHG) from NHANVIEN inner join DEAN on NHANVIEN.PHG = DEAN.PHONG
	where DEAN.MADA = @MaDa
	and   DEAN.DDIEM_DA = @Ddiem_Da
end
exec sl_Da 3,N'TP HCM'

--b5
drop trigger Update_GT
create trigger Update_GT on NHANVIEN
after update
as
begin
	declare @nam int,@nu int
	select @nam =  COUNT(PHAI) from NHANVIEN where PHAI = N'Nam'
	select @nu = COUNT(PHAI) from NHANVIEN where PHAI = N'Nữ'
	print 'So nhan vien nam la: ' + convert(varchar,@nam)
	print 'So nhan vien nu la: ' + convert(varchar,@nu)
end

update NHANVIEN set PHAI = N'Nam' where MANV = 04
select * from NHANVIEN

--b6
select * from PHANCONG
alter function SumTG(@MaDA int)
returns float
as
begin
	return(select SUM(THOIGIAN) from PHANCONG where MADA = @MaDA)
end

print 'Tong thoi gian lam viec cua de an do la: ' + cast(dbo.SumTG(20) as varchar)

--b7
select * from DIADIEM_PHG
select * from PHONGBAN
select * from NHANVIEN
create view tt_nv
as
	select NHANVIEN.HONV,NHANVIEN.TENNV,PHONGBAN.TENPHG,DIADIEM_PHG.DIADIEM  
	from NHANVIEN inner join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
				inner join DIADIEM_PHG on NHANVIEN.PHG=DIADIEM_PHG.MAPHG
	where NHANVIEN.LUONG > 30000
	
select * from tt_nv
select * from NHANVIEN
