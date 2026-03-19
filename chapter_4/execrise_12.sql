--  a. Liệt kê ho_ten_hs, gioi_tinh, dia_chi của các nhóm được phân nhóm theo ho_ten_hs và gioi_tinh 
-- trong bảng hoc_sinh. Thử suy nghĩ về nguyê nhân lỗi nếu có lỗi xảy ra (*)
select ho_ten_hs, gioi_tinh, dia_chi
from hoc_sinh
group by ho_ten_hs, gioi_tinh,dia_chi;
-- => Lỗi: Khi gộp nhiều dòng thành 1 nhóm, nếu nhóm đó có nhiều địa chỉ khác nhau,
--  SQL sẽ không biết phải chọn địa chỉ nào để hiển thị lên kết quả duy nhất, nên hệ thống báo lỗi.

--  b. Đếm số lượng học sinh là nam.
select COUNT(*) AS soNam
from hoc_sinh
where gioi_tinh = 'Nam';

-- c. Đếm số lượng học sinh trong lớp có tên là Lớp 1A và lớp đó nằm trong năm học 2022-2023.
select COUNT(hs.ma_hs) AS soLuongHS
from hoc_sinh hs
join lop l ON hs.ma_lop = l.ma_lop
where l.ten_lop = 'Lớp 1A' and l.nam_hoc = '2022-2023';

-- d. Đếm số lớp đã phụ trách (có thể là 1 hoặc nhiều môn nào đó) của từng giáo viên.
select gv.ho_ten_gv, COUNT(ptbm.ma_mh) AS soLuongLopPhuTrach
from giao_vien gv
inner join phu_trach_bo_mon ptbm ON gv.ma_gv = ptbm.ma_gvpt
group by gv.ma_gv, gv.ho_ten_gv;

-- e. Đếm những môn học đã từng có học sinh thi giữa kỳ được 9 điểm trở lên. (*). Gợi ý: làm theo 2 cách, 
-- 1 là dùng WHERE, 2 là dùng HAVING.

-- WHERE
select mh.ten_mh, COUNT(*) AS soLuongHS
from mon_hoc mh
join ket_qua_hoc_tap kq ON mh.ma_mh = kq.ma_mh
where kq.diem_thi_giua_ky >= 9
group by mh.ten_mh;
-- HAVING
select mh.ten_mh, COUNT(*) AS soLuongHS
from mon_hoc mh
join ket_qua_hoc_tap kq ON mh.ma_mh = kq.ma_mh
group by mh.ten_mh
having MAX(kq.diem_thi_giua_ky) >= 9;

-- f. Đếm xem tương ứng với mỗi địa chỉ (của học sinh), số lượng học sinh đang ở mỗi địa chỉ là bao nhiêu em.
select dia_chi, COUNT(*) AS soLuongHS
from hoc_sinh
group by dia_chi;

-- g. Liệt kê điểm thi cao nhất của từng môn học (dựa vào điểm thi cuối kỳ mà các học sinh đã từng thi).
SELECT mh.ten_mh, MAX(kq.diem_thi_cuoi_ky) AS diemThiCaoNhat
FROM mon_hoc mh
JOIN ket_qua_hoc_tap kq ON mh.ma_mh = kq.ma_mh
GROUP BY mh.ten_mh;
-- h. Liệt kê điểm thi trung bình của từng môn học (dựa vào điểm thi cuối kỳ mà các học sinh đã từng thi).
-- i. Liệt kê những môn học có điểm thi trung bình cao nhất (dựa vào điểm thi cuối kỳ mà các học sinh đã từng thi). Gợi ý: có trường hợp nhiều hơn 1 môn học có điểm thi trung bình cao nhất. (**)
-- j. Tính điểm thi trung bình của từng học sinh trong trường. Chỉ tính điểm trung bình cho những học sinh đã từng thi cuối kỳ cho ít nhất 1 môn. Dựa vào cột điểm thi cuối kỳ để tính.
-- k. Tìm học sinh có điểm thi trung bình các môn học cao nhất của lớp 1A trong năm học 2022-2023. Nếu có nhiều hơn 1 em thỏa mãn yêu cầu thì sẽ xét ưu tiên theo họ tên (sắp xếp họ tên theo A-Z, chỉ ưu tiên cho 1 em đứng trước trong danh sách). Dựa vào cột điểm thi cuối kỳ để tính. (Gợi ý: tương tự câu i nhưng có thêm ORDER BY)
-- l. Tìm họ tên của những giáo viên đã từng dạy những học sinh có điểm trung bình cao nhất (xét trên dữ liệu của bất kể môn gì, chỉ tính điểm thi cuối kỳ của học kỳ 2). (***) (Suy nghĩ cẩn thận trước khi quyết định làm)

