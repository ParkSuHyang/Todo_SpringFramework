package com.github.todo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.github.todo.vo.SharedTodo;

@Mapper
public interface SharedTodoMapper {
	public List<SharedTodo> getSharedTodoByTodoId(Integer id);

	public int deleteSharedTodoList(List<SharedTodo> sharedTodoList);

	public int deleteSharedTodo(SharedTodo sharedTodo);

	public int isExistSharedTodo(SharedTodo sharedTodo);

	public int createSharedTodo(SharedTodo sharedTodo);
}
