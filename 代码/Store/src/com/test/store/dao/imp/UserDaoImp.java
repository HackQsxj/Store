package com.test.store.dao.imp;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import com.test.store.dao.UserDao;
import com.test.store.domain.User;
import com.test.store.utils.JDBCUtils;

public class UserDaoImp implements UserDao {

	@Override
	public void userRegist(User user) throws Exception {
		String sql = "Insert into user values("
				+ "?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		Object[] params = { user.getUid(), user.getUsername(), user.getPassword(), user.getName(),
				user.getEmail(), user.getTelephone(), user.getBirthday(), user.getSex(),
				user.getState(), user.getCode()
		};
		runner.update(sql, params);
	}

	@Override
	public User findByCode(String code) throws SQLException {
		String sql = "select * from user where code=?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		User user = runner.query(sql, new BeanHandler<User>(User.class), code);
		return user;
	}

	@Override
	public void updateUser(User user) throws SQLException {
		String sql = "update user set username = ?, password = ?,"
				+ "name = ?, email = ?, telephone = ?, birthday = ?,"
				+ "sex = ?, state = ?, code = ? where uid = ?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		Object[] params = { user.getUsername(), user.getPassword(), user.getName(),
				user.getEmail(), user.getTelephone(), user.getBirthday(), user.getSex(),
				user.getState(), user.getCode(), user.getUid()
		};
		runner.update(sql, params);
	}

	@Override
	public User userLogin(User user) throws SQLException{
		String sql = "select * from user where username=? and password=?";
		QueryRunner runner = new QueryRunner(JDBCUtils.getDataSource());
		return runner.query(sql, new BeanHandler<User>(User.class), user.getUsername(), user.getPassword());
	}

}
