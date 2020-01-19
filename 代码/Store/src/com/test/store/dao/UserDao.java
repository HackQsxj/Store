package com.test.store.dao;

import java.sql.SQLException;

import com.test.store.domain.User;

public interface UserDao {

	void userRegist(User user) throws Exception;
	User findByCode(String code) throws SQLException;
	void updateUser(User user) throws SQLException;
	User userLogin(User user) throws SQLException;
}
