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
	<h2>Share Todo</h2>
	<div class="container">
		<div class="row">
			<div id="custom-search-input">
				<div class="input-group col-md-12"  style="margin:20px;">
					<input id="search" type="text" class="search-query form-control" placeholder="Search"></input>
					<span class="input-group-btn" >
						<button id="search_btn"class="btn btn-danger" type="button">
	                   	<span class=" glyphicon glyphicon-search"></span>
	               		</button>
	          		</span>
	             </div>
	        </div>
		</div>
	</div>

	<div class="container" style="margin-top:10px;">
		<div class="list-group" name="listgroup_none">
			<input id="myId" type="hidden" name="myId" value="${cookie.userId.value }">
			<input id="todoId" type="hidden" name="todoId" value="${todoId}">
			<c:forEach items="${sharedTodo}" var="sharedTodo">
				<div>
					<input type="hidden" name="userId" value="${sharedTodo.userId}">
					<a class="list-group-item">${sharedTodo.userId}
						<span class="pull-right">
					      	<span class="glyphicon glyphicon-user"></span>
					      	<button class="remove_field" id="${sharedTodo.userId}" name="btn_delete" >
			          			<span class="glyphicon glyphicon-trash"></span>
			     			</button>
					     </span> 
					</a>
				</div>		
			</c:forEach>
		</div>
	</div>
</body>
<script>
var wrapper = $(".list-group");

$(wrapper).on("click", ".remove_field", function(e) {
	if (confirm("정말 삭제하시겠습니까??") == true) {
		var todoId = $("#todoId").val();
		var id = $(this).attr('id');

		$.ajax({
			url : "/sharedTodo/delete",
			type : 'POST',
			data : {
				"todoId" : todoId,
				"userId" : id
			},
			dataType : 'text',
			success : function(data) {
				var chkRst = data;
				if (chkRst == 'true') {
					$(this).parent().parent('div').remove();
					location.href = "/todo/share/" + todoId;
				} else {
					alert("삭제실패했습니다.");
				}
			},
			error : function(xhr, status, e) {
				alert(e);
			}
		});
	} else {
		return;
	}
});

$("#search_btn").on("click", function() {
	var id = $("#search").val();
	var myId = $("#myId").val();

	if (id == "") {
		alert("검색할 ID를 입력하세요");
		return;
	} else if (id == myId) {
		alert("본인 ID를 입력하셨습니다.");
		return;
	}

	$.ajax({
		url : "/user/validate",
		type : 'POST',
		data : 'id=' + id,
		success : function(data) {
			var result = data;
			if (result == 'success') {
				isWriter();
			} else {
				alert("존재하지 않는 사용자입니다.");
			}
		},
		error : function(xhr, status, e) {
			alert("first error");
		}
	});
});

function isWriter(id){
	var todoId = $("#todoId").val();
	var id = $("#search").val();

	$.ajax({
		url : "/todo/isWriter",
		type : 'POST',
		data : {
			"todoId" : todoId,
			"userId" : id
		},
		success : function(data) {
			var result = data;
			if (result == true) {
				alert("작성자는 등록할 수 없습니다.");
			} else {
				isExistSharedTodo(id);
			}
		},
		error : function(xhr, status, e) {
			alert("first error");
		}
	});
}
function isExistSharedTodo(id) {
	var todoId = $("#todoId").val();
	
	$.ajax({
		url : "/sharedTodo/isExist",
		type : 'POST',
		data : {
			"todoId" : todoId,
			"userId" : id
		},
		success : function(data) {
			var result = data;
			if (result == true) {
				alert("이미 공유된 사용자입니다.")
			} else {
				saveSharedTodo(id);
			}
		},
		error : function(xhr, status, e) {
			alert("check!error");
		}
	});
}

function saveSharedTodo(id) {
	var todoId = $("#todoId").val();

	$.ajax({
		url : "/sharedTodo/submit",
		type : 'POST',
		data : {
			"todoId" : todoId,
			"userId" : id
		},
		success : function(data) {
			var result = data;
			if (result == true) {
				$(wrapper)
					.append(
						'<div><input type="hidden" name="userId" value="'
						+ id
						+ '">'
						+ '<a class="list-group-item">'
						+ id
						+ '<span class="pull-right"> <span class="glyphicon glyphicon-user"></span> <button id="h" name="btn_delete" class="remove_field"><span class="glyphicon glyphicon-trash"></span></button></span></a></div>');
				location.href = "/todo/share/" + todoId;
			} else {
				alert("sharedTodo에 저장하지 못했습니다.");
			}
		},
		error : function(xhr, status, e) {
			alert("save!error");
		}
	});
}
</script>
</html>