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
			<h2 class="text-center">게시글 수정</h2>
			<form  id="mform" name="mform" action="modify" method="post">
				<!-- 시큐리티 관련 정보 추가 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<!-- 페이지 관련 정보 추가 -->
				<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
       			<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
       			<!-- 검색 적용 -->
       			<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
				<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
				<!-- gs_type -->
				<input type='hidden' name='gs_type' value='<c:out value="${cri.gs_type }"/>'>
				
				<div class="form-group">
					<label for="bno">번호:</label>
					<input type="text" class="form-control" id="bno" name="bno" readonly value='<c:out value="${board.bno }"/>' />		
				</div>
				<div class="form-group">
					<label for="title">제목:</label>
					<input type="text" class="form-control" id="title" name="title" value='<c:out value="${board.title }"/>'/>		
				</div>
				<div class="form-group">
					<label for="content">내용:</label>
<textarea class="form-control" id="content" name="content" rows="10" >
<c:out value="${board.content}" />
</textarea>		
				</div>
				<div class="form-group">
					<label for="userid">작성자:</label>
					<input type="text" class="form-control" id="userid" name="userid" readonly value='<c:out value="${board.userid}"/>'/>		
				</div>
				<div class="form-group">
					<label for="regdate">게시일:</label>
					<input type="text" class="form-control" id="regdate" name="regdate" 
						value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regdate}" />'  readonly/>		
				</div>
				<div class="form-group">
					<label for="updatedate">수정일:</label>
					<input type="text" class="form-control" id="updatedate" name="updatedate" 
						value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.updatedate}" />'  readonly/>		
				</div>
 				<!-- 시큐리티 적용 -->
 				<sec:authentication property="principal" var="pinfo"/>
 				<sec:authorize access="isAuthenticated()">
 					<c:if test="${pinfo.username eq board.userid}">
 						<button type="submit" data-oper='modify' class="btn btn-info">수정</button>&nbsp;&nbsp;
 						<button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>&nbsp;&nbsp;
 					</c:if>
 				</sec:authorize>
				<button type="submit" data-oper='list' class="btn btn-success">목록</button>
			</form>
			
			<!-- 첨부 파일 영역 -->
			<div class="attach mt-4">
				<h5 class="text-center wordArtEffect text-success mb-5">첨부파일
					수정(Ajax)</h5>
				<div class="row">
					<div class="form-group uploadDiv col-md-12">
						<label for="upload">&nbsp;&nbsp;&nbsp;&nbsp;파일수정업로드:</label> <input
							type="file" class="form-control" id="upload" name="uploadFile"
							multiple />
					</div>
				</div>

				<!-- 첨부 파일 리스트 -->
				<div class='uploadResult mt-3'>
					<div class='row' id='cardRow'></div>
				</div>
			</div>
		</div> <!-- col-md-9 -->
		
		<%@include file="../include/right.jsp" %>
		
	</div> <!-- row -->
</div> <!-- maincontent -->
<%@include file="../include/footer.jsp" %>

<script>
$(function(){ //$(document).ready(function(){});의 단축형
	let formObj = $("#mform");
	$("button").on("click",function(e){
		e.preventDefault(); //이벤트가 일어난 버튼의 기본 동작을 제거
		let operation = $(this).data("oper"); //data-xxx속성의 xxx가 oper인것의 속성값을 반환(modify,remove,list 중 선택)
		console.log("operation : "  + operation);
		if(operation == "remove") {
			formObj.attr("action","remove");
		}		
		else if(operation == "list") {
			/* 페이지 처리 미고려
			formObj.attr("action", "list").attr("method","get");
			formObj.empty(); //formObj의 자식 엘리먼트를 모두 제거(4개포함 게시판 컬럼)
			*/
			//페이지 처리 고려
			formObj.attr("action", "list").attr("method","get");
			//페이지 정보
			let pageNumTag = $("input[name='pageNum']").clone() //복사해둠 clone()없어도 무방
		    let amountTag = $("input[name='amount']").clone();
			//검색처리
			let keywordTag = $("input[name='keyword']").clone();
		    let typeTag = $("input[name='type']").clone();
		    //gs_type
		    let gsType = $("input[name='gs_type']").clone();
		    formObj.empty(); //formObj의 자식 엘리먼트를 모두 제거(4개포함 게시판 컬럼)
		    
		    formObj.append(pageNumTag); //자식으로 붙여쓰기
		    formObj.append(amountTag);
		    formObj.append(keywordTag);
		    formObj.append(typeTag);
		    formObj.append(gsType);
		}
		// 첨부파일 고려
		else if(operation == 'modify') {
			//formObj.attr("action","modify");
			console.log("수정 클릭");
			
			let str ="";
			
			$(".uploadResult .card  p").each(function(i, obj){
		    	
		    	let jobj = $(obj);
		    	
		    	console.dir(jobj);
		    	console.log("-------------------------");
		    	console.log(jobj.data("filename"));
		    	
		    	str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			    str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			    str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			    str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
		    });
			console.log(str);
		    
		    formObj.prepend(str);
		}
		
		formObj.submit();
	});
	
});
</script>

