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
			<h2 class="text-center">회원관리</h2>
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
    		<!-- 페이지 표시 영역 -->
			<ul class="pagination justify-content-center" style="margin: 20px 0">
				<c:if test="${pageMaker.prev}">
					<li class="page-item">
						<a class="page-link" href="${pageMaker.startPage - 1}">Prev</a> <!-- 앞페이지 마지막 -->
					</li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage}"	end="${pageMaker.endPage}">
					<li	class="page-item ${pageMaker.cri.pageNum == num ? 'active':''}">
						<a class="page-link" href="${num}">${num}</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<li class="page-item">
						<a class="page-link" href="${pageMaker.endPage + 1}">Next</a> <!-- 다음페이지 처음 페이지 표시 -->
					</li>
				</c:if>		
			</ul>	
			<!-- 페이지 번호 클릭시 콘트롤라로 (public void list(Criteria cri, Model model)) 로 요청하는 form, 나중에 검색 데이터도 여기서 같이 처리  -->
			<form id='actionForm' action="adminlist" method='get'>
				<input type='hidden' name='pageNum'	value='${pageMaker.cri.pageNum}'> 
				<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
				<!-- 검색처리 추가 -->
			</form>	
		</div> <!-- col-md-8 -->
		
		<%@include file="../include/right.jsp" %>
		
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

<script>
$(document).ready(function(){
	
	//페이지 처리
	let actionForm = $("#actionForm");	
	
	$(".page-item a").on("click",function(e){		
		e.preventDefault(); //a의 원래 기능을 취소
		console.log('page 번호 클릭');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		//find(selector)메서드는 자식 엘리먼트에서 selector에 해당하는 엘리먼트를 선택 
		//pageNum이 neme인 input의 value에 클릭한 a의 href값(페이지 번호)을 넣어줌
		//this는 이벤트가 일어난 객체이므로 <a>가 됨
		actionForm.attr("action", "adminMember");
		actionForm.submit(); //submit(),reset()은 form의 이벤트
	});
	
});
</script>

</body>
</html>