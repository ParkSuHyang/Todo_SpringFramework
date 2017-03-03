package com.github.todo.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.todo.mapper.TagMapper;
import com.github.todo.mapper.TodoMapper;
import com.github.todo.util.constants.DateConstant;
import com.github.todo.vo.Tag;
import com.github.todo.vo.Todo;

@Service
public class TagService {
	@Autowired
	private TagMapper tagMapper;

	@Autowired
	private TodoMapper todoMapper;

	public boolean createTag(Tag tag) {
		return tagMapper.createTag(tag) > 0;
	}

	public boolean updateTag(Tag tag) {
		return tagMapper.updateTag(tag) > 0;
	}

	@Transactional
	public boolean deleteTag(Integer id) {
		List<Todo> todoList = todoMapper.getTodoListByTagId(id);

		for (Todo todo : todoList) {
			todo.setTag(null);
		}

		return tagMapper.deleteTag(id) > 0;
	}

	public Tag getTag(Integer id) {
		return tagMapper.getTagById(id);
	}

	public List<Tag> getTagListByUserId(String userId) {
		return tagMapper.getTagListByUserId(userId);
	}

	public HashMap<String, List<Todo>> getTodoListByTagIdAndDateType(Integer id, String userId) {
		HashMap<String, List<Todo>> todos = new HashMap<String, List<Todo>>();
		List<Todo> pastTodo = todoMapper.getTodoListByTagIdAndDateType(id, userId, DateConstant.PAST_TODO);
		List<Todo> todayTodo = todoMapper.getTodoListByTagIdAndDateType(id, userId, DateConstant.TODAY_TODO);
		List<Todo> tomorrowTodo = todoMapper.getTodoListByTagIdAndDateType(id, userId, DateConstant.TOMORROW_TODO);
		List<Todo> laterTodo = todoMapper.getTodoListByTagIdAndDateType(id, userId, DateConstant.LATER_TODO);
		List<Todo> undefinedTodo = todoMapper.getTodoListByTagIdAndDateType(id, userId, DateConstant.UNDEFINED_TODO);

		todos.put(DateConstant.PAST_TODO, pastTodo);
		todos.put(DateConstant.TODAY_TODO, todayTodo);
		todos.put(DateConstant.TOMORROW_TODO, tomorrowTodo);
		todos.put(DateConstant.LATER_TODO, laterTodo);
		todos.put(DateConstant.UNDEFINED_TODO, undefinedTodo);

		return todos;
	}
}
