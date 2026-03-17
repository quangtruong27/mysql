
-- a. Toàn bộ thông tin của toàn bộ giáo viên trong trường.
select * from giao_vien;

--  b. Họ tên học sinh, giới tính, họ tên phụ huynh của toàn bộ sinh viên trong trường.
select * from hoc_sinh;
select ho_ten_hs, gioi_tinh, ho_ten_ph from hoc_sinh;

-- c. Toàn bộ thông tin của tất cả các lớp trong trường.
select * from lop;