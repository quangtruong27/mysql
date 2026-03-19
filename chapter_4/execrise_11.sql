-- a. Liệt kê những địa chỉ khác nhau trong bảng hoc_sinh (bằng 2 cách khác nhau) ()
select distinct dia_chi from hoc_sinh;
select dia_chi from hoc_sinh group by dia_chi;
 
-- b. Liệt kê ho_ten_hs, gioi_tinh của các nhóm được phân nhóm theo ho_ten_hs và gioi_tinh trong bảng hoc_sinh.
select ho_ten_hs, gioi_tinh from hoc_sinh group by ho_ten_hs, gioi_tinh;

-- c. Liệt kê ho_ten_hs của các nhóm được phân nhóm theo ho_ten_hs và gioi_tinh trong bảng hoc_sinh. 
-- Chú ý thử giải thích vì sao không liệt kê gioi_tinh mà vẫn không bị lỗi. ()
select ho_ten_hs from hoc_sinh group by ho_ten_hs, gioi_tinh;

-- d. Liệt kê ma_mh, ten_mh, diem_thi_cuoi_ky của từng môn học chia theo từng mức điểm thi cuối kỳ. 
-- (Gợi ý: chỉ liệt kê những môn đã từng có học sinh thi cuối kỳ). ()
select kq.ma_mh, mh.ten_mh, kq.diem_thi_cuoi_ky
from ket_qua_hoc_tap kq JOIN mon_hoc mh ON kq.ma_mh = mh.ma_mh
where kq.diem_thi_cuoi_ky IS NOT NULL
group by kq.ma_mh, kq.diem_thi_cuoi_ky;

-- e. Liệt kê ma_gv, ten_gv của những giáo viên đã từng được phân công phụ trách ít nhất 1 môn học.
-- Nếu ma_gv, ten_gv trùng lặp nhiều lần thì chỉ hiển thị ra 1 lần trong kết quả trả về.
select distinct gv.ma_gv, gv.ho_ten_gv from giao_vien gv 
JOIN phu_trach_bo_mon ptbm ON gv.ma_gv = ptbm.ma_gvpt;

-- f. Liệt kê tháng và năm của những tháng và năm đã có ít nhất 1 học sinh tham gia thi cuối kỳ
-- (đã có diem_thi_cuoi_ky rồi). ()
select  MONTH(ktc.ngay_gio_thi_cuoi_ky) AS thang, YEAR(ktc.ngay_gio_thi_cuoi_ky) AS nam
from ket_qua_hoc_tap ktc
where ktc.diem_thi_cuoi_ky IS NOT NULL
group by thang, nam;

-- g. Liệt kê họ tên của những học sinh có địa chỉ ở Hải Châu và từng thi (giữa kỳ hoặc cuối kỳ)
-- ít nhất 1 lần. Nếu họ tên trùng lặp thì chỉ hiển thị ra 1 lần trong kết quả trả về. Yêu cầu:
-- Không được sử dụng từ khoá DISTINCT.
select hs.ho_ten_hs
from hoc_sinh hs JOIN ket_qua_hoc_tap kq ON hs.ma_hs = kq.ma_hs
where hs.dia_chi = 'Hải Châu' AND kq.diem_thi_giua_ky IS NOT NULL OR kq.diem_thi_cuoi_ky IS NOT NULL
group by hs.ho_ten_hs;