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

<style>
/* 이미지 슬라이더 스타일 */
.slider {
    display: flex;
    align-items: center;
}

/* 이미지 모달 내부 이미지 스타일 */
.modal-image {
    max-width: 100%; /* 이미지 너비를 부모 요소에 맞게 조절합니다. */
    max-height: 350px; /* 이미지 높이를 최대 300px로 제한하여 비율을 유지합니다. */
    display: block; /* 이미지를 블록 요소로 표시하여 여백을 자동으로 처리합니다. */
    margin: 0 auto; /* 이미지를 가운데 정렬합니다. */
}

<!-- 이미지 스타일 추가 -->

/* 이미지 컨테이너 스타일 */
.card-img-container {
    max-width: 100%; /* 컨테이너의 최대 너비 설정 */
    max-height: 350px; /* 컨테이너의 최대 높이 설정 */
    display: flex; /* 이미지를 가운데 정렬하기 위해 flex 사용 */
    justify-content: center; /* 이미지를 가운데 정렬하기 위해 가로 정렬 설정 */
    align-items: center; /* 이미지를 가운데 정렬하기 위해 세로 정렬 설정 */
}

/* 이미지 스타일 */
.card-img-container img {
    max-width: 100%; /* 이미지의 최대 너비 설정 */
    max-height: 100%; /* 이미지의 최대 높이 설정 */
    width: auto; /* 너비를 자동으로 조절하여 비율 유지 */
    height: auto; /* 높이를 자동으로 조절하여 비율 유지 */
}

/* 댓글 수정, 삭제 버튼 스타일 */
.btn-group {
    margin-left: 10px; /* 버튼 사이 여백 조절 */
}

/* 답글 달기 버튼 스타일 */
.btn-group.reply {
    margin-left: 10px; /* 버튼 사이 여백 조절 */
}

</style>
<!-- Slick Carousel 스타일 및 스크립트 추가 -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css">

</head>
<body>

