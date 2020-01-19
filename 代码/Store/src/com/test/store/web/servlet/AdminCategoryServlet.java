package com.test.store.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.store.domain.Category;
import com.test.store.domain.PageBean;
import com.test.store.domain.Product;
import com.test.store.service.CategoryService;
import com.test.store.service.ProductService;
import com.test.store.service.imp.CategoryServiceImp;
import com.test.store.service.imp.ProductServiceImp;
import com.test.store.utils.UUIDUtils;
import com.test.store.web.base.BaseServlet;

/**
 * Servlet implementation class AdminCategoryServlet
 */
public class AdminCategoryServlet extends BaseServlet {
	
	public String findAllCates(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
//		获取全部的分类信息
		CategoryService cService = new CategoryServiceImp();
		List<Category> list = cService.getAllCates();
//		放入request
		request.setAttribute("allCates", list);
//		转发到指定页面
		return "/admin/category/list.jsp";
	}
	public String addCategoryUI(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		return "/admin/category/add.jsp";
	}
	public String save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String cname = request.getParameter("cname");
		String cid = UUIDUtils.getId();
		Category c = new Category();
		c.setCid(cid);
		c.setCname(cname);
//		调用业务层添加分类功能
		CategoryService cService = new CategoryServiceImp();
		cService.addCategory(c);
		response.sendRedirect("/Demo16Store/AdminCategoryServlet?method=findAllCates");
		return null;
	}
	public String delCategory(HttpServletRequest request, HttpServletResponse response) throws Exception{
//		获取该分类id
		String cid = request.getParameter("cid");
		System.out.println(cid);
//		调用业务层查询该分类是否有商品关联
		ProductService pService = new ProductServiceImp();
		List<Product> list = pService.findByCid(cid);
//		有商品关联，则将相关商品上的cid设置为null
		if(null != list){
			pService.setNullByCid(cid);
		}
//		调用业务层删除该分类
		CategoryService cService = new CategoryServiceImp();
		cService.delCategory(cid);
//		重定向
		response.sendRedirect("/Demo16Store/AdminCategoryServlet?method=findAllCates");
		return null;
	}
	public String editCategory(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cid = request.getParameter("cid");
		request.setAttribute("editCatecid", cid);
		return "/admin/category/edit.jsp";
	}
	public String update(HttpServletRequest request, HttpServletResponse response) throws Exception{
//		获取分类名称、id
		String cid = request.getParameter("cid");
		String cname = request.getParameter("cname");
//		System.out.println("cid="+cid+"cname="+cname);
//		调用业务层更新
		CategoryService cService = new CategoryServiceImp();
		cService.updateCategory(cid, cname);
//		重定向
		response.sendRedirect("/Demo16Store/AdminCategoryServlet?method=findAllCates");
		return null;
	}
}
