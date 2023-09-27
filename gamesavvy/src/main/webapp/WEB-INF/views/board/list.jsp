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
					<c:when test="${pageMaker.cri.gs_type == 6}">
						<h1 class="h3 mb-2 text-center">추천게시판</h1>
							<div> <!-- 등록 버튼 -->
								<button type="button" class="float-right mb-3" id="regBtn">게시물 등록</button>
							</div>
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
								<th style="width: 93%" class="font-weight-normal">제목</th>
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
										<small><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}" /></small>
										<c:out value="${notice.cnt }"/>
										<c:out value="${recommendCountsForNotices[notice.bno]}"/>
									</td>
								</tr>
							</c:forEach>
							<c:forEach items="${list}" var="board">
								<tr>
									<td class="bno">
										<div  style="margin-top: 30px;">
											<c:out value="${board.bno}" />
										</div>
									</td>
									<td><!-- 게시판 이미지. -->
										<div class="row">
										<div class="col-md-1">
										<div id="bno" data-bno="<c:out value="${board.bno}"/>"></div>&nbsp;&nbsp;
										</div>
										<div class="col-md-10">
										<div style="text-align: left; font-size: 18px">&nbsp;&nbsp;
										<a class='move' id="title_hover" style="font-weight:bold;color: #000000;text-decoration: none;" href='<c:out value="${board.bno}"/>'>
											<c:out value="${board.title}" />&nbsp;&nbsp;
											<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M123.6 391.3c12.9-9.4 29.6-11.8 44.6-6.4c26.5 9.6 56.2 15.1 87.8 15.1c124.7 0 208-80.5 208-160s-83.3-160-208-160S48 160.5 48 240c0 32 12.4 62.8 35.7 89.2c8.6 9.7 12.8 22.5 11.8 35.5c-1.4 18.1-5.7 34.7-11.3 49.4c17-7.9 31.1-16.7 39.4-22.7zM21.2 431.9c1.8-2.7 3.5-5.4 5.1-8.1c10-16.6 19.5-38.4 21.4-62.9C17.7 326.8 0 285.1 0 240C0 125.1 114.6 32 256 32s256 93.1 256 208s-114.6 208-256 208c-37.1 0-72.3-6.4-104.1-17.9c-11.9 8.7-31.3 20.6-54.3 30.6c-15.1 6.6-32.3 12.6-50.1 16.1c-.8 .2-1.6 .3-2.4 .5c-4.4 .8-8.7 1.5-13.2 1.9c-.2 0-.5 .1-.7 .1c-5.1 .5-10.2 .8-15.3 .8c-6.5 0-12.3-3.9-14.8-9.9c-2.5-6-1.1-12.8 3.4-17.4c4.1-4.2 7.8-8.7 11.3-13.5c1.7-2.3 3.3-4.6 4.8-6.9c.1-.2 .2-.3 .3-.5z"/></svg>
											<span class="position-absolute top-0 start-100 translate-middle badge rounded-circle bg-light">
												<c:out value="${board.replycnt}"/>
											</span>
										</a>
										</div>
										<div class="row">
									    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									    	<div id="user-profile" style="margin-top: 20px; margin-bottom: 20px;" data-userid="<c:out value="${board.userid}" />"></div>
									    		&nbsp;<c:out value="${board.userid}" />
									    	</div>
									    	<!-- 게시글 작성일 엘리먼트에 시간 정보를 표시 HH:mm:ss 추가 -->
									    	<div style="text-align: left;" >&nbsp;&nbsp;&nbsp;
									    	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock-history" viewBox="0 0 16 16">
												<path d="M8.515 1.019A7 7 0 0 0 8 1V0a8 8 0 0 1 .589.022l-.074.997zm2.004.45a7.003 7.003 0 0 0-.985-.299l.219-.976c.383.086.76.2 1.126.342l-.36.933zm1.37.71a7.01 7.01 0 0 0-.439-.27l.493-.87a8.025 8.025 0 0 1 .979.654l-.615.789a6.996 6.996 0 0 0-.418-.302zm1.834 1.79a6.99 6.99 0 0 0-.653-.796l.724-.69c.27.285.52.59.747.91l-.818.576zm.744 1.352a7.08 7.08 0 0 0-.214-.468l.893-.45a7.976 7.976 0 0 1 .45 1.088l-.95.313a7.023 7.023 0 0 0-.179-.483zm.53 2.507a6.991 6.991 0 0 0-.1-1.025l.985-.17c.067.386.106.778.116 1.17l-1 .025zm-.131 1.538c.033-.17.06-.339.081-.51l.993.123a7.957 7.957 0 0 1-.23 1.155l-.964-.267c.046-.165.086-.332.12-.501zm-.952 2.379c.184-.29.346-.594.486-.908l.914.405c-.16.36-.345.706-.555 1.038l-.845-.535zm-.964 1.205c.122-.122.239-.248.35-.378l.758.653a8.073 8.073 0 0 1-.401.432l-.707-.707z"/>
												<path d="M8 1a7 7 0 1 0 4.95 11.95l.707.707A8.001 8.001 0 1 1 8 0v1z"/>
												<path d="M7.5 3a.5.5 0 0 1 .5.5v5.21l3.248 1.856a.5.5 0 0 1-.496.868l-3.5-2A.5.5 0 0 1 7 9V3.5a.5.5 0 0 1 .5-.5z"/>
											</svg>
											<small class='date-cell' style="margin-left: 1px;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate}" /></small>
											&nbsp;
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
												<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
												<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
											</svg>
											<c:out value="${board.cnt }"/>
											&nbsp;&nbsp;
											<i class="fas fa-thumbs-up"></i>&nbsp;&nbsp;<c:out value="${recommendCounts[board.bno]}"/>
											</div>
										</div>
										</div>
									</td>
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
					        <option value="6" <c:if test="${pageMaker.cri.gs_type == 6}">selected</c:if>>추천게시판</option>
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
    // 게시글 작성일을 상대적인 시간으로 포맷하는 함수
    function formatDateToRelativeTime(date) {
        // 현재 시간을 가져옴
        let now = new Date();
        // 게시글 작성일을 JavaScript Date 객체로 변환
        let postDate = new Date(date);
        // 현재 시간과 게시글 작성일의 차이를 밀리초 단위로 계산
        let timeDiff = now.getTime() - postDate.getTime();
        // 차이를 초 단위로 계산
        let seconds = Math.floor(timeDiff / 1000);

        // 게시된 지 60초 이내라면 "방금"을 반환
        if (seconds < 60) {
            return "방금";
        }
        // 게시된 지 1시간 이내라면 분 단위로 표시
        else if (seconds < 3600) {
        	let minutes = Math.floor(seconds / 60);
            return minutes + "분 전";
        }
        // 게시된 지 24시간 이내라면 시간 단위로 표시
        else if (seconds < 86400) {
        	let hours = Math.floor(seconds / 3600);
            return hours + "시간 전";
        }
        // 24시간이 지나면 "어제"를 반환
        else {
        	let days = Math.floor(seconds / 86400);
            if (days === 1) {
                return "어제";
            } else {
                // 년, 월, 일을 가져와서 "년-월-일" 형식으로 반환
                let year = postDate.getFullYear();
                let month = String(postDate.getMonth() + 1).padStart(2, '0');
                let day = String(postDate.getDate()).padStart(2, '0');
                return year + '-' + month + '-' + day;
            }
        }
    }

    // 모든 작성일 엘리먼트에 대해 작성일을 변환하여 설정
    let dateElements = document.querySelectorAll(".date-cell");
    dateElements.forEach((element) => {
        // 엘리먼트에서 작성일을 가져옵니다.
        let originalDate = element.textContent.trim();
        // 작성일을 상대적인 시간으로 변환합니다.
        let formattedDate = formatDateToRelativeTime(originalDate);
        // 엘리먼트의 텍스트 내용을 변환된 작성일로 설정합니다.
        element.textContent = formattedDate;
    });
