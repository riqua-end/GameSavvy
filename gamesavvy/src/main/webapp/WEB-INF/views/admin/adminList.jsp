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
			<h2 class="text-center">게시판 관리</h2>
			<table class="table table-bordered">
				<thead style="background-color: black; color: white;">
					<tr>
						<td>번호</td>
						<td>분류</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성일</td>
						<td>삭제</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${adminList}" var="board">
						<tr>
							<td><c:out value="${board.bno}"/></td>
							<!-- 나중에 다중게시판시 수정할 부분. -->
							<td>분류</td>
							<td><c:out value="${board.title}"/></td>
							<td><c:out value="${board.userid}"/></td>
							<td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
							<td>
								<a class="btn btn-danger" href="#" onclick="showConfirmDialog('${board.bno}')">삭제</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>			
		</div> <!-- col-md-9 -->
		
		<%@include file="../include/right.jsp" %>
		
	</div> <!-- row -->
</div> <!-- maincontent -->
<%@include file="../include/footer.jsp" %>

<script>
function showConfirmDialog(bno) {
    if (confirm('삭제된 데이터는 복구할 수 없습니다. 정말로 ' + bno + ' 번 게시판을 삭제하시겠습니까?')) {
        window.location.href = '<c:url value="/admin/deleteList/' + bno + '" />';
    }
}
</script>

</body>
</html>