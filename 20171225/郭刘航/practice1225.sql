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
('00001','ˮ�','ʩ����',45.56,6),
('00002','����ʮ����','������',37.56,12),
('00003','��������1566','����ƽ',25.56,67),
('00004','�������','����ˮ��',24.56,61),
('00005','������С˵��','������',45.56,65),
('00006','����è','��Ŀ��ʯ',52.22,75),
('00007','���㷽��','̷��ǿ',20.78,69),
('00008','����İ���','JackieYan',45.78,89),
('00009','����������ʿ','ëķ',35.78,29),
('00010','���㷽��ϰ�⼯','̷��ǿ',20.78,69)
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

--1. д������BORROW���SQL��䣬Ҫ��������������Լ��������������Լ��

--2. �ҳ����鳬��5���Ķ���,������鿨�ż�����ͼ�����
SELECT bor.cno as ����,COUNT(*) as ����
FROM tb_borrow bor
GROUP BY bor.cno
HAVING COUNT(*) >= 5
--3. ��ѯ������"ˮ�"һ��Ķ��ߣ�����������༶
SELECT ca.cname,ca.class 
from tb_book bo,tb_borrow bro,tb_card ca
WHERE bo.bno= bro.bno
AND bro.cno = ca.cno
AND bo.bname = 'ˮ�'

SELECT ca.cname,ca.class from tb_card ca WHERE ca.cno IN (
SELECT bor.cno from tb_borrow bor WHERE bor.bno = (
SELECT bo.bno from tb_book bo WHERE bo.bname = 'ˮ�'))

select * from tb_card ca where exists(
SELECT ca.cno
from tb_borrow bor ,tb_book bo
where bo.bname='ˮ�'
AND bor.bno=bo.bno
AND ca.cno = bor.cno)
--4. ��ѯ����δ��ͼ�飬��������ߣ����ţ�����ż���������
SELECT * FROM tb_borrow WHERE rdate < GETDATE()
--5. ��ѯ��������"����"�ؼ��ʵ�ͼ�飬�����š�����������
SELECT *FROM tb_book WHERE bname LIKE '%����%'
--6. ��ѯ����ͼ���м۸���ߵ�ͼ�飬�������������]
SELECT bname,author FROM tb_book WHERE price =(
SELECT max(price) FROM tb_book)
--7. ��ѯ��ǰ����"���㷽��"��û�н�"���㷽��ϰ�⼯"�Ķ��ߣ��������鿨�ţ��������Ž����������
SELECT bor.cno from tb_borrow bor,tb_book bo
WHERE bor.bno = bo.bno
AND bo.bname = '���㷽��' AND not exists(
  SELECT bor.cno FROM tb_borrow bbor,tb_book bbo
  where bbor.bno = bbo.bno
  AND bbo.bname='���㷽��ϰ�⼯'
  AND bor.cno = bbor.cno)
  ORDER BY bor.cno DESC
--8. ��"01"��ͬѧ����ͼ��Ļ��ڶ��ӳ�һ��
UPDATE tb_borrow 
SET rdate = DATEADD(DAY,7,bor.rdate)
FROM tb_card ca,tb_borrow bor 
WHERE ca.class = '01'AND ca.cno = bor.cno
--9�� ��BOOKS����ɾ����ǰ���˽��ĵ�ͼ���¼��
DELETE FROM tb_book WHERE tb_book.bno NOT IN
(SELECT tb_book.bno FROM tb_book,tb_borrow WHERE tb_book.bno = tb_borrow.bno)
--10.��ѯ��ǰͬʱ����"���㷽��"��"�����ѧ"������Ķ��ߣ��������鿨�ţ��������������������
SELECT bor.cno from tb_borrow bor,tb_book bo
WHERE bor.bno = bo.bno
AND bo.bname = '���㷽��' AND exists(
  SELECT bor.cno FROM tb_borrow bbor,tb_book bbo
  where bbor.bno = bbo.bno
  AND bbo.bname='����è'
  AND bor.cno = bbor.cno)
  ORDER BY bor.cno ASC
