package com.test.store.dao.imp;

import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.test.store.dao.CategoryDao;
import com.test.store.domain.Category;
import com.test.store.utils.JDBCUtils;

public class CategoryDaoImp implements CategoryDao{

	@Override
	public List<Category> getAllCates() throws Exception {
		String sql = "select * from category";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		return runner.query(sql, new BeanListHandler<Category>(Category.class));
	}

	@Override
	public void addCategory(Category c) throws Exception {
		String sql = "insert into category values (?,?)";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		runner.update(sql, c.getCid(), c.getCname());
	}

	@Override
	public void delCategory(String cid) throws Exception {
		String sql = "delete from category where cid=?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		runner.update(sql, cid);
	}

	@Override
	public void updateCategory(String cid, String cname) throws Exception {
		String sql = "update category set cname=? where cid=?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		runner.update(sql, cname, cid);
	}


}
