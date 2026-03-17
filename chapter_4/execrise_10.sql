-- a. MaHS, HoTenHS, GioiTinh, MaLop, TenLop, NamHoc, MaGVCN, HoTenGV (chủ nhiệm) của học sinh trong trường.
SELECT hs.ma_hs, hs.ho_ten_hs, hs.gioi_tinh, hs.ma_lop, lop.ten_lop, lop.nam_hoc, lop.ma_gvcn, gv.ho_ten_gv
FROM hoc_sinh hs
JOIN lop ON hs.ma_lop = lop.ma_lop
JOIN giao_vien gv ON lop.ma_gvcn = gv.ma_gv;

-- b. MaHS, HoTenHS, HocKy, MaMH, TenMH, DiemThiGiuaKy, DiemThiCuoiKy của học sinh và các môn học đã có 
-- kết quả tương ứng với từng học sinh trong trường.
SELECT kq.ma_hs, hs.ho_ten_hs, kq.hoc_ky, kq.ma_mh, mh.ten_mh, kq.diem_thi_giua_ky, kq.diem_thi_cuoi_ky
FROM ket_qua_hoc_tap kq
JOIN hoc_sinh hs ON kq.ma_hs = hs.ma_hs
JOIN mon_hoc mh ON kq.ma_mh = mh.ma_mh;

-- c. MaHS, HoTenHS, HocKy, MaMH, TenMH, DiemThiGiuaKy, DiemThiCuoiKy, MaLop, MaGV (phụ trách), HoTenGV (phụ trách) 
-- của học sinh và các môn học đã có kết quả tương ứng với từng học sinh trong trường.
SELECT kq.ma_hs, hs.ho_ten_hs, kq.hoc_ky, kq.ma_mh, mh.ten_mh, kq.diem_thi_giua_ky, kq.diem_thi_cuoi_ky,
       hs.ma_lop, lop.ma_gvcn, gv.ho_ten_gv
FROM ket_qua_hoc_tap kq
JOIN hoc_sinh hs ON kq.ma_hs = hs.ma_hs
JOIN mon_hoc mh ON kq.ma_mh = mh.ma_mh
JOIN lop ON hs.ma_lop = lop.ma_lop
JOIN giao_vien gv ON lop.ma_gvcn = gv.ma_gv;

-- d. MaHS, HoTenHS, MaLop, MaGVCN, HoTenGV (chủ nhiệm), HocKy, MaMH, TenMH, DiemThiGiuaKy, DiemThiCuoiKy, 
-- MaGV (phụ trách), HoTenGV (phụ trách) của học sinh và các môn học đã có kết quả tương ứng với 
-- từng học sinh trong trường.\
SELECT kq.ma_hs, hs.ho_ten_hs, hs.ma_lop, lop.ma_gvcn, gv_chu_nhiem.ho_ten_gv AS ho_ten_gv_chu_nhiem,
       kq.hoc_ky, kq.ma_mh, mh.ten_mh, kq.diem_thi_giua_ky, kq.diem_thi_cuoi_ky,
       lop.ma_gvcn AS ma_gv_phu_trach, gv_phu_trach.ho_ten_gv AS ho_ten_gv_phu_trach
FROM ket_qua_hoc_tap kq
JOIN hoc_sinh hs ON kq.ma_hs = hs.ma_hs
JOIN lop ON hs.ma_lop = lop.ma_lop
JOIN giao_vien gv_chu_nhiem ON lop.ma_gvcn = gv_chu_nhiem.ma_gv
JOIN mon_hoc mh ON kq.ma_mh = mh.ma_mh
LEFT JOIN giao_vien gv_phu_trach ON lop.ma_gvcn = gv_phu_trach.ma_gv;

-- e. MaHS, HoTenHS, MaLop, MaGVCN, HoTenGV (chủ nhiệm), HocKy, MaMH, TenMH, DiemThiGiuaKy, DiemThiCuoiKy, 
-- MaGV (phụ trách), HoTenGV (phụ trách) của những học sinh nữ với các môn học đã có kết quả thi cuối kỳ 
-- hoặc giữa kỳ được 9 điểm trở lên.
SELECT kq.ma_hs, hs.ho_ten_hs, hs.ma_lop, lop.ma_gvcn, gv_chu_nhiem.ho_ten_gv AS ho_ten_gv_chu_nhiem,
       kq.hoc_ky, kq.ma_mh, mh.ten_mh, kq.diem_thi_giua_ky, kq.diem_thi_cuoi_ky,
       lop.ma_gvcn AS ma_gv_phu_trach, gv_phu_trach.ho_ten_gv AS ho_ten_gv_phu_trach
FROM ket_qua_hoc_tap kq
JOIN hoc_sinh hs ON kq.ma_hs = hs.ma_hs
JOIN lop ON hs.ma_lop = lop.ma_lop
JOIN giao_vien gv_chu_nhiem ON lop.ma_gvcn = gv_chu_nhiem.ma_gv
JOIN mon_hoc mh ON kq.ma_mh = mh.ma_mh
LEFT JOIN giao_vien gv_phu_trach ON lop.ma_gvcn = gv_phu_trach.ma_gv
WHERE (kq.diem_thi_cuoi_ky >= 9 OR kq.diem_thi_giua_ky >= 9) AND hs.gioi_tinh = 'Nữ';

