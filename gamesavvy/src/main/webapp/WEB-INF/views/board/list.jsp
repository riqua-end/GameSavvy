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

<style>
#regBtn {
    background: #444;
    border: 1px solid #303030;
    color: #fff;
    padding: 0 20px;
}
</style>

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
			<div id="submain">
				<h2 class="text-center">자유게시판</h2>
				<div> <!-- 등록 버튼 -->
					<button type="button" class="float-right mb-3" id="regBtn">게시물 등록</button>
				</div>
				<div class="table-responsive-md mt-4">
					<table id="boardTable" class="table table-hover text-center">
						<thead>
							<tr>
								<th style="width: 10%" class="font-weight-normal">번호</th>
								<th style="width: 45%" class="font-weight-normal">제목</th>
								<th style="width: 15%" class="font-weight-normal">작성자</th>
								<th style="width: 15%" class="font-weight-normal">작성일</th>
								<th style="width: 15%" class="font-weight-normal">수정일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="board">
								<tr>
									<td class="bno"><c:out value="${board.bno}" /></td>
									<td>
										<a class='move' href='<c:out value="${board.bno}"/>'>
											<c:out value="${board.title}" />
										</a>						
									</td>
									<td><c:out value="${board.userid}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updatedate}" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div> <!-- table-responsive-md -->
			</div> <!-- submain -->
			
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
			<form id='actionForm' action="list" method='get'>
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
$(document).ready(function(){
	
	//EL의 result는 RedirectAttributes의 rttr.addFlashAttribute("result", board.getBno());로 전달된 값
	let result = '<c:out value="${result}"></c:out>';
	
	console.log("result : " + result);
	
	history.replaceState({}, null, null);
	//현재의 히스토리를 전부 비워 줍니다.
	//뒤로가기 방지
	
	$("#regBtn").on("click", function(){
		self.location = "register";
	});
	
	//페이지 처리
	let actionForm = $("#actionForm");	
	
	$(".page-item a").on("click",function(e){		
		e.preventDefault(); //a의 원래 기능을 취소
		console.log('page 번호 클릭');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		//find(selector)메서드는 자식 엘리먼트에서 selector에 해당하는 엘리먼트를 선택 
		//pageNum이 neme인 input의 value에 클릭한 a의 href값(페이지 번호)을 넣어줌
		//this는 이벤트가 일어난 객체이므로 <a>가 됨
		actionForm.attr("action", "list");
		actionForm.submit(); //submit(),reset()은 form의 이벤트
	});
	
	$(".move").on("click",function(e){
		e.preventDefault(); //a의 원래 기능을 취소
		console.log('page 번호 클릭');
		actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");  //게시물번호 bno를 actionForm에 추가
		actionForm.attr("action", "get"); //콘트롤라 get으로 요청
		actionForm.submit();
	});
	
});
</script>

</body>
</html>