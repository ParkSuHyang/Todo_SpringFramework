package com.github.todo.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Component;

import com.github.todo.vo.Tag;
import com.github.todo.vo.Todo;
import com.github.todo.vo.User;

@Component
public class ValidationUtil {
	private static final String REGEXP_USER_ID = "^[a-zA-Z0-9]{4,20}$";
	private static final String REGEXP_USER_NAME = "^[가-힣a-zA-Z]{3,20}+";
	private static final String REGEXP_USER_PASSWORD = "^[a-zA-Z0-9]{5,20}$";
	private static final String REGEXP_TAG_NAME = "^[가-힣a-zA-Z0-9 ]{1,20}+";
	private static final String REGEXP_TAG_COLOR = "^([a-fA-Z0-9]{6})$";
	private static final String REGEXP_TODO_NAME = "^[가-힣a-zA-Z0-9 ]{1,20}+";

	public boolean validateUserId(String userId) {
		return isMatchingPattern(REGEXP_USER_ID, userId);
	}

	public boolean validateUserName(String userName) {
		return isMatchingPattern(REGEXP_USER_NAME, userName);
	}

	public boolean validateUserPassword(String userPassword) {
		return isMatchingPattern(REGEXP_USER_PASSWORD, userPassword);
	}

	public boolean saveUser(User user) {
		return validateUserId(user.getId()) && validateUserName(user.getName())
				&& validateUserPassword(user.getPassword());
	}

	public boolean saveTodo(Todo todo) {
		return isMatchingPattern(REGEXP_TODO_NAME, todo.getName());
	}

	public boolean saveTag(Tag tag) {
		boolean isValidTagName = isMatchingPattern(REGEXP_TAG_NAME, tag.getTagName());
		boolean isValidTagColor = isMatchingPattern(REGEXP_TAG_COLOR, tag.getColor());

		return isValidTagName && isValidTagColor;
	}

	public boolean isMatchingPattern(String regex, String input) {
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(input);

		return matcher.matches();
	}
}