<script>
//첨부물 리스트 처리
$(document).ready(function(){
	//즉시실행함수(1회)
	(function(){
		let bno = '<c:out value="${board.bno}"/>';
		
		$.getJSON("getAttachList", {bno: bno}, function(arr){
			console.log(arr);	
		      
		    let str = "";
		    
		    $(arr).each(function(i, obj){
		    	if(!obj.fileType) {
		    		let fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
		    		str += "<div class='card col-md-3'>";
		    		str += "<div class='card-body'>";
		    		str += "<p class='mx-auto' style='width:90%;' title='"+ obj.fileName + "'" ;
					str +=  "data-path='"+obj.uploadPath +"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>";
					str += "<img class='mx-auto d-block' src='../images/attach.png' >";
					str += "</p>";
					str += "<h4><span class='d-block w-50 mx-auto badge badge-secondary badge-pill' data-file='"+fileCallPath+"' data-type='file'> &times; </span></h4>";
		    		str += "</div>";
		    		str += "</div>";
		    	}
		    	else {
		    		let fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName); //주소창의 URI인코딩 형식 문자열,섬네일
		    		
					let originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName; //원본 파일
					originPath = originPath.replace(new RegExp(/\\/g),"/"); //\\를 /로 대체 
					//let originPath = obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName;  //위 2줄대신 바로 사용해도 됨
					
					str += "<div class='card col-md-3'>";
					str += "<div class='card-body'>";
					str += "<p class='mx-auto' style='width:90%;' title='"+ obj.fileName + "'" ;
					str +=  "data-path='"+obj.uploadPath +"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>";
					str += "<img class='mx-auto d-block' src='../upload/display?fileName="+fileCallPath+"'>";
					str += "</p>";
					str += "<h4><span class='d-block w-50 mx-auto badge badge-secondary badge-pill' data-file='"+fileCallPath+"' data-type='image'> &times; </span></h4>";
					str += "</div>";
		    		str += "</div>";
		    	}
		    });
		    
		    $(".uploadResult #cardRow").html(str);
		});
		
	})();
	
	//폴더에서 파일 삭제
	$(".uploadResult").on("click","span", function(e){
		
		console.log("delete file");
	    
		if (confirm("정말 삭제하시겠습니까?")) {
			
			let targetFile = $(this).data("file");
			let type = $(this).data("type");
			
			let targetLi = $(this).closest(".card");
			
			targetLi.remove();
		}
		
	});
});
</script>

<script>
//수정창에서 파일 업로드 처리
$(document).ready(function(){
	
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	let maxSize = 5242880; //5MB
	
	let uploadUL = $(".uploadResult #cardRow");
	
	//ajax시 사용하는 csrf
	let csrfHeaderName ="${_csrf.headerName}"; 
	let csrfTokenValue="${_csrf.token}";
	
	// beforeSend대신 사용
	$(document).ajaxSend(function(e, xhr, options) { 
      xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
    });
	
	//change이벤트로 파일업로드 이벤트 처리--ㅡmodufy.jsp에서는 수정을 위한 업로드
	$("input[type='file']").change(function(e){
		let formData = new FormData(); //가상의 form엘리먼트 생성
		let inputFile = $("input[name='uploadFile']");
		let files = inputFile[0].files; 
		//files변수는 input태그에서 선택된 복수개의 파일 객체를 가지는 배열 변수
		console.log(files);
		
		for(let i = 0; i < files.length; i++) {
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			formData.append("uploadFile", files[i]); 
		}
		
		$.ajax({
			url: '../upload/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType : 'json',
			success : function(result) {
				console.log("파일수정완료");
				showUploadResult(result);
				$("#upload").val(""); //파일 입력창 초기화
				console.log("파일수정완료확인");
			},
			error : function() {
				alert("ajax upload failed");
			}
		});
		
	});
	
	function checkExtension(fileName, fileSize) {
		if(fileSize >= maxSize) {
			alert("파일 사이즈 초과");
		    return false;
		}
		if(regex.test(fileName)) {
			 alert("해당 종류의 파일은 업로드할 수 없습니다.");
		     return false;
		}
		return true;
	}
	
	function showUploadResult(uploadResultArr) {
		if(!uploadResultArr || uploadResultArr.length == 0) {
			uploadUL.append("");
			return;
		}
		
		$(uploadResultArr).each(function(i, obj){
			
			let str ="";
			
			if(obj.image) {
				let fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
				
				//원본파일은 필요 없으나 작성해봄
				let originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName;
				originPath = originPath.replace(new RegExp(/\\/g),"/"); //\\를 /로 대체 
				//let originPath = obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName;  //위 2줄대신 바로 사용해도 됨
				str += "<div class='card col-md-3'>";
				str += "<div class='card-body'>";
				str += "<p class='mx-auto' style='width:90%;' title='"+ obj.fileName + "'" ;
				str +=  "data-path='"+obj.uploadPath +"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
				str += "<img class='mx-auto d-block' src='../upload/display?fileName="+fileCallPath+"'>";
				str += "</p>";
				str += "<h4><span class='d-block w-50 mx-auto badge badge-secondary badge-pill' data-file='"+fileCallPath+"' data-type='image'> &times; </span></h4>";
				str += "</div>";
				str += "</div>";
			}
			else {
				let fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
				str += "<div class='card col-md-3'>";
				str += "<div class='card-body'>";
				str += "<p class='mx-auto' style='width:90%;' title='"+ obj.fileName + "'" ;
				str +=  "data-path='"+obj.uploadPath +"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
				str += "<img class='mx-auto d-block' src='../images/attach.png' >";
				str += "</p>";
				str += "<h4><span class='d-block w-50 mx-auto badge badge-secondary badge-pill' data-file='"+fileCallPath+"' data-type='file'> &times; </span></h4>";
				str += "</div>";
				str += "</div>";
			}
			uploadUL.append(str);
		});
	}
});
</script>

</body>
</html>