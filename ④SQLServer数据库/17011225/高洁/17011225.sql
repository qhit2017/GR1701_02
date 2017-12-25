CREATE table tb_card(
cno nvarchar(32) primary key,
cname  nvarchar(16) not null,
calss  nvarchar(16)
)
CREATE table tb_book(
bno nvarchar(32) primary key,
bname nvarchar(16) not null,
bjiage decimal(8,4),
bkucun tinyint
)

CREATE table tb_borrowl(
id tinyint identity(1,1),
cno nvarchar(32),
bno nvarchar(32),
foreign key(cno) references tb_card(cno),
foreign key(bno) references tb_book(bno),
rdate datetime
)
INSERT INTO  tb_card 
VALUES 
('001','jackie','01'),
('002','tom','02'),
('003','Jerry','01'),
('004','mary','03'),
('005','Lucy','03'),
('006','Lily','02'),
('007','Jane','02')
INSERT INTO tb_book 
VALUES 
('00001','水浒',45.56,6),
('00002','万历十五年',37.56,12),
('00003','大明王朝1566',25.56,67),
('00004','世间的盐',24.56,61),
('00005','汪曾祺小说集',45.56,65),
('00006','组合数学',52.22,75),
('00007','计算方法',20.78,69),
('00008','网络的奥秘',45.78,89),
('00009','月亮与六便士',35.78,29),
('00010','计算方法习题集',20.78,69)
INSERT INTO tb_borrowl(cno,bno,rdate) 
VALUES 
('002','00009','2017-8-5'),
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


--1. 写出建立BORROW表的SQL语句，要求定义主码完整性约束和引用完整性约束

--2. 找出借书超过5本的读者,输出借书卡号及所借图书册数
SELECT bor.cno as '卡号',COUNT(bor.cno) as '数量' 
from tb_borrowl bor GROUP BY bor.cno 
HAVING COUNT(bor.cno)>4

--3. 查询借阅了"水浒"一书的读者，输出姓名及班级
--第二种方法
SELECT ca.cname,ca.calss from tb_card ca WHERE ca.cno in
(SELECT bor.cno  from tb_borrowl bor where bor.bno =
(SELECT bo.bno  from tb_book bo WHERE bo.bname='水浒' ))

--4. 查询过期未还图书，输出借阅者（卡号）、书号及还书日期

--5. 查询书名包括"网络"关键词的图书，输出书号、书名、作者
--6. 查询现有图书中价格最高的图书，输出书名及作者
--7. 查询当前借了"计算方法"但没有借"计算方法习题集"的读者，输出其借书卡号，并按卡号降序排序输出
--8. 将"01"班同学所借图书的还期都延长一周
--9． 从BOOKS表中删除当前无人借阅的图书记录。
--10.查询当前同时借有"计算方法"和"组合数学"两本书的读者，输出其借书卡号，并按卡号升序排序输出