<%@include file="../include/header.jsp" %>
<div class="container mt-4 mb-4" id="maincontent">
	<div class="row">
		
		<div class="col-md-9">
			<h2 class="text-center">게시글 내용</h2>
			<div class="container mt-4 mb-4">
			    <div class="border-top mb-2"></div>
			    <div class="d-flex justify-content-between align-items-center p-1">
			        <span class="mb-0 font-weight-bold h4 p-1">${board.title}</span>
			        <span class="text-muted text-right"><fmt:formatDate value="${board.regdate}" pattern="yyyy.MM.dd" /></span>
			    </div>
			    <div class="border-top mb-2 mt-2"></div>
			    <div class="d-flex justify-content-between align-items-center p-1">
			        <div class="text-left">
			            <span class="text-primary font-weight-bold h5 p-1">${board.userid}</span>
			        </div>
			        <div class="text-right">
			            <span class="mr-3">조회 수 <b><c:out value="${board.cnt}"/></b></span>
			            <span class="mr-3">추천 수 <b>${recommendCount}</b></span>
			            <span>댓글 <b><c:out value="${board.replycnt}"/></b></span>
			        </div>
			    </div>
			    <div class="border-bottom mb-3 mt-2"></div>
			    
			    <!-- 첨부 파일 이미지 -->
			    <div class="p-1 card-img-top card-img-container" style="position: relative;" id="cardRow_<c:out value="${board.bno}" />">
			    	<!-- 여기에 이미지 추가됨 -->
			    </div>
			    <div class="p-1">${board.content}</div>
			</div>

			<!-- 시큐리티적용 로그인아이디와 게시글 작성기 동일시만 버튼 보임 -->
			<sec:authentication property="principal" var="pinfo" />
			  <!-- EL안에서는 pinfo사용 -->
			<sec:authorize access="isAuthenticated()">
				<c:if test="${pinfo.username eq board.userid}">
			  		<button data-oper='modify' class="btn btn-info">Modify</button>
			  	</c:if>
			</sec:authorize>
				<button data-oper='list' class="btn btn-danger">게시판목록</button> 
			
			
			<!-- 로그인한 사용자만 좋아요 버튼 출력 -->
			<sec:authorize access="isAuthenticated()">
	            <!-- 좋아요 버튼 -->
				<div style="text-align: center;">
				    <div>
				        <button id="likeButton" class="btn btn-primary"><i class="far fa-heart" style="color: #ffffff;"></i> 좋아요</button>
				        <button id="unLikeButton" class="btn btn-danger" style="display: none;"><i class="fas fa-heart" style="color: #ffffff;"></i> 좋아요 취소</button>
				        <span id="likeCount">${recommendCount}</span>
				    </div>
				</div>
	        </sec:authorize>
			
			<!-- 버튼 클릭을 처리하기 위한 form,안보이는 창(나중 페이지 정보 댓글 정보 등을 같이 처리 -->
			<form id='operForm' action="modify" method="get">
			  	<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
			  	<!-- 페이지 정보를 추가 -->	
				<input	type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'> 
				<input	type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
				<!-- 검색처리 추가 -->
				<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
				<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
				<!-- gs_type -->
				<input type='hidden' name='gs_type' value='<c:out value="${cri.gs_type }"/>'>
			</form>
			
			
			<!-- 댓글 등록 -->
            <!-- 댓글 영역 -->
            <div>
                <h3> <i class="far fa-comments fa-sm" style="color: #d22d2d;"></i> Comments</h3>
            </div>
            
            <!-- 댓글 입력 폼 -->
            <form id="replyForm" role="form" method="post">
                <div class="form-group">
                    <textarea class="form-control" name="reply" rows="4" style="resize:none; width:100%; border-radius:10px;" placeholder="댓글을 입력해주세요."></textarea>
                </div>
                <!-- replyer 정보를 서버에서 받아서 hidden 필드에 설정해준다 --> 
                <input type="hidden" name="replyer" value="${principal.username}" /> 
                <input type="hidden" name="bno" value="${board.bno}" />
            	<button class="btn btn-dark float-right" type="button" id="addReplyBtn">댓글 등록하기</button>
            </form>
            
            <!-- 댓글 리스트 -->
            <section class="mt-3" style="margin-top: 4rem !important;">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <ul class="chat list-group">
                            <!-- 부모 댓글
                            <li class='list-group-item clearfix' data-rno='2'>
                                <strong class='text-primary'>user00</strong>
                                <small class='float-right text-mute'>2023-05-03</small>
                                <p>댓글 내용입니다</p>
                            </li>
                            -->
                            <!-- 자식 댓글이 나오는 곳 -->
                        </ul>
                    </div>
                </div>
                <!-- 댓글용 페이지 표시 -->
                <div id='replyPage' style="text-align:center;">
                </div>
            </section>
		</div> <!-- col-md-9 -->
		
		<%@include file="../include/right.jsp" %>
		
	</div> <!-- row -->
</div> <!-- maincontent -->
<%@include file="../include/footer.jsp" %>

<!-- reply.js ajax 처리를 위한 스크립트 -->
<script type="text/javascript" src="../js/reply.js"></script>

<!-- 이미지 클릭시 슬라이더 모달창 -->
<%@ include file ="../include/imgModal.jsp"%>
<!-- slick 라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<script>
$(document).ready(function(){	
	//게시글 조회 버튼 처리 
	//modify,list 처리 버튼 
	
	let operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action", "modify").submit();
	});
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#bno").remove();
		//id가 bno인 DOM을 찾아서 제거
		operForm.attr("action", "list");
		operForm.submit();
	});
});
</script>

