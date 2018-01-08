create table tb_card(
cno nvarchar(16) primary key,
cname nvarchar(16) not null,
class nvarchar(4) not null)
--sp_help tb_card

insert into tb_card (cno,cname,class) values
('001','jackie','01'),
('002','tom','02'),
('003','Jerry','01'),
('004','mary','03'),
('005','Lucy','03'),
('006','Lily','02'),
('007','Jane','02')
select * from tb_card

create table tb_book(
bno nvarchar(16) primary key,
bname nvarchar(32) not null,
author nvarchar(16) not null,
price money,
repertory smallint)
--sp_help tb_book

insert into tb_book (bno,bname,author,price,repertory) values
('00001','水浒','施耐庵',45.56,6),
('00002','万历十五年','黄仁宇',37.56,12),
('00003','大明王朝1566','刘和平',25.56,67),
('00004','世间的盐','风行水上',24.56,61),
('00005','汪曾祺小说集','汪曾祺',45.56,65),
('00006','组合数学','华罗庚',52.22,75),
('00007','计算方法','谭浩强',20.78,69),
('00008','网络的奥秘','JackieYan',45.78,89),
('00009','月亮与六便士','毛姆',35.78,29),
('00010','计算方法习题集','谭浩强',20.78,69)
select * from tb_book

create table tb_borrow(
id int identity(1,1) primary key,
cno nvarchar(16) not null,
bno nvarchar(16) not null,
rdate datetime not null,
foreign key(cno) references tb_card(cno),
foreign key(bno) references tb_book(bno))
--sp_help tb_borrow

insert into tb_borrow (cno,bno,rdate) values
('001','00010','2017-10-5'),
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
select * from tb_borrow

--1. 写出建立BORROW表的SQL语句，要求定义主码完整性约束和引用完整性约束
--2. 找出借书超过5本的读者,输出借书卡号及所借图书册数
select bw.cno 借书卡号,COUNT(*) 所借图书册数 from tb_borrow bw group by bw.cno having COUNT(*)>5
--3. 查询借阅了"水浒"一书的读者，输出姓名及班级

----1.连接查询
select cd.cname,cd.class 
from tb_book bk,tb_card cd,tb_borrow bw 
where cd.cno=bw.cno and bw.bno=bk.bno and bk.bname='水浒'
----2.子查询 in
select cd.cname,cd.class from tb_card cd where cd.cno in(
select bw.cno from tb_borrow bw where bw.bno=(
select bk.bno from tb_book bk where bk.bname='水浒'))
----3.子查询 exists
select cd.cname,cd.class from tb_card cd where exists (
select cd.cno from tb_book bk,tb_borrow bw 
where cd.cno=bw.cno and bw.bno=bk.bno and bk.bname='水浒')
----4.连接查询 join
select cd.cname,cd.class from tb_card cd 
inner join tb_borrow bw on bw.cno=cd.cno
inner join tb_book bk on bk.bno=bw.bno
where bk.bname='水浒'

--4. 查询过期未还图书，输出借阅者（卡号）、书号及还书日期
select * from tb_borrow bw where bw.rdate<GETDATE()
--5. 查询书名包括"网络"关键词的图书，输出书号、书名、作者
select bk.bno,bk.bname,bk.author from tb_book bk where bk.bname like '%网络%'
--6. 查询现有图书中价格最高的图书，输出书名及作者
select bk.bname,bk.author from tb_book bk where bk.price=(
select max(price) from tb_book)
--7. 查询当前借了"计算方法"但没有借"计算方法习题集"的读者，输出其借书卡号，并按卡号降序排序输出
select bw.cno from tb_book bk,tb_borrow bw where bw.bno=bk.bno and bk.bname='计算方法' and not exists (
select bbw.cno from tb_book bbk,tb_borrow bbw where bbw.bno=bbk.bno and bbw.cno=bw.cno and bbk.bname='计算方法习题集')
order by bw.cno desc
--8. 将"01"班同学所借图书的还期都延长一周
update tb_borrow set rdate = (rdate+7) where tb_borrow.cno in
(select cd.cno from tb_card cd,tb_borrow bw where cd.cno=bw.cno and cd.class='01')
--9． 从BOOKS表中删除当前无人借阅的图书记录。
delete from tb_book where tb_book.bno not in (select bk.bno from tb_borrow bw,tb_book bk where bw.bno=bk.bno)
--10.查询当前同时借有"计算方法"和"组合数学"两本书的读者，输出其借书卡号，并按卡号升序排序输出
select bw.cno from tb_book bk,tb_borrow bw where bw.bno=bk.bno and bk.bname='计算方法' and not exists (
select bbw.cno from tb_book bbk,tb_borrow bbw where bbw.bno=bbk.bno and bbw.cno=bw.cno and bbk.bname='组合数学')
order by bw.cno