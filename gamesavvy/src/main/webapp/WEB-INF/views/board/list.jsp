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

.lightred {
    background-color: #FFAAAA; /* 연한 빨강색 배경 */
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
				<c:choose >
					<c:when test="${pageMaker.cri.gs_type == 1}">
						<h1 class="h3 mb-2 text-center">자유게시판</h1>
							<div> <!-- 등록 버튼 -->
								<button type="button" class="float-right mb-3" id="regBtn">게시물 등록</button>
							</div>
					</c:when>
					<c:when test="${pageMaker.cri.gs_type == 2}">
						<h1 class="h3 mb-2 text-center">공략게시판</h1>
							<div> <!-- 등록 버튼 -->
								<button type="button" class="float-right mb-3" id="regBtn">게시물 등록</button>
							</div>
					</c:when>
					<c:when test="${pageMaker.cri.gs_type == 3}">
						<h1 class="h3 mb-2 text-center">정보게시판</h1>
							<div> <!-- 등록 버튼 -->
								<button type="button" class="float-right mb-3" id="regBtn">게시물 등록</button>
							</div>
					</c:when>
					<c:when test="${pageMaker.cri.gs_type == 4}">
						<h1 class="h3 mb-2 text-center">리뷰게시판</h1>
							<div> <!-- 등록 버튼 -->
								<button type="button" class="float-right mb-3" id="regBtn">게시물 등록</button>
							</div>
					</c:when>
					<c:when test="${pageMaker.cri.gs_type == 5}">
						<h1 class="h3 mb-2 text-center">공지사항</h1>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
							<div> <!-- 등록 버튼 -->
								<button type="button" class="float-right mb-3" id="regBtn">게시물 등록</button>
							</div>
						</sec:authorize>
					</c:when>
				</c:choose>
				<button type="button" onclick="location.href='/board/list?gs_type=${cri.gs_type}&type=${cri.type}&keyword=${cri.keyword}&sort=bno'" class="btn btn-info">최신순</button>
				<button type="button" onclick="location.href='/board/list?gs_type=${cri.gs_type}&type=${cri.type}&keyword=${cri.keyword}&sort=cnt'" class="btn btn-info">조회순</button>
				<button type="button" onclick="location.href='/board/list?gs_type=${cri.gs_type}&type=${cri.type}&keyword=${cri.keyword}&sort=replyCnt'" class="btn btn-info">댓글순</button>
				<button type="button" onclick="location.href='/board/list?gs_type=${cri.gs_type}&type=${cri.type}&keyword=${cri.keyword}&sort=recommendCount'" class="btn btn-info">추천순</button>
				<div class="table-responsive-md mt-4">
					<table id="boardTable" class="table table-hover text-center">
						<thead class="table-dark">
							<tr>
								<th style="width: 7%" class="font-weight-normal">번호</th>
								<th style="width: 43%" class="font-weight-normal">제목</th>
								<th style="width: 10%" class="font-weight-normal">작성자</th>
								<th style="width: 16%" class="font-weight-normal">작성일</th>
								<th style="width: 7%" class="font-weight-normal">조회수</th>
								<th style="width: 7%" class="font-weight-normal">추천</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${notice}" var="notice">
								<tr class="lightred">
									<td class="bno"></td>
									<td>
										<a class='move' id="title_hover"style="font-weight:bold;color: #000000;text-decoration: none;" href='<c:out value="${notice.bno}"/>'>
											<strong>[공지]<c:out value="${notice.title}" /></strong>&nbsp;&nbsp;
											<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M123.6 391.3c12.9-9.4 29.6-11.8 44.6-6.4c26.5 9.6 56.2 15.1 87.8 15.1c124.7 0 208-80.5 208-160s-83.3-160-208-160S48 160.5 48 240c0 32 12.4 62.8 35.7 89.2c8.6 9.7 12.8 22.5 11.8 35.5c-1.4 18.1-5.7 34.7-11.3 49.4c17-7.9 31.1-16.7 39.4-22.7zM21.2 431.9c1.8-2.7 3.5-5.4 5.1-8.1c10-16.6 19.5-38.4 21.4-62.9C17.7 326.8 0 285.1 0 240C0 125.1 114.6 32 256 32s256 93.1 256 208s-114.6 208-256 208c-37.1 0-72.3-6.4-104.1-17.9c-11.9 8.7-31.3 20.6-54.3 30.6c-15.1 6.6-32.3 12.6-50.1 16.1c-.8 .2-1.6 .3-2.4 .5c-4.4 .8-8.7 1.5-13.2 1.9c-.2 0-.5 .1-.7 .1c-5.1 .5-10.2 .8-15.3 .8c-6.5 0-12.3-3.9-14.8-9.9c-2.5-6-1.1-12.8 3.4-17.4c4.1-4.2 7.8-8.7 11.3-13.5c1.7-2.3 3.3-4.6 4.8-6.9c.1-.2 .2-.3 .3-.5z"/></svg>
											<span class="position-absolute top-0 start-100 translate-middle badge rounded-circle bg-light">
												<c:out value="${notice.replycnt}"/>
											</span>
										</a>						
									</td>
									<td><c:out value="${notice.userid}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}" /></td>
									<td><c:out value="${notice.cnt }"/></td>
									<td><c:out value="${recommendCountsForNotices[notice.bno]}"/></td>
								</tr>
							</c:forEach>
							<c:forEach items="${list}" var="board">
								<tr>
									<td class="bno"><c:out value="${board.bno}" /></td>
									<td>
										<a class='move' id="title_hover"style="font-weight:bold;color: #000000;text-decoration: none;" href='<c:out value="${board.bno}"/>'>
											<c:out value="${board.title}" />&nbsp;&nbsp;
											<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M123.6 391.3c12.9-9.4 29.6-11.8 44.6-6.4c26.5 9.6 56.2 15.1 87.8 15.1c124.7 0 208-80.5 208-160s-83.3-160-208-160S48 160.5 48 240c0 32 12.4 62.8 35.7 89.2c8.6 9.7 12.8 22.5 11.8 35.5c-1.4 18.1-5.7 34.7-11.3 49.4c17-7.9 31.1-16.7 39.4-22.7zM21.2 431.9c1.8-2.7 3.5-5.4 5.1-8.1c10-16.6 19.5-38.4 21.4-62.9C17.7 326.8 0 285.1 0 240C0 125.1 114.6 32 256 32s256 93.1 256 208s-114.6 208-256 208c-37.1 0-72.3-6.4-104.1-17.9c-11.9 8.7-31.3 20.6-54.3 30.6c-15.1 6.6-32.3 12.6-50.1 16.1c-.8 .2-1.6 .3-2.4 .5c-4.4 .8-8.7 1.5-13.2 1.9c-.2 0-.5 .1-.7 .1c-5.1 .5-10.2 .8-15.3 .8c-6.5 0-12.3-3.9-14.8-9.9c-2.5-6-1.1-12.8 3.4-17.4c4.1-4.2 7.8-8.7 11.3-13.5c1.7-2.3 3.3-4.6 4.8-6.9c.1-.2 .2-.3 .3-.5z"/></svg>
											<span class="position-absolute top-0 start-100 translate-middle badge rounded-circle bg-light">
												<c:out value="${board.replycnt}"/>
											</span>
										</a>						
									</td>
									<!-- 프로필 이미지 표시 -->
									
									<td>
									    <div class="row" >
									    	<div class="col-md-9" id="user-profile" data-userid="<c:out value="${board.userid}" />"></div>
									    	<div class="col-md-3">
									    		<c:out value="${board.userid}" />
									   		</div>
									    </div>
									</td>
									
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" /></td>
									<td><c:out value="${board.cnt }"/></td>
									<td><c:out value="${recommendCounts[board.bno]}"/></td>
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
			
			<!-- 검색 처리 -->
			<div class="row">
				<div class="col-lg-12">
					<form id='searchForm' action="list" method='get'>
					    <select name='type'>
					        <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>>----</option>
					        <option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected':''}"/>>제목 or 내용 or 작성자</option>
					    </select>
					
					    <!-- gs_type 추가 -->
					    <select name='gs_type'>
					        <option value="1" <c:if test="${pageMaker.cri.gs_type == 1}">selected</c:if>>자유게시판</option>
					        <option value="2" <c:if test="${pageMaker.cri.gs_type == 2}">selected</c:if>>공략게시판</option>
					        <option value="3" <c:if test="${pageMaker.cri.gs_type == 3}">selected</c:if>>정보게시판</option>
					        <option value="4" <c:if test="${pageMaker.cri.gs_type == 4}">selected</c:if>>리뷰게시판</option>
					    </select>
					
					    <input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'/>
					    <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
					    <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>
					    <input type='hidden' name='gs_type' value='<c:out value="${pageMaker.cri.gs_type }"/>'>
					
					    <button id="search" class='btn btn-outline-primary btn-sm'>Search</button>
					    <button data-oper='clear' class="btn btn-outline-info btn-clear btn-sm" type="button">Clear</button>
					</form>

				</div>
			</div>
			
			
			<!-- 페이지 번호 클릭시 콘트롤라로 (public void list(Criteria cri, Model model)) 로 요청하는 form, 나중에 검색 데이터도 여기서 같이 처리  -->
			<form id='actionForm' action="list" method='get'>
				<input type='hidden' name='pageNum'	value='${pageMaker.cri.pageNum}'> 
				<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
				<!-- 검색처리 추가 -->
				<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'> 
				<input type='hidden' name='keyword'	value='<c:out value="${ pageMaker.cri.keyword }"/>'>
				<!-- gs_type -->
				<input type='hidden' name='gs_type' value='<c:out value="${pageMaker.cri.gs_type }"/>'>
			</form>
			
			<!-- 모달 (게시글 등록 완료시) -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="myModalLabel">GameSavvy</h4>
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						</div>
						<div class="modal-body">처리가 완료되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
			
		</div> <!-- col-md-8 -->
		
		<%@include file="../include/right.jsp" %>
		
	</div> <!-- row -->
</div> <!-- maincontent -->
<%@include file="../include/footer.jsp" %>

<script>
(function(){
    let userIdElements = document.querySelectorAll("#user-profile"); // 모든 게시글의 작성자 아이디 요소 선택

    userIdElements.forEach(function(element) {
        let userid = element.getAttribute("data-userid"); // 작성자 아이디 가져오기

        $.getJSON("getProfileImages",{userid: userid}, function(arr) {
            let str = "";
            let hasImage = false; // 이미지 여부를 확인하는 변수
            
            $(arr).each(function(i, obj){
                if(obj.fileType === true) {
                    let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName); // 섬네일

                    let originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName; // 원본파일 경로
                    originPath = originPath.replace(new RegExp(/\\/g), "/"); // \\를 /로 대체
					                   
                    str += "<div class='rounded-circle' style='overflow: hidden; width: 25px; height: 25px;'>";
                    str += "<img src='../upload/displayimg?fileName="+fileCallPath+"' style='object-fit:cover; width: 100%; height: 100%;'>";
                    str += "</div>";
          
                    hasImage = true; // 이미지가 하나 이상 있는 경우 true로 설정
                }
            });

            // 이미지가 없을 경우 기본 이미지를 표시하는 코드 추가
            if (!hasImage) {
                str += "<div class='rounded-circle' style='overflow: hidden; width: 25px; height: 25px;'>";
                str += "<img src='../resources/images/default-image.png' style='object-fit:cover; width: 100%; height: 100%;'>";
                str += "</div>";
            }

            // 작성자 아이디 요소 다음에 프로필 이미지 요소 추가
            $(element).after(str);
        });
    });
})();


