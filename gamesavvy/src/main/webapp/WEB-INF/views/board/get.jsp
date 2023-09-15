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
</head>
<body>

<%@include file="../include/header.jsp" %>
<div class="container mt-4 mb-4" id="maincontent">
	<div class="row">
		
		<div class="col-md-9">
			<h2 class="text-center">게시글 내용</h2>
			<form>
				<div class="form-group">
					<label for="bno">번호:</label> 
					<input type="text"
						class="form-control" id="bno" name="bno" readonly
						value='<c:out value="${board.bno }"/>' />
				</div>
				<div class="form-group">
					<label for="title">제목:</label> 
					<input type="text"
						class="form-control" id="title" name="title" readonly
						value='<c:out value="${board.title }"/>' />
				</div>
				<div class="form-group">
					<label for="content">내용:</label>
<textarea class="form-control" id="content" name="content"	rows="10" readonly>
<c:out value="${board.content}" />
</textarea>
				</div>
				<div class="form-group">
					<label for="userid">작성자:</label> 
					<input type="text"
						class="form-control" id="userid" name="userid" readonly
						value='<c:out value="${board.userid }"/>' />
				</div>
			</form>
			<!-- 시큐리티적용 로그인아이디와 게시글 작성기 동일시만 버튼 보임 -->
			<sec:authentication property="principal" var="pinfo" />
			  <!-- EL안에서는 pinfo사용 -->
			<sec:authorize access="isAuthenticated()">
				<c:if test="${pinfo.username eq board.userid}">
			  		<button data-oper='modify' class="btn btn-info">Modify</button>
			  	</c:if>
			</sec:authorize>
				<button data-oper='list' class="btn btn-danger">게시판목록</button> 
			<!-- 버튼 클릭을 처리하기 위한 form,안보이는 창(나중 페이지 정보 댓글 정보 등을 같이 처리 -->
			<form id='operForm' action="modify" method="get">
			  	<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
			  	<!-- 페이지 정보를 추가 -->	
				<input	type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'> 
				<input	type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
				<!-- 검색처리 추가 -->
				<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
				<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
			</form>
		</div> <!-- col-md-9 -->
		
		<%@include file="../include/right.jsp" %>
		
	</div> <!-- row -->
</div> <!-- maincontent -->
<%@include file="../include/footer.jsp" %>

<script>
$(document).ready(function(){	
	//게시글 조회 버튼 처리 
	//modify,list 처리 버튼 
	
	let operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action", "modify").submit();
	});
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#bno").remove();
		//id가 bno인 DOM을 찾아서 제거
		operForm.attr("action", "list");
		operForm.submit();
	});
});
</script>

</body>
</html>