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
.homeTitle{
	color: white;
}

.card {
        max-width: 400px;
        margin: 0 auto; /* 가운데 정렬을 위한 스타일 */
        width: 18rem;
    }

.card-img-top {
    object-fit: cover; /* 이미지를 카드의 크기에 맞게 잘라 표시 */
    height: 10rem;
}
/* 캐러셀 컨테이너의 최대 높이 설정 */
    .carousel {
        max-height: 100%; /* 원하는 높이로 설정 */
    }

    /* 캐러셀 이미지를 부모 요소에 맞게 조절하고 가로 중앙 정렬 */
    .carousel-inner img {
        width: 100%; /* 가로 크기 자동 조절 */
        max-height: 100%; /* 최대 높이 100%로 설정하여 비율 유지 */
        display: block; /* 이미지를 가로 중앙 정렬하기 위해 필요 */
        margin: 0 auto; /* 이미지를 가로 중앙 정렬 */
    }
</style>

<!-- RWD -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- MS -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8,IE=EmulateIE9"/> 
<body>

<%@include file="../include/header.jsp" %>

<div class="container-fluid">
    <!-- carousel클래스는 캐러셀콘테이너생성 클래스,slide은 css transition이나 animation사용 -->
    <!-- data-ride속성은 로딩즉시 스라이드 시작 -->
    <div id="demo" class="carousel silde" data-ride="carousel">
        <!-- Indicators는 캐러셀 아이템의 위치 표시 -->
        <!-- 캐러셀이 여러개 존재할수 있으므로 indicator가 위치할 캐러셀은 data-target으로 결정 -->
        <!-- indicator콘테이너는 ul사용 -->
        <ul class="carousel-indicators">
            <li data-taget="#demo" data-slide-to="0" class="active"></li>
            <li data-taget="#demo" data-slide-to="1"></li>
            <li data-taget="#demo" data-slide-to="2"></li>
            <li data-taget="#demo" data-slide-to="3"></li>
            <li data-taget="#demo" data-slide-to="4"></li>
            <li data-taget="#demo" data-slide-to="5"></li>
            <li data-taget="#demo" data-slide-to="6"></li>
            <li data-taget="#demo" data-slide-to="7"></li>
        </ul>
        <!-- 케러셀 content(내용물)의 스라이드 쇼,내용물은 carousel-inner콘테이너에 수용 -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <div class="embed-responsive" style="width: 100%; height: 600px;">
			    	<iframe alt="img1" class="embed-responsive-item" src="https://www.youtube.com/embed/C3fW-LIoDLc"></iframe>
				</div>
            </div>
            <div class="carousel-item">
                <div class="embed-responsive" style="width: 100%; height: 600px;">
			    	<iframe alt="img2" class="embed-responsive-item" src="https://www.youtube.com/embed/LGcECozNXEw"></iframe>
				</div>
            </div>
            <div class="carousel-item">
                <div class="embed-responsive" style="width: 100%; height: 600px;">
			    	<iframe alt="img3" class="embed-responsive-item" src="https://www.youtube.com/embed/__w615A5lC4"></iframe>
				</div>
            </div>
            <div class="carousel-item">
                <div class="embed-responsive" style="width: 100%; height: 600px;">
			    	<iframe alt="img4" class="embed-responsive-item" src="https://www.youtube.com/embed/SyP3V2sacQ0"></iframe>
				</div>	
            </div>
            <div class="carousel-item">
                <div class="embed-responsive" style="width: 100%; height: 600px;">
			    	<iframe alt="img5" class="embed-responsive-item" src="https://www.youtube.com/embed/C7KTI94LzI8"></iframe>
				</div>	
            </div>
            <div class="carousel-item">
                <div class="embed-responsive" style="width: 100%; height: 600px;">
			    	<iframe alt="img5" class="embed-responsive-item" src="https://www.youtube.com/embed/5KdE0p2joJw"></iframe>
				</div>
            </div>
            <div class="carousel-item">
            	<video height="500" alt="img7" loop="" muted="" autoplay="" playsinline="" poster="https://cdn.akamai.steamstatic.com/steam/clusters/frontpage/3997104af95560502d558b26/page_bg_koreana.jpg?t=1695662269" class="fullscreen-bg__video">
					<source src="https://cdn.akamai.steamstatic.com/steam/clusters/frontpage/3997104af95560502d558b26/webm_page_bg_koreana.webm?t=1695662269" type="video/webm">
					<source src="https://cdn.akamai.steamstatic.com/steam/clusters/frontpage/3997104af95560502d558b26/mp4_page_bg_koreana.mp4?t=1695662269" type="video/mp4">
				</video>
			</div>								
        </div>
        <!-- Left and right controls,왼쪽 오른쪽의 콘트롤 버튼 -->
        <a class="carousel-control-prev" href="#demo" data-slide="prev">
            <span class="carousel-control-prev-icon"></span> <!-- 아이콘으로 문자열 표시 -->
        </a>
        <a class="carousel-control-next" href="#demo" data-slide="next">
            <span class="carousel-control-next-icon"></span> <!-- 아이콘으로 문자열 표시 -->
        </a>
    </div>
