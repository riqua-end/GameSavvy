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
		
		<%@include file="../include/left.jsp" %>
		
		<div class="col-md-8">
			<h2 class="text-center">Admin Member</h2>
			<table class="table table-bordered">
        		<thead style="background-color: black; color: white;">
          			<tr>
                		<th>회원 아이디</th>
                		<th>회원 이름</th>
                		<th>가입일</th>
                		<th>탈퇴 여부</th>
                		<th>강제 탈퇴</th>
            		</tr>
        		</thead>
       			<tbody>
            		<c:forEach items="${admin}" var="member">
                		<tr>
                    		<td>${member.userid}</td>
                    		<td>${member.username}</td>
                    		<td><fmt:formatDate value="${member.regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    		<td>${member.enabled ? '활성' : '탈퇴'}</td>
                    		<td>
                        		<a class="btn btn-danger" href="#" onclick="showConfirmDialog('${member.userid}')">강제 탈퇴</a>
                    		</td>
                		</tr>
            		</c:forEach>
        		</tbody>
    		</table>
		</div> <!-- col-md-8 -->
		
		<%@include file="../include/right.jsp" %>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<%@include file="../include/adminMenu.jsp" %>
		</sec:authorize>
		
	</div> <!-- row -->
</div> <!-- maincontent -->
<%@include file="../include/footer.jsp" %>

<script>
function showConfirmDialog(userid) {
    if (confirm('삭제된 데이터는 복구할 수 없습니다. 정말로 ' + userid + ' 회원을 강제 탈퇴하시겠습니까?')) {
        window.location.href = '<c:url value="/admin/delete/' + userid + '" />';
    }
}
</script>

</body>
</html>