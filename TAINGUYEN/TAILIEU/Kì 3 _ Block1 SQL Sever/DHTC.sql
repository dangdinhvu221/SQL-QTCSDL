create database DKTC
go
use DKTC
go
create table SINHVIEN(
	MaSV nvarchar(10) not null,
	HoTen nvarchar(50) not null,
	NgaySinh DateTime not null,
	GioiTinh nvarchar(10) not null,
	MK nvarchar(10) not null,
	constraint PK_SINHVIEN primary key(MaSV)
)
insert into SINHVIEN(MaSV,HoTen,NgaySinh,GioiTinh,MK)
values
	('19D190097',N'Nguyễn Khắc Việt Hưng','2001-03-03',N'Nữ','F'),
	('19D190135',N'Nghiêm Vân Trà','2001-05-10',N'Nữ','S'),
	('19D190456',N'Trần Đức Bo','2000-08-03',N'Nam','A')
select * from SINHVIEN

create table HOCPHAN(
	MaHP nvarchar(20) not null,
	TenHP nvarchar(50) not null,
	SoTC int not null,
	NgayBD Datetime not null,
	NgayKT Datetime not null,
	constraint PK_HOCPHAN primary key(MaHP),
)
insert into HOCPHAN(MaHP,TenHP,SoTC,NgayBD,NgayKT)
values
	('2007INFO2311',N'Cơ sở dữ liệu',2,'2020-08-03','2020-11-27'),
	('2031MIEC0111',N'Kinh tế vi mô 1',3,'2020-06-03','2020-09-27'),
	('2051PCOM0111',N'Thương Mại Điện Tử Căn Bản',3,'2020-08-03','2020-11-27'),
	('20617INFO0621',N'Cơ sở lập trình',3,'2020-06-08','2020-09-25'),
	('2049FMAT0211',N'Toán cao cấp 2',2,'2020-08-03','2020-11-27')
select * from HOCPHAN

create table THONGTINDK(
	MaSV nvarchar(10) not null,
	HoTen nvarchar(50) not null,
	MaHP nvarchar(20) not null,
	TenHP nvarchar(50) not null,
	SoTC int not null,
	constraint FK_THONGTINDK_SINHVIEN foreign key(MaSV) references SINHVIEN(MaSV),
	constraint FK_THONGTINDK_HOCPHAN foreign key(MaHP) references HOCPHAN(MaHP)
)

insert into THONGTINDK(MaSV,HoTen,MaHP,TenHP,SoTC)
values 
	('19D190097',N'Nguyễn Khắc Việt Hưng','2007INFO2311',N'Cơ sở dữ liệu',2),
	('19D190097',N'Nguyễn Khắc Việt Hưng','2051PCOM0111',N'Thương Mại Điện Tử Căn Bản',3),
	('19D190135',N'Nghiêm Vân Trà','20617INFO0621',N'Cơ sở lập trình',3),
	('19D190456',N'Trần Đức Bo','2007INFO2311',N'Cơ sở dữ liệu',2),
	('19D190456',N'Trần Đức Bo','20617INFO0621',N'Cơ sở lập trình',3),
	('19D190456',N'Trần Đức Bo','2049FMAT0211',N'Toán cao cấp 2',2)
select * from THONGTINDK
