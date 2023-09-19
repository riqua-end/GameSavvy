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
.card img {
	width: 150px;
	height: 150px;
}
</style> 
</head>
<body>

<%@include file="../include/header.jsp" %>
<div class="container mt-4 mb-4" id="maincontent">
	<div class="row">
		
		<div class="col-md-9">
			<h2 class="text-center">게시물 등록</h2>
			<form action="register" method="post" id="freg" name="freg" role="form">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="form-group">
						<label for="title">제목:</label>
						<input type="text" class="form-control" id="title" placeholder="Enter Title" 
							name="title" required />		
					</div>
					<div class="form-group">
						<label for="content">내용:</label>
						<textarea class="form-control" id="content" placeholder="Enter Content"	name="content" rows="10" required></textarea>		
					</div>
					 <!-- security적용후 사용자 아이디로 지정 -->
					<div class="form-group">
						<label for="userid">작성자:</label>
						<input type="text" class="form-control" id="userid" name="userid" 
							value='<sec:authentication property="principal.username"/>' readonly/>
					</div>
					<button type="submit" class="btn btn-success">작성</button>&nbsp;&nbsp;
					<button type="reset" class="btn btn-danger">취소</button>	&nbsp;&nbsp;
					<a id="listLink" href="list" class="btn btn-primary">목록보기</a>

			</form>
			
			<!-- 첨부파일 등록 처리 -->
			<div class="attach mt-4">
				<h5 class="text-center wordArtEffect text-success mb-5">이미지 업로드</h5>
				<!-- upload처리 -->
				<div class="row">
					<div class="form-group uploadDiv col-md-12">
						<label for="upload">&nbsp;&nbsp;&nbsp;&nbsp;이미지업로드:</label>
						<input type="file" class="form-control" id="upload" name="uploadFile" multiple />
						<!-- submit버튼없이 change이벤트로 처리 -->
					</div>
				</div> <!-- row -->
				
				<!-- 업로드된 파일 보기 -->
				<div class='uploadResult mt-3'>	
					<div class='row' id='cardRow'>
					</div>
				</div>
			</div>
			<!-- attach -->
			
		</div> <!-- col-md-9 -->
		
		<%@include file="../include/right.jsp" %>
		
	</div> <!-- row -->
</div> <!-- maincontent -->
<%@include file="../include/footer.jsp" %>


<script>
$(document).ready(function(){
	
	let formObj = $("form[role='form']");
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	let maxSize = 5242880; //5MB
	
	let uploadUL = $(".uploadResult #cardRow");
	
	//security csrf설정
	let csrfHeaderName ="${_csrf.headerName}"; 
	let csrfTokenValue="${_csrf.token}";
	
	//beforeSend대신 사용(한번만 지정)
	$(document).ajaxSend(function(e, xhr, options) { 
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
    });
	
	//게시글 작성의 submit버튼 클릭 이벤트
	$("button[type='submit']").on("click", function(e){
		
		 e.preventDefault();
		 
		 console.log("submit clicked");
		 
		 let str = "";
		 
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
		 
		 formObj.prepend(str).submit();
	});
	
	// 이미지 업로드 이벤트 처리
	$("input[type='file']").change(function(e){
	    let formData = new FormData(); // 가상의 form 엘리먼트 생성
	    let inputFile = $("input[name='uploadFile']");
	    let files = inputFile[0].files;

	    console.log(files);
	    
	    for (let i = 0; i < files.length; i++) {
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
	        dataType: 'json',
	        success: function(result) {
	            console.log(result);
	            showUploadResult(result);
	            $("#upload").val(""); // 파일 입력창 초기화
	        },
	        error: function() {
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
			return;
		}
		$(uploadResultArr).each(function(i, obj){
			let str ="";
			if(obj.image) {
				let fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
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
				let fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				str += "<div class='card col-md-3'>";
				str += "<div class='card-body'>";
				str += "<p class='mx-auto' style='width:90%;' title='"+ obj.fileName + "'" ;
				str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' >";
				str += "<img class='mx-auto d-block' src='../images/attach.png' >";
				str += "</p>";
				str += "<h4><span class='d-block w-50 mx-auto badge badge-secondary badge-pill' data-file='"+fileCallPath+"' data-type='file'> &times; </span></h4>";
				str += "</div>";
				str += "</div>";
			}
			uploadUL.append(str);
		});		
	}
	
	//첨부 파일 삭제 이벤트 처리
	$(".uploadResult").on("click", "span", function(e){
		
		console.log("delete file");
	      
	    let targetFile = $(this).data("file");
		let type = $(this).data("type");
		
		let targetLi = $(this).closest(".card");
		
		$.ajax({			
			url : '../upload/deleteFile',
		    data: {fileName: targetFile, type:type},
		    dataType:'text',
		    type: 'POST',
		    //beforeSend추가 부분이나 ajaxSend메서드 사용
		    success: function(result){		             
		           targetLi.remove();
		    }
		});
	});
	
	
});
</script>
</body>
</html>