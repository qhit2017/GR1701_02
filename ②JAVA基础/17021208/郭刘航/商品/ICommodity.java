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
public interface ICommodity {

	void helpInfo();
	
	void addCommodity(ArrayList<Commodity> arrayList,Scanner sc);
	
	void stockCommodity(ArrayList<Commodity> arrayList,Scanner sc);
	
	void sellCommodity(ArrayList<Commodity> arrayList,Scanner sc);
	
	void infoCommodity(ArrayList<Commodity> arrayList);
}
