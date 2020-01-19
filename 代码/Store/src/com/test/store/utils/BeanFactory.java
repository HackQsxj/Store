package com.test.store.utils;

import java.io.InputStream;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class BeanFactory {

	// 解析XML
	public static Object createObject(String name) {

		try {
			// 通过传递过来的name获取application.xml中name对应的class值
			// 获取到Document对象
			SAXReader reader = new SAXReader();
			// 获取xml文件的输入流
			InputStream is = BeanFactory.class.getClassLoader().getResourceAsStream("mysql.xml");
			Document doc = reader.read(is);
			// 获取到根节点beans
			Element rootElement = doc.getRootElement();
			// 获取子节点bean，返回集合
			List<Element> list = rootElement.elements();
			// 遍历集合，判断每个元素id与当前name是否一致
			for (Element ele : list) {
				String id = ele.attributeValue("id");
				if (id.equals(name)) {
					// 一致，获取到当前元素上的class
					String str = ele.attributeValue("class");
					Class clazz = Class.forName(str);
					// 利用class值通过反射创建对象返回
					return clazz.newInstance();
				}
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
		return null;
	}
}
