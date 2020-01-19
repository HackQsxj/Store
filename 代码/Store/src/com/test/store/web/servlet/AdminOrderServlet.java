package com.test.store.web.servlet;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.store.domain.Order;
import com.test.store.service.OrderService;
import com.test.store.service.imp.OrderServiceImp;
import com.test.store.web.base.BaseServlet;

import net.sf.json.JSONArray;

/**
 * Servlet implementation class AdminOrderServlet
 */
public class AdminOrderServlet extends BaseServlet {

	
	public String findAllOrders(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String state = request.getParameter("state");
		OrderService oService = new OrderServiceImp();
		List<Order> list = null;
		if(null == state||"".equals(state)){
//		获取全部订单
			list = oService.findAllOrders();
		}else{
			list = oService.findAllOrders(state);
		}
//		将全部订单放入request
		request.setAttribute("allOrders", list);
//		转发
		return "/admin/order/list.jsp";
	}
	public String findOrderByOidWithAjax(HttpServletRequest request, HttpServletResponse response) throws Exception {

//		获取服务端订单id
		String oid = request.getParameter("id");
//		调用业务层
		OrderService oService = new OrderServiceImp();
		Order order = oService.findOrderByOid(oid);
//		将返回的集合转换为JSON格式字符串
		String jsonStr = JSONArray.fromObject(order.getList()).toString();
//		响应到客户端
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().println(jsonStr);
		return null;
	}
	public String updateOrderByOid(HttpServletRequest request, HttpServletResponse response) throws Exception {

//		获取订单id
		String oid = request.getParameter("oid");
//		调用业务层查询
		OrderService oService = new OrderServiceImp();
		Order order = oService.findOrderByOid(oid);
//		修改订单状态
		order.setState(3);
		oService.updateOrder(order);
//		重定向到
		response.sendRedirect("/Demo16Store/AdminOrderServlet?method=findAllOrders&state=3");
		return null;
	}
}
