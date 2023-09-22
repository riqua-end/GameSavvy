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
<body>

<%@include file="../include/header.jsp" %>
<div class="container mt-4 mb-4" id="maincontent">
	<div class="row">
		
		<div class="col-md-9">
			<h2 class="text-center">Steam Savvy</h2>
			<div class="row">
				<div class="col-md-6">
					<a href="../board/list?gs_type=1">자유게시판</a>
					<div class="table-responsive-md mt-2">
						<table id="boardTable" class="table table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>제목</th>
									<th>조회수</th>
									<th>추천</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${board1}" var="board">
									<tr>
										<td>
											<a style="font-weight:bold;color: #000000;text-decoration: none;" href="/board/get?bno=${board.bno}">
												<c:out value="${board.title}"/>
												<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M123.6 391.3c12.9-9.4 29.6-11.8 44.6-6.4c26.5 9.6 56.2 15.1 87.8 15.1c124.7 0 208-80.5 208-160s-83.3-160-208-160S48 160.5 48 240c0 32 12.4 62.8 35.7 89.2c8.6 9.7 12.8 22.5 11.8 35.5c-1.4 18.1-5.7 34.7-11.3 49.4c17-7.9 31.1-16.7 39.4-22.7zM21.2 431.9c1.8-2.7 3.5-5.4 5.1-8.1c10-16.6 19.5-38.4 21.4-62.9C17.7 326.8 0 285.1 0 240C0 125.1 114.6 32 256 32s256 93.1 256 208s-114.6 208-256 208c-37.1 0-72.3-6.4-104.1-17.9c-11.9 8.7-31.3 20.6-54.3 30.6c-15.1 6.6-32.3 12.6-50.1 16.1c-.8 .2-1.6 .3-2.4 .5c-4.4 .8-8.7 1.5-13.2 1.9c-.2 0-.5 .1-.7 .1c-5.1 .5-10.2 .8-15.3 .8c-6.5 0-12.3-3.9-14.8-9.9c-2.5-6-1.1-12.8 3.4-17.4c4.1-4.2 7.8-8.7 11.3-13.5c1.7-2.3 3.3-4.6 4.8-6.9c.1-.2 .2-.3 .3-.5z"/></svg>
												<span class="position-absolute top-0 start-100 translate-middle badge rounded-circle bg-light">
													<c:out value="${board.replycnt}"/>
												</span>
											</a></td>
										<td><c:out value="${board.cnt}"/></td>
										<td><c:out value="${recommendCounts[board.bno]}"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div> <!-- table-responsive-md mt-2 -->
				</div> <!-- col-md-6 -->
				<div class="col-md-6">
					<a href="../board/list?gs_type=2">공략게시판</a>
					<div class="table-responsive-md mt-2">
						<table id="boardTable" class="table table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>제목</th>
									<th>조회수</th>
									<th>추천</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${board2}" var="board">
									<tr>
										<td>
											<a style="font-weight:bold;color: #000000;text-decoration: none;" href="/board/get?bno=${board.bno}">
												<c:out value="${board.title}"/>
												<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M123.6 391.3c12.9-9.4 29.6-11.8 44.6-6.4c26.5 9.6 56.2 15.1 87.8 15.1c124.7 0 208-80.5 208-160s-83.3-160-208-160S48 160.5 48 240c0 32 12.4 62.8 35.7 89.2c8.6 9.7 12.8 22.5 11.8 35.5c-1.4 18.1-5.7 34.7-11.3 49.4c17-7.9 31.1-16.7 39.4-22.7zM21.2 431.9c1.8-2.7 3.5-5.4 5.1-8.1c10-16.6 19.5-38.4 21.4-62.9C17.7 326.8 0 285.1 0 240C0 125.1 114.6 32 256 32s256 93.1 256 208s-114.6 208-256 208c-37.1 0-72.3-6.4-104.1-17.9c-11.9 8.7-31.3 20.6-54.3 30.6c-15.1 6.6-32.3 12.6-50.1 16.1c-.8 .2-1.6 .3-2.4 .5c-4.4 .8-8.7 1.5-13.2 1.9c-.2 0-.5 .1-.7 .1c-5.1 .5-10.2 .8-15.3 .8c-6.5 0-12.3-3.9-14.8-9.9c-2.5-6-1.1-12.8 3.4-17.4c4.1-4.2 7.8-8.7 11.3-13.5c1.7-2.3 3.3-4.6 4.8-6.9c.1-.2 .2-.3 .3-.5z"/></svg>
												<span class="position-absolute top-0 start-100 translate-middle badge rounded-circle bg-light">
													<c:out value="${board.replycnt}"/>
												</span>
											</a></td>
										<td><c:out value="${board.cnt}"/></td>
										<td><c:out value="${recommendCounts[board.bno]}"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div> <!-- table-responsive-md mt-2 -->
				</div> <!-- col-md-6 -->
			</div> <!-- row -->
			<div class="row">
				<div class="col-md-6">
					<a href="../board/list?gs_type=3">정보게시판</a>
					<div class="table-responsive-md mt-2">
						<table id="boardTable" class="table table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>제목</th>
									<th>조회수</th>
									<th>추천</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${board3}" var="board">
									<tr>
										<td>
											<a style="font-weight:bold;color: #000000;text-decoration: none;" href="/board/get?bno=${board.bno}">
												<c:out value="${board.title}"/>
												<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M123.6 391.3c12.9-9.4 29.6-11.8 44.6-6.4c26.5 9.6 56.2 15.1 87.8 15.1c124.7 0 208-80.5 208-160s-83.3-160-208-160S48 160.5 48 240c0 32 12.4 62.8 35.7 89.2c8.6 9.7 12.8 22.5 11.8 35.5c-1.4 18.1-5.7 34.7-11.3 49.4c17-7.9 31.1-16.7 39.4-22.7zM21.2 431.9c1.8-2.7 3.5-5.4 5.1-8.1c10-16.6 19.5-38.4 21.4-62.9C17.7 326.8 0 285.1 0 240C0 125.1 114.6 32 256 32s256 93.1 256 208s-114.6 208-256 208c-37.1 0-72.3-6.4-104.1-17.9c-11.9 8.7-31.3 20.6-54.3 30.6c-15.1 6.6-32.3 12.6-50.1 16.1c-.8 .2-1.6 .3-2.4 .5c-4.4 .8-8.7 1.5-13.2 1.9c-.2 0-.5 .1-.7 .1c-5.1 .5-10.2 .8-15.3 .8c-6.5 0-12.3-3.9-14.8-9.9c-2.5-6-1.1-12.8 3.4-17.4c4.1-4.2 7.8-8.7 11.3-13.5c1.7-2.3 3.3-4.6 4.8-6.9c.1-.2 .2-.3 .3-.5z"/></svg>
												<span class="position-absolute top-0 start-100 translate-middle badge rounded-circle bg-light">
													<c:out value="${board.replycnt}"/>
												</span>
											</a></td>
										<td><c:out value="${board.cnt}"/></td>
										<td><c:out value="${recommendCounts[board.bno]}"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div> <!-- table-responsive-md mt-2 -->
				</div> <!-- col-md-6 -->
				<div class="col-md-6">
					<a href="../board/list?gs_type=4">리뷰게시판</a>
					<div class="table-responsive-md mt-2">
						<table id="boardTable" class="table table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>제목</th>
									<th>조회수</th>
									<th>추천</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${board4}" var="board">
									<tr>
										<td>
											<a style="font-weight:bold;color: #000000;text-decoration: none;" href="/board/get?bno=${board.bno}">
												<c:out value="${board.title}"/>
												<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M123.6 391.3c12.9-9.4 29.6-11.8 44.6-6.4c26.5 9.6 56.2 15.1 87.8 15.1c124.7 0 208-80.5 208-160s-83.3-160-208-160S48 160.5 48 240c0 32 12.4 62.8 35.7 89.2c8.6 9.7 12.8 22.5 11.8 35.5c-1.4 18.1-5.7 34.7-11.3 49.4c17-7.9 31.1-16.7 39.4-22.7zM21.2 431.9c1.8-2.7 3.5-5.4 5.1-8.1c10-16.6 19.5-38.4 21.4-62.9C17.7 326.8 0 285.1 0 240C0 125.1 114.6 32 256 32s256 93.1 256 208s-114.6 208-256 208c-37.1 0-72.3-6.4-104.1-17.9c-11.9 8.7-31.3 20.6-54.3 30.6c-15.1 6.6-32.3 12.6-50.1 16.1c-.8 .2-1.6 .3-2.4 .5c-4.4 .8-8.7 1.5-13.2 1.9c-.2 0-.5 .1-.7 .1c-5.1 .5-10.2 .8-15.3 .8c-6.5 0-12.3-3.9-14.8-9.9c-2.5-6-1.1-12.8 3.4-17.4c4.1-4.2 7.8-8.7 11.3-13.5c1.7-2.3 3.3-4.6 4.8-6.9c.1-.2 .2-.3 .3-.5z"/></svg>
												<span class="position-absolute top-0 start-100 translate-middle badge rounded-circle bg-light">
													<c:out value="${board.replycnt}"/>
												</span>
											</a></td>
										<td><c:out value="${board.cnt}"/></td>
										<td><c:out value="${recommendCounts[board.bno]}"/></td>
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

</body>
</html>