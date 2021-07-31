/*BÀI 1: Với mỗi đề án, liệt kê tên đề án và 
tổng số giờ làm việc một tuần của tất cả các nhân viên
tham dự đề án đó.
o Xuất định dạng “tổng số giờ làm việc” kiểu decimal với 2 số thập phân.
o Xuất định dạng “tổng số giờ làm việc” kiểu varchar
*/

select tendean, sum(thoigian) as TongSoGio,
cast( sum(thoigian) as decimal(8,2)) as castdecimal,
convert (decimal(8,2),  sum(thoigian) ) as convertdecimal,
cast( sum(thoigian) as varchar) as var1,
convert(varchar,  sum(thoigian)) as var2
from dean join congviec on dean.mada = congviec.mada
join phancong on phancong.mada = congviec.mada
group by tendean

select tendean, sum(thoigian) as tonggia
from dean join congviec on dean.mada = congviec.mada
join phancong on congviec.mada=  phancong.mada
group by tendean

/* Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm
việc cho phòng ban đó.
o Xuất định dạng “luong trung bình” kiểu decimal với 2 số thập phân, sử dụng dấu
phẩy để phân biệt phần nguyên và phần thập phân.
o Xuất định dạng “luong trung bình” kiểu varchar. Sử dụng dấu phẩy tách cứ mỗi 3
chữ số trong chuỗi ra, gợi ý dùng thêm các hàm Left, Replace */

declare @LTB varchar(20)
select @LTB = convert(varchar, avg(luong), 1)
from nhanvien 
group by phg
select @LTB
--truy xuaast
select tenphg, @LTB as ltb,
replace(left(@LTB,len(@LTB) - 3), '.', ',') + '.' + right(@LTB, 2)
from phongban join nhanvien on phongban.maphg = nhanvien.phg
group by tenphg


-- k su dung bien vo huong
SELECT TENPHG, AVG(LUONG) AS LTB,
	CONVERT(VARCHAR,AVG(LUONG),1) AS DEC,
	REPLACE(LEFT(CONVERT(VARCHAR,AVG(LUONG),1),LEN(CONVERT(VARCHAR,AVG(LUONG),1))-3),
		'.',',') + ',' + RIGHT(CONVERT(VARCHAR,AVG(LUONG),1),2)
FROM PHONGBAN JOIN NHANVIEN ON PHONGBAN.MAPHG = NHANVIEN.PHG
GROUP BY TENPHG

declare @LTB1 varchar(20)
select @LTB1 = convert(varchar, avg(luong), 1)
from nhanvien 
group by phg
select tenphg, avg(luong) as LTB,
convert(decimal(8,2), avg(luong),1) as LTBDEC,
replace(left(@LTB1, len(@LTB1) -3), '.', ',') + '.' + right(@LTB1, 2) as lTBDEC
from phongban join nhanvien on phongban.maphg = nhanvien.phg
group by tenphg

select * from dean
select *from congviec
select * from phancong

/*Bài 2: (2 điểm)
Sử dụng các hàm toán học
 Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các 
nhân viên tham dự đề án đó.
o Xuất định dạng “tổng số giờ làm việc” với hàm CEILING
o Xuất định dạng “tổng số giờ làm việc” với hàm FLOOR
o Xuất định dạng “tổng số giờ làm việc” làm tròn tới 2 chữ số thập phân*/

select tendean, sum(thoigian) as tongsg,
ceiling(sum(thoigian)) as cei,
floor(sum(thoigian)) as fl,
round(sum(thoigian),2) as roun
from dean join congviec on dean.mada = congviec.mada
join phancong on phancong.mada = congviec.mada
group by tendean


/*Bài 3: (2 điểm) Sử dụng các hàm xử lý chuỗi
 Danh sách những nhân viên (HONV, TENLOT, TENNV, DCHI) 
có trên 2 thân nhân, thỏa các yêu cầu
o Dữ liệu cột HONV được viết in hoa toàn bộ
o Dữ liệu cột TENLOT được viết chữ thường toàn bộ
o Dữ liệu chột TENNV có ký tự thứ 2 được viết in hoa, 
các ký tự còn lại viết
thường( ví dụ: kHanh)
o Dữ liệu cột DCHI chỉ hiển thị phần tên đường, không hiển thị các thông tin khác
như số nhà hay thành phố.*/

select honv, tenlot, tennv, dchi,
upper(honv) as up, lower(tenlot) as loww,
lower(left(tennv, 1)) + upper(substring(tennv,2,1)) + lower(right(tennv, len(tennv)-2))as tennv,
substring(dchi, charindex(' ', dchi), charindex(',',dchi) -  charindex(' ', dchi)) as chars
from nhanvien

/*--➢ Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có
đông nhân viên nhất, hiển thị thêm một cột thay thế tên trưởng phòng bằng tên
“Fpoly”*/

select honv+' ' + tenlot+ ' ' + tennv as trphong, trphg, tenphg
from nhanvien join phongban on phongban.TRPHG= nhanvien.manv
where trphg = (select trphg 
				from phongban join nhanvien on phongban.maphg = nhanvien.phg
				group by trphg
				having count(manv) = (select max(SLNN) from (select count(manv) as SLNN
				from nhanvien 
				group by PHG) as SLNN))


select * from PHONGBAN
select * from NHANVIEN
--select @nvnn
declare @nvnn int
select @nvnn = max(slnn) from
(select count(manv) as slnn  from nhanvien
group by phg) as slnn
--select @tenPhg
declare @tenPhg nvarchar(50)
select @tenPhg =  tenphg
from PHONGBAN join NHANVIEN on PHONGBAN.MAPHG =
NHANVIEN.PHG
group by tenphg
having count(manv) = @nvnn                                
----TRUY XUẤT
select HONV + ' ' + TENLOT + ' ' + TENNV as [TP], TENPHG 
from PHONGBAN join NHANVIEN on PHONGBAN.MAPHG = NHANVIEN.PHG
where TENPHG = @tenPhg and manv = TRPHG