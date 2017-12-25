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
('00001','ˮ�',45.56,6),
('00002','����ʮ����',37.56,12),
('00003','��������1566',25.56,67),
('00004','�������',24.56,61),
('00005','������С˵��',45.56,65),
('00006','�����ѧ',52.22,75),
('00007','���㷽��',20.78,69),
('00008','����İ���',45.78,89),
('00009','����������ʿ',35.78,29),
('00010','���㷽��ϰ�⼯',20.78,69)
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


--1. д������BORROW���SQL��䣬Ҫ��������������Լ��������������Լ��

--2. �ҳ����鳬��5���Ķ���,������鿨�ż�����ͼ�����
SELECT bor.cno as '����',COUNT(bor.cno) as '����' 
from tb_borrowl bor GROUP BY bor.cno 
HAVING COUNT(bor.cno)>4

--3. ��ѯ������"ˮ�"һ��Ķ��ߣ�����������༶
--�ڶ��ַ���
SELECT ca.cname,ca.calss from tb_card ca WHERE ca.cno in
(SELECT bor.cno  from tb_borrowl bor where bor.bno =
(SELECT bo.bno  from tb_book bo WHERE bo.bname='ˮ�' ))

--4. ��ѯ����δ��ͼ�飬��������ߣ����ţ�����ż���������

--5. ��ѯ��������"����"�ؼ��ʵ�ͼ�飬�����š�����������
--6. ��ѯ����ͼ���м۸���ߵ�ͼ�飬�������������
--7. ��ѯ��ǰ����"���㷽��"��û�н�"���㷽��ϰ�⼯"�Ķ��ߣ��������鿨�ţ��������Ž����������
--8. ��"01"��ͬѧ����ͼ��Ļ��ڶ��ӳ�һ��
--9�� ��BOOKS����ɾ����ǰ���˽��ĵ�ͼ���¼��
--10.��ѯ��ǰͬʱ����"���㷽��"��"�����ѧ"������Ķ��ߣ��������鿨�ţ��������������������




