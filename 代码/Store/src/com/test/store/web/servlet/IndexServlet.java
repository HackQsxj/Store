package com.test.store.web.servlet;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.store.domain.Product;
import com.test.store.service.ProductService;
import com.test.store.service.imp.ProductServiceImp;
import com.test.store.web.base.BaseServlet;


public class IndexServlet extends BaseServlet {
	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
/*
 * //		调用业务层功能：获取全部分类信息，返回集合
		CategoryService cService = new CategoryServiceImp();
		List<Category> list = cService.getAllCates();
//		将返回的集合放入request
		req.setAttribute("allCates", list);
//		System.out.println(list.toString());

*/
		
//		调用业务层的查询最新商品和最热商品这两个功能
		ProductService pService = new ProductServiceImp();
		List<Product> list01 = pService.findNews();
		List<Product> list02 = pService.findHots();
//		System.out.println(list01.toString());
//		System.out.println(list02.toString());
//		将两个集合放入request
		req.setAttribute("news", list01);
		req.setAttribute("hots", list02);
//		转发到真实的首页
		return "/jsp/index.jsp";
	}
}
