----PROC Thêm sản phẩm
CREATE PROC ThemLH @tenlh nvarchar(50)
AS
BEGIN
DECLARE @MaLH varchar(10)
DECLARE @Sott int
DECLARE contro CURSOR FORWARD_ONLY FOR SELECT MaLH from LOAIHANG
SET @Sott = 0

OPEN contro
FETCH NEXT FROM contro INTO @MaLH
WHILE(@@FETCH_STATUS = 0)
BEGIN
	IF((CAST(right(@MaLH, 8) AS int) - @sott) = 1)
		BEGIN
			SET @Sott = @Sott + 1
		END
	ELSE BREAK
	FETCH NEXT FROM contro INTO @MaLH
END
DECLARE @cdai int
DECLARE @i int
SET @MaLH = CAST((@sott + 1) as varchar(8))
SET @cdai = LEN(@MaLH)
SET @i = 1
while ( @i <= 8 - @cdai)
BEGIN
	SET @MaLH = '0' + @MaLH
	SET @i = @i + 1
END
SET @MaLH = 'LH' + @MaLH

INSERT INTO LOAIHANG(MaLH, TenLH) values (@MaLH, @tenlh)
CLOSE contro
DEALLOCATE contro
END

----exec DanhMaKH @tenKH = N'Hiếu', @dc = N'Thái Nguyên', @SDT = '09127862476', @LoaiKH = N'Khách VIP'

--CREATE PROC SuaLH @malh varchar(10), @tenlh nvarchar(50)
--AS
--BEGIN
--UPDATE LOAIHANG SET TenLH = @tenlh
--WHERE MaLH = @malh
--END

--CREATE PROC XoaLH @malh varchar(10)
--AS
--BEGIN
--DELETE FROM LOAIHANG WHERE MaLH = @malh
--END