</div>

<div class="container mt-4 mb-4" id="maincontent">
	<div class="row">
		<div class="col-md-9">
			<table id="boardTable" class="table table-hover text-center">
					<thead class="table-dark">
						<tr>
							<th>
								<h2><strong>Steam Game 이달의 소식</strong></h2>
							</th>
						</tr>
					</thead>
			</table>
			<div class="embed-responsive embed-responsive-16by9">
			    <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/uqd1a0xJuoQ"></iframe>
			</div>
			<hr></hr>
			<a target="_blank" href="http://www.sidizgaming.com/">
				<img src="../resources/images/fff.PNG" alt="logo" class="Logo-img" style="width: 827px;">
			</a>
			<a target="_blank" href="https://dragonheir.nvsgames.com/?af_xp=referral&pid=KRcommunity&c=InvenDA&af_click_lookback=30d&af_adset=PCupbanner">
				<img src="../resources/images/qqq.PNG" alt="logo" class="Logo-img" onclick="openNewWindow()" style="width: 825px;">
			</a>
			<div class="container mt-4">
			    <table id="boardTable" class="table table-hover text-center">
						<thead class="table-dark">
							<tr>
								<th>
									<h2><a class="homeTitle" href="../board/list?gs_type=6"><strong>Steam Game 추천게시판</strong></a></h2>
								</th>
							</tr>
						</thead>
				</table>
			    <div class="card-group">
				    <c:forEach items="${board6}" var="board">
				        <div class="card">
				        	<div id="bno" data-bno="<c:out value="${board.bno}" />">
				        		<a href="/board/get?gs_type=6&bno=${board.bno}"> <!-- 이미지 클릭 시 해당 게시글로 이동 -->
					                <img src="../resources/images/default-image.png" class="card-img-top" alt="...">
					            </a>
				        	</div>
				            <div class="card-body p-2">
				                <h4 class="card-title"><a href="/board/get?gs_type=6&bno=${board.bno}" style="font-weight:bold;color: #000000;text-decoration: none;"><c:out value="${board.title}" /></a></h4>
				            </div>
				            <div class="card-footer">
				            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock-history" viewBox="0 0 16 16">
									<path d="M8.515 1.019A7 7 0 0 0 8 1V0a8 8 0 0 1 .589.022l-.074.997zm2.004.45a7.003 7.003 0 0 0-.985-.299l.219-.976c.383.086.76.2 1.126.342l-.36.933zm1.37.71a7.01 7.01 0 0 0-.439-.27l.493-.87a8.025 8.025 0 0 1 .979.654l-.615.789a6.996 6.996 0 0 0-.418-.302zm1.834 1.79a6.99 6.99 0 0 0-.653-.796l.724-.69c.27.285.52.59.747.91l-.818.576zm.744 1.352a7.08 7.08 0 0 0-.214-.468l.893-.45a7.976 7.976 0 0 1 .45 1.088l-.95.313a7.023 7.023 0 0 0-.179-.483zm.53 2.507a6.991 6.991 0 0 0-.1-1.025l.985-.17c.067.386.106.778.116 1.17l-1 .025zm-.131 1.538c.033-.17.06-.339.081-.51l.993.123a7.957 7.957 0 0 1-.23 1.155l-.964-.267c.046-.165.086-.332.12-.501zm-.952 2.379c.184-.29.346-.594.486-.908l.914.405c-.16.36-.345.706-.555 1.038l-.845-.535zm-.964 1.205c.122-.122.239-.248.35-.378l.758.653a8.073 8.073 0 0 1-.401.432l-.707-.707z"/>
									<path d="M8 1a7 7 0 1 0 4.95 11.95l.707.707A8.001 8.001 0 1 1 8 0v1z"/>
									<path d="M7.5 3a.5.5 0 0 1 .5.5v5.21l3.248 1.856a.5.5 0 0 1-.496.868l-3.5-2A.5.5 0 0 1 7 9V3.5a.5.5 0 0 1 .5-.5z"/>
								</svg><small class="date-cell" style="margin-left: 5px;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate}" /></small><br>
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-wechat" viewBox="0 0 16 16">
									<path d="M11.176 14.429c-2.665 0-4.826-1.8-4.826-4.018 0-2.22 2.159-4.02 4.824-4.02S16 8.191 16 10.411c0 1.21-.65 2.301-1.666 3.036a.324.324 0 0 0-.12.366l.218.81a.616.616 0 0 1 .029.117.166.166 0 0 1-.162.162.177.177 0 0 1-.092-.03l-1.057-.61a.519.519 0 0 0-.256-.074.509.509 0 0 0-.142.021 5.668 5.668 0 0 1-1.576.22ZM9.064 9.542a.647.647 0 1 0 .557-1 .645.645 0 0 0-.646.647.615.615 0 0 0 .09.353Zm3.232.001a.646.646 0 1 0 .546-1 .645.645 0 0 0-.644.644.627.627 0 0 0 .098.356Z"/>
									<path d="M0 6.826c0 1.455.781 2.765 2.001 3.656a.385.385 0 0 1 .143.439l-.161.6-.1.373a.499.499 0 0 0-.032.14.192.192 0 0 0 .193.193c.039 0 .077-.01.111-.029l1.268-.733a.622.622 0 0 1 .308-.088c.058 0 .116.009.171.025a6.83 6.83 0 0 0 1.625.26 4.45 4.45 0 0 1-.177-1.251c0-2.936 2.785-5.02 5.824-5.02.05 0 .1 0 .15.002C10.587 3.429 8.392 2 5.796 2 2.596 2 0 4.16 0 6.826Zm4.632-1.555a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0Zm3.875 0a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0Z"/>
								</svg>&nbsp;<c:out value="${board.replycnt}"/>
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
									<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
									<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
								</svg>&nbsp;<c:out value="${board.cnt}"/>
								<i class="fas fa-thumbs-up">&nbsp;</i><c:out value="${recommendCounts[board.bno]}"/>
						    </div>
				        </div>
				    </c:forEach>
				</div>
			</div>

			<br></br>
			<div class="row">
				<div class="col-md-6">
					<div class="table-responsive-md mt-2">
						<table id="boardTable" class="table table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>
										<a class="homeTitle" href="../board/list?gs_type=1"><strong>자유게시판</strong></a>
									</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${board1}" var="board">
									<tr>
										<td>
											<div class="row">
												<div class="col-md-6">
													<div class="row" >
									    				<div id="user-profile" data-userid="<c:out value="${board.userid}" />">&nbsp;&nbsp;</div>&nbsp;&nbsp;
								    						<div style="opacity: 0.7;"><c:out value="${board.userid}" /></div>&nbsp;
								    						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock-history" viewBox="0 0 16 16">
  															<path d="M8.515 1.019A7 7 0 0 0 8 1V0a8 8 0 0 1 .589.022l-.074.997zm2.004.45a7.003 7.003 0 0 0-.985-.299l.219-.976c.383.086.76.2 1.126.342l-.36.933zm1.37.71a7.01 7.01 0 0 0-.439-.27l.493-.87a8.025 8.025 0 0 1 .979.654l-.615.789a6.996 6.996 0 0 0-.418-.302zm1.834 1.79a6.99 6.99 0 0 0-.653-.796l.724-.69c.27.285.52.59.747.91l-.818.576zm.744 1.352a7.08 7.08 0 0 0-.214-.468l.893-.45a7.976 7.976 0 0 1 .45 1.088l-.95.313a7.023 7.023 0 0 0-.179-.483zm.53 2.507a6.991 6.991 0 0 0-.1-1.025l.985-.17c.067.386.106.778.116 1.17l-1 .025zm-.131 1.538c.033-.17.06-.339.081-.51l.993.123a7.957 7.957 0 0 1-.23 1.155l-.964-.267c.046-.165.086-.332.12-.501zm-.952 2.379c.184-.29.346-.594.486-.908l.914.405c-.16.36-.345.706-.555 1.038l-.845-.535zm-.964 1.205c.122-.122.239-.248.35-.378l.758.653a8.073 8.073 0 0 1-.401.432l-.707-.707z"/>
  															<path d="M8 1a7 7 0 1 0 4.95 11.95l.707.707A8.001 8.001 0 1 1 8 0v1z"/>
  															<path d="M7.5 3a.5.5 0 0 1 .5.5v5.21l3.248 1.856a.5.5 0 0 1-.496.868l-3.5-2A.5.5 0 0 1 7 9V3.5a.5.5 0 0 1 .5-.5z"/>
															</svg><small class="date-cell" style="margin-left: 5px;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate}" /></small>
									    			</div>
												</div>
												<div class="col-md-6" style="text-align: right;">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-wechat" viewBox="0 0 16 16">
  													<path d="M11.176 14.429c-2.665 0-4.826-1.8-4.826-4.018 0-2.22 2.159-4.02 4.824-4.02S16 8.191 16 10.411c0 1.21-.65 2.301-1.666 3.036a.324.324 0 0 0-.12.366l.218.81a.616.616 0 0 1 .029.117.166.166 0 0 1-.162.162.177.177 0 0 1-.092-.03l-1.057-.61a.519.519 0 0 0-.256-.074.509.509 0 0 0-.142.021 5.668 5.668 0 0 1-1.576.22ZM9.064 9.542a.647.647 0 1 0 .557-1 .645.645 0 0 0-.646.647.615.615 0 0 0 .09.353Zm3.232.001a.646.646 0 1 0 .546-1 .645.645 0 0 0-.644.644.627.627 0 0 0 .098.356Z"/>
  													<path d="M0 6.826c0 1.455.781 2.765 2.001 3.656a.385.385 0 0 1 .143.439l-.161.6-.1.373a.499.499 0 0 0-.032.14.192.192 0 0 0 .193.193c.039 0 .077-.01.111-.029l1.268-.733a.622.622 0 0 1 .308-.088c.058 0 .116.009.171.025a6.83 6.83 0 0 0 1.625.26 4.45 4.45 0 0 1-.177-1.251c0-2.936 2.785-5.02 5.824-5.02.05 0 .1 0 .15.002C10.587 3.429 8.392 2 5.796 2 2.596 2 0 4.16 0 6.826Zm4.632-1.555a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0Zm3.875 0a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0Z"/>
													</svg>&nbsp;<c:out value="${board.replycnt}"/>
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
  													<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
  													<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
													</svg>&nbsp;<c:out value="${board.cnt}"/>
													<i class="fas fa-thumbs-up"></i>&nbsp;&nbsp;<c:out value="${recommendCounts[board.bno]}"/>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12" style="text-align: left; font-size: 16px">
													<a style="font-weight:bold;color: #000000;text-decoration: none;" href="/board/get?gs_type=1&bno=${board.bno}">
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${board.title}"/>
													</a>
												</div>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div> <!-- table-responsive-md mt-2 -->
				</div> <!-- col-md-6 -->
				<div class="col-md-6">
					<div class="table-responsive-md mt-2">
						<table id="boardTable" class="table table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>
										<a class="homeTitle" href="../board/list?gs_type=2"><strong>공략게시판</strong></a>
									</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${board2}" var="board">
									<tr>
										<td>
											<div class="row">
												<div class="col-md-6">
													<div class="row" >
									    				<div id="user-profile" data-userid="<c:out value="${board.userid}" />">&nbsp;&nbsp;</div>&nbsp;&nbsp;
								    						<div style="opacity: 0.7;"><c:out value="${board.userid}" /></div>&nbsp;
								    						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock-history" viewBox="0 0 16 16">
  															<path d="M8.515 1.019A7 7 0 0 0 8 1V0a8 8 0 0 1 .589.022l-.074.997zm2.004.45a7.003 7.003 0 0 0-.985-.299l.219-.976c.383.086.76.2 1.126.342l-.36.933zm1.37.71a7.01 7.01 0 0 0-.439-.27l.493-.87a8.025 8.025 0 0 1 .979.654l-.615.789a6.996 6.996 0 0 0-.418-.302zm1.834 1.79a6.99 6.99 0 0 0-.653-.796l.724-.69c.27.285.52.59.747.91l-.818.576zm.744 1.352a7.08 7.08 0 0 0-.214-.468l.893-.45a7.976 7.976 0 0 1 .45 1.088l-.95.313a7.023 7.023 0 0 0-.179-.483zm.53 2.507a6.991 6.991 0 0 0-.1-1.025l.985-.17c.067.386.106.778.116 1.17l-1 .025zm-.131 1.538c.033-.17.06-.339.081-.51l.993.123a7.957 7.957 0 0 1-.23 1.155l-.964-.267c.046-.165.086-.332.12-.501zm-.952 2.379c.184-.29.346-.594.486-.908l.914.405c-.16.36-.345.706-.555 1.038l-.845-.535zm-.964 1.205c.122-.122.239-.248.35-.378l.758.653a8.073 8.073 0 0 1-.401.432l-.707-.707z"/>
  															<path d="M8 1a7 7 0 1 0 4.95 11.95l.707.707A8.001 8.001 0 1 1 8 0v1z"/>
  															<path d="M7.5 3a.5.5 0 0 1 .5.5v5.21l3.248 1.856a.5.5 0 0 1-.496.868l-3.5-2A.5.5 0 0 1 7 9V3.5a.5.5 0 0 1 .5-.5z"/>
															</svg><small class="date-cell" style="margin-left: 5px;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate}" /></small>
									    			</div>
												</div>
												<div class="col-md-6" style="text-align: right;">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-wechat" viewBox="0 0 16 16">
  													<path d="M11.176 14.429c-2.665 0-4.826-1.8-4.826-4.018 0-2.22 2.159-4.02 4.824-4.02S16 8.191 16 10.411c0 1.21-.65 2.301-1.666 3.036a.324.324 0 0 0-.12.366l.218.81a.616.616 0 0 1 .029.117.166.166 0 0 1-.162.162.177.177 0 0 1-.092-.03l-1.057-.61a.519.519 0 0 0-.256-.074.509.509 0 0 0-.142.021 5.668 5.668 0 0 1-1.576.22ZM9.064 9.542a.647.647 0 1 0 .557-1 .645.645 0 0 0-.646.647.615.615 0 0 0 .09.353Zm3.232.001a.646.646 0 1 0 .546-1 .645.645 0 0 0-.644.644.627.627 0 0 0 .098.356Z"/>
  													<path d="M0 6.826c0 1.455.781 2.765 2.001 3.656a.385.385 0 0 1 .143.439l-.161.6-.1.373a.499.499 0 0 0-.032.14.192.192 0 0 0 .193.193c.039 0 .077-.01.111-.029l1.268-.733a.622.622 0 0 1 .308-.088c.058 0 .116.009.171.025a6.83 6.83 0 0 0 1.625.26 4.45 4.45 0 0 1-.177-1.251c0-2.936 2.785-5.02 5.824-5.02.05 0 .1 0 .15.002C10.587 3.429 8.392 2 5.796 2 2.596 2 0 4.16 0 6.826Zm4.632-1.555a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0Zm3.875 0a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0Z"/>
													</svg>&nbsp;<c:out value="${board.replycnt}"/>
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
  													<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
  													<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
													</svg>&nbsp;<c:out value="${board.cnt}"/>
													<i class="fas fa-thumbs-up"></i>&nbsp;&nbsp;<c:out value="${recommendCounts[board.bno]}"/>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12" style="text-align: left; font-size: 16px">
													<a style="font-weight:bold;color: #000000;text-decoration: none;" href="/board/get?gs_type=1&bno=${board.bno}">
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${board.title}"/>
													</a>
												</div>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div> <!-- table-responsive-md mt-2 -->
				</div> <!-- col-md-6 -->
			</div> <!-- row -->
			<div class="row">
				<div class="col-md-6">
					<div class="table-responsive-md mt-2">
						<table id="boardTable" class="table table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>
										<a class="homeTitle" href="../board/list?gs_type=3"><strong>정보게시판</strong></a>
									</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${board3}" var="board">
									<tr>
										<td>
											<div class="row">
												<div class="col-md-6">
													<div class="row" >
									    				<div id="user-profile" data-userid="<c:out value="${board.userid}" />">&nbsp;&nbsp;</div>&nbsp;&nbsp;
								    						<div style="opacity: 0.7;"><c:out value="${board.userid}" /></div>&nbsp;
								    						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock-history" viewBox="0 0 16 16">
  															<path d="M8.515 1.019A7 7 0 0 0 8 1V0a8 8 0 0 1 .589.022l-.074.997zm2.004.45a7.003 7.003 0 0 0-.985-.299l.219-.976c.383.086.76.2 1.126.342l-.36.933zm1.37.71a7.01 7.01 0 0 0-.439-.27l.493-.87a8.025 8.025 0 0 1 .979.654l-.615.789a6.996 6.996 0 0 0-.418-.302zm1.834 1.79a6.99 6.99 0 0 0-.653-.796l.724-.69c.27.285.52.59.747.91l-.818.576zm.744 1.352a7.08 7.08 0 0 0-.214-.468l.893-.45a7.976 7.976 0 0 1 .45 1.088l-.95.313a7.023 7.023 0 0 0-.179-.483zm.53 2.507a6.991 6.991 0 0 0-.1-1.025l.985-.17c.067.386.106.778.116 1.17l-1 .025zm-.131 1.538c.033-.17.06-.339.081-.51l.993.123a7.957 7.957 0 0 1-.23 1.155l-.964-.267c.046-.165.086-.332.12-.501zm-.952 2.379c.184-.29.346-.594.486-.908l.914.405c-.16.36-.345.706-.555 1.038l-.845-.535zm-.964 1.205c.122-.122.239-.248.35-.378l.758.653a8.073 8.073 0 0 1-.401.432l-.707-.707z"/>
  															<path d="M8 1a7 7 0 1 0 4.95 11.95l.707.707A8.001 8.001 0 1 1 8 0v1z"/>
  															<path d="M7.5 3a.5.5 0 0 1 .5.5v5.21l3.248 1.856a.5.5 0 0 1-.496.868l-3.5-2A.5.5 0 0 1 7 9V3.5a.5.5 0 0 1 .5-.5z"/>
															</svg><small class="date-cell" style="margin-left: 5px;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate}" /></small>
									    			</div>
												</div>
												<div class="col-md-6" style="text-align: right;">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-wechat" viewBox="0 0 16 16">
  													<path d="M11.176 14.429c-2.665 0-4.826-1.8-4.826-4.018 0-2.22 2.159-4.02 4.824-4.02S16 8.191 16 10.411c0 1.21-.65 2.301-1.666 3.036a.324.324 0 0 0-.12.366l.218.81a.616.616 0 0 1 .029.117.166.166 0 0 1-.162.162.177.177 0 0 1-.092-.03l-1.057-.61a.519.519 0 0 0-.256-.074.509.509 0 0 0-.142.021 5.668 5.668 0 0 1-1.576.22ZM9.064 9.542a.647.647 0 1 0 .557-1 .645.645 0 0 0-.646.647.615.615 0 0 0 .09.353Zm3.232.001a.646.646 0 1 0 .546-1 .645.645 0 0 0-.644.644.627.627 0 0 0 .098.356Z"/>
  													<path d="M0 6.826c0 1.455.781 2.765 2.001 3.656a.385.385 0 0 1 .143.439l-.161.6-.1.373a.499.499 0 0 0-.032.14.192.192 0 0 0 .193.193c.039 0 .077-.01.111-.029l1.268-.733a.622.622 0 0 1 .308-.088c.058 0 .116.009.171.025a6.83 6.83 0 0 0 1.625.26 4.45 4.45 0 0 1-.177-1.251c0-2.936 2.785-5.02 5.824-5.02.05 0 .1 0 .15.002C10.587 3.429 8.392 2 5.796 2 2.596 2 0 4.16 0 6.826Zm4.632-1.555a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0Zm3.875 0a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0Z"/>
													</svg>&nbsp;<c:out value="${board.replycnt}"/>
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
  													<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
  													<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
													</svg>&nbsp;<c:out value="${board.cnt}"/>
													<i class="fas fa-thumbs-up"></i>&nbsp;&nbsp;<c:out value="${recommendCounts[board.bno]}"/>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12" style="text-align: left; font-size: 16px">
													<a style="font-weight:bold;color: #000000;text-decoration: none;" href="/board/get?gs_type=1&bno=${board.bno}">
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${board.title}"/>
													</a>
												</div>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div> <!-- table-responsive-md mt-2 -->
				</div> <!-- col-md-6 -->
				<div class="col-md-6">
					<div class="table-responsive-md mt-2">
						<table id="boardTable" class="table table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>
										<a class="homeTitle" href="../board/list?gs_type=4"><strong>리뷰게시판</strong></a>
									</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${board4}" var="board">
									<tr>
										<td>
											<div class="row">
												<div class="col-md-6">
													<div class="row" >
									    				<div id="user-profile" data-userid="<c:out value="${board.userid}" />">&nbsp;&nbsp;</div>&nbsp;&nbsp;
								    						<div style="opacity: 0.7;"><c:out value="${board.userid}" /></div>&nbsp;
								    						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock-history" viewBox="0 0 16 16">
  															<path d="M8.515 1.019A7 7 0 0 0 8 1V0a8 8 0 0 1 .589.022l-.074.997zm2.004.45a7.003 7.003 0 0 0-.985-.299l.219-.976c.383.086.76.2 1.126.342l-.36.933zm1.37.71a7.01 7.01 0 0 0-.439-.27l.493-.87a8.025 8.025 0 0 1 .979.654l-.615.789a6.996 6.996 0 0 0-.418-.302zm1.834 1.79a6.99 6.99 0 0 0-.653-.796l.724-.69c.27.285.52.59.747.91l-.818.576zm.744 1.352a7.08 7.08 0 0 0-.214-.468l.893-.45a7.976 7.976 0 0 1 .45 1.088l-.95.313a7.023 7.023 0 0 0-.179-.483zm.53 2.507a6.991 6.991 0 0 0-.1-1.025l.985-.17c.067.386.106.778.116 1.17l-1 .025zm-.131 1.538c.033-.17.06-.339.081-.51l.993.123a7.957 7.957 0 0 1-.23 1.155l-.964-.267c.046-.165.086-.332.12-.501zm-.952 2.379c.184-.29.346-.594.486-.908l.914.405c-.16.36-.345.706-.555 1.038l-.845-.535zm-.964 1.205c.122-.122.239-.248.35-.378l.758.653a8.073 8.073 0 0 1-.401.432l-.707-.707z"/>
  															<path d="M8 1a7 7 0 1 0 4.95 11.95l.707.707A8.001 8.001 0 1 1 8 0v1z"/>
  															<path d="M7.5 3a.5.5 0 0 1 .5.5v5.21l3.248 1.856a.5.5 0 0 1-.496.868l-3.5-2A.5.5 0 0 1 7 9V3.5a.5.5 0 0 1 .5-.5z"/>
															</svg><small class="date-cell" style="margin-left: 5px;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate}" /></small>
									    			</div>
												</div>
												<div class="col-md-6" style="text-align: right;">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-wechat" viewBox="0 0 16 16">
  													<path d="M11.176 14.429c-2.665 0-4.826-1.8-4.826-4.018 0-2.22 2.159-4.02 4.824-4.02S16 8.191 16 10.411c0 1.21-.65 2.301-1.666 3.036a.324.324 0 0 0-.12.366l.218.81a.616.616 0 0 1 .029.117.166.166 0 0 1-.162.162.177.177 0 0 1-.092-.03l-1.057-.61a.519.519 0 0 0-.256-.074.509.509 0 0 0-.142.021 5.668 5.668 0 0 1-1.576.22ZM9.064 9.542a.647.647 0 1 0 .557-1 .645.645 0 0 0-.646.647.615.615 0 0 0 .09.353Zm3.232.001a.646.646 0 1 0 .546-1 .645.645 0 0 0-.644.644.627.627 0 0 0 .098.356Z"/>
  													<path d="M0 6.826c0 1.455.781 2.765 2.001 3.656a.385.385 0 0 1 .143.439l-.161.6-.1.373a.499.499 0 0 0-.032.14.192.192 0 0 0 .193.193c.039 0 .077-.01.111-.029l1.268-.733a.622.622 0 0 1 .308-.088c.058 0 .116.009.171.025a6.83 6.83 0 0 0 1.625.26 4.45 4.45 0 0 1-.177-1.251c0-2.936 2.785-5.02 5.824-5.02.05 0 .1 0 .15.002C10.587 3.429 8.392 2 5.796 2 2.596 2 0 4.16 0 6.826Zm4.632-1.555a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0Zm3.875 0a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0Z"/>
													</svg>&nbsp;<c:out value="${board.replycnt}"/>
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
  													<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
  													<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
													</svg>&nbsp;<c:out value="${board.cnt}"/>
													<i class="fas fa-thumbs-up"></i>&nbsp;&nbsp;<c:out value="${recommendCounts[board.bno]}"/>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12" style="text-align: left; font-size: 16px">
													<a style="font-weight:bold;color: #000000;text-decoration: none;" href="/board/get?gs_type=1&bno=${board.bno}">
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${board.title}"/>
													</a>
												</div>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div> <!-- table-responsive-md mt-2 -->
				</div> <!-- col-md-6 -->
			</div> <!-- row -->
		</div> <!-- col-md-8 -->
		
		<%@include file="../include/right.jsp" %>
		
	</div> <!-- row -->
