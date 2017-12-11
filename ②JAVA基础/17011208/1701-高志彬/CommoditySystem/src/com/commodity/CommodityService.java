package com.commodity;

import java.util.ArrayList;
import java.util.Scanner;

/**
 * @author  ���� E-mail:1456014420@qq.com
 * @date    ����ʱ�䣺2017��11��27�� ����4:24:12 
 * @version 1.0 
 * @parameter  
 * @since  
 * @return  
 * @function
 */
public class CommodityService implements ICommodity {
	/*ģ��һ��������ϵͳ����ҵ��Χ������
	1   ������Ʒ
	2   ����
	3   ����
	4   �ο����
	5   �˳�����
	 */
	@Override
	public void helpInfo() {
		System.out.println("----------��Ʒ������ϵͳ-----------");
		System.out.println("[1].������Ʒ,¼����Ʒ��Ϣ,������Add");
		//1��������Ʒ��¼����Ʒ��Ϣ������Ʒ��š����ơ��۸񡢳�ʼ����
		System.out.println("[2].����,������Ʒ��ź�����,������Stock");
		//2��������������Ʒ��ź����������д˱����Ʒ��
		//��������Ӧ��������û������ʾ����ʧ�ܡ�
		System.out.println("[3].����,������Ʒ��ź�����,������Sell");
		//3�����ۣ�������Ʒ��ź����������д˱����Ʒ����Ʒ������������������
		//�������Ӧ������������ʾ����ʧ�ܡ�
		System.out.println("[4].��ʾ������Ʒ��Ϣ(������Ʒ��š����ơ��۸�����),������Info");
		//4���ο���������ʾ������Ʒ��Ϣ������Ʒ��š�
		//���ơ��۸�����
		System.out.println("[5].�˳�ϵͳ��������Exit");
	}

	@Override
	public void addCommodity(ArrayList<Commodity> arrayList, Scanner sc) {
		
		String string = sc.next();
		String[] a = string.split(",");
		if (a.length!=4) {
			System.out.println("���������Ϣ����");
		} else {
			Commodity commodity = new Commodity(a[0], a[1], 
					Double.parseDouble(a[2]), Long.parseLong(a[3]));
			arrayList.add(commodity);
			System.out.println(commodity.toString());
		}
	}

	@Override
	public void stockCommodity(ArrayList<Commodity> arrayList, Scanner sc) {
		String[] a = sc.next().split(",");
		boolean isSucc=false;
		if (a.length!=2) {
			System.out.println("�������Ϣ���������޷�����");
		}else{
			for (Commodity commodity : arrayList) {
				if (commodity.getId().equals(a[0])) {
					long newNumber=commodity.getNumber()+Long.parseLong(a[1]);
					System.out.println(newNumber);	
					System.out.println(commodity.toString());
					isSucc=true;
				}							
			}									
		}
		if (!isSucc) {
			System.out.println("����ʧ��");
		}
	}

	@Override
	public void sellCommodity(ArrayList<Commodity> arrayList, Scanner sc) {
		String[] a = sc.next().split(",");
		boolean isSucc=false;
		if (a.length!=2) {
			System.out.println("�������Ϣ���������޷�����");
		}else{
			for (Commodity commodity : arrayList) {
				if (commodity.getId().equals(a[0])) {
					if (commodity.getNumber()>Long.parseLong(a[1])) {
						long newNumber=commodity.getNumber()-Long.parseLong(a[1]);
						System.out.println(newNumber);	
						System.out.println(commodity.toString());
						isSucc=true;
					}					
				}							
			}									
		}
		if (!isSucc) {
			System.out.println("����ʧ��");
		}
	}

	@Override
	public void infoCommodity(ArrayList<Commodity> arrayList) {
		for (Commodity commodity : arrayList) {
			System.out.println(commodity);
		}
	}

}
