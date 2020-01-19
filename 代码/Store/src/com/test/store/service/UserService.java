package com.test.store.service;

import java.sql.SQLException;

import com.test.store.domain.User;

public interface UserService {

	void userRegist(User user) throws Exception;
	boolean activeUser(String code) throws SQLException;
	User userLogin(User user) throws SQLException;
}
