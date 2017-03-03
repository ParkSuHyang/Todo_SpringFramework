<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<body style="padding-top:100px;">
	<jsp:include page = "/WEB-INF/jsp/header/main_menu_bar.jsp"/>
	<div class="panel panel-danger">
		<div class="panel-heading">
			<h3 class="text-center">
	          <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Oops:
	          <small>User not found - <b>check input</b></small>
	         </h3>
	    </div>
	    <div class="panel-body">
			<form action="/login/submit" method='post'>
				<div class="container">
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="Enter UserId" name="id" maxlength="20" required></input>
							<label for="uLogin" class="input-group-addon glyphicon glyphicon-user"></label>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<input type="password" class="form-control" placeholder="Enter Password" name="password" maxlength="20" required></input>
							<label for="uPassword" class="input-group-addon glyphicon glyphicon-lock"></label>
						</div>
					</div>
					<div class="clearfix" style="text-align : center;">
						<input class="btn btn-primary" type="submit" value="Login" style="width:35%;"></input>  
						<a class="btn btn-primary" href="/login/signup" role="button" style="width:35%;">signup</a><br>
					</div>			
				</div>
			</form>
		</div>
	</div>
</body>
</html>