package com.test.store.dao;

import java.util.List;

import com.test.store.domain.Category;

public interface CategoryDao {

	List<Category> getAllCates() throws Exception;

	void addCategory(Category c) throws Exception;

	void delCategory(String cid) throws Exception;

	void updateCategory(String cid, String cname) throws Exception;

}
