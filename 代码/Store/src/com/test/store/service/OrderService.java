package com.test.store.service;

import java.util.List;

import com.test.store.domain.Order;
import com.test.store.domain.PageBean;
import com.test.store.domain.User;


public interface OrderService {

	void saveOrder(Order order) throws Exception;


	PageBean<Order> findMyOrdersWithPage(User user, int pageNumber) throws Exception;


	Order findOrderByOid(String oid) throws Exception;


	void updateOrder(Order order) throws Exception;


	List<Order> findAllOrders() throws Exception;


	List<Order> findAllOrders(String state) throws Exception;

}
