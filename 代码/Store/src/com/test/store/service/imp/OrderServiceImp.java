package com.test.store.service.imp;


import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.test.store.dao.OrderDao;
import com.test.store.dao.imp.OrderDaoImp;
import com.test.store.domain.Order;
import com.test.store.domain.OrderItem;
import com.test.store.domain.PageBean;
import com.test.store.domain.User;
import com.test.store.service.OrderService;
import com.test.store.utils.BeanFactory;
import com.test.store.utils.JDBCUtils;

public class OrderServiceImp implements OrderService {

	@Override
	public List<Order> findAllOrders() throws Exception {
		
		return dao.findAllOrders();
	}


	@Override
	public List<Order> findAllOrders(String state) throws Exception {
		
		return dao.findAllOrders(state);
	}


	OrderDao dao = (OrderDao) BeanFactory.createObject("OrderDao");
	@Override
	public void saveOrder(Order order) throws SQLException {
//		保存订单和订单下的所有的订单项（使用事务，保证逻辑的全部执行）
		
		/*try {
			JDBCUtils.startTransaction();
			OrderDao dao = new OrderDaoImp();
			dao.saveOrder(order);
			for (OrderItem item : order.getList()) {
				dao.saveOrderItem(item);
			}
			JDBCUtils.commitAndClose();
		} catch (Exception e) {
			JDBCUtils.rollbackAndClose();
			e.printStackTrace();
		}*/
		Connection conn = null;
		try{
//			获取连接
			conn = JDBCUtils.getConnection();
//			开启事务
			conn.setAutoCommit(false);
//			保存订单
			
			dao.saveOrder(conn, order);
//			保存订单项
			for (OrderItem item : order.getList()) {
				dao.saveOrderItem(conn, item);
			}
//			提交
			conn.commit();
		}catch (Exception e){
//			回滚
			conn.rollback();
		}
	}


	@Override
	public PageBean<Order> findMyOrdersWithPage(User user, int pageNumber) throws Exception {
//		计算订单总数
		int totalRecord = dao.getTotalRecords(user.getUid());
//		创建PageBean对象，计算并携带分页参数
		PageBean<Order> pageBean = new PageBean<>(pageNumber, 3, totalRecord);
//		关联集合
		List<Order> list = dao.findMyOrdersWithPage(user, pageBean.getStartIndex(), pageBean.getPageSize());

		pageBean.setList(list);;
//		关联url
		pageBean.setPath("OrderServlet?method=findMyOrdersWithPage");
		
		return pageBean;
	}


	@Override
	public Order findOrderByOid(String oid) throws Exception {
		return dao.findOrderByOid(oid);
	}


	@Override
	public void updateOrder(Order order) throws Exception {
	
		dao.updateOrder(order);
	}


}
