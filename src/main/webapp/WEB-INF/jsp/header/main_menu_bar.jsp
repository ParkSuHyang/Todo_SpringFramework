<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#myNavbar">
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/login/form">Todo</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav">
				<li class="active"><a href="/login/form">Home</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="/login/signup"><span
						class="glyphicon glyphicon-user"></span> Sign up</a></li>
				<li><a href="/login/form"><span
						class="glyphicon glyphicon-log-out"></span> Sign in</a></li>
			</ul>
		</div>
	</div>
</nav>