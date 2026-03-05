create database store_management;

create table product (
	id int primary key auto_increment,
    name varchar(255) not null,
    description text,
    price double,
    stock int
);

select * from product;

-- Thêm Dữ Liệu:
-- b. Sử dụng lệnh mà không chỉ định tên cột. 
insert into product
values (null,'Iphone 17 Pro Max', 'Hỏng hết', 120000, 10);-- không chỉ định tên cột nên phải có null trong id

-- c. Sử dụng lệnh và chỉ định rõ tên cột. 
insert into product (name, description, price, stock)
values ('SamSung Note 21', 'Khong ai dung', 200000, 100);

-- Truy Vấn Dữ Liệu:
-- Liệt kê id, name, và price của tất cả sản phẩm.
select id, name, price
from product;

-- Liệt kê id, name, và price của các sản phẩm có giá dưới 10 triệu.
select id, name, price
from product
where price < 10000000;

-- Cập Nhật Dữ Liệu:
-- b. Sử dụng lệnh mà không có điều kiện WHERE.
set sql_safe_updates = 0;

update product
set price = 50000000;

-- c. Sử dụng lệnh với điều kiện WHERE.
update product
set price = 1000000
where id = 1;

set sql_safe_updates = 1;

-- Chỉnh Sửa Bảng:
-- a. Thêm trường Barcode với tất cả dữ liệu từ trước là NULL 
alter table product
add barcode varchar(255);

-- b. Thêm trường Warranty với giá trị mặc định là 6 tháng.
alter table product
add warranty int default 6;

-- Xóa Dữ Liệu:
-- b. Sử dụng lệnh mà không có điều kiện WHERE.
SET sql_safe_updates = 0;

delete from product;

--  c. Sử dụng lệnh với điều kiện WHERE.
delete from product
where id = 2;

SET sql_safe_updates = 1;

-- Xóa Bảng:
drop table product;

-- Xóa Cơ Sở Dữ Liệu:
-- a. Xóa mà không có điều kiện (Lỗi xảy ra nếu database không tồn tại).
drop database store_management;

--  b. Xóa bằng cách kiểm tra database đã tồn tại chưa rồi tiến hành xóa.
drop database if exists store_management;