package com.test.store.service;

import java.util.List;

import com.test.store.domain.PageBean;
import com.test.store.domain.Product;

public interface ProductService {

	List<Product> findNews() throws Exception;

	List<Product> findHots() throws Exception;

	Product findProductById(String pid) throws Exception;

	PageBean<Product> findByCid(String cid, int pageNumber, int pageSize) throws Exception;

	void setNullByCid(String cid) throws Exception;

	List<Product> findByCid(String cid) throws Exception;

	PageBean<Product> findAllProductsWithPage(int pageNumber) throws Exception;

	void saveProduct(Product product) throws Exception;

}
