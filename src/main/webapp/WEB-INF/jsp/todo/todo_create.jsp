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
<link rel="stylesheet" href="../css/button.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body style="padding-top: 100px;">
	<jsp:include page="/WEB-INF/jsp/header/menu_bar.jsp"/>
	<div style="text-align: center;">
		<h2>Todo Create</h2>
		<div class="list-group" name="listgroup_none">
			<div>
				<a class="list-group-item list-group-item-info disabled">날짜와 시간 같이 입력하지않으면 입력처리 되지 않습니다</a> 
			</div>
		</div>
			<div class="container">
				<div class="form-group">
					<input id="todoName" type="text" class="form-control" placeholder="Enter Todo Name" name="name" maxlength="20" required>
				</div>
				<div class="form-group">
					<input id="endDate" type="date" max="9999-12-31" class="form-control clicktoedit" name="endDate" onfocusout="validate()"value="">
				</div>
				<div class="form-group">
	          		<input id="endTime" type="time" class="form-control clicktoedit" name="endTime" value="">
	          	</div>
	        </div>
			<div class="clearfix">
				<button id="btn_submit" class="btn btn-primary" style="width: 35%;">Save</button>
			</div>

	</div>
</body>
<script>
$("#btn_submit").on("click", function() {

	var name = $("#todoName").val();
	var endDate = $("#endDate").val();
	var endTime = $("#endTime").val();

	$.ajax({
		url : "/todo/submit",
		type : 'POST',
		data : {
			"name" : name,
			"endDate" : endDate,
			"endTime" : endTime
		},
		success : function(message) {
			var resultMessage = message;
			if (resultMessage == 'success') {
				location.href="/";
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