<!-- 추천 기능 구현 -->
<script>
$(document).ready(function(){
    // 게시글 고유 번호 가져오기
    let boardId = '<c:out value="${board.bno}"/>';
    
    // 현재 로그인한 사용자의 이름 가져오기 (Spring Security의 태그 사용)
    <sec:authorize access="isAuthenticated()">
        <c:set var="username" value="${pinfo.principalUsername}" />
    </sec:authorize>
    // 위에서 가져온 사용자 이름 변수 저장
    let userId = '${username}';
    
    // 좋아요 버튼과 좋아요 취소 버튼 가져오기
    let likeButton = $("#likeButton");
    let unLikeButton = $("#unLikeButton");
    // 추천 수를 표시할 span 태그 가져오기
    let likeCountSpan = $("#likeCount");
    
    // 좋아요 버튼 클릭 이벤트 처리
    likeButton.click(function () {
        toggleLike(true); // 좋아요 버튼 클릭 시 toggleLike 함수 호출
    });

    // 좋아요 취소 버튼 클릭 이벤트 처리
    unLikeButton.click(function () {
        toggleLike(false); // 좋아요 취소 버튼 클릭 시 toggleLike 함수 호출
    });

    // 추천 상태 토글 함수 정의
    function toggleLike(like) {
        // 서버로 보낼 URL 설정 (좋아요인 경우와 좋아요 취소인 경우 분기)
        let url = like ? '../board/like' : '../board/dislike';

        // AJAX 요청 보내기
        $.ajax({
            type: 'POST',
            url: url,
            data: { bno: boardId }, // 게시글 번호 데이터 전송
            dataType: 'text', // 서버 응답을 text 형식으로 받아옴 (liked 또는 unliked)
            success: function (response) {
                // 서버 응답에 따라 버튼 상태 변경
                if (response === 'liked') {
                    likeButton.hide(); // 좋아요 버튼 숨기기
                    unLikeButton.show(); // 좋아요 취소 버튼 보이기
                } else if (response === 'unliked') {
                    likeButton.show(); // 좋아요 버튼 보이기
                    unLikeButton.hide(); // 좋아요 취소 버튼 숨기기
                }
                updateRecommendCount(); // 추천 수 업데이트 함수 호출
            }
        });
    }

    // 추천수 업데이트 함수 정의
    function updateRecommendCount() {
        // AJAX 요청 보내기
        $.ajax({
            type: 'GET',
            url: '../board/getRecommendCount', // 추천 수를 가져올 URL
            data: { bno: boardId }, // 게시글 번호 데이터 전송
            dataType: 'json', // 서버 응답을 json 형식으로 받아옴
            success: function (data) {
                likeCountSpan.text('추천수 : ' + data); // 추천 수 표시 업데이트
            }
        });
    }

    // 페이지 로딩 시 좋아요 상태와 추천수 초기화 함수 정의
    function initLikeStatus() {
        // AJAX 요청 보내기
        $.ajax({
            type: 'GET',
            url: '../board/checkLiked', // 좋아요 상태 확인을 위한 URL
            data: { bno: boardId }, // 게시글 번호 데이터 전송
            dataType: 'text', // 서버 응답을 text 형식으로 받아옴
            success: function (response) {
                // 서버 응답에 따라 버튼 상태 변경
                if (response === 'liked') {
                    likeButton.hide(); // 좋아요 버튼 숨기기
                    unLikeButton.show(); // 좋아요 취소 버튼 보이기
                } else {
                    likeButton.show(); // 좋아요 버튼 보이기
                    unLikeButton.hide(); // 좋아요 취소 버튼 숨기기
                }
                updateRecommendCount(); // 추천 수 업데이트 함수 호출
            }
        });
    }

    initLikeStatus(); // 페이지 로딩 시 좋아요 상태와 추천수 초기화 함수 호출
    
});
</script>

