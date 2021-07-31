Declare @dtb float
set @dtb = 7
	if @dtb<3 
		print N'Kém';
	else
		if @dtb<5
			print N'Yếu';
	else
		if @dtb<7.5
			print N'Trung Bình';
	else
		if @dtb<9
			print N'Khá';
	else
		if @dtb>10
			print N'Giỏi';
---------------------
use QLDA
go
if (select count(*) from NHANVIEN where Luong > 30000)>0
begin
	print 'Danh sach nhan vien IT co luong > 30000'
	select HONV,TENNV
		from NHANVIEN
		where LUONG > 3000
end
else
	print 'Không có ai làm IT ma luong 300000'

---------------------
select iif(LUONG>30000,'Truong phong','NhanVien')
as ChucVu,TENNV,LUONG
from NHANVIEN
----------------------------------
select pb.tenpb,count(nv.phg) as N'Số nhân viên',
	iif(count(nv.phg)<3, N'Thiếu nhân viên', iif(count(nv.phg<5),N'Đủ nhân viên',N'Đông nhân viên')) as N'Nhận xét',
from phongban pb inner join nhanvien nv on pb.MAPHG=nv.phg
group by pb.tenpb

-----------------------
select TENNV = case PHAI
when 'nam' then 'Mr. '+[TENNV]
when N'Nữ' then 'Ms. '+[TENNV]
else 'Freesex. ' + [TENNV]
end
from NHANVIEN
------------------
select pb.TENPHG,count(nv.PHG) as N'Số nhân viên',
N'Nhận xét' = case
	when count(nv.PHG)<3 then N'Thiếu nhân viên'
	when count(nv.PHG)<5 then N'Đủ nhân viên'
	else N'Đông nhân viên'
	end
from phongban pb inner join nhanvien nv on pb.MAPHG =nv.phg
group by pb.TENPHG
-----------------
select TENNV,LUONG,THUE=case
	when LUONG <25000 then LUONG*0.1
	when LUONG <30000 then LUONG*0.12
	when LUONG <40000 then LUONG*0.15
	when LUONG <50000 then LUONG*0.2
	else LUONG*0.25
	end
from NHANVIEN
-----------------
declare @dem int = 0;
while @dem<5
begin
	print 'Quan trong la phuong phap hoc';
	set @dem=@dem+1;
end;
print 'Hoc lap trinh thi ra cung de'
go
----------------
declare @i int
set @i=0
while @i<10
begin
	if(@i<5) continue;
	print N'Đây là số '+cast;
	set @dem=@dem+1;
end;
print 'Hoc lap trinh thi ra cung de'
go
-------------------
begin try 
	insert PHONGBAN
	values(799,'ZXK-799','2008-07-01','0197-05-22')

	print'Success: Record was inserted'
end try

