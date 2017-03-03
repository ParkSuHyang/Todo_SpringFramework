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
<body>
	<jsp:include page="/WEB-INF/jsp/header/menu_bar.jsp"/>
	<div class="container">
		<h2>TODO LIST</h2>
		<div class="list-group" name="listgroup_none">
			<c:forEach items="${todo}" var="todo">
				<c:choose>
			    	<c:when test="${todo.key eq 'pastTodo'}">
			    		<a href="#" class="list-group-item disabled">미해결 목록</a> 
			    		<c:forEach items="${todo.value}" var="todoList">
			    			<a href="/todo/${todoList.id}" class="list-group-item">${todoList.name}
					    		<span class="label label-default" style="background-color:#${todoList.tag.color}">${todoList.tag.tagName}</span>
					    		<c:if test="${todoList.userId ne cookie.userId.value}">
						    		<span class="pull-right">
			      					<span class="glyphicon glyphicon-user"></span></span>
		      					</c:if>	
		      				</a>		
			    		</c:forEach>
			    	</c:when>
			    	<c:when test="${todo.key eq 'todayTodo'}">
			        	<a href="#" class="list-group-item disabled">오늘 할 일</a> 
			    		<c:forEach items="${todo.value}" var="todoList">
			    			<a href="/todo/${todoList.id}" class="list-group-item">${todoList.name}
					    		<span class="label label-default" style="background-color:#${todoList.tag.color}">${todoList.tag.tagName}</span>
					    		<c:if test="${todoList.userId ne cookie.userId.value}">
					    			<span class="pull-right">
		      						<span class="glyphicon glyphicon-user"></span></span>
		      					</c:if>	
		      				</a>		
			    		</c:forEach>
			    	</c:when>
			    	<c:when test="${todo.key eq 'tomorrowTodo'}">
			    		<a href="#" class="list-group-item disabled">내일 할 일</a> 
			    		<c:forEach items="${todo.value}" var="todoList">
			    			<a href="/todo/${todoList.id}" class="list-group-item">${todoList.name}
					    		<span class="label label-default" style="background-color:#${todoList.tag.color}">${todoList.tag.tagName}</span>
					    		<c:if test="${todoList.userId ne cookie.userId.value}">
					    			<span class="pull-right">
		      						<span class="glyphicon glyphicon-user"></span></span>
		      					</c:if>	
		      				</a>		
			    		</c:forEach>
			    	</c:when>
			    	<c:when test="${todo.key eq 'laterTodo'}">
			        	<a href="#" class="list-group-item disabled">나중에 할 일</a> 
			    		<c:forEach items="${todo.value}" var="todoList">
				    		<a href="/todo/${todoList.id}" class="list-group-item">${todoList.name}
					    		<span class="label label-default" style="background-color:#${todoList.tag.color}">${todoList.tag.tagName}</span>
					    		<c:if test="${todoList.userId ne cookie.userId.value}">
					    			<span class="pull-right">
		      						<span class="glyphicon glyphicon-user"></span></span>
		      					</c:if>	
		      				</a>			    			
			    		</c:forEach>
			    	</c:when>
			    	<c:when test="${todo.key eq 'undefinedTodo'}">
			    		<a href="#" class="list-group-item disabled">마감날짜가 정해지지 않은 일</a> 
			    		<c:forEach items="${todo.value}" var="todoList">
			    			<a href="/todo/${todoList.id}" class="list-group-item">${todoList.name}
					    		<span class="label label-default" style="background-color:#${todoList.tag.color}">${todoList.tag.tagName}</span>
					    		<c:if test="${todoList.userId ne cookie.userId.value}">
					    			<span class="pull-right">
		      						<span class="glyphicon glyphicon-user"></span></span>
		      					</c:if>	
		      				</a>
			    		</c:forEach>
			    	</c:when>
				</c:choose>
			</c:forEach>
		</div>
	</div>
</body>
</html>