CREATE database db_multilist
use db_multilist

CREATE table tb_Borrow(
cno nvarchar(32) prIMARY KEY,
cname nvarchar(32) not null,
class nvarchar(8))   --�����
ALTER table tb_Borrow alter column class nvarchar(8)

CREATE table tb_books(
bno nvarchar(32) prIMARY KEY,
bname nvarchar(32) not null,
nuthor nvarchar(16),
priace decimal(8,4),
repertory smallint)--ͼ���
--�����¼��
CREATE table tb_BorrowRecord(
id tinyint identity(1,1),
cno nvarchar(32),
bno nvarchar(32),
BorrowDate date)--��������
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
values('00001','ˮ�','ʩ����',45.56,6),
('00002','����ʮ����','������',37.56,12),
('00003','��������1566','����ƽ',25.56,67),
('00004','�������','����ˮ��',24.56,61),
('00005','������С˵��','������',45.56,65),
('00006','�����ѧ','���޸�',52.22,75),
('00007','���㷽��','̷��ǿ',20.78,69),
('00008','����İ���','JackieYan',45.78,89),
('00009','����������ʿ','ëķ',35.78,29),
('00010','���㷽��ϰ�⼯','̷��ǿ',20.78,69)
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
SELECT * FROM tb_Borrow --�����
SELECT * FROM tb_books --ͼ���
SELECT * FROM tb_BorrowRecord --��������
select name from sys.objects where type ='u'
sp_help tb_BorrowRecord

--1. д������BORROW���SQL��䣬Ҫ��������������Լ��������������Լ��
--2. �ҳ����鳬��5���Ķ���,������鿨�ż�����ͼ�����
--3. ��ѯ������"ˮ�"һ��Ķ��ߣ�����������༶
--4. ��ѯ����δ��ͼ�飬��������ߣ����ţ�����ż���������
--5. ��ѯ��������"����"�ؼ��ʵ�ͼ�飬�����š�����������
--6. ��ѯ����ͼ���м۸���ߵ�ͼ�飬�������������
--7. ��ѯ��ǰ����"���㷽��"��û�н�"���㷽��ϰ�⼯"
--�Ķ��ߣ��������鿨�ţ��������Ž����������
--8. ��"01"��ͬѧ����ͼ��Ļ��ڶ��ӳ�һ��
--9�� ��BOOKS����ɾ����ǰ���˽��ĵ�ͼ���¼��
--10.��ѯ��ǰͬʱ����"���㷽��"��"�����ѧ"
--������Ķ��ߣ��������鿨�ţ��������������������