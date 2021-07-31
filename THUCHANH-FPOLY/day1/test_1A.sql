use QLDA;
go

--select * from NHANVIEN where PHG = 4;

--select * from NHANVIEN where LUONG > 3000;

--select * from NHANVIEN where (PHG = 4 and LUONG > 25000) or (PHG = 5 and LUONG > 30000);

--select CONCAT(HONV, ' ' , TENLOT , ' ' , TENNV) as HovaTen, DCHI from NHANVIEN where DCHI like N'%HCM%' or DCHI like N'%Hồ Chí Minh%';

--select CONCAT(HONV, ' ' , TENLOT , ' ' , TENNV) as HovaTen from NHANVIEN where HONV like N'N%';

--select CONCAT(HONV, ' ' , TENLOT , ' ' , TENNV) as HovaTen, NGSINH, DCHI, DATEDIFF(Year,NGSINH,GETDATE()) as 'Tuổi'
--from NHANVIEN
--where HONV = N'Đinh' and TENLOT = N'Bá' and TENNV = N'Tiên';

----LAB 02: Sử dụng biến thực hiện các công việc:
/* Chương trình tính diện tích, chu vi hình chữ nhật khi biết 
chiều dài và chiều rộng.*/
declare @cDai float, @cRong float, @DienTich float, @ChuVi float;

set @cDai = 5.5;
set @cRong = 8;

set @DienTich = @cDai * @cRong;
set @ChuVi = (@cDai + @cRong) * 2;
--- xuất
SELECT @ChuVi AS CVHCN, @DienTich AS DTHCN
--select N'Diện Tích = ' + CAST(@DienTich as varchar)
--select N'Chu Vi = ' +  CAST(@ChuVi as varchar)

/*CVHCN = (CD + CR)*2; DTHCN = CD * CR*/


/* Dựa trên csdl QLDA thực hiện truy vấn, các giá trị truyền vào 
và trả ra phải dưới dạng sử dụng biến.
1. Cho biêt nhân viên có lương cao nhất*/
declare @max float;
select @max = max(luong) from NHANVIEN;
select @max AS LUONGMAX
SELECT * FROM dbo.NHANVIEN
WHERE LUONG = @max


/*2. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức 
lương trên mức lương trung bình của phòng "Nghiên cứu”*/
DECLARE @LTB FLOAT
SELECT @LTB = AVG(LUONG)
FROM NHANVIEN JOIN PHONGBAN ON NHANVIEN.PHG = PHONGBAN.MAPHG
WHERE TENPHG = N'NGHIÊN CỨU'
SELECT @LTB

---XUAT
SELECT HONV, TENLOT, TENNV
FROM NHANVIEN
WHERE LUONG > @LTB

/*3. Với các phòng ban có mức lương trung bình trên 30,000, 
liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.*/
DECLARE @LTB FLOAT
SELECT @LTB = AVG(LUONG)
FROM dbo.NHANVIEN
SELECT @LTB

SELECT TENPHG, COUNT(MANV) AS SLNV 
FROM dbo.PHONGBAN INNER JOIN dbo.NHANVIEN ON NHANVIEN.PHG = PHONGBAN.MAPHG
WHERE @LTB > 30000
GROUP BY TENPHG

/*4. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà
phòng ban đó chủ trì*/