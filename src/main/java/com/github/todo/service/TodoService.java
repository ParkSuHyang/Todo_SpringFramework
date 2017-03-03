package com.github.todo.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.todo.mapper.SharedTodoMapper;
import com.github.todo.mapper.TodoMapper;
import com.github.todo.util.constants.DateConstant;
import com.github.todo.vo.SharedTodo;
import com.github.todo.vo.Todo;

@Service
public class TodoService {
	@Autowired
	private TodoMapper todoMapper;

	@Autowired
	private SharedTodoMapper sharedTodoMapper;

	public boolean createTodo(Todo todo, String userId) {
		Todo setTodo = setCorrectEndDateTime(todo);
		todo.setUserId(userId);

		return todoMapper.createTodo(setTodo) > 0;
	}

	public boolean updateTodo(Todo todo) {
		Todo setTodo = setCorrectEndDateTime(todo);

		return todoMapper.updateTodo(setTodo) > 0;
	}

	@Transactional
	public boolean deleteTodo(Integer id) {
		if (todoMapper.deleteTodo(id) > 0) {
			List<SharedTodo> sharedTodoList = sharedTodoMapper.getSharedTodoByTodoId(id);
			if (sharedTodoList.size() != 0) {
				return sharedTodoMapper.deleteSharedTodoList(sharedTodoList) > 0;
			}
			return true;
		}

		return false;
	}

	public Todo getTodo(Integer id) {
		return todoMapper.getTodo(id);
	}

	public boolean isWriter(Integer id, String userId) {
		Todo todo = getTodo(id);
		return todo.getUserId().equals(userId);
	}

	public Todo setCorrectEndDateTime(Todo todo) {
		if (todo.getEndDate().equals("") || todo.getEndTime().equals("")) {
			todo.setEndDate(null);
			todo.setEndTime(null);
		}

		return todo;
	}

	public HashMap<String, List<Todo>> getTodoListByUserId(String id) {
		HashMap<String, List<Todo>> todos = new HashMap<String, List<Todo>>();
		List<Todo> pastTodo = todoMapper.getTodoListByDateType(id, DateConstant.PAST_TODO);
		List<Todo> todayTodo = todoMapper.getTodoListByDateType(id, DateConstant.TODAY_TODO);
		List<Todo> tomorrowTodo = todoMapper.getTodoListByDateType(id, DateConstant.TOMORROW_TODO);
		List<Todo> laterTodo = todoMapper.getTodoListByDateType(id, DateConstant.LATER_TODO);
		List<Todo> undefinedTodo = todoMapper.getTodoListByDateType(id, DateConstant.UNDEFINED_TODO);

		todos.put(DateConstant.PAST_TODO, pastTodo);
		todos.put(DateConstant.TODAY_TODO, todayTodo);
		todos.put(DateConstant.TOMORROW_TODO, tomorrowTodo);
		todos.put(DateConstant.LATER_TODO, laterTodo);
		todos.put(DateConstant.UNDEFINED_TODO, undefinedTodo);

		return todos;
	}
}