<script>
$(document).ready(function(){
    
    //댓글 처리 스크립트
    let bnoValue = '<c:out value="${board.bno}"/>';
    let replyUL = $(".chat"); //ul 안에 댓글 항목을 추가
    
    let pageNum = 1;
    let replyPageFooter = $("#replyPage");
    
    showList(1); //댓글 리스트 보여주기
    
    $("#addReplyBtn").on("click", function () {
        // 댓글 작성 여부 확인
        if (!replyer) {
            let isConfirm = confirm("댓글을 작성하려면 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
            if (isConfirm) {
                // 로그인 페이지로 이동
                window.location.href = "../member/login";
            }
            return;
        }

        let reply = {
            reply: $("#replyForm textarea[name='reply']").val(),
            replyer: replyer,
            bno: $("#replyForm input[name='bno']").val()
        };
        let replyValue = $("textarea[name='reply']");
        if (replyValue.val().trim() === "") {
            alert("댓글을 입력해 주세요.");
            replyValue.focus();
            return;
        }

        // 댓글 등록 서비스 호출
        replyService.add(reply, function (result) {
            alert("댓글이 등록되었습니다.");
            $("#replyForm textarea[name='reply']").val("");
            showList(-1); // 등록 후 댓글 목록 보이게 함
        });
    });

    
 	// 댓글 목록을 출력하는 함수
    function showList(page) {
        console.log("show list" + page);

        // 댓글 목록을 서버로부터 가져오는 replyService.getList 함수 호출
        replyService.getList({ bno: bnoValue, page: page || 1 }, function (rpDto) {
            let replyCnt = rpDto.replyCnt; // 댓글 총 개수
            let list = rpDto.list; // 댓글 목록 데이터

            console.log("replyCnt" + replyCnt);
            console.log("list" + list);

            if (page == -1) {
                // 페이지가 -1인 경우, 마지막 페이지를 계산하여 다시 showList 호출
                pageNum = Math.ceil(replyCnt / 10.0);
                showList(pageNum);
                return;
            }

            // 댓글 목록 데이터를 트리 구조로 정리
            let treeData = organizeReplyData(list);

            // 트리 구조로부터 HTML 생성
            let str = generateReplyHTML(treeData);

            // 생성된 HTML을 댓글 목록 영역에 적용
            replyUL.html(str);

            // 댓글 목록을 출력한 후에, 현재 사용자의 이름(댓글 작성자)을 각 댓글 항목에 데이터 속성으로 저장
            replyUL.find("strong[data-replyer]").each(function () {
                $(this).data("currentUsername", replyer);
            });

            // 댓글 페이지를 표시하는 함수 호출
            showReplyPage(replyCnt);
        });
    }

 	// 댓글 데이터를 트리 구조로 정리하는 함수
    function organizeReplyData(list) {
        let treeData = {}; // 댓글 데이터를 트리 구조로 정리할 객체 생성

        // 댓글 목록 순회
        list.forEach(function (reply) {
            if (!treeData[reply.rno]) {
                // 트리 데이터에 해당 댓글의 rno가 없는 경우, 새로운 댓글로 초기화
                treeData[reply.rno] = reply;
                treeData[reply.rno].children = []; // 해당 댓글의 자식 댓글 목록 초기화
            }
            if (reply.parent_id) {
                if (!treeData[reply.parent_id]) {
                    // 해당 댓글의 부모 댓글이 트리 데이터에 없는 경우, 새로운 부모 댓글로 초기화
                    treeData[reply.parent_id] = {
                        children: []
                    };
                }
                // 부모 댓글의 자식 댓글 목록에 현재 댓글 추가
                treeData[reply.parent_id].children.push(reply);
            }
        });
        return treeData; // 트리 구조로 정리된 댓글 데이터 반환
    }

    // 댓글을 HTML로 변환하는 함수
    function generateReplyHTML(treeData) {
        let str = ""; // HTML 문자열을 저장할 변수 초기화
        for (let rno in treeData) {
            let reply = treeData[rno]; // 현재 댓글 데이터

            // 삭제된 댓글이 아닌 경우에만 처리
            if (reply.reply !== "(삭제된 댓글입니다.)") {
                if (!reply.parent_id) {
                    // 부모 댓글인 경우
                    str += generateReplyItem(treeData, rno, 0);
                    // 자식 댓글이 있다면 자식 댓글도 추가
                    if (reply.children.length > 0) {
                        str += "<ul class='list-group child-replies ml-5'>";
                        str += generateChildReplies(treeData, reply.children, 1);
                        str += "</ul>";
                    }
                }
            } else {
                // 삭제된 댓글인 경우에도 부모 댓글의 정보를 출력
                if (reply.parent_id) {
                    str += generateReplyItem(treeData, reply.parent_id, 0);
                }
            }
        }
        return str; // 생성된 HTML 문자열 반환
    }

    // 자식 댓글을 HTML로 변환하는 함수
    function generateChildReplies(treeData, children, depth) {
        let str = ""; // HTML 문자열을 저장할 변수 초기화
        children.forEach(function (child) {
            // 삭제된 댓글은 출력하지 않음
            if (child.reply !== "(삭제된 댓글입니다.)") {
                str += generateReplyItem(treeData, child.rno, depth);
                // 손자 댓글이 있다면 재귀적으로 추가
                if (child.children.length > 0) {
                    str += "<ul class='list-group child-replies ml-5'>";
                    str += generateChildReplies(treeData, child.children, depth + 1);
                    str += "</ul>";
                }
            }
        });
        return str; // 생성된 HTML 문자열 반환
    }


    // 댓글 아이템을 HTML로 생성하는 함수
    function generateReplyItem(treeData, rno, depth) {
        let reply = treeData[rno];
        let str = "<li class='list-group-item clearfix pb-0' data-rno='" + reply.rno + "'>";

        // 삭제된 부모 댓글인 경우를 처리
        if (reply.parent_id === undefined) {
            str += "<p class='text-danger font-weight-bold' style='font-size: 16px;'>(삭제된 댓글입니다.)</p>";
        } else {
            // 일반적인 댓글 아이템 생성
            str += "<strong class='text-info' data-replyer='" + reply.replyer + "'>" +
                "<i class='fab fa-waze' style='color: #3b71ce;'></i> " +
                reply.replyer + "</strong>";
            str += "<small class='float-right text-muted'>" + replyService.formatDateToRelativeTime(reply.replyDate) + "</small>";
            str += "<p>" + reply.reply + "</p>";

            // 댓글 작성자와 현재 로그인한 사용자가 같을 경우 수정, 삭제 버튼 표시
            if (replyer === reply.replyer) {
                str += "<div class='btn-group float-right'>";
                str += "<a href='#' class='btn btn-sm btn-primary modify'>수정</a>";
                str += "<a href='#' class='btn btn-sm btn-danger delete'>삭제</a>";
                str += "</div>";
            } else {
                // 댓글 작성자와 현재 로그인한 사용자가 다를 경우 답글 달기 버튼 표시
                str += "<div class='btn-group float-right'>";
                str += "<a href='#' class='btn btn-sm btn-success reply'>답글달기</a>";
                str += "</div>";
            }
        }

        str += "</li>";
        return str;
    }




    
    function showReplyPage(replyCnt) {
        
        let endNum = Math.ceil(pageNum / 10.0) * 10;
        
        let startNum = endNum - 9;
        
        let prev = startNum != 1;
        let next = false;
        
        if(endNum * 10 >= replyCnt) {
            endNum = Math.ceil(replyCnt/10.0);
        }
        
        if(endNum * 10 < replyCnt) {
            next = true;
        }
        
        let str = "<ul class='pagination justify-content-center' style='margin: 20px 0'>";
        
        if(prev) {
            str += "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
        }
        
        for(let i = startNum ; i <= endNum; i++) {
            let active = pageNum == i ? "active": "";
            str+= "<li class='page-item " +active+" '><a class='page-link' href='"+ i +"'>"+ i +"</a></li>";
        }
        
        if(next) {
            str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
        }
        
        str += "</ul>";
        
        console.log(str);
        
        replyPageFooter.html(str);
    }
    
    //댓글 작성자를 로그인한 username으로 지정
    let replyer = null;
    //sec EL문을 자바스크립트에서 사용
    <sec:authentication property="principal" var="pinfo"/>
    <sec:authorize access="isAuthenticated()">
    	replyer = '<sec:authentication property="principal.username"/>';
    	let replyers = "${pinfo.username}";
    </sec:authorize>
    //sec:authentication 태그를 이용하여 principal 객체인 pinfo에서 username을 가져옴
    //c:set 태그를 이용하여 가져온 username을 변수에 저장
    
    //ajax csrf설정
    let csrfHeaderName = "${_csrf.headerName}";
    let csrfTokenValue = "${_csrf.token}";
    
    $(document).ajaxSend(function(e,xhr,options){
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);    
    });
    
    
 	// 댓글 수정 버튼 클릭 이벤트 처리
    $(".chat").on("click", "a.modify", function(e) {
        e.preventDefault();
        //$(this)는 클릭 이벤트가 발생한 <a>태그 , closest("li")는 <a>를 포함한 가장 가까운 <li> 요소
        let li = $(this).closest("li");
        let rno = li.data("rno");
		
        //<p>태그 안의 text요소(댓글 내용)을 불러옴
        //즉 li태그 안에 자식요소 중에서 p태그의 text
        let reply = li.children("p").text();
        let replyer = li.children("strong[data-replyer]").data("replyer"); // 댓글 작성자 정보 가져오기
        
        

        // 수정 폼을 텍스트 에디터로 변경
        li.children("p").html("<textarea class='form-control' rows='2' style='resize:none; width:100%; border-radius:10px;'>" + reply + "</textarea>");
        li.find("a.modify").hide();
        li.find("a.delete").hide();
        li.append("<a href='#' class='btn btn-sm btn-success float-right finish'>수정완료</a>");
        
     	// 댓글 작성자 정보를 replyer 변수에 저장
        li.data("replyer", replyer);
    });

    // 댓글 수정 완료 버튼 클릭 이벤트 처리
    $(".chat").on("click", "a.finish", function(e) {
        e.preventDefault();
        let li = $(this).closest("li");
        let rno = li.data("rno");

        let reply = li.find("textarea").val();
        let replyer = li.data("replyer"); // 댓글 작성자 정보 가져오기
        
        let data = {
            rno: rno,
            reply: reply,
            replyer: replyer // 수정된 replyer 정보를 서버로 전송
        };

        // 댓글 수정 서비스 호출
        replyService.update(data, function(result) {
            alert("댓글이 수정되었습니다.");
            showList(pageNum); // 수정 후 댓글 목록 보이게 함
        });
    });

    // 댓글 삭제 버튼 클릭 이벤트 처리
    $(".chat").on("click", "a.delete", function(e) {
        e.preventDefault();
        let li = $(this).closest("li");
        let rno = li.data("rno");
		
        let replyer = li.children("strong[data-replyer]").data("replyer"); // 댓글 작성자 정보 가져오기
        
     	// 댓글 삭제 여부를 확인하는 confirm 창 띄우기
        let isDelete = confirm("정말로 삭제하시겠습니까?");
        if (isDelete) {
            // 댓글 삭제 서비스 호출
            replyService.remove(rno, replyer, function(result) {
                alert("댓글이 삭제되었습니다."); // 삭제 완료 시 alert 창 띄우기
                showList(pageNum); // 삭제 후 댓글 목록 보이게 함
            });
        }

        
    });
    
    //페이지 번호 클릭시 이벤트 처리(해당 페이지의 댓글 리스트 표시)
    replyPageFooter.on("click","li a", function(e){
    	e.preventDefault();
    	console.log("page click");
    	
    	let targetPageNum = $(this).attr("href");
    	
    	console.log("targetPageNum" + targetPageNum);
    	
    	pageNum = targetPageNum;
    	
    	showList(pageNum);
    });
    
    
   	// 댓글 리스트 출력 후, 대댓글 버튼 클릭 이벤트 처리
   	$(".chat").on("click", "a.reply", function(e) {
   	    e.preventDefault(); // 기본 클릭 이벤트 동작을 막음
   	    let li = $(this).closest("li"); // 클릭한 버튼의 가장 가까운 상위 li 요소를 찾음
   	    let parentRno = li.data("rno"); // 부모 댓글의 아이디(rno)를 가져옴

   	    // 대댓글 작성 폼이 아직 보이지 않는 경우
   	    if (li.find(".reply-form").length === 0) {
   	        // 대댓글 작성 폼 생성
   	        let replyForm = "<div class='reply-form'>" +
   	            "<textarea class='form-control' rows='2' style='resize:none; width:100%; border-radius:10px;'></textarea>" +
   	            "<a href='#' class='btn btn-sm btn-success float-right add-reply'>대댓글 달기</a>" +
   	            "</div>";

   	        // 대댓글 작성 폼을 부모 댓글 아래에 추가
   	        li.append(replyForm);

   	        // 버튼 텍스트를 "답글 달기 취소"로 변경하고 버튼 색상을 변경
   	        $(this).text("답글 달기 취소").removeClass("btn-success").addClass("btn-danger");
   	    } else { // 대댓글 작성 폼이 이미 보이는 경우
   	        // 대댓글 작성 폼을 제거
   	        li.find(".reply-form").remove();

   	        // 버튼 텍스트를 "답글 달기"로 변경하고 버튼 색상을 변경
   	        $(this).text("답글 달기").removeClass("btn-danger").addClass("btn-success");
   	    }

   	    // 대댓글 작성 버튼 클릭 이벤트 처리
   	    $(".add-reply").on("click", function(e) {
   	        e.preventDefault(); // 기본 클릭 이벤트 동작을 막음
   	        let replyText = $(this).prev("textarea").val(); // 대댓글 내용을 가져옴

   	        // 대댓글 등록 서비스 호출 (부모 댓글의 아이디(rno)와 작성된 대댓글 내용을 전송)
   	        let reply = {
   	            reply: replyText,
   	            replyer: replyer, // 현재 로그인한 사용자
   	            bno: bnoValue, // 게시글 번호
   	            parent_id: parentRno // 부모 댓글의 아이디(rno)
   	        };

   	        replyService.add(reply, function(result) {
   	            alert("대댓글이 등록되었습니다.");
   	            // 대댓글 등록 후, 해당 부모 댓글의 대댓글 목록을 갱신
   	            showList(pageNum);
   	        });

   	        // 대댓글 작성 폼을 제거
   	        li.find(".reply-form").remove();

   	        // 버튼 텍스트를 "답글 달기"로 변경하고 버튼 색상을 변경
   	        li.find(".reply").text("답글 달기").removeClass("btn-danger").addClass("btn-success");
   	    });
   	});

});

