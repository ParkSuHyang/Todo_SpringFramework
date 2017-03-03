<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>박수향:TODO</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/button.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body style="padding-top: 100px;">
	<jsp:include page = "/WEB-INF/jsp/header/main_menu_bar.jsp"/>
		<h2 style="text-align:center;">Sign Up</h2>
		<div>
			<div class="container">
				<div id="user_id_form" class="has-feedback">
					<input type="text" class="form-control" id="userId" onfocusout="isValidId()" placeholder="Enter Id (숫자&영문자 4~20자리)" name="id" maxlength="20" >
					<input type="hidden" class="form-control" id="statusId" value="" readonly>
					<input type="hidden" class="form-control" id="checkId" value="N" > 
					
				</div>
				<div class="form-group">
					<input id="name" type="text" class="form-control" placeholder="Enter Name (한글&영문자 3~20자리)" name="name" maxlength="20" required>
				</div>
				<div class="form-group">
					<input id="password" type="password" class="form-control" placeholder="Enter Password (숫자&영문자 5~20자리)" name="password" maxlength="20" required>
				</div>
				<div class="clearfix" style="text-align : center;">
					<input class="btn btn-primary" type="button" value="Sign Up" style="width: 35%;" onClick="beforeSubmitCheck()"></input> 
					<a class="btn btn-primary" href="/login/form" role="button" style="width: 35%;">Cancel</a><br>
				</div>
			</div>
		</div>
</body>
<script>
function beforeSubmitCheck() {
	if ($("#checkId").val() == 'N') {
		alert('please check your id!');
		return;
	}
	else{
		var id = $("#userId").val();
		var name = $("#name").val();
		var password = $("#password").val();
		$.ajax({
			url : "/user/create",
			type : 'POST',
			data: {
				'id' : id,
				'name' : name,
				'password' : password
			},
			success : function(data) {
				var resultMessage = data;
				if (resultMessage=='success') {
					location.href="/login/form";
				} else {
					alert(resultMessage);
				}
			},
			error : function(xhr, status, e) {  
				     alert(e);
			}

		});
	}
}

function isValidId() {	 
	var userId = $("#userId").val();
	$("#statusId").attr("type", "text");

	if(userId==""){
		$("#statusId").val('please input your id');
		$("#checkId").val('N');
		return;
	}
	$.ajax({
		url : "/user/validate",
		type : 'POST',
		data: {
			'id' : userId
		},
		success : function(data) {
			var resultMessage = data;
			if (resultMessage=='success') {
				$("#statusId").val('Existing Id');
				$("#checkId").val('N');
			} else if(resultMessage == 'NotValidId'){
				$("#statusId").val('Unvalid Id');
				$("#checkId").val('N');		
			} else{
				$("#statusId").val('Enrollable Id');
				$("#checkId").val('Y');
			}
		},
		error : function(xhr, status, e) {  
			     alert(e);
		}

	});
}
</script>
</html>