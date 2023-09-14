<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Insert title here</title>
<meta charset="UTF-8">

<style>
body {
  font-family: "Lato", sans-serif;
}

.sidenav {
  z-index: 1;
  background: #eee;
  overflow-x: hidden;
  padding: 8px 0;
}

.sidenav a {
  padding: 6px 8px 6px 16px;
  text-decoration: none;
  color: #2196F3;
  display: block;
}

.sidenav a:hover {
  color: #064579;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
</style>

<!-- RWD -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- MS -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8,IE=EmulateIE9"/> 
</head>
<body>

<div class="col-md-2">
	<h4 class="text-center">메뉴</h4>
	<div class="sidenav">
  		<!-- 로그인 안한 경우 -->
		 	<sec:authorize access="isAnonymous()">
		 		<a id="customlogin" href="../member/login">로그인</a>
		 		<a id="memberJoin" href="../member/join">회원가입</a>
		 	</sec:authorize>
		 		
		 	<!-- 로그인 한 경우 -->
		 	<sec:authorize access="isAuthenticated()">
		 			<a href="#"><sec:authentication property="principal.username"/></a>
		 			<a href="../member/modify">회원정보</a>
		 			<a href="#">로그아웃</a>
		 	</sec:authorize>
  		<hr></hr>
  		<a href="#">e스포츠정보</a>
  		<a href="#">e스포츠일정</a>
	</div>
</div> <!-- col-md-2 -->

</body>
</html>