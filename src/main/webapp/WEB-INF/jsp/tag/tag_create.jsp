<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>박수향:TODO</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<link rel="stylesheet" href="/css/icon.css">
<link rel="stylesheet" href="/css/button.css">
<body style="padding-top: 100px;">
	<jsp:include page="/WEB-INF/jsp/header/menu_bar.jsp"/>
	<div style="text-align: center;">
		<h2>Tag Create</h2>
		<div class="container">
			<input id="userId" type="hidden" class="form-control"  name="userId" value="${cookie.userId.value}">
			<div class="form-group">
				<input id="tagName" type="text" class="form-control" placeholder="Enter Tag Name" name="tagName" maxlength="20" required>
			</div>
			<div class="form-group">
				<input id="color" type="text" class="form-control " name="color" placeholder="Enter Color (ex:FF0000)" minlength="6" maxlength="6" required>
	       	</div>
			<div class="clearfix">
				<button id="btn_submit" class="btn btn-primary" style="width: 35%;">Save</button>
			</div>
		</div>
	</div>
</body>
<script>
$("#btn_submit").on("click", function() {
	var userId = $("#userId").val();
	var tagName = $("#tagName").val();
	var color = $("#color").val();
	
	$.ajax({
		url : "/tag/submit",
		type : 'POST',
		data : {
			"tagName" : tagName,
			"color" : color,
			"userId" : userId
		},
		success : function(message) {
			var resultMessage = message;
			if (resultMessage == "success") {
				location.href="/tags";
			} else{
				alert(message);
			} 
		},
		error : function(xhr, status, e) {
			alert(e);
		}
	});
});

</script>
</html>