</div> <!-- maincontent -->
<%@include file="../include/footer.jsp" %>

<script>
(function(){
    let bnoElements = document.querySelectorAll(".card"); // 모든 게시글 카드 요소 선택

    bnoElements.forEach(function(card) {
        let bnoElement = card.querySelector("#bno"); // 각 게시글 카드 내의 bno 요소 선택
        let bno = bnoElement.getAttribute("data-bno"); // 게시글 bno 가져오기

        $.getJSON("getAttachList", { bno: bno }, function(arr) {
            let hasImage = false; // 이미지 여부를 확인하는 변수
            let imageElement = card.querySelector(".card-img-top"); // 카드 내의 이미지 요소 선택
            
            $(arr).each(function(i, obj){
                if(obj.fileType === true && !hasImage) { // 다중 이미지 중 첫 번째 이미지만 처리
                    let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName); // 섬네일
                    let originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName; // 원본파일 경로
                    originPath = originPath.replace(new RegExp(/\\/g), "/"); // \\를 /로 대체
                                  
                    imageElement.setAttribute("src", '../upload/display?fileName='+fileCallPath);
                    imageElement.parentElement.setAttribute("href", '/board/get?gs_type=6&bno=' + bno); // 이미지 클릭 시 해당 게시글로 이동
          
                    hasImage = true; // 이미지가 하나 이상 있는 경우 true로 설정
                }
            });
            // 이미지가 없을 경우 기본 이미지를 표시하는 코드 추가
            if (!hasImage) {
                imageElement.setAttribute("src", '../resources/images/no_image.png');
            }
        });
    });
})();
</script>

