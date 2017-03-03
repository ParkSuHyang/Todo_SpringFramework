package com.github.todo.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;

import com.github.todo.util.constants.CookieConstant;
import com.github.todo.vo.User;

@Component
public class CookieUtil {
	public void addCookie(User user, HttpServletRequest request, HttpServletResponse response) {
		Cookie loginStatusCookie = new Cookie(CookieConstant.LOGIN_CODE, CookieConstant.LOGIN_COOKIE);
		loginStatusCookie.setPath("/");
		Cookie userIdCookie = new Cookie(CookieConstant.USER_CODE, user.getId());
		userIdCookie.setPath("/");

		response.addCookie(loginStatusCookie);
		response.addCookie(userIdCookie);
	}

	public void expireCookie(HttpServletResponse response) {
		Cookie expireLoginStatusCookie = new Cookie(CookieConstant.LOGIN_CODE, null);
		Cookie expireUserIdCookie = new Cookie(CookieConstant.USER_CODE, null);

		expireLoginStatusCookie.setPath("/");
		expireLoginStatusCookie.setMaxAge(0);
		expireUserIdCookie.setPath("/");
		expireUserIdCookie.setMaxAge(0);

		response.addCookie(expireLoginStatusCookie);
		response.addCookie(expireUserIdCookie);
	}
}
