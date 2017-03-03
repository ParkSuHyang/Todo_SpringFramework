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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/button.css">
<link rel="stylesheet" href="/css/icon.css">
<link rel="stylesheet" href="/css/select.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
	#main span { cursor: pointer; } 
	#main li { cursor: pointer; } 
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/header/menu_bar.jsp"/>
		<h2>TODO DETAIL</h2>
		<div class="container">
			<div class="for/m-group">
				<a class="btn icon-btn btn-info" href="/todo/share/${todo.id}"><span class="glyphicon btn-glyphicon glyphicon-share img-circle text-info"></span>Share</a>
				<span class="pull-right">
					<button id="${todo.id}" name="btn_delete" class="btn btn-xs btn-danger" style="margin-top:3px; padding:7px;">
	         		<span class="glyphicon glyphicon-trash"></span>
	    			</button>
	    		</span>
			</div><br>
			<div class="list-group" name="listgroup_none">
				<div>
					<a class="list-group-item list-group-item-info disabled">날짜와 시간 같이 입력하지않으면 입력처리 되지 않습니다</a> 
				</div>
			</div>
		
		<div id="updateForm" class="" >
			<input id="todoId" type="hidden" name="id" value="${todo.id}">
			<div class="form-group">
				<label for="titleInput">할일 제목</label>
				<span id="tempTag" name="tag_view" class="label label-default" style="background-color:#${todo.tag.color}" >${todo.tag.tagName}</span>
				<input type="text" class="form-control clicktoedit" name="name" id="todoName"  value="${todo.name}" maxlength="20" required>
			</div>
			<div class="form-group">
				<input type="hidden" class="form-control clicktoedit" name="tagId" id="tagId" value="${todo.tag.tagId}"  >
			</div>
			<div class="form-group">
				<label for="duedateInput">종료 날짜</label>
				<input type="date" min="1970-01-01" max="9999-12-31" class="form-control clicktoedit" name="endDate" id="endDate" value="${todo.endDate}" >
			</div>
			
			<div class="form-group">
	         	<label for="duedatetimeInput">종료 시간</label>
	          	<input type="time" class="form-control clicktoedit" name="endTime" id="endTime" value="${todo.endTime}">
	        </div>
	        
	        <div class="form-group">
	        	<input type="hidden" class="form-control" name="state" id="state" value="${todo.state}">
	        </div>
	        
        	<div class="form-group">
          		<button type="submit" id="modify_button" class="btn btn-default" style="display:none;">수정</button>
          		<p class="form-control-static">최초 작성 시간: </p><a>${todo.createTime}</a>
          		<p class="form-control-static">최종 수정 시간: </p><a>${todo.updateTime}</a>
        	</div>			
		
			<div class="container">
				<div class="row">
					<div class="col-xs-6 col-sm-3">
           				<a class="btn btn-primary btn-select btn-select-light">
                		<input type="hidden" class="btn-select-input" id="" name="" value="" />
                			<span class="btn-select-value">태그를 선택하세요</span>
                			<span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
                			<ul id='myid'>
                				<li color="FFFFFF">태그미지정<span class="label label-default" style="background-color:#FFFFFF"></span></li>
                				<c:forEach items="${tag}" var="tag">
          							<li id="${tag.tagId}" name="${tag.tagName}" color="${tag.color}">${tag.tagName} <span class="label label-default" style="background-color:#${tag.color}">${tag.tagName}</span></li>
			    				</c:forEach>
                			</ul>
           				</a>
        			</div>
				</div>
			</div>
			 
			<div class="clearfix" style="text-align : center;">
				<button id="btn_submit" class="btn btn-primary" style="width: 30%;">Edit</button>
				<a class="btn btn-primary" href="/" role="button" style="width: 30%;">Cancel</a>
				<button id="${todo.id}" name="btn_state_update" class="btn btn-primary" style="width: 30%;" >Complete</button>
				<br>
			</div>
		</div>
	</div>
</body>
<script>
$(document).ready(function () {
    $(".btn-select").each(function (e) {
        var value = $(this).find("ul li.selected").html();
        if (value != undefined) {
            $(this).find(".btn-select-input").val(value);
            $(this).find(".btn-select-value").html(value);
        }
    });
});

$(document).on('click', '.btn-select', function (e) {
    e.preventDefault();
    var ul = $(this).find("ul");
    if ($(this).hasClass("active")) {
        if (ul.find("li").is(e.target)) {
            var target = $(e.target);
            target.addClass("selected").siblings().removeClass("selected");
            var value = target.html();
            $(this).find(".btn-select-input").val(value);
            $(this).find(".btn-select-value").html(value);
        }
        ul.hide();
        $(this).removeClass("active");
    }
    else {
        $('.btn-select').not(this).each(function () {
            $(this).removeClass("active").find("ul").hide();
        });
        ul.slideDown(300);
        $(this).addClass("active");
    }
});

$(document).on('click', function (e) {
    var target = $(e.target).closest(".btn-select");
    if (!target.length) {
        $(".btn-select").removeClass("active").find("ul").hide();
    }
});

$(document).ready(function () {
    $("ul[id*=myid] li").click(function () {
   	    $("#tagId").val($(this).attr('id'));
   	    $("#tempTag").html($(this).attr('name'));
   	 	$("#tempTag").css('background-color', '#'+$(this).attr('color') );
    });
});

$("button[name=btn_state_update]").click(function() {
	if (confirm("정말 완료하셨습니까?") == true){
		$("#state").val(0);
		updateTodo();
	}else{ 
    	return;
	}
});

$("button[name=btn_delete]").click(function() {
	if (confirm("정말 삭제하시겠습니까??") == true){  
		var id = $("#todoId").val();

		$.ajax({
			url : "/todo/delete",
			type : 'POST',
			data : {
				'id' : id,
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
	}else{ 
    	return;
	}
});

$("#btn_submit").on("click", function() {
	updateTodo();
});

function updateTodo(){
	var id = $("#todoId").val();
	var name = $("#todoName").val();
	var endDate = $("#endDate").val();
	var endTime = $("#endTime").val();
	var state = $("#state").val();
	var tagId = $("#tagId").val();
		
	$.ajax({
		url : "/todo/update",
		type : 'POST',
		data : {
			'id' : id,
			'name' : name,
			'endDate' : endDate,
			'endTime' : endTime,
			'state' : state,
			'tag.tagId' : tagId
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
}
</script>
</html>
