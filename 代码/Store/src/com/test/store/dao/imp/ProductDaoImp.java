package com.test.store.dao.imp;

import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.test.store.dao.ProductDao;
import com.test.store.domain.Product;
import com.test.store.utils.JDBCUtils;

public class ProductDaoImp implements ProductDao {

	@Override
	public void saveProduct(Product product) throws Exception {
		String sql = "insert into product values (?,?,?,?,?,?,?,?,?,?)";
		QueryRunner runner = new  QueryRunner(JDBCUtils.getDataSource());
		Object[] params={product.getPid(),product.getPname(),product.getMarket_price(),
				product.getShop_price(),product.getPimage(),product.getPdate(),product.getIs_hot(),
				product.getPdesc(),product.getPflag(),product.getCid()};
		runner.update(sql, params);
	}

	@Override
	public List<Product> findNews() throws Exception {
		String sql = "select * from product where pflag=0"
				+ " order by pdate desc limit 0, 9";
		QueryRunner runner = new  QueryRunner(JDBCUtils.getDataSource());
		return runner.query(sql, new BeanListHandler<Product>(Product.class));
	}

	@Override
	public List<Product> findHots() throws Exception {
		String sql = "select * from product where pflag=0"
				+ " and is_hot=1 order by pdate desc limit 0, 9";
		QueryRunner runner = new  QueryRunner(JDBCUtils.getDataSource());
		return runner.query(sql, new BeanListHandler<Product>(Product.class));
	}

	@Override
	public Product findProductById(String pid) throws Exception {
		String sql = "select * from product where pid=?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		return runner.query(sql, new BeanHandler<Product>(Product.class), pid);
	}

	@Override
	public List<Product> findAllByCid(String cid, int startIndex, int pageSize) throws Exception {
		String sql = "select * from product where cid=? and"
				+ " pflag=? order by pdate desc limit ?,?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		List<Product> list = runner.query(sql, new BeanListHandler<Product>(Product.class), cid, 0, startIndex, pageSize);
		return list;
	}

	@Override
	public int findTotalRecordByCid(String cid) throws Exception {
		String sql = "select count(*) from product where cid=?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		Long totalRecord = (Long) runner.query(sql, new ScalarHandler(), cid);
		return totalRecord.intValue();
	}

	@Override
	public void setNullByCid(String cid) throws Exception {
		String sql = "update product set cid=null where cid=?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		runner.update(sql, cid);
	}

	@Override
	public List<Product> findByCid(String cid) throws Exception {
		String sql = "select * from product where cid=?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		return runner.query(sql, new BeanListHandler<Product>(Product.class), cid);
	}

	@Override
	public int findTotalRecord() throws Exception {
		String sql = "select count(*) from product";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		Long totalRecord = (Long) runner.query(sql, new ScalarHandler());
		return totalRecord.intValue();
	}

	@Override
	public List<Product> findAllProductsWithPage(int startIndex, int pageSize) throws Exception {
		String sql = "select * from product order by pdate desc limit ?,?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		return runner.query(sql, new BeanListHandler<Product>(Product.class), startIndex, pageSize);
	}
}
