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
			<h2 class="text-center mt-4 mb-4">게시판 관리</h2>
			<table class="table table-bordered">
				<thead style="background-color: black; color: white;">
					<tr>
						<th style="width: 7%">번호</th>
						<th style="width: 10%">분류</th>
						<th style="width: 43%">제목</th>
						<th style="width: 10%">작성자</th>
						<th style="width: 17%">작성일</th>
						<th style="width: 13%">삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${adminList}" var="board">
						<tr>
							<td><c:out value="${board.bno}"/></td>
							<!-- 나중에 다중게시판시 수정할 부분. -->
							<td>
								<c:out value="${board.categoryName}"/>
							</td>
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
			<!-- 검색 처리 -->
			<div class="row">
				<div class="col-lg-12">
					<form id='searchForm' action="adminList" method='get'>
					    <select name='type'>
					        <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>>----</option>
					        
					        <option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected':''}"/>>제목 or 내용 or 작성자</option>
					    </select>
					
					    <input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'/>
					    <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
					    <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>
						
						
					    <button id="search" class='btn btn-outline-primary btn-sm'>Search</button>
					    <button data-oper='clear' class="btn btn-outline-info btn-clear btn-sm" type="button">Clear</button>
					</form>

				</div>
			</div>
			<!-- 페이지 번호 클릭시 콘트롤라로 (public void list(Criteria cri, Model model)) 로 요청하는 form, 나중에 검색 데이터도 여기서 같이 처리  -->
			<form id='actionForm' action="adminList" method='get'>
				<input type='hidden' name='pageNum'	value='${pageMaker.cri.pageNum}'> 
				<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
				<!-- 검색처리 추가 -->
				<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'> 
				<input type='hidden' name='keyword'	value='<c:out value="${ pageMaker.cri.keyword }"/>'>
				<!-- gs_type -->
				
			</form>	
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
		actionForm.attr("action", "adminList");
		actionForm.submit(); //submit(),reset()은 form의 이벤트
	});
	
	//검색 처리
	let searchForm = $("#searchForm");
	
	$("#searchForm #search").on("click", function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색 종류를 선택하세요.");
			return false;
		}
		
		if(!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요");
			return false;
		}
		
		// 페이지 번호를 1로 설정하여 첫 페이지로 이동
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();
	});
	
	// clear 버튼 클릭 시 검색 폼 초기화 및 페이지 이동
    $("button[data-oper='clear']").on("click", function(e){
        e.preventDefault();

        // 검색 폼 초기화
        searchForm.find("select[name='type']").val(""); // 검색 종류 초기화
        searchForm.find("input[name='keyword']").val(""); // 키워드 초기화
        
		
     	// 페이지 번호를 1로 설정하여 첫 페이지로 이동
        searchForm.find("input[name='pageNum']").val("1");
        searchForm.submit();
    });
	
});
</script>

</body>
</html>