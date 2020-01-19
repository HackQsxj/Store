package com.test.store.test;

import org.junit.Test;

import com.test.store.dao.ProductDao;
import com.test.store.dao.imp.ProductDaoImp;

public class TestDemo {
	@Test
	public void TestRecord() throws Exception{
		ProductDao dao = new ProductDaoImp();
		int total = dao.findTotalRecordByCid("1");
		System.out.println(total);
	}
}
