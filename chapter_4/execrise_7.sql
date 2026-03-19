--    a. Họ tên của toàn bộ học sinh trong trường, nếu họ tên nào trùng nhau thì chỉ hiển thị 1 lần.
select distinct ho_ten_hs from hoc_sinh;

--    b. Mã lớp của các lớp đã có học sinh học ở lớp đó. Nếu mã lớp nào trùng nhau thì chỉ hiển thị 1 lần.
select distinct ma_lop from hoc_sinh where ma_lop is not null;

--    c. Mã môn học của những môn học đã có ít nhất 1 giáo viên được phân công phụ trách rồi. (*)
select distinct ma_mh from phu_trach_bo_mon where ma_mh is not null;

--    d. Mã môn học của những môn học đã từng được tổ chức thi ít nhất 1 lần.
select distinct ma_mh from ket_qua_hoc_tap;

--    e. Mã giáo viên của những giáo viên đã từng làm chủ nhiệm cho ít nhất 1lớp nào đó.
select distinct ma_gvcn from lop;

select gioi_tinh, count(dia_chi), dia_chi from hoc_sinh group by gioi_tinh, dia_chi;

select ma_hs, AVG(