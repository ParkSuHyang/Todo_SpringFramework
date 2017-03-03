package com.github.todo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.todo.service.SharedTodoService;
import com.github.todo.vo.SharedTodo;

@Controller
public class SharedTodoController {
	@Autowired
	private SharedTodoService sharedTodoService;

	@RequestMapping(value = "/sharedTodo/isExist", method = { RequestMethod.POST })
	@ResponseBody
	public Boolean isExistSharedTodo(SharedTodo sharedTodo) {
		return sharedTodoService.isExistSharedTodo(sharedTodo);
	}

	@RequestMapping(value = "/sharedTodo/delete", method = { RequestMethod.POST })
	@ResponseBody
	public Boolean deleteSharedTodo(SharedTodo sharedTodo) {
		return sharedTodoService.deleteSharedTodo(sharedTodo);
	}

	@RequestMapping(value = "/sharedTodo/submit", method = { RequestMethod.POST })
	@ResponseBody
	public Boolean saveSharedTodo(SharedTodo sharedTodo) {
		return sharedTodoService.createSharedTodo(sharedTodo);
	}
}
