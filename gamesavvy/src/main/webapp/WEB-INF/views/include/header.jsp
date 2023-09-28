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
<!--BS 4 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!--favicon -->
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />
<!--fontawesome icon-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<!--google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="../css/myCss.css?after"> <!-- 수정시 바로 적용을 위해 after추가 -->
</head>
<body>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container d-flex justify-content-center">
        <div>
            <a class="navbar-brand" href="../home/home" >
                <img src="../resources/images/logo.png" alt="logo" class="Logo-img" style="width: 300px;">
            </a>
        </div>
    </div>
</nav>

<div class="container-fluid sticky-top bg-white">
    <div class="container">
        <div class="row">
            <div class="col-2 d-flex justify-content-between">
                <nav class="navbar navbar-light">

                    <div class="nav-item dropdown">
                        <a class="navbar-toggler d-inline-flex align-items-center" id="dropdownMenuButton" data-toggle="dropdown"
                           aria-haspopup="true" aria-expanded="false">
                            <span class="navbar-toggler-icon"></span>
                            &nbsp;&nbsp;<span style="color: black;">카테고리</span>
                        </a>

                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="../board/list?gs_type=5">공지사항</a>
                            <a class="dropdown-item" href="../board/list?gs_type=1">자유게시판</a>
                            <a class="dropdown-item" href="../board/list?gs_type=2">공략게시판</a>
                            <a class="dropdown-item" href="../board/list?gs_type=3">정보게시판</a>
                            <a class="dropdown-item" href="../board/list?gs_type=4">리뷰게시판</a>
                            <a class="dropdown-item" href="../board/list?gs_type=6">추천게시판</a>
                        </div>
                    </div>
                </nav>
            </div>
            <nav class="nav nav-pills nav-fill nav-justified">
			  <a class="mainMenu nav-link p-4" href="../board/list?gs_type=1">자유게시판</a>
			  <a class="mainMenu nav-link p-4" href="../board/list?gs_type=2">공략게시판</a>
			  <a class="mainMenu nav-link p-4" href="../board/list?gs_type=3">정보게시판</a>
			  <a class="mainMenu nav-link p-4" href="../board/list?gs_type=4">리뷰게시판</a>
			  <a class="mainMenu nav-link p-4" href="../board/list?gs_type=6">추천게시판</a>
			</nav>
			<!-- 
            <div class="col d-flex justify-content-center flex-wrap align-items-center">
                <div class="p-2 text-black"><a class="mainMenu" href="../board/list?gs_type=1">자유게시판</a></div>
                <div class="p-2 text-black"><a class="mainMenu" href="../board/list?gs_type=2">공략게시판</a></div>
                <div class="p-2 text-black"><a class="mainMenu" href="../board/list?gs_type=3">정보게시판</a></div>
                <div class="p-2 text-black"><a class="mainMenu" href="../board/list?gs_type=4">리뷰게시판</a></div>
                <div class="p-2 text-black"><a class="mainMenu" href="../board/list?gs_type=6">추천게시판</a></div>
            </div>
            -->
            <div class="col-2 text-black d-flex align-items-center justify-content-center">
                <h4>
			        <button type="button" class="btn" style="cursor: pointer;">
		                <svg xmlns="http://www.w3.org/2000/svg" width="27" height="27" viewBox="0 0 448 512"><path d="M224 0c-17.7 0-32 14.3-32 32V49.9C119.5 61.4 64 124.2 64 200v33.4c0 45.4-15.5 89.5-43.8 124.9L5.3 377c-5.8 7.2-6.9 17.1-2.9 25.4S14.8 416 24 416H424c9.2 0 17.6-5.3 21.6-13.6s2.9-18.2-2.9-25.4l-14.9-18.6C399.5 322.9 384 278.8 384 233.4V200c0-75.8-55.5-138.6-128-150.1V32c0-17.7-14.3-32-32-32zm0 96h8c57.4 0 104 46.6 104 104v33.4c0 47.9 13.9 94.6 39.7 134.6H72.3C98.1 328 112 281.3 112 233.4V200c0-57.4 46.6-104 104-104h8zm64 352H224 160c0 17 6.7 33.3 18.7 45.3s28.3 18.7 45.3 18.7s33.3-6.7 45.3-18.7s18.7-28.3 18.7-45.3z"/></svg>
		            </button>
		
		            <button id="customButton" type="button" class="btn" style="cursor: pointer;">
		    	        <svg xmlns="http://www.w3.org/2000/svg" width="27" height="27" viewBox="0 0 448 512"><path d="M304 128a80 80 0 1 0 -160 0 80 80 0 1 0 160 0zM96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM49.3 464H398.7c-8.9-63.3-63.3-112-129-112H178.3c-65.7 0-120.1 48.7-129 112zM0 482.3C0 383.8 79.8 304 178.3 304h91.4C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7H29.7C13.3 512 0 498.7 0 482.3z"/></svg>
		            </button>
                </h4>
            </div>
        </div>
        <hr> <!-- header 와 main의 경계선 -->
    </div>
</div>

<script>
//customButton 클릭 시 /member/custom.jsp로 이동
document.getElementById('customButton').addEventListener('click', function() {
    window.location.href = '/member/custom';
});
</script>
</body>
</html>