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
('00001','ˮ�','ʩ����',45.56,6),
('00002','����ʮ����','������',37.56,12),
('00003','��������1566','����ƽ',25.56,67),
('00004','�������','����ˮ��',24.56,61),
('00005','������С˵��','������',45.56,65),
('00006','�����ѧ','���޸�',52.22,75),
('00007','���㷽��','̷��ǿ',20.78,69),
('00008','����İ���','JackieYan',45.78,89),
('00009','����������ʿ','ëķ',35.78,29),
('00010','���㷽��ϰ�⼯','̷��ǿ',20.78,69)
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

--1. д������BORROW���SQL��䣬Ҫ��������������Լ��������������Լ��
--2. �ҳ����鳬��5���Ķ���,������鿨�ż�����ͼ�����
select bw.cno ���鿨��,COUNT(*) ����ͼ����� from tb_borrow bw group by bw.cno having COUNT(*)>5
--3. ��ѯ������"ˮ�"һ��Ķ��ߣ�����������༶

----1.���Ӳ�ѯ
select cd.cname,cd.class 
from tb_book bk,tb_card cd,tb_borrow bw 
where cd.cno=bw.cno and bw.bno=bk.bno and bk.bname='ˮ�'
----2.�Ӳ�ѯ in
select cd.cname,cd.class from tb_card cd where cd.cno in(
select bw.cno from tb_borrow bw where bw.bno=(
select bk.bno from tb_book bk where bk.bname='ˮ�'))
----3.�Ӳ�ѯ exists
select cd.cname,cd.class from tb_card cd where exists (
select cd.cno from tb_book bk,tb_borrow bw 
where cd.cno=bw.cno and bw.bno=bk.bno and bk.bname='ˮ�')
----4.���Ӳ�ѯ join
select cd.cname,cd.class from tb_card cd 
inner join tb_borrow bw on bw.cno=cd.cno
inner join tb_book bk on bk.bno=bw.bno
where bk.bname='ˮ�'

--4. ��ѯ����δ��ͼ�飬��������ߣ����ţ�����ż���������
select * from tb_borrow bw where bw.rdate<GETDATE()
--5. ��ѯ��������"����"�ؼ��ʵ�ͼ�飬�����š�����������
select bk.bno,bk.bname,bk.author from tb_book bk where bk.bname like '%����%'
--6. ��ѯ����ͼ���м۸���ߵ�ͼ�飬�������������
select bk.bname,bk.author from tb_book bk where bk.price=(
select max(price) from tb_book)
--7. ��ѯ��ǰ����"���㷽��"��û�н�"���㷽��ϰ�⼯"�Ķ��ߣ��������鿨�ţ��������Ž����������
select bw.cno from tb_book bk,tb_borrow bw where bw.bno=bk.bno and bk.bname='���㷽��' and not exists (
select bbw.cno from tb_book bbk,tb_borrow bbw where bbw.bno=bbk.bno and bbw.cno=bw.cno and bbk.bname='���㷽��ϰ�⼯')
order by bw.cno desc
--8. ��"01"��ͬѧ����ͼ��Ļ��ڶ��ӳ�һ��
update tb_borrow set rdate = (rdate+7) where tb_borrow.cno in
(select cd.cno from tb_card cd,tb_borrow bw where cd.cno=bw.cno and cd.class='01')
--9�� ��BOOKS����ɾ����ǰ���˽��ĵ�ͼ���¼��
delete from tb_book where tb_book.bno not in (select bk.bno from tb_borrow bw,tb_book bk where bw.bno=bk.bno)
--10.��ѯ��ǰͬʱ����"���㷽��"��"�����ѧ"������Ķ��ߣ��������鿨�ţ��������������������
select bw.cno from tb_book bk,tb_borrow bw where bw.bno=bk.bno and bk.bname='���㷽��' and not exists (
select bbw.cno from tb_book bbk,tb_borrow bbw where bbw.bno=bbk.bno and bbw.cno=bw.cno and bbk.bname='�����ѧ')
order by bw.cno