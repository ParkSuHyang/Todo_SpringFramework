package com.github.todo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.todo.mapper.SharedTodoMapper;
import com.github.todo.vo.SharedTodo;

@Service
public class SharedTodoService {
	@Autowired
	private SharedTodoMapper sharedTodoMapper;

	public List<SharedTodo> getSharedTodoListByTodoId(Integer id) {
		return sharedTodoMapper.getSharedTodoByTodoId(id);
	}

	public boolean createSharedTodo(SharedTodo sharedTodo) {
		return sharedTodoMapper.createSharedTodo(sharedTodo) > 0;
	}

	public boolean isExistSharedTodo(SharedTodo sharedTodo) {
		return sharedTodoMapper.isExistSharedTodo(sharedTodo) > 0;
	}

	@Transactional
	public boolean deleteSharedTodo(SharedTodo sharedTodo) {
		return sharedTodoMapper.deleteSharedTodo(sharedTodo) > 0;
	}
}