</script>

<script>
//프로필 이미지 부분.
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
// 게시물 이미지 추출.
(function(){
    let bnoElements = document.querySelectorAll("#bno"); // 모든 게시글의 작성자 아이디 요소 선택

    bnoElements.forEach(function(element) {
        let bno = element.getAttribute("data-bno"); // 작성자 아이디 가져오기

        $.getJSON("getAttachList", { bno: bno }, function(arr) {
            let str = "";
            let hasImage = false; // 이미지 여부를 확인하는 변수
            
            $(arr).each(function(i, obj){
                if(obj.fileType === true) {
                    let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName); // 섬네일
                    let originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName; // 원본파일 경로
                    originPath = originPath.replace(new RegExp(/\\/g), "/"); // \\를 /로 대체
					                   
                    str += "<div style='overflow: hidden; width: 70px; height: 70px;'>";
                    str += "<img src='../upload/displayimg?fileName="+fileCallPath+"' style='object-fit:cover; width: 100%; height: 100%;'>";
                    str += "</div>";
          
                    hasImage = true; // 이미지가 하나 이상 있는 경우 true로 설정
                }
            });
            // 이미지가 없을 경우 기본 이미지를 표시하는 코드 추가
            if (!hasImage) {
                str += "<div style='overflow: hidden; width: 70px; height: 70px;'>";
                str += "<img src='../resources/images/default-board.PNG' style='object-fit:cover; width: 100%; height: 100%;'>";
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