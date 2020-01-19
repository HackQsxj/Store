package com.test.store.dao;

import java.util.List;

import com.test.store.domain.Product;

public interface ProductDao {


	List<Product> findNews() throws Exception;

	List<Product> findHots() throws Exception;

	Product findProductById(String pid) throws Exception;

	int findTotalRecordByCid(String cid) throws Exception;

	List<Product> findAllByCid(String cid, int startIndex, int pageSize) throws Exception;

	void setNullByCid(String cid) throws Exception;

	List<Product> findByCid(String cid) throws Exception;

	int findTotalRecord() throws Exception;

	List<Product> findAllProductsWithPage(int startIndex, int pageSize) throws Exception;

	void saveProduct(Product product) throws Exception;

}
