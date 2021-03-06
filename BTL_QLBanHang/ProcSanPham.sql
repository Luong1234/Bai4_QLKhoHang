--USE QL_MuaHang02
--GO
----PROC Thêm sản phẩm
ALTER PROC ThemSP @tensp nvarchar(50), @malh nvarchar(50), @soluong int, @loinhuan float, @gianhap bigint, @mota text, @nsx nvarchar(50), @hinhanh nvarchar(100)
AS
BEGIN
DECLARE @MaSP varchar(10)
DECLARE @Sott int
DECLARE contro CURSOR FORWARD_ONLY FOR SELECT MaSP from SANPHAM
SET @Sott = 0

OPEN contro
FETCH NEXT FROM contro INTO @MaSP
WHILE(@@FETCH_STATUS = 0)
BEGIN
	IF((CAST(right(@MaSP, 8) AS int) - @sott) = 1)
		BEGIN
			SET @Sott = CAST(right(@MaSP, 8) AS int)
		END
	ELSE BREAK
	FETCH NEXT FROM contro INTO @MaSP
END

DECLARE @cdai int
DECLARE @i int
SET @MaSP = CAST((@sott + 1) as varchar(8))
SET @cdai = LEN(@MaSP)
SET @i = 1
while ( @i <= 8 - @cdai)
BEGIN
	SET @MaSP = '0' + @MaSP
	SET @i = @i + 1
END
SET @MaSP = 'SP' + @MaSP

INSERT INTO SANPHAM(MaSP, TenSP, MaLH, SoLuong, LoiNhuan, GiaNhap, GiaBan, MoTa, NSX, HinhAnh) values ( @MaSP, @tensp, @malh, @soluong, @loinhuan, @gianhap, (@gianhap+@gianhap*@loinhuan/100), @mota, @nsx, @hinhanh)
SELECT @MaSP
CLOSE contro
DEALLOCATE contro
END

exec dbo.themsp @tensp = N'fs', @malh = 'LH1', @soluong = 100, @loinhuan = 15, @gianhap = 1000, @mota = N'sfsgsfagsfwrw', @nsx = N'Dell', @hinhanh = N'fasfagw'

ALTER PROC SuaSP @masp varchar(10), @tensp nvarchar(50), @malh nvarchar(50), @soluong int, @loinhuan float, @gianhap bigint, @mota text, @nsx nvarchar(50)
AS
BEGIN
UPDATE SANPHAM SET TenSP = @tensp,
MaLH = @malh, SoLuong = @soluong, GiaNhap = @gianhap, GiaBan = @gianhap+@gianhap*@loinhuan/100, MoTa = @mota, NSX = @nsx, LoiNhuan = @loinhuan
WHERE MaSP = @masp
END

--CREATE PROC XoaSP @masp varchar(10)
--AS
--BEGIN
--DELETE FROM SANPHAM WHERE MaSP = @masp
--END

CREATE PROC SuaSL @masp varchar(10), @sl int
AS
BEGIN
	UPDATE SANPHAM SET SoLuong = SoLuong + @sl
	WHERE MaSP = @masp
END

