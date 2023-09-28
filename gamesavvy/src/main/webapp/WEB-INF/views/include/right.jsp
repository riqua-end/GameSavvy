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
	 			<a href="../member/custom">회원정보</a>
	 			<a href="../member/logout">로그아웃</a>
	 	</sec:authorize>
	</div> <!-- log-out -->
	</div> <!-- webzine-login -->
	<div class="webzine-menu">
    	<h4>메뉴</h4>
    	<hr></hr>
    	<div class="sidenav">
       		<a href="../home/home">홈</a>
        	<a href="../board/list?gs_type=1">자유게시판</a>
        	<a href="../board/list?gs_type=2">공략게시판</a>
        	<a href="../board/list?gs_type=3">정보게시판</a>
        	<a href="../board/list?gs_type=4">리뷰게시판</a>
        	<a href="../board/list?gs_type=6">추천게시판</a>
    	</div>
	</div>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	<div class="webzine-admin">
		<h4>관리자 메뉴</h4>
		<hr></hr>
		<div class="sidenav">
			<a href="../admin/adminMember">회원관리</a>
			<a href="../admin/adminList">게시판관리</a>
			<a href="../board/list?gs_type=5">공지게시판</a>
		</div>
	</div>
	</sec:authorize>
	
	<!-- 배너 -->
	<table id="boardTable" class="table table-hover text-center">
			<thead class="table-dark">
				<tr>
					<th>
						<h2><strong>Steam 이달의 게임</strong></h2>
					</th>
				</tr>
			</thead>
	</table>
	<div id="carouselExample" class="carousel slide" data-ride="carousel">
	    <div class="carousel-inner">
	        <div class="carousel-item active">
	            <a href="https://store.steampowered.com/app/2195250/EA_SPORTS_FC_24/" class="img_area" target="_blank">
	                <img src="https://cdn.akamai.steamstatic.com/steam/apps/2195250/header.jpg?t=1695138449" class="d-block w-100" alt="...">
	            </a>
	        </div>
	        <div class="carousel-item">
	            <a href="https://store.steampowered.com/app/1627720/Lies_of_P/" class="img_area" target="_blank">
	                <img src="https://cdn.akamai.steamstatic.com/steam/apps/1627720/header.jpg?t=1695272170" class="d-block w-100" alt="...">
	            </a>
	        </div>
	        <div class="carousel-item">
	            <a href="https://store.steampowered.com/app/730/CounterStrike_2/" class="img_area" target="_blank">
	                <img src="https://cdn.akamai.steamstatic.com/steam/apps/730/header.jpg?t=1695853301" class="d-block w-100" alt="...">
	            </a>
	        </div>
	        <div class="carousel-item">
	            <a href="https://store.steampowered.com/app/1260320/Party_Animals/" class="img_area" target="_blank">
	                <img src="https://cdn.akamai.steamstatic.com/steam/apps/1260320/header.jpg?t=1695243290" class="d-block w-100" alt="...">
	            </a>
	        </div>
	        <div class="carousel-item">
	            <a href="https://store.steampowered.com/app/570/Dota_2/" class="img_area" target="_blank">
	                <img src="https://cdn.akamai.steamstatic.com/steam/apps/570/header.jpg?t=1682639497" class="d-block w-100" alt="...">
	            </a>
	        </div>
	    </div>
	    <a class="carousel-control-prev" href="#carouselExample" role="button" data-slide="prev">
	        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	        <span class="sr-only">Previous</span>
	    </a>
	    <a class="carousel-control-next" href="#carouselExample" role="button" data-slide="next">
	        <span class="carousel-control-next-icon" aria-hidden="true"></span>
	        <span class="sr-only">Next</span>
	    </a>
	</div>
</div> <!-- col-md-3 -->

</body>
</html>