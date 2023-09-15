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
			<h2 class="text-center">게시글 수정</h2>
			<form  id="mform" name="mform" action="modify" method="post">
				<!-- 시큐리티 관련 정보 추가 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<!-- 페이지 관련 정보 추가 -->
				<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
       			<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
       			<!-- 검색 적용 -->
       			<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
				<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>	
				
				<div class="form-group">
					<label for="bno">번호:</label>
					<input type="text" class="form-control" id="bno" name="bno" readonly value='<c:out value="${board.bno }"/>' />		
				</div>
				<div class="form-group">
					<label for="title">제목:</label>
					<input type="text" class="form-control" id="title" name="title" value='<c:out value="${board.title }"/>'/>		
				</div>
				<div class="form-group">
					<label for="content">내용:</label>
<textarea class="form-control" id="content" name="content" rows="10" >
<c:out value="${board.content}" />
</textarea>		
				</div>
				<div class="form-group">
					<label for="userid">작성자:</label>
					<input type="text" class="form-control" id="userid" name="userid" readonly value='<c:out value="${board.userid}"/>'/>		
				</div>
				<div class="form-group">
					<label for="regdate">게시일:</label>
					<input type="text" class="form-control" id="regdate" name="regdate" 
						value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regdate}" />'  readonly/>		
				</div>
				<div class="form-group">
					<label for="updatedate">수정일:</label>
					<input type="text" class="form-control" id="updatedate" name="updatedate" 
						value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.updatedate}" />'  readonly/>		
				</div>
 				<!-- 시큐리티 적용 -->
 				<sec:authentication property="principal" var="pinfo"/>
 				<sec:authorize access="isAuthenticated()">
 					<c:if test="${pinfo.username eq board.userid}">
 						<button type="submit" data-oper='modify' class="btn btn-info">수정</button>&nbsp;&nbsp;
 						<button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>&nbsp;&nbsp;
 					</c:if>
 				</sec:authorize>
				<button type="submit" data-oper='list' class="btn btn-success">목록</button>
			</form>
		</div> <!-- col-md-9 -->
		
		<%@include file="../include/right.jsp" %>
		
	</div> <!-- row -->
</div> <!-- maincontent -->
<%@include file="../include/footer.jsp" %>

<script>
$(function(){ //$(document).ready(function(){});의 단축형
	let formObj = $("#mform");
	$("button").on("click",function(e){
		e.preventDefault(); //이벤트가 일어난 버튼의 기본 동작을 제거
		let operation = $(this).data("oper"); //data-xxx속성의 xxx가 oper인것의 속성값을 반환(modify,remove,list 중 선택)
		console.log("operation : "  + operation);
		if(operation == "remove") {
			formObj.attr("action","remove");
		}		
		else if(operation == "list") {
			/* 페이지 처리 미고려
			formObj.attr("action", "list").attr("method","get");
			formObj.empty(); //formObj의 자식 엘리먼트를 모두 제거(4개포함 게시판 컬럼)
			*/
			//페이지 처리 고려
			formObj.attr("action", "list").attr("method","get");
			//페이지 정보
			let pageNumTag = $("input[name='pageNum']").clone() //복사해둠 clone()없어도 무방
		    let amountTag = $("input[name='amount']").clone();
			//검색처리
			let keywordTag = $("input[name='keyword']").clone();
		    let typeTag = $("input[name='type']").clone();
			
		    formObj.empty(); //formObj의 자식 엘리먼트를 모두 제거(4개포함 게시판 컬럼)
		    
		    formObj.append(pageNumTag); //자식으로 붙여쓰기
		    formObj.append(amountTag);
		    formObj.append(keywordTag);
		    formObj.append(typeTag);
		}
		// 첨부파일 미고려
		else if(operation == 'modify') {
			formObj.attr("action","modify");
		}
		
		formObj.submit();
	});
	
});
</script>

</body>
</html>