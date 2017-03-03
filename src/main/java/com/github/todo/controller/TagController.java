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
import com.github.todo.service.TagService;
import com.github.todo.service.TodoService;
import com.github.todo.util.ValidationUtil;
import com.github.todo.vo.Tag;
import com.github.todo.vo.Todo;

@Controller
public class TagController {
	@Autowired
	private TagService tagService;

	@Autowired
	private TodoService todoService;

	@Autowired
	private ValidationUtil validationUtil;

	@RequestMapping(value = "/tags", method = { RequestMethod.GET })
	public String getTagListByUserId(@CookieValue(value = "userId") String userId, Model model) {
		List<Tag> tags = tagService.getTagListByUserId(userId);
		model.addAttribute("tag", tags);
		return "tag/tag_list";
	}

	@RequestMapping(value = "/tag/create", method = { RequestMethod.GET })
	public String getCreateTagView() {
		return "tag/tag_create";
	}

	@RequestMapping(value = "/tag/submit", method = { RequestMethod.POST })
	@ResponseBody
	public String createTag(Tag tag) {
		if (validationUtil.saveTag(tag)) {
			if (tagService.createTag(tag)) {
				return ResultMessage.SUCCESS.getMessage();
			}
			return ResultMessage.CREATE_ERROR.getMessage();
		}
		return ResultMessage.INPUT_ERROR.getMessage();
	}

	@RequestMapping(value = "/tag/{id}", method = { RequestMethod.GET })
	public String getTodoListByTagId(@CookieValue(value = "userId") String userId, @PathVariable Integer id,
			Model model) {
		HashMap<String, List<Todo>> todos = tagService.getTodoListByTagIdAndDateType(id, userId);
		model.addAttribute("todo", todos);
		return "todo/todo_list";
	}

	@RequestMapping(value = "/tag/none", method = { RequestMethod.GET })
	public String getTodoListByTagIdNull(@CookieValue(value = "userId") String userId, Model model) {
		HashMap<String, List<Todo>> todos = todoService.getTodoListByUserId(userId);
		model.addAttribute("todo", todos);
		return "tag/tag_null_list";
	}

	@RequestMapping(value = "/tag/detail/{id}", method = { RequestMethod.GET })
	public String getTagDetail(@PathVariable Integer id, Model model) {
		Tag tag = tagService.getTag(id);
		model.addAttribute("tag", tag);
		return "tag/tag";
	}

	@RequestMapping(value = "/tag/delete", method = { RequestMethod.POST })
	@ResponseBody
	public String deleteTag(@RequestParam("tagId") Integer id) {
		if (tagService.deleteTag(id)) {
			return ResultMessage.SUCCESS.getMessage();
		}
		return ResultMessage.DELETE_ERROR.getMessage();
	}

	@RequestMapping(value = "/tag/update", method = { RequestMethod.POST })
	@ResponseBody
	public String updateTag(Tag tag) {
		if (validationUtil.saveTag(tag)) {
			if (tagService.updateTag(tag)) {
				return ResultMessage.SUCCESS.getMessage();
			}
			return ResultMessage.UPDATE_ERROR.getMessage();
		}
		return ResultMessage.INPUT_ERROR.getMessage();
	}

}
