Create database qlsv;
go
use qlsv;
go

Create table sinh_vien (
	id int NOT NULL IDENTITY(1,1),
	name VARCHAR(255) NOT NULL,
	ma_sv VARCHAR(255) NOT NULL UNIQUE,
	email VARCHAR(255) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL
)
alter table sinh_vien add diem int not null;

select * from sinh_vien
insert sinh_vien
values('Sang','ph12221','sang@gmail.com','123456',7),
('Khai','ph12175','khai@gmail.com','124567',9),
('Viet Anh','ph12321','vietanh@gmail.com','134567',8),
('Hong Anh','ph12222','honganh@gmail.com','234567',6)
