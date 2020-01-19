package com.test.store.web.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.store.domain.User;
import com.test.store.service.UserService;
import com.test.store.service.imp.UserServiceImp;
import com.test.store.utils.MailUtils;
import com.test.store.utils.MyBeanUtils;
import com.test.store.utils.UUIDUtils;
import com.test.store.web.base.BaseServlet;

public class UserServlet extends BaseServlet {
	/**
	 * 用户退出
	 * @throws Exception 
	 */
	public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception{
//		清除session
		request.getSession().invalidate();
//		重定向到首页
		response.sendRedirect("/Demo16Store/index.jsp");
		return null;
	}
	/**
	 * 用户登录
	 */
	public String loginUI(HttpServletRequest request, HttpServletResponse response){
		return "/jsp/login.jsp";
	}
	public String loginUser(HttpServletRequest request, HttpServletResponse response){
//		获取用户数据
		User user = new User();
		MyBeanUtils.populate(user, request.getParameterMap());
//		调用业务层登录功能
		UserService userService = new UserServiceImp();
		try {
			user = userService.userLogin(user);
//			用户登录成功，将用户信息放入session中
			request.getSession().setAttribute("loginUser", user);
//			重定向到首页
			response.sendRedirect("/Demo16Store/index.jsp");
			return null;
		} catch (Exception e) {
			
//			用户登录失败
			String msg = e.getMessage();
			System.out.println(msg);
//			页面显示用户登录失败
			request.setAttribute("msg", msg);
			return "/jsp/login.jsp";
		}
	}
	/**
	 * 用户激活
	 * @throws SQLException 
	 */
	public String active(HttpServletRequest request, HttpServletResponse response) throws SQLException{
//		获取激活码
		String code = request.getParameter("code");
//		调用业务层激活功能
		UserService userService = new UserServiceImp();
		boolean flag = userService.activeUser(code);
		if(flag == true){
			request.setAttribute("msg", "用户激活成功，请登录");
			return "/jsp/login.jsp";
		}else{
			request.setAttribute("msg", "用户激活失败，请重新激活");
			return "/jsp/info.jsp";
		}

	}
	/**
	 * 注册页面
	 * @param request
	 * @param response
	 * @return
	 */
	public String registUI(HttpServletRequest request, HttpServletResponse response){
		return "/jsp/register.jsp";
	}
	public String userRegister(HttpServletRequest request, HttpServletResponse response){
//		接收表单参数
		Map<String, String[]> map = request.getParameterMap();
/*		for (Map.Entry<String, String[]> entry : map.entrySet()) {
			
		}*/
		/*Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while(iterator.hasNext()){
			String str = iterator.next();
			System.out.println(str);
			String[] strs = map.get(str);
			for(String string : strs){
				System.out.println(string);
			}
		}*/
		User user = new User();
		MyBeanUtils.populate(user, map);
		user.setUid(UUIDUtils.getId());
		user.setState(0);
		user.setCode(UUIDUtils.getCode());
		System.out.println(user);
//		调用业务层注册功能
		UserService userService = new UserServiceImp();
		try {
			//		注册成功，向用户邮箱发送信息，跳转到提示页面
			userService.userRegist(user);
			MailUtils.sendMail(user.getEmail(), user.getCode());
			request.setAttribute("msg", "用户注册成功,请激活");
		} catch (Exception e) {
//			注册失败，跳转到提示页面
			request.setAttribute("msg", "用户注册失败,请重新注册");
		}
		return "/jsp/info.jsp";
	}
}
