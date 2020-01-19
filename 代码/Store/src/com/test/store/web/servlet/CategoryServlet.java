package com.test.store.web.servlet;

import com.test.store.domain.Category;
import com.test.store.service.CategoryService;
import com.test.store.service.imp.CategoryServiceImp;
import com.test.store.utils.JedisUtils;
import com.test.store.web.base.BaseServlet;

import net.sf.json.JSONArray;
import redis.clients.jedis.Jedis;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CategoryServlet
 */
public class CategoryServlet extends BaseServlet {

	public String findAllCates(HttpServletRequest request, HttpServletResponse response) throws Exception{

//		在redis中获取全部分类信息
		Jedis jedis = JedisUtils.getJedis();
		String jsonStr = jedis.get("allCates");
		if(null == jsonStr||"".equals(jsonStr)){
//			调用业务层获取全部分类
			CategoryService cService = new CategoryServiceImp();
			List<Category> list = cService.getAllCates();
			
//			将全部分类转换为JSON格式的数据
			jsonStr = JSONArray.fromObject(list).toString();
			System.out.println("redis中没有数据");
//			将json格式数据放入Redis中
			jedis.set("allCates", jsonStr);
//			将全部分类响应到客户端
//			告诉浏览器本次响应的数据是JSON格式的字符串
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().print(jsonStr);
		}else{
//			缓存中有数据
//			System.out.println("redis中有数据");
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().print(jsonStr);
		}
		JedisUtils.closeJedis(jedis);
		return null; 
	}
}
