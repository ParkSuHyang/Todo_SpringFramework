package com.github.todo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.todo.service.UserService;
import com.github.todo.util.CookieUtil;
import com.github.todo.vo.User;

@Controller
public class LoginController {
	@Autowired
	private UserService userService;

	@Autowired
	private CookieUtil cookieUtil;

	public LoginController() {

	}

	@RequestMapping(value = "/login/form", method = { RequestMethod.GET })
	public String login() {
		return "login/login";
	}

	@RequestMapping(value = "/login/signup", method = { RequestMethod.GET })
	public String signup() {
		return "login/sign_up";
	}

	@RequestMapping(value = "/login/submit", method = { RequestMethod.POST })
	public String login(User user, HttpServletRequest request, HttpServletResponse response) {
		if (userService.isAuthorizeUser(user)) {
			cookieUtil.addCookie(user, request, response);
			return "redirect:/";
		}

		return "login/login_fail";
	}

	@RequestMapping(value = "/logout")
	public String logout(HttpServletResponse response) {
		cookieUtil.expireCookie(response);
		return "redirect:/login/login";
	}
}