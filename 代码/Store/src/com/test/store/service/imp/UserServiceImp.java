package com.test.store.service.imp;

import java.sql.SQLException;

import com.test.store.dao.UserDao;
import com.test.store.dao.imp.UserDaoImp;
import com.test.store.domain.User;
import com.test.store.service.UserService;
import com.test.store.utils.BeanFactory;

public class UserServiceImp implements UserService {

	UserDao dao = (UserDao) BeanFactory.createObject("UserDao");
	@Override
	public void userRegist(User user) throws Exception {
//		实现注册功能
		dao.userRegist(user);
	}

	@Override
	public boolean activeUser(String code) throws SQLException {
//		实现账户激活功能
		User user = dao.findByCode(code);
		if(null != user){
//			可以根据激活码查询到一个用户
//			修改用户的状态，清楚激活码
			user.setState(1);
			user.setCode(null);
			dao.updateUser(user);
			return true;
		}else{
//			不可以根据激活码查询到用户
			return false;
		}
	}

	@Override
	public User userLogin(User user) throws SQLException {
//		此处可用异常来传递一些信息
		User uu = dao.userLogin(user);
		if(null == uu){
//			表示密码不正确或用户不存在
			throw new RuntimeException("密码不正确或用户不存在");
		}else if(uu.getState() == 0){
			throw new RuntimeException("用户未激活");
		}else{
			return uu;
		}
	}
	
}