</script>



<script>
$(document).ready(function(){
	
	//EL의 result는 RedirectAttributes의 rttr.addFlashAttribute("result", board.getBno());로 전달된 값
	let result = '<c:out value="${result}"></c:out>';
	
	console.log("result : " + result);
	checkModal(result);
	
	history.replaceState({}, null, null);
	//현재의 히스토리를 전부 비워 줍니다.
	//뒤로가기 방지
	
	$("#regBtn").on("click", function(){
		self.location = "register";
	});
	
	//모달창
	function checkModal(result) {
		
		if (result === '') {
			return;
		}
		if(parseInt(result) > 0) {
			$(".modal-body").html("게시글" + parseInt(result) + "번이 등록되었습니다.");
		}
		
		$("#myModal").modal("show");
	}
	
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
		actionForm.attr("action", "list");
		actionForm.submit(); //submit(),reset()은 form의 이벤트
	});
	
	//게시글 제목 클릭시 이동
	$('.move').on("click",function(e){
		e.preventDefault(); //a의 원래 기능을 취소
		console.log('게시글 번호 클릭');
		console.log('page 번호 클릭');
		actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");  //게시물번호 bno를 actionForm에 추가
		actionForm.attr("action", "get"); //콘트롤라 get으로 요청
		actionForm.submit();
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
        searchForm.find("input[name='gs_type']").val(""); //gs_type 초기화
		
     	// 페이지 번호를 1로 설정하여 첫 페이지로 이동
        searchForm.find("input[name='pageNum']").val("1");
        searchForm.submit();
    });
	
});
</script>

</body>
</html>