</script>


<script>
$(document).ready(function () {
    // 페이지 로딩시 이미지 목록을 가져와서 추가하는 함수
    function loadImages() {
        // 이미지를 가져올 게시물의 bno 목록
        let bno = '<c:out value="${board.bno}"/>';
        $.getJSON("getAttachList", { bno: bno }, function (arr) {
            console.log(arr); // arr은 컨트롤러에서 반환하는 json으로 된 List<GsAttachVO>객체
            let str = '<div class="d-flex flex-row flex-wrap justify-content-start align-items-center" style="margin: 0px;">';
            $(arr).each(function (i, obj) {
                if (!obj.fileType) { // 일반 파일일시
                    let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                    str += "<div class='card-body'>";
                    str += "<p class='mx-auto' style='width:90%;' title='" + obj.fileName + "'>";
                    str += "<a href='../upload/download?fileName=" + fileCallPath + "'>";
                    str += "<img class='mx-auto d-block img-thumbnail' src='../images/qna.png' >";
                    str += "</a>";
                    str += "</p>";
                    str += "</div>";
                    str += "</div>";
                } else { // 이미지 파일일시
                    let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName); //섬네일
                    let originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName; // 원본파일 경로
                    // 이미지 생성 부분
                    
                    str += '<div class="card">';
                    str += '<a href="javascript:void(0);" data-bno-id="' + bno + '" data-image-path="' + originPath + '" class="btn-show-images">';
                    str += '<img class="card-img-top review-image" src="../upload/display?fileName=' + fileCallPath + '" alt="Review Image">';
                    str += "</a>";
                    str += '</div>';
                }
            });
            str += '</div>';
            $("#cardRow_" + bno).html(str);
        });
        
    }

    // 페이지 로딩 시 이미지 목록을 불러옴
    loadImages();
    
 	// 이미지 클릭 시 슬라이더 열기
    $(document).on("click", ".btn-show-images", function () {
        let bno = $(this).data("bno-id");
        let clickedIndex = $(this).parent().index(); // 클릭한 이미지의 부모 요소(카드)의 인덱스
        openImageModal(bno, clickedIndex);
    });

 	// 이미지 모달 열기 및 이미지 목록을 동적으로 생성하는 함수
    function openImageModal(bno, clickedIndex) {
        let modalContent = '';
        let fileCallPath = ''; // fileCallPath를 미리 정의

        $.getJSON("getAttachList", { bno: bno }, function (arr) {
            let str = '<div class="slider">';
            $(arr).each(function (i, obj) {
                let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                str += '<div>';
                str += '<img class="img-fluid modal-image" src="../upload/display?fileName=' + fileCallPath + '">';
                str += '</div>';
            });

            str += '</div>';
            $("#imageModalContent").html(str); // 모달 내용 설정

            // 이미지가 한 개인 경우에는 슬라이더를 초기화하지 않고, 이미지만 표시
            if (arr.length > 1) {
                // 슬라이더 초기화
                $('.slider').slick({
                    slidesToShow: 1, // 1개씩 보이도록 설정
                    slidesToScroll: 1,
                    dots : true,
                    initialSlide: clickedIndex, // 클릭한 이미지가 첫 번째로 보이도록 설정
                    prevArrow: '<button type="button" class="slick-prev" style="background-color: black; font-size: 20px;"></button>',
                    nextArrow: '<button type="button" class="slick-next" style="background-color: black; font-size: 20px;"></button>'
                });

                // 클릭한 이미지가 첫 번째로 보이도록 슬라이더 위치 설정
                $('.slider').slick('slickGoTo', clickedIndex);
            } else {
                // 이미지가 한 개일 때 이미지 컨테이너를 가운데 정렬
                $('.slider').css('display', 'flex');
                $('.slider').css('justify-content', 'center');
                $('.slider').css('align-items', 'center');
            }

            // 이미지 모달 열기
            $(".imageModal").modal("show");
        });
    }



});
</script>
</body>
</html>