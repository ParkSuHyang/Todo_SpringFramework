package com.github.todo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.todo.enums.ResultMessage;
import com.github.todo.service.UserService;
import com.github.todo.util.ValidationUtil;
import com.github.todo.vo.User;

@Controller
public class UserController {
	@Autowired
	private UserService userService;

	@Autowired
	private ValidationUtil validationUtil;

	@RequestMapping(value = "/user/create", method = { RequestMethod.POST })
	@ResponseBody
	public String createUser(User user) {
		if (validationUtil.saveUser(user)) {
			if (userService.createUser(user)) {
				return ResultMessage.SUCCESS.getMessage();
			}
			return ResultMessage.CREATE_ERROR.getMessage();
		}
		return ResultMessage.INPUT_ERROR.getMessage();
	}

	@RequestMapping(value = "/user/validate", method = RequestMethod.POST)
	@ResponseBody
	public String validateUserId(String id) {
		if (validationUtil.validateUserId(id)) {
			if (userService.isExistId(id)) {
				return ResultMessage.SUCCESS.getMessage();
			}
			return ResultMessage.USER_ID_EXISTS.getMessage();
		}
		return ResultMessage.USER_IS_NOT_VALID.getMessage();
	}
}
