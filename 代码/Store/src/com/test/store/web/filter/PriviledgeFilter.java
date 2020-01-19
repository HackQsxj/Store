package com.test.store.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.test.store.domain.User;


public class PriviledgeFilter implements Filter {


    public PriviledgeFilter() {
        
    }


	public void destroy() {
		
	}


	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest)request;
//		判断当前的session中是否存在登录成功的用户
		User user = (User)req.getSession().getAttribute("loginUser");
		if(null != user){
//		存在，放行；不存在，转到提示页面
			chain.doFilter(request, response);			
		}else{
			req.setAttribute("msg", "请登录后再访问");
			req.getRequestDispatcher("/jsp/info.jsp").forward(request, response);
		}
	}


	public void init(FilterConfig fConfig) throws ServletException {
		
	}

}
