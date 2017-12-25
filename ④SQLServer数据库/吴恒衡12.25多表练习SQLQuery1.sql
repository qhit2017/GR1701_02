CREATE database db_multilist
use db_multilist

CREATE table tb_Borrow(
cno nvarchar(32) prIMARY KEY,
cname nvarchar(32) not null,
class nvarchar(8))   --借书表
ALTER table tb_Borrow alter column class nvarchar(8)

CREATE table tb_books(
bno nvarchar(32) prIMARY KEY,
bname nvarchar(32) not null,
nuthor nvarchar(16),
priace decimal(8,4),
repertory smallint)--图书表
--借书记录表
CREATE table tb_BorrowRecord(
id tinyint identity(1,1),
cno nvarchar(32),
bno nvarchar(32),
BorrowDate date)--借书日期
INSERT INTO  tb_Borrow(cno,cname,class)
values('001','jackie','01'),
('002','tom','02'),
('003','Jerry','01'),
('004','mary','03'),
('005','Lucy','03'),
('006','Lily','02'),
('007','Jane','02')
INSERT INTO tb_books(bno,bname,
nuthor,priace,repertory)
values('00001','水浒','施耐庵',45.56,6),
('00002','万历十五年','黄仁宇',37.56,12),
('00003','大明王朝1566','刘和平',25.56,67),
('00004','世间的盐','风行水上',24.56,61),
('00005','汪曾祺小说集','汪曾祺',45.56,65),
('00006','组合数学','华罗庚',52.22,75),
('00007','计算方法','谭浩强',20.78,69),
('00008','网络的奥秘','JackieYan',45.78,89),
('00009','月亮与六便士','毛姆',35.78,29),
('00010','计算方法习题集','谭浩强',20.78,69)
INSERT INTO tb_BorrowRecord(
cno,bno,BorrowDate)
values('002','00009','2017-8-5'),
('007','00010','2017-10-5'),
('001','00001','2017-3-5'),
('001','00002','2017-3-5'),
('001','00003','2017-3-5'),
('001','00004','2017-3-5'),
('002','00004','2017-3-5'),
('003','00003','2017-3-5'),
('007','00005','2016-3-5'),
('005','00001','2017-3-5'),
('001','00007','2017-3-5'),
('003','00006','2017-3-5'),
('003','00007','2017-3-5')
SELECT * FROM tb_Borrow --借书表
SELECT * FROM tb_books --图书表
SELECT * FROM tb_BorrowRecord --借书日期
select name from sys.objects where type ='u'
sp_help tb_BorrowRecord

--1. 写出建立BORROW表的SQL语句，要求定义主码完整性约束和引用完整性约束
--2. 找出借书超过5本的读者,输出借书卡号及所借图书册数
--3. 查询借阅了"水浒"一书的读者，输出姓名及班级
--4. 查询过期未还图书，输出借阅者（卡号）、书号及还书日期
--5. 查询书名包括"网络"关键词的图书，输出书号、书名、作者
--6. 查询现有图书中价格最高的图书，输出书名及作者
--7. 查询当前借了"计算方法"但没有借"计算方法习题集"
--的读者，输出其借书卡号，并按卡号降序排序输出
--8. 将"01"班同学所借图书的还期都延长一周
--9． 从BOOKS表中删除当前无人借阅的图书记录。
--10.查询当前同时借有"计算方法"和"组合数学"
--两本书的读者，输出其借书卡号，并按卡号升序排序输出