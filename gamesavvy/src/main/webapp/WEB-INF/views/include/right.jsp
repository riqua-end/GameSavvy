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

.webzine-login .log-out div a {
    display: flex;
    align-items: center;
    color: #969696;
    font-size: 12px;
    font-family: "Noto Sans",sans-serif;
    font-weight: 300;
}

.webzine-login .log-out div {
    display: flex;
    justify-content: flex-end;
}

.webzine-login .log-out .login-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 0 15px;
    height: 52px;
    background-color: #bf0404;
    border-radius: 3px;
    color: #fff;
    font-size: 15px;
    font-family: "Noto Sans",sans-serif;
}
.webzine-login .log-out p {
    margin: 0 0 10px 0;
    color: #969696;
    font-size: 12px;
    font-family: "Noto Sans",sans-serif;
    font-weight: 300;
}

.webzine-login .log-out {
    padding: 15px;
}

.webzine-login {
    margin: 0 0 10px;
    background-color: #f8f8f8;
    border: 1px solid #d0d0d0;
    box-sizing: border-box;
}
html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i{
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font-family: "Malgun Gothic","맑은 고딕",helvetica,"Apple SD Gothic Neo",sans-serif;
}
div, ul, ol, li, dl, dt, dd, h1, h2, h3, h4, h5, h6, form, fieldset {
    display: block;
    float: none;
}
div {
    display: block;
}
style 속성 {
    backskin-color: #FFFFFF;
    background-position-x: -420px;
    backskin-st: 0px;
}
body {
    line-height: normal;
}
body, p, h1, h2, h3, h4, h5, h6, ul, ol, li, dl, dt, dd, table, th, td, form, fieldset, legend, input, textarea, button, select {
    font-size: 13px;
}
</style>

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
		<p>더 안전하고 편리하게 사용하세요.</p>
  		<!-- 로그인 안한 경우 -->
	 	<sec:authorize access="isAnonymous()">
	 		<a id="customlogin" href="../member/login" class="login-btn">로그인</a>
	 			<div>
	 				<a id="memberJoin" href="../member/join">회원가입</a>
	 			</div>
	 	</sec:authorize>
	 	<!-- 로그인 한 경우 -->
	 	<sec:authorize access="isAuthenticated()">
	 			<a href="#"><sec:authentication property="principal.username"/></a>
	 			<a href="../member/modify">회원정보</a>
	 			<a href="#">로그아웃</a>
	 	</sec:authorize>
		 	
	</div> <!-- log-out -->
	</div> <!-- webzine-login -->
	<div>
    <h4 class="text-center">메뉴</h4>
    <div class="sidenav">
        <a href="../home/home">홈</a>
        <hr></hr>
        <a href="../board/list">자유게시판</a>
    </div>
</div>
</div> <!-- col-md-3 -->


</body>
</html>