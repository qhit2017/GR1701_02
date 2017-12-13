package Commodity;

import java.util.ArrayList;
import java.util.Scanner;

/** 
 * @author  ���� E-mail:1561061182@qq.com
 * @date    ����ʱ�䣺2017��11��8�� ����6:44:32 
 * @version 1.0 
 * @parameter  
 * @since  
 * @return  
 * @function
 */
public class CommodityService implements ICommodity {

	@Override
	public void helpInfo() {
		System.out.println("-----��Ʒ����ϵͳ-----");
		System.out.println("��1��������Ʒ������Add");
 	   	System.out.println("��2������������Stock");
 	   	System.out.println("��3������������Sell");
 	   	System.out.println("��4���ο����������Info");
 	   	System.out.println("��5���˳�����������Quit");
	}

	@Override
	public void addCommodity(ArrayList<Commodity> arrayList, Scanner sc) {
		String string = sc.next();
		String[] a = string.split(",");
		
		if (a.length != 4) {
			System.out.println("You have been wrong��������");
		} else {
			Commodity commodity = new Commodity(a[0], a[1], Double.parseDouble(a[2]), Long.parseLong(a[3]));
			arrayList.add(commodity);
			System.out.println(commodity.toString());
		}
	}

	@Override
	public void stockCommodity(ArrayList<Commodity> arrayList, Scanner sc) {
		String[] a = sc.next().split(",");
		boolean isSuc = false;
		if (a.length != 2) {
			System.out.println("You have been wrong!!!!");
		} else {
			for (Commodity commodity : arrayList) {
				if (commodity.getId().equals(a[0])) {
					long newNumber = commodity.getNumber()+Long.parseLong(a[1]);
					commodity.setNumber(newNumber);
					System.out.println(commodity.toString());
					isSuc = true;
				}
			}
		}
		if (!isSuc) {
			System.out.println("����ʧ�ܣ�������");
		}
	}

	@Override
	public void sellCommodity(ArrayList<Commodity> arrayList, Scanner sc) {
		String[] a = sc.next().split(",");
		boolean isSuc = false;
		if (a.length != 2) {
			System.out.println("You have been wrong!!!!");
		} else {
			for (Commodity commodity : arrayList) {
				if (commodity.getId().equals(a[0])) {
					if (commodity.getNumber()>Long.parseLong(a[1])) {
						long newNumber = commodity.getNumber()-Long.parseLong(a[1]);
						commodity.setNumber(newNumber);
						System.out.println(commodity.toString());
						isSuc = true;
					}
				}
			}
		}
		if (!isSuc) {
			System.out.println("����ʧ�ܣ�������");
		}
	}

	@Override
	public void infoCommodity(ArrayList<Commodity> arrayList) {
		for (Commodity commodity : arrayList) {
			System.out.println(commodity.toString());
		}
	}

}
