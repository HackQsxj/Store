package com.test.store.web.servlet;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.store.domain.PageBean;
import com.test.store.domain.Product;
import com.test.store.service.ProductService;
import com.test.store.service.imp.ProductServiceImp;
import com.test.store.web.base.BaseServlet;

/**
 * Servlet implementation class ProductServlet
 */
public class ProductServlet extends BaseServlet {
	
	public String findProductById(HttpServletRequest request, HttpServletResponse response) throws Exception{
//		获取商品pid
		String pid = request.getParameter("pid");
//		根据商品pid查询商品信息
		ProductService pService = new ProductServiceImp();
		Product product = pService.findProductById(pid);
		request.setAttribute("product", product);
		return "/jsp/product_info.jsp";
	}
	public String findByCid(HttpServletRequest request, HttpServletResponse response) throws Exception{
//		接受分类id
		String cid = request.getParameter("cid");
//		当前页
		int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		
//		每页显示个数
		int pageSize = 12;
		ProductService pService = new ProductServiceImp();
		PageBean<Product> pageBean = pService.findByCid(cid, pageNumber, pageSize);
		
//		将数据放入request
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("cid", cid);
		return "/jsp/product_list.jsp";
	}
}
