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
			<h1 class="h3 mb-2 text-center">쪽지함</h1>
			<div class="table-responsive-md mt-4">
				<table id="boardTable" class="table table-hover text-center">
					<thead class="table-dark">
						<tr>
							<th style="width: 7%" class="font-weight-normal">비고</th>
							<th style="width: 93%" class="font-weight-normal">제목</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${NoteList}" var="note">
							<tr>
								<td></td>
								<td>
									<div class="row">
										<div class="col-md-3">
											<div id="user-profile" style="margin-top: 20px; margin-bottom: 20px;" data-userid="<c:out value="${note.userid}" />"></div>
									    		&nbsp;<c:out value="${note.userid}" />
										</div>
										<div class="col-md-6">
											<a class='move' id="title_hover" style="font-weight:bold;color: #000000;text-decoration: none;" href='<c:out value="${note.rno}"/>'>
												<c:out value="${note.title}" />
											</a>
										</div>
										<div class="col-md-3">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock-history" viewBox="0 0 16 16">
												<path d="M8.515 1.019A7 7 0 0 0 8 1V0a8 8 0 0 1 .589.022l-.074.997zm2.004.45a7.003 7.003 0 0 0-.985-.299l.219-.976c.383.086.76.2 1.126.342l-.36.933zm1.37.71a7.01 7.01 0 0 0-.439-.27l.493-.87a8.025 8.025 0 0 1 .979.654l-.615.789a6.996 6.996 0 0 0-.418-.302zm1.834 1.79a6.99 6.99 0 0 0-.653-.796l.724-.69c.27.285.52.59.747.91l-.818.576zm.744 1.352a7.08 7.08 0 0 0-.214-.468l.893-.45a7.976 7.976 0 0 1 .45 1.088l-.95.313a7.023 7.023 0 0 0-.179-.483zm.53 2.507a6.991 6.991 0 0 0-.1-1.025l.985-.17c.067.386.106.778.116 1.17l-1 .025zm-.131 1.538c.033-.17.06-.339.081-.51l.993.123a7.957 7.957 0 0 1-.23 1.155l-.964-.267c.046-.165.086-.332.12-.501zm-.952 2.379c.184-.29.346-.594.486-.908l.914.405c-.16.36-.345.706-.555 1.038l-.845-.535zm-.964 1.205c.122-.122.239-.248.35-.378l.758.653a8.073 8.073 0 0 1-.401.432l-.707-.707z"/>
												<path d="M8 1a7 7 0 1 0 4.95 11.95l.707.707A8.001 8.001 0 1 1 8 0v1z"/>
												<path d="M7.5 3a.5.5 0 0 1 .5.5v5.21l3.248 1.856a.5.5 0 0 1-.496.868l-3.5-2A.5.5 0 0 1 7 9V3.5a.5.5 0 0 1 .5-.5z"/>
											</svg>
											<small class='date-cell' style="margin-left: 1px;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${note.regdate}" /></small>
										</div>
									</div>
								</td>
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
				<li	class="page-item ${pageMaker.cn.pageNum == num ? 'active':''}">
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
		<form id='actionForm' action="note" method='get'>
			<input type='hidden' name='pageNum'	value='${pageMaker.cn.pageNum}'> 
			<input type='hidden' name='amount' value='${pageMaker.cn.amount}'>
		</form>
		
		</div>
		
		<%@include file="../include/right.jsp" %>
		
	</div>
</div>

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
	
});
</script>

</body>
</html>