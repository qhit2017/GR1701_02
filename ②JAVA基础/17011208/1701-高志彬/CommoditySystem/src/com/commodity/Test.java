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
public class Test {

	public static void main(String[] args) {
		
		ArrayList<Commodity> arrayList =new ArrayList<Commodity>();
		
		CommodityService service =new CommodityService();
		
		Scanner sc = new Scanner(System.in);
		
		service.helpInfo();		
		boolean isQuit = true;
		String s ;
		while (isQuit) {
			s = sc.next();
			switch (s) {
			case "Add":
				System.out.println("¼����Ʒ��Ϣ������Ʒ��š����ơ��۸񡢳�ʼ����");
				service.addCommodity(arrayList, sc);
				break;
			case "Stock":
				service.stockCommodity(arrayList, sc);
				break;
			case "Sell":
				service.sellCommodity(arrayList, sc);
				break;
			case "Info":
				service.infoCommodity(arrayList);				
				break;
			case "Exit":
				isQuit = false;
				break;														
			default:
				break;
			}
			
		}
		System.out.println("�˳�ϵͳ");

		
		
		
		
		
		

	}

}
