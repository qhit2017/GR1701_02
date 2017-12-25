CREATE table tb_card(
cno nvarchar(32) primary key,
cname nvarchar(16) not null,
class nvarchar)

ALTER table tb_card alter column class nvarchar(8)

-------------------------------------
CREATE table tb_book(
bno nvarchar(32) primary key,
bname nvarchar(32) not null,
author nvarchar(16),
price decimal(8,4),
repertory smallint)

----------------------------------------
CREATE table tb_borrow(
id tinyint identity(1,1),
cno nvarchar(32),
bno nvarchar(32),
foreign key (cno) references tb_card(cno),
foreign key (bno) references tb_book(bno),
rdate datetime)

sp_help tb_card

INSERT into tb_card values
('001','jackie','01'),
('002','tom','02'),
('003','Jerry','01'),
('004','mary','03'),
('005','Lucy','03'),
('006','Lily','02'),
('007','Jane','02')
---------------------------
INSERT INTO tb_book VALUES 
('00001','水浒','施耐庵',45.56,6),
('00002','万历十五年','黄仁宇',37.56,12),
('00003','大明王朝1566','刘和平',25.56,67),
('00004','世间的盐','风行水上',24.56,61),
('00005','汪曾祺小说集','汪曾祺',45.56,65),
('00006','我是猫','夏目漱石',52.22,75),
('00007','计算方法','谭浩强',20.78,69),
('00008','网络的奥秘','JackieYan',45.78,89),
('00009','月亮与六便士','毛姆',35.78,29),
('00010','计算方法习题集','谭浩强',20.78,69)
---------------------------------------------------

INSERT INTO tb_borrow VALUES 
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

-----------------------------------------

--1. 写出建立BORROW表的SQL语句，要求定义主码完整性约束和引用完整性约束

--2. 找出借书超过5本的读者,输出借书卡号及所借图书册数
SELECT bor.cno as 卡号,COUNT(*) as 册数
FROM tb_borrow bor
GROUP BY bor.cno
HAVING COUNT(*) >= 5
--3. 查询借阅了"水浒"一书的读者，输出姓名及班级
SELECT ca.cname,ca.class 
from tb_book bo,tb_borrow bro,tb_card ca
WHERE bo.bno= bro.bno
AND bro.cno = ca.cno
AND bo.bname = '水浒'

SELECT ca.cname,ca.class from tb_card ca WHERE ca.cno IN (
SELECT bor.cno from tb_borrow bor WHERE bor.bno = (
SELECT bo.bno from tb_book bo WHERE bo.bname = '水浒'))

select * from tb_card ca where exists(
SELECT ca.cno
from tb_borrow bor ,tb_book bo
where bo.bname='水浒'
AND bor.bno=bo.bno
AND ca.cno = bor.cno)
--4. 查询过期未还图书，输出借阅者（卡号）、书号及还书日期
SELECT * FROM tb_borrow WHERE rdate < GETDATE()
--5. 查询书名包括"网络"关键词的图书，输出书号、书名、作者
SELECT *FROM tb_book WHERE bname LIKE '%网络%'
--6. 查询现有图书中价格最高的图书，输出书名及作者]
SELECT bname,author FROM tb_book WHERE price =(
SELECT max(price) FROM tb_book)
--7. 查询当前借了"计算方法"但没有借"计算方法习题集"的读者，输出其借书卡号，并按卡号降序排序输出
SELECT bor.cno from tb_borrow bor,tb_book bo
WHERE bor.bno = bo.bno
AND bo.bname = '计算方法' AND not exists(
  SELECT bor.cno FROM tb_borrow bbor,tb_book bbo
  where bbor.bno = bbo.bno
  AND bbo.bname='计算方法习题集'
  AND bor.cno = bbor.cno)
  ORDER BY bor.cno DESC
--8. 将"01"班同学所借图书的还期都延长一周
UPDATE tb_borrow 
SET rdate = DATEADD(DAY,7,bor.rdate)
FROM tb_card ca,tb_borrow bor 
WHERE ca.class = '01'AND ca.cno = bor.cno
--9． 从BOOKS表中删除当前无人借阅的图书记录。
DELETE FROM tb_book WHERE tb_book.bno NOT IN
(SELECT tb_book.bno FROM tb_book,tb_borrow WHERE tb_book.bno = tb_borrow.bno)
--10.查询当前同时借有"计算方法"和"组合数学"两本书的读者，输出其借书卡号，并按卡号升序排序输出
SELECT bor.cno from tb_borrow bor,tb_book bo
WHERE bor.bno = bo.bno
AND bo.bname = '计算方法' AND exists(
  SELECT bor.cno FROM tb_borrow bbor,tb_book bbo
  where bbor.bno = bbo.bno
  AND bbo.bname='我是猫'
  AND bor.cno = bbor.cno)
  ORDER BY bor.cno ASC
