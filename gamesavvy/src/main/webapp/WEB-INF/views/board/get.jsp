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
			<h2 class="text-center">게시글 내용</h2>
			<form>
				<div class="form-group">
					<label for="bno">번호:</label> 
					<input type="text"
						class="form-control" id="bno" name="bno" readonly
						value='<c:out value="${board.bno }"/>' />
				</div>
				<div class="form-group">
					<label for="title">제목:</label> 
					<input type="text"
						class="form-control" id="title" name="title" readonly
						value='<c:out value="${board.title }"/>' />
				</div>
				<div class="form-group">
					<label for="content">내용:</label>
<textarea class="form-control" id="content" name="content"	rows="10" readonly>
<c:out value="${board.content}" />
</textarea>
				</div>
				<div class="form-group">
					<label for="userid">작성자:</label> 
					<input type="text"
						class="form-control" id="userid" name="userid" readonly
						value='<c:out value="${board.userid }"/>' />
				</div>
			</form>
			<!-- 시큐리티적용 로그인아이디와 게시글 작성기 동일시만 버튼 보임 -->
			<sec:authentication property="principal" var="pinfo" />
			  <!-- EL안에서는 pinfo사용 -->
			<sec:authorize access="isAuthenticated()">
				<c:if test="${pinfo.username eq board.userid}">
			  		<button data-oper='modify' class="btn btn-info">Modify</button>
			  	</c:if>
			</sec:authorize>
				<button data-oper='list' class="btn btn-danger">게시판목록</button> 
			<!-- 버튼 클릭을 처리하기 위한 form,안보이는 창(나중 페이지 정보 댓글 정보 등을 같이 처리 -->
			<form id='operForm' action="modify" method="get">
			  	<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
			  	<!-- 페이지 정보를 추가 -->	
				<input	type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'> 
				<input	type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
				<!-- 검색처리 추가 -->
				<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
				<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
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
                            <!-- 
                            <li class='list-group-item clearfix' data-rno='2'>
                                <strong class='text-primary'>user00</strong>
                                <small class='float-right text-mute'>2023-05-03</small>
                                <p>댓글 내용입니다</p>
                            </li>
                            -->
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


<script>
$(document).ready(function(){
    
    //댓글 처리 스크립트
    let bnoValue = '<c:out value="${board.bno}"/>';
    let replyUL = $(".chat"); //ul 안에 댓글 항목을 추가
    
    let pageNum = 1;
    let replyPageFooter = $("#replyPage");
    
    showList(1); //댓글 리스트 보여주기
    
    $("#addReplyBtn").on("click", function(){
        
    	// 댓글 작성 여부 확인
        if (!replyer) {
            let isConfirm = confirm("댓글을 작성하려면 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
            if (isConfirm) {
                // 로그인 페이지로 이동
                window.location.href = "../member/login";
            }
            return;
        }
    	
    	// 댓글 내용을 formData에 직접 추가
        let reply = {
        		reply: $("#replyForm textarea[name='reply']").val(),
        		replyer: replyer,
        		bno: $("#replyForm input[name='bno']").val()
    	};
        let replyValue = $("textarea[name='reply']");
        if(replyValue.val().trim() === "") {
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
	
 	
    
    
    function showList(page) {
        console.log("show list" + page);
        
        replyService.getList({bno:bnoValue,page:page||1},function(rpDto){
            
            let replyCnt = rpDto.replyCnt;
            let list = rpDto.list;
            console.log("replyCnt" + replyCnt);
            console.log("list" + list);
            
            if(page == -1) {
                pageNum = Math.ceil(replyCnt/10.0);
                showList(pageNum);
                return;
            }
            
            let str = "";
            
            if(list == null || list.length == 0) {
                replyUL.html("");
                return;
            }
            
            for (let i = 0, len = list.length; i < len; i++) {
                str += "<li class='list-group-item clearfix pb-0' data-rno='" + list[i].rno + "'>";
                str += "<strong class='text-info' data-replyer='" + list[i].replyer + "'>" + 
                       "<i class='fab fa-waze' style='color: #3b71ce;'></i> " +
                       list[i].replyer + "</strong>";
                str += "<small class='float-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small>";
                str += "<p>" + list[i].reply + "</p>";
                // 댓글 작성자만 댓글 수정, 삭제 버튼 보이게 처리
                if (replyer === list[i].replyer) {
                    str += "<div class='btn-group float-right'>";
                    str += "<a href='#' class='btn btn-sm btn-primary modify'>수정</a>";
                    str += "<a href='#' class='btn btn-sm btn-danger delete'>삭제</a>";
                    str += "</div>";
                }
                str += "</li>";
            }

            
            replyUL.html(str);
            
         	// 댓글 목록을 출력한 후에, 현재 사용자의 이름(댓글 작성자)을 각 댓글 항목에 데이터 속성으로 저장
            replyUL.find("strong[data-replyer]").each(function () {
                $(this).data("currentUsername", replyer);
            });
            
            showReplyPage(replyCnt);
        });
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
	
});

</script>
</body>
</html>