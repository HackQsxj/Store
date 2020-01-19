package com.test.store.dao.imp;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.test.store.dao.OrderDao;
import com.test.store.domain.Order;
import com.test.store.domain.OrderItem;
import com.test.store.domain.Product;
import com.test.store.domain.User;
import com.test.store.utils.JDBCUtils;

public class OrderDaoImp implements OrderDao {

	@Override
	public List<Order> findAllOrders() throws Exception {
		
		String sql = "select * from orders";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		List<Order> list = runner.query(sql, new BeanListHandler<Order>(Order.class));
		return list;
	}

	@Override
	public List<Order> findAllOrders(String state) throws Exception {
		String sql = "select * from orders where state=?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		List<Order> list = runner.query(sql, new BeanListHandler<Order>(Order.class), state);
		return list;
	}

	@Override
	public void saveOrder(Connection conn, Order order) throws Exception {
	
		String sql = "insert into orders values (?,?,?,?,?,?,?,?)";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		Object[] params = {order.getOid(), order.getOrdertime(), order.getTotal(),
				order.getState(), order.getAddress(), order.getName(), order.getTelephone(),
				order.getUser().getUid()};
		runner.update(conn, sql, params);
		
	}

	@Override
	public void saveOrderItem(Connection conn, OrderItem item) throws Exception {
	
		String sql = "insert into orderitem values (?,?,?,?,?)";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		Object[] params = {item.getItemid(), item.getQuantity(), item.getTotal(),
				item.getProduct().getPid(), item.getOrder().getOid()};
		runner.update(conn, sql, params); 
	}

	@Override
	public int getTotalRecords(String uid) throws Exception {
		
		String sql = "select count(*) from orders where uid=?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		Long pageNumber = (Long)runner.query(sql, new ScalarHandler(), uid);
		return pageNumber.intValue();
	}

	@Override
	public List<Order> findMyOrdersWithPage(User user, int startIndex, int pageSize) throws Exception {
		String sql = "select * from orders where uid=? limit ?,?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		List<Order> list = runner.query(sql, new BeanListHandler<Order>(Order.class), user.getUid(), startIndex, pageSize);
		
//		遍历订单
		for (Order order : list) {
//			获取每笔订单的oid
			String oid = order.getOid();
//			查询每笔订单下的订单项以及订单商品信息
			sql = "select * from orderitem o ,product p"
					+ " where o.pid=p.pid and oid=?";
//			将数据库中的数据查询出来并存放到List<Map>中
			List<Map<String, Object>> list02 = runner.query(sql, new MapListHandler(), oid);
			
			for (Map<String, Object> map : list02) {
				OrderItem orderItem = new OrderItem();
				Product product = new Product();
				
				// 由于BeanUtils将字符串"1992-3-3"向user对象的setBithday();方法传递参数有问题,手动向BeanUtils注册一个时间类型转换器
				// 1_创建时间类型的转换器
				DateConverter dt = new DateConverter();
				// 2_设置转换的格式
				dt.setPattern("yyyy-MM-dd");
				// 3_注册转换器
				ConvertUtils.register(dt, java.util.Date.class);
				
				BeanUtils.populate(orderItem, map);
				BeanUtils.populate(product, map);
//				让每个订单项与商品发生关联关系
				orderItem.setProduct(product);
//				将每个订单项存入订单
				order.getList().add(orderItem);
			}
		}
		
		return list;
	}

	@Override
	public Order findOrderByOid(String oid) throws Exception {
		String sql = "select * from orders where oid=?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		Order order = runner.query(sql, new BeanHandler<Order>(Order.class), oid);
//		根据订单id，查询订单所有的订单项和商品信息
		sql = "select * from orderitem o ,product p"
					+ " where o.pid=p.pid and oid=?";
		List<Map<String, Object>> list02 = runner.query(sql, new MapListHandler(), oid);
		
		for (Map<String, Object> map : list02) {
			OrderItem orderItem = new OrderItem();
			Product product = new Product();
			
			// 由于BeanUtils将字符串"1992-3-3"向user对象的setBithday();方法传递参数有问题,手动向BeanUtils注册一个时间类型转换器
			// 1_创建时间类型的转换器
			DateConverter dt = new DateConverter();
			// 2_设置转换的格式
			dt.setPattern("yyyy-MM-dd");
			// 3_注册转换器
			ConvertUtils.register(dt, java.util.Date.class);
			
			BeanUtils.populate(orderItem, map);
			BeanUtils.populate(product, map);
//			让每个订单项与商品发生关联关系
			orderItem.setProduct(product);
//			将每个订单项存入订单
			order.getList().add(orderItem);
		}
		return order;
	}

	@Override
	public void updateOrder(Order order) throws Exception {
	
		String sql = "update orders set ordertime=?, "
				+ "total=?, state=?, address=?, name=?, "
				+ "telephone=? where oid=?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		Object[] params = {order.getOrdertime(), order.getTotal(), 
				order.getState(), order.getAddress(), order.getName(), 
				order.getTelephone(), order.getOid()};
		runner.update(sql, params);
	}
}
