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
<!-- RWD -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- MS -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8,IE=EmulateIE9"/> 
</head>
<body>

<div class="col-md-3">
	<div class="webzine-login">
	<div class="log-out">
  		<!-- 로그인 안한 경우 -->
	 	<sec:authorize access="isAnonymous()">
	 		<p>더 안전하고 편리하게 사용하세요.</p>
	 		<a id="customlogin" href="../member/login" class="login-btn">로그인</a>
	 			<div>
	 				<a id="memberJoin" href="../member/join">회원가입</a>
	 			</div>
	 	</sec:authorize>
	 	<!-- 로그인 한 경우 -->
	 	<sec:authorize access="isAuthenticated()">
	 			<a><sec:authentication property="principal.username"/>님 환영합니다.</a>
	 			<hr></hr>
	 			<a href="../member/modify">회원정보</a>
	 			<a href="../member/logout">로그아웃</a>
	 	</sec:authorize>
	</div> <!-- log-out -->
	</div> <!-- webzine-login -->
	<div class="webzine-menu">
    	<h4>메뉴</h4>
    	<hr></hr>
    	<div class="sidenav">
       		<a href="../home/home">홈</a>
        	<a href="../board/list">자유게시판</a>
    	</div>
	</div>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	<div class="webzine-admin">
		<h4>관리자 메뉴</h4>
		<hr></hr>
		<div class="sidenav">
			<a href="../admin/adminMember">회원관리</a>
			<a href="../admin/adminList">게시판관리</a>
			<a href="#">공지게시판</a>
		</div>
	</div>
	</sec:authorize>
</div> <!-- col-md-3 -->

</body>
</html>