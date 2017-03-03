package com.github.todo.enums;

public enum ResultMessage {
	SUCCESS("success"), USER_IS_NOT_VALID("NotValidId"), USER_ID_EXISTS("Existing Id"), INPUT_ERROR(
			"Input Error!"), UPDATE_ERROR(
					"UPDATE ERROR"), CREATE_ERROR("CREATE ERROR"), DELETE_ERROR("DELETE ERROR");

	private String message;

	private ResultMessage(String message) {
		this.message = message;
	}

	public String getMessage() {
		return message;
	}
}
