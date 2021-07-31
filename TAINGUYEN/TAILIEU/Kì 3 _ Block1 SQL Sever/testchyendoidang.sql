DECLARE @FullName VarChar(40)
SET @FullName = 'Haiii Xuannnnnn Saaangggggg' 
--select Reverse(left(REVERSE(@FullName),CHARINDEX(' ',reverse(@FullName))-1))
--select RIGHT(@FullName,CHARINDEX(' ',Reverse(@FullName)))
select SUBSTRING(@FullName,CHARINDEX(' ',@FullName),len(@FullName)-1)