<script>
(function(){
    let userIdElements = document.querySelectorAll("#user-profile"); // 모든 게시글의 작성자 아이디 요소 선택

    userIdElements.forEach(function(element) {
        let userid = element.getAttribute("data-userid"); // 작성자 아이디 가져오기

        $.getJSON("getProfileImages",{userid: userid}, function(arr) {
            let str = "";
            let hasImage = false; // 이미지 여부를 확인하는 변수
            
            $(arr).each(function(i, obj){
                if(obj.fileType === true) {
                    let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName); // 섬네일

                    let originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName; // 원본파일 경로
                    originPath = originPath.replace(new RegExp(/\\/g), "/"); // \\를 /로 대체
					                   
                    str += "<div class='rounded-circle' style='overflow: hidden; width: 25px; height: 25px;'>";
                    str += "<img src='../upload/displayimg?fileName="+fileCallPath+"' style='object-fit:cover; width: 100%; height: 100%;'>";
                    str += "</div>";
          
                    hasImage = true; // 이미지가 하나 이상 있는 경우 true로 설정
                }
            });

            // 이미지가 없을 경우 기본 이미지를 표시하는 코드 추가
            if (!hasImage) {
                str += "<div class='rounded-circle' style='overflow: hidden; width: 25px; height: 25px;'>";
                str += "<img src='../resources/images/default-image.png' style='object-fit:cover; width: 100%; height: 100%;'>";
                str += "</div>";
            }

            // 작성자 아이디 요소 다음에 프로필 이미지 요소 추가
            $(element).after(str);
        });
    });
})();
</script>

