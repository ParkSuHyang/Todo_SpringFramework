package com.github.todo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.github.todo.vo.User;

@Mapper
public interface UserMapper {
	public int isAuthorizeUser(User user);

	public User getUser(String id);

	public int createUser(User user);
}