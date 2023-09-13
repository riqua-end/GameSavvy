<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Insert title here</title>
<meta charset="UTF-8">

<!-- RWD -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- MS -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8,IE=EmulateIE9"/> 
<!--BS 4 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!--icon -->
<!--fontawesome icon-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" 
   integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<!--google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="../css/login.css?after"/> <!--수정시 바로 적용을 위해 after추가 -->
</head>
<body>

<!-- 로그인 폼 -->

<div class="container">
	<div id="login-card">
		<div class="login-card-logo">
			<img src="../images/logo.png" alt="logo">
		</div>
		
		
  		<h4><c:out value="${logout}"/></h4>
  		<!-- action은 login으로 처리,method는 post,root context에서 요청 -->
  		<form id="loginForm" method='post' action="../login">
  			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  			<div class="form-group">
				<label for="uId">아이디</label>
				<input type="text" class="form-control" name="username" placeholder="아이디 입력" 	id="uId" required/>
				<span style="color:red;"><c:out value="${error}"/></span>			
			</div>
			<div class="form-group">
				<label for="uPw">비밀번호</label>
				<input type="password" class="form-control" name="password" id="uPw" placeholder="비밀번호 입력" required/>
			</div>
			<!-- 로그아웃 안하고 접속 단절후  일정시간 로그인 없이 재접속 remember-me -->
			<div class="form-group form-check">
				<input type="checkbox" class="form-check-input" id="rememberMe" name="remember-me" checked>
				<label class="form-check-label" for="rememberMe" aria-describedby="rememberMeHelp">remember-me</label>
			</div>
					
			<button type="button" id="loginFormBtn" class="btn btn-success">로그인</button>
			<button type="button" class="btn btn-danger" id="goBackButton">뒤로가기</button>
  		</form>
	</div><!-- submain -->
</div>

<script>
$(function(){
	$("#loginFormBtn").on("click", function(e){
		e.preventDefault();
		$("#loginForm").submit();
	});
	
	$("#goBackButton").on("click", function() {
		self.location = "/";
	});
	
});
</script>


</body>
</html>