<script>
    // 게시글 작성일을 상대적인 시간으로 포맷하는 함수
    function formatDateToRelativeTime(date) {
        // 현재 시간을 가져옴
        let now = new Date();
        // 게시글 작성일을 JavaScript Date 객체로 변환
        let postDate = new Date(date);
        // 현재 시간과 게시글 작성일의 차이를 밀리초 단위로 계산
        let timeDiff = now.getTime() - postDate.getTime();
        // 차이를 초 단위로 계산
        let seconds = Math.floor(timeDiff / 1000);

        // 게시된 지 60초 이내라면 "방금"을 반환
        if (seconds < 60) {
            return "방금";
        }
        // 게시된 지 1시간 이내라면 분 단위로 표시
        else if (seconds < 3600) {
        	let minutes = Math.floor(seconds / 60);
            return minutes + "분 전";
        }
        // 게시된 지 24시간 이내라면 시간 단위로 표시
        else if (seconds < 86400) {
        	let hours = Math.floor(seconds / 3600);
            return hours + "시간 전";
        }
        // 24시간이 지나면 "어제"를 반환
        else {
        	let days = Math.floor(seconds / 86400);
            if (days === 1) {
                return "어제";
            } else {
                // 년, 월, 일을 가져와서 "년-월-일" 형식으로 반환
                let year = postDate.getFullYear();
                let month = String(postDate.getMonth() + 1).padStart(2, '0');
                let day = String(postDate.getDate()).padStart(2, '0');
                return year + '-' + month + '-' + day;
            }
        }
    }

    // 모든 작성일 엘리먼트에 대해 작성일을 변환하여 설정
    let dateElements = document.querySelectorAll(".date-cell");
    dateElements.forEach((element) => {
        // 엘리먼트에서 작성일을 가져옵니다.
        let originalDate = element.textContent.trim();
        // 작성일을 상대적인 시간으로 변환합니다.
        let formattedDate = formatDateToRelativeTime(originalDate);
        // 엘리먼트의 텍스트 내용을 변환된 작성일로 설정합니다.
        element.textContent = formattedDate;
    });
</script>


</body>
</html>