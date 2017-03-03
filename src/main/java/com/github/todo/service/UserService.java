package com.github.todo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.todo.mapper.UserMapper;
import com.github.todo.vo.User;

@Service
public class UserService {
	@Autowired
	private UserMapper userMapper;

	public boolean isAuthorizeUser(User user) {
		return userMapper.isAuthorizeUser(user) > 0;
	}

	public boolean isExistId(String id) {
		if (userMapper.getUser(id) == null) {
			return false;
		}
		return true;
	}

	public boolean createUser(User user) {
		return userMapper.createUser(user) > 0;
	}
}