package com.github.todo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.github.todo.vo.Todo;

@Mapper
public interface TodoMapper {
	public Todo getTodo(Integer id);

	public List<Todo> getAllTodoList();

	public List<Todo> getTodoListByTagId(Integer id);

	public int createTodo(Todo todo);

	public int updateTodo(Todo todo);

	public int deleteTodo(Integer id);

	public List<Todo> getTodoListByDateType(@Param("userId") String userId, @Param("dateType") String dateType);

	public List<Todo> getTodoListByTagIdAndDateType(@Param("tagId") Integer tagId, @Param("userId") String userId,
			@Param("dateType") String dateType);
}
