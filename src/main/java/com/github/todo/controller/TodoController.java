package com.github.todo.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.todo.enums.ResultMessage;
import com.github.todo.service.SharedTodoService;
import com.github.todo.service.TagService;
import com.github.todo.service.TodoService;
import com.github.todo.util.ValidationUtil;
import com.github.todo.vo.SharedTodo;
import com.github.todo.vo.Tag;
import com.github.todo.vo.Todo;

@Controller
public class TodoController {
	@Autowired
	private TodoService todoService;

	@Autowired
	private TagService tagService;

	@Autowired
	private ValidationUtil validationUtil;

	@Autowired
	private SharedTodoService sharedTodoService;

	@RequestMapping(value = "/", method = { RequestMethod.GET })
	public String getTodoList(@CookieValue(value = "userId") String userId, Model model) {
		HashMap<String, List<Todo>> todos = todoService.getTodoListByUserId(userId);
		model.addAttribute("todo", todos);
		return "todo/todo_list";
	}

	@RequestMapping(value = "/todo/create", method = { RequestMethod.GET })
	public String createTodo() {
		return "todo/todo_create";
	}

	@RequestMapping(value = "/todo/submit", method = { RequestMethod.POST })
	@ResponseBody
	public String submitTodo(@CookieValue(value = "userId") String userId, Todo todo, Model model) {
		if (validationUtil.saveTodo(todo)) {
			if (todoService.createTodo(todo, userId)) {
				return ResultMessage.SUCCESS.getMessage();
			}
			return ResultMessage.CREATE_ERROR.getMessage();
		}
		return ResultMessage.INPUT_ERROR.getMessage();
	}

	@RequestMapping(value = "/todo/update", method = { RequestMethod.POST })
	@ResponseBody
	public String updateTodo(Todo todo) {
		if (validationUtil.saveTodo(todo)) {
			if (todoService.updateTodo(todo)) {
				return ResultMessage.SUCCESS.getMessage();
			}
			return ResultMessage.UPDATE_ERROR.getMessage();
		}
		return ResultMessage.INPUT_ERROR.getMessage();
	}

	@RequestMapping(value = "/todo/delete", method = { RequestMethod.POST })
	@ResponseBody
	public String deleteTodo(@RequestParam Integer id) {
		if (todoService.deleteTodo(id)) {
			return ResultMessage.SUCCESS.getMessage();
		}
		return ResultMessage.DELETE_ERROR.getMessage();
	}

	@RequestMapping(value = "/todo/{id}", method = { RequestMethod.GET })
	public String getTodo(@CookieValue(value = "userId") String userId, Model model, @PathVariable Integer id) {
		Todo todo = todoService.getTodo(id);
		List<Tag> tags = tagService.getTagListByUserId(userId);
		model.addAttribute("todo", todo);
		model.addAttribute("tag", tags);
		return "todo/todo";
	}

	@RequestMapping(value = "/todo/share/{id}", method = { RequestMethod.GET })
	public String getShareTodoList(@PathVariable Integer id, Model model) {
		List<SharedTodo> sharedTodos = sharedTodoService.getSharedTodoListByTodoId(id);
		model.addAttribute("sharedTodo", sharedTodos);
		model.addAttribute("todoId", id);
		return "/todo/todo_share";
	}

	@RequestMapping(value = "/todo/isWriter", method = { RequestMethod.POST })
	@ResponseBody
	public Boolean isWriter(@RequestParam("todoId") Integer todoId, @RequestParam("userId") String userId) {
		return todoService.isWriter(todoId, userId);
	}
}