-- f. MaHS, HoTenHS, HocKy, MaMH, TenMH, DiemThiGiuaKy, DiemThiCuoiKy, MaLop, MaGV (phụ trách), HoTenGV (phụ trách)
-- của học sinh và các môn học đã có kết quả tương ứng với từng học sinh trong trường.
-- Với điều kiện là chỉ hiển thị những môn học mà giáo viên phụ trách môn đó cũng chính là giáo viên chủ nhiệm của lớp.
SELECT kq.ma_hs, hs.ho_ten_hs, kq.hoc_ky, kq.ma_mh, mh.ten_mh, kq.diem_thi_giua_ky, kq.diem_thi_cuoi_ky,
       hs.ma_lop, lop.ma_gvcn, gv_chu_nhiem.ho_ten_gv AS ho_ten_gv_chu_nhiem
FROM ket_qua_hoc_tap kq
JOIN hoc_sinh hs ON kq.ma_hs = hs.ma_hs
JOIN lop ON hs.ma_lop = lop.ma_lop
JOIN giao_vien gv_chu_nhiem ON lop.ma_gvcn = gv_chu_nhiem.ma_gv
JOIN mon_hoc mh ON kq.ma_mh = mh.ma_mh
LEFT JOIN phu_trach_bo_mon ptbm ON lop.ma_gvcn = ptbm.ma_gvpt AND mh.ma_mh = ptbm.ma_mh AND kq.hoc_ky = ptbm.hoc_ky
WHERE ptbm.ma_gvpt IS NOT NULL;

-- g. MaMH, MaLop, HocKy của những môn học đã được thi cuối kỳ vào năm 2023
SELECT kq.ma_mh, lop.ma_lop, kq.hoc_ky
FROM ket_qua_hoc_tap kq
JOIN hoc_sinh hs ON kq.ma_hs = hs.ma_hs
JOIN lop ON hs.ma_lop = lop.ma_lop
WHERE YEAR(kq.ngay_gio_thi_cuoi_ky) = 2023;

-- h. MaMH, MaLop, HocKy của những môn học đã được thi vào tháng 8 năm 2023
SELECT kq.ma_mh, lop.ma_lop, kq.hoc_ky
FROM ket_qua_hoc_tap kq
JOIN hoc_sinh hs ON kq.ma_hs = hs.ma_hs
JOIN lop ON hs.ma_lop = lop.ma_lop
WHERE YEAR(kq.ngay_gio_thi_cuoi_ky) = 2023 AND MONTH(kq.ngay_gio_thi_cuoi_ky) = 8;

-- i. MaMH, MaLop, HocKy của những môn học đã được thi trước ngày 20 tháng 8 năm 2023
SELECT kq.ma_mh, lop.ma_lop, kq.hoc_ky
FROM ket_qua_hoc_tap kq
JOIN hoc_sinh hs ON kq.ma_hs = hs.ma_hs
JOIN lop ON hs.ma_lop = lop.ma_lop
WHERE kq.ngay_gio_thi_cuoi_ky < '2023-08-20';

-- j. MaMH, MaLop, HocKy của những môn học đã được thi trước ngày 20 tháng 8 năm 2023 đúng 1 tuần.
SELECT kq.ma_mh, lop.ma_lop, kq.hoc_ky
FROM ket_qua_hoc_tap kq
JOIN hoc_sinh hs ON kq.ma_hs = hs.ma_hs
JOIN lop ON hs.ma_lop = lop.ma_lop
WHERE kq.ngay_gio_thi_cuoi_ky >= '2023-08-13' AND kq.ngay_gio_thi_cuoi_ky < '2023-08-20';

-- k. MaMH, MaLop, HocKy của những môn học đã được thi sau ngày 20 tháng 8 năm 2023 đúng 21 ngày.
SELECT kq.ma_mh, lop.ma_lop, kq.hoc_ky
FROM ket_qua_hoc_tap kq
JOIN hoc_sinh hs ON kq.ma_hs = hs.ma_hs
JOIN lop ON hs.ma_lop = lop.ma_lop
WHERE kq.ngay_gio_thi_cuoi_ky >= '2023-09-10' AND kq.ngay_gio_thi_cuoi_ky <= '2023-10-01';

-- l. MaMH, MaLop, HocKy của những môn học đã được thi trong khoảng từ ngày 10 đến ngày 20 tháng 8 năm 2023.
SELECT kq.ma_mh, lop.ma_lop, kq.hoc_ky
FROM ket_qua_hoc_tap kq
JOIN hoc_sinh hs ON kq.ma_hs = hs.ma_hs
JOIN lop ON hs.ma_lop = lop.ma_lop
WHERE kq.ngay_gio_thi_cuoi_ky >= '2023-08-10' AND kq.ngay_gio_thi_cuoi_ky <= '2023-08-20';

-- m. MaMH, MaLop, HocKy của những môn học đã được thi trong khoảng từ 10 giờ 00 phút ngày 10 đến 20 giờ 30 phút 
-- ngày 20 tháng 8 năm 2023.
SELECT kq.ma_mh, lop.ma_lop, kq.hoc_ky
FROM ket_qua_hoc_tap kq
JOIN hoc_sinh hs ON kq.ma_hs = hs.ma_hs
JOIN lop ON hs.ma_lop = lop.ma_lop
WHERE kq.ngay_gio_thi_cuoi_ky >= '2023-08-20 10:00:00' AND kq.ngay_gio_thi_cuoi_ky <= '2023-08-20 20:30:00';