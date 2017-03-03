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
<link rel="stylesheet" href="../css/icon.css">
<body style="padding-top: 100px;">
	<jsp:include page="/WEB-INF/jsp/header/menu_bar.jsp"/>
	<div class="container">
		<div>
			<a class="btn icon-btn btn-success" href="/tag/create"><span class="glyphicon btn-glyphicon glyphicon-plus img-circle text-success"></span>Tag Add</a><br><br>
		</div>
		<div>
			<span class="button" style="background-color: transparent;"><span class="glyphicon glyphicon-flower"></span></span>
		</div>
		<div class="list-group">
			<a class="list-group-item"> None Tag
			<span class="pull-right">
				<button onclick="location.href='../tag/none'" class="btn btn-xs btn-info">
          			<span class="glyphicon glyphicon-chevron-right"></span>
     			</button>
     		</span>
     		</a>
		</div>
 		<div class="list-group" >
			<c:forEach items="${tag}" var="tag">
				<a class="list-group-item" id="${tag.tagId}" name="${tag.tagId}">
				<input type="hidden" id="tagId" value="${tag.tagId}">
	     			<span class="glyphicon glyphicon-pushpin"></span>  ${tag.tagName}
	      			<span class="pull-right">
	      			<span class="label label-default" style="background-color:#${tag.color}">${tag.tagName}</span>  
	      					<button id="${tag.tagId}" name="btn_update" class="btn btn-xs btn-warning">
          					<span class="glyphicon glyphicon-pencil"></span>
     						</button>
	      					<button id="${tag.tagId}" name="btn_delete" class="btn btn-xs btn-danger">
          					<span class="glyphicon glyphicon-trash"></span>
          					</button>
          					<button id="${tag.tagId}" onclick="location.href='/tag/${tag.tagId}'"class="btn btn-xs btn-info">
          					<span class="glyphicon glyphicon-chevron-right"></span>
     						</button>
     				</span>
          		</a>
      			<br>
    		</c:forEach>
  		</div>
	</div>
</body>

<script>
$("button[name=btn_delete]").click(function() {
	if (confirm("Are you sure you want to delete it?") == true){  
		var tagId = this.id;
		
		$.ajax({
			url : "/tag/delete",
			type : 'POST',
			data : {
				'tagId' : tagId,
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
	}else{ 
    	return;
	}
});

$("button[name=btn_update]").click(function() {
	location.href='/tag/detail/'+ this.id; 
});
</script>
</html>