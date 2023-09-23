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

.boxbox {
    width: 100%;
    padding: 25px 25px;
    margin-bottom: -20px;
    background-color: rgb(247, 247, 247);
}
.boxUserProfile {
    min-width: 48px;
    height: 100px;
    display: flex;
    -webkit-box-pack: center;
    justify-content: center;
    -webkit-box-align: center;
    align-items: center;
    padding: 0px 5px;
    border-radius: 100%;
    font-weight: normal;
    font-size: 14px;
    text-align: center;
    border: 1px solid rgb(148, 146, 150);
    background-color: rgb(255, 255, 255);
    color: rgb(148, 146, 150);
}
.userUser {
    margin: 0 0 10px 0;
    color: #969696;
    font-size: 12px;
    font-family: "Noto Sans",sans-serif;
    font-weight: 300;
}
.strongUser {
    color: black; /* 텍스트 색상을 검정으로 설정 */
    font-weight: bold; /* 글꼴을 굵게 설정 */
}
.btnBtn {
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
			<h2 class="text-center">회원정보</h2>
			<div class="boxbox">
				<div class="row">
					<div class="col-md-2">
						<div class="boxUserProfile">
							<img src="../resources/images/logo.png" alt="logo" class="Logo-img" style="width: 120px;">
						</div>
					</div> <!-- col-md-6 -->
					<div class="col-md-4">
						<p class="userUser">
							<strong class="strongUser"><sec:authentication property="principal.member.username"/></strong>
						님 어서오세요.</p>
						<a class="btnBtn" href="../member/modify">회원정보수정</a>
					</div> <!-- col-md-6 -->
					<div class="col-md-3">
						<strong>내가 작성한 게시글 수</strong>
						<br></br>
						<h3>${total}</h3>
					</div> <!-- col-md-6 -->
					<div class="col-md-3">
						<strong>내가 작성한 댓글 수</strong>
						<br></br>
						<h3>${replyTotal}</h3>
					</div> <!-- col-md-6 -->
				</div> <!-- row -->
			</div> <!-- boxbox -->
			<div class="row">
				<div class="col-md-6">
					<br></br>
					<strong>작성한 게시글 목록</strong>
					<div class="table-responsive-md mt-2">
						<table id="boardTable" class="table table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>분류</th>
									<th>제목</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${custom}" var="board">
									<tr>
										<td><c:out value="${board.categoryName}"/></td>
										<td>
											<a style="font-weight:bold;color: #000000;text-decoration: none;" href="/board/get?bno=${board.bno}">
												<c:out value="${board.title}"/>
												<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M123.6 391.3c12.9-9.4 29.6-11.8 44.6-6.4c26.5 9.6 56.2 15.1 87.8 15.1c124.7 0 208-80.5 208-160s-83.3-160-208-160S48 160.5 48 240c0 32 12.4 62.8 35.7 89.2c8.6 9.7 12.8 22.5 11.8 35.5c-1.4 18.1-5.7 34.7-11.3 49.4c17-7.9 31.1-16.7 39.4-22.7zM21.2 431.9c1.8-2.7 3.5-5.4 5.1-8.1c10-16.6 19.5-38.4 21.4-62.9C17.7 326.8 0 285.1 0 240C0 125.1 114.6 32 256 32s256 93.1 256 208s-114.6 208-256 208c-37.1 0-72.3-6.4-104.1-17.9c-11.9 8.7-31.3 20.6-54.3 30.6c-15.1 6.6-32.3 12.6-50.1 16.1c-.8 .2-1.6 .3-2.4 .5c-4.4 .8-8.7 1.5-13.2 1.9c-.2 0-.5 .1-.7 .1c-5.1 .5-10.2 .8-15.3 .8c-6.5 0-12.3-3.9-14.8-9.9c-2.5-6-1.1-12.8 3.4-17.4c4.1-4.2 7.8-8.7 11.3-13.5c1.7-2.3 3.3-4.6 4.8-6.9c.1-.2 .2-.3 .3-.5z"/></svg>
												<span class="position-absolute top-0 start-100 translate-middle badge rounded-circle bg-light">
													<c:out value="${board.replycnt}"/>
												</span>
											</a>
										</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
										<td><c:out value="${board.cnt}"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
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
					<form id='actionForm' action="custom" method='get'>
						<input type='hidden' name='pageNum'	value='${pageMaker.cri.pageNum}'> 
						<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					</form>
				</div> <!-- col-md-6 -->
			</div> <!-- row -->
		</div> <!-- col-md-9 -->
		<%@include file="../include/right.jsp" %>
	</div> <!-- row -->
</div> <!-- maincontent -->
<%@include file="../include/footer.jsp" %>

<script>
$(document).ready(function(){
	
	//페이지 처리
	let actionForm = $("#actionForm");	
	
	//페이지 번호를 클릭시 이동
	$(".page-item a").on("click",function(e){		
		e.preventDefault(); //a의 원래 기능을 취소
		console.log('page 번호 클릭');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		//find(selector)메서드는 자식 엘리먼트에서 selector에 해당하는 엘리먼트를 선택 
		//pageNum이 neme인 input의 value에 클릭한 a의 href값(페이지 번호)을 넣어줌
		//this는 이벤트가 일어난 객체이므로 <a>가 됨
		actionForm.attr("action", "custom");
		actionForm.submit(); //submit(),reset()은 form의 이벤트
	});
	
});
</script>

</body>
</html>