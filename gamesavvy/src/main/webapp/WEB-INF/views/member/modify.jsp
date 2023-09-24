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
<title>profile edit</title>
<meta charset="UTF-8">

<!-- RWD -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- MS -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8,IE=EmulateIE9"/>

<style>
/* 비밀번호 확인 일치 유효성검사 */
.pwck_input_re_1 {
	color : green;
	display:none;
}
.pwck_input_re_2 {
	color : red;
	display:none;
}

/*썸네일 클릭시 나타나는 모달 이미지*/
.modal_img{
	width:60%
}

/*썸네일 삭제 버튼*/
.badge{
	cursor: pointer;
}

.custom-file-label::after {
	content: "사진 선택" !important;
}
.custom-file-label {
	color: #1d80e3 !important;
	cursor: pointer;
}
.custom-file-input {
	cursor: pointer !important;
}
</style>
</head>
<body>

<%@ include file="../include/header.jsp" %>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header text-center">회원정보 수정</h1>
	</div>
</div>

<div class="row d-flex justify-content-center mb-3">
	<div class="col-md-6 col-md-offset-6">
		<div class="panel panel-default">
			<div class="panel-heading"><br></div>
				<div class="panel-body">
					<form role="form" action="../member/modify" method="post" enctype="multipart/form-data" id="frm1" name="frm1">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						<input type="hidden" id="userNameInput" value='<sec:authentication property="principal.member.username"/>'>
							
							<!-- 프로필 이미지 미리보기 -->
							<div class="form-group text-center">
							    <div class="uploadResult d-flex justify-content-center align-items-center">
							        <div class="row" id="cardRow">
							        	
							        </div>
							    </div>
							</div>
							
							<!-- 업로드 입력 창 -->
							<div class="form-group">
							    <label for="profileImage">프로필 이미지</label>
							    <div class="input-group">
							        <div class="custom-file">
							            <input type="file" class="custom-file-input" id="profileImage" name="uploadFile">
							            <label class="custom-file-label" for="profileImage">파일을 선택하세요</label>
							        </div>
							    </div>
							</div>
							

							<div class="form-group">
								<label>아이디</label> <input class="form-control" name='userid'
									value='<sec:authentication property="principal.username"/>' readonly>
							</div>
							
							<div class="form-group">
							    <label for="curPw">현재 비밀번호</label>
							    <input type="password" class="form-control" name="curPw" id="curPw" placeholder="현재 비밀번호 입력" required/>
							    <span class="cur_pw_ck"></span>
							</div>
							
							<div class="form-group">
								<label for="uPw">새비밀번호</label>
								<input type="password" class="form-control" name="userpw" id="uPw"	placeholder="비밀번호 입력" required/>
								<span class="final_pw_ck"></span>
							</div>
							<div class="form-group">
								<label for="uPwChk">새비밀번호확인</label>
								<input type="password" class="form-control" name="userpwChk" id="uPwChk"	placeholder="비밀번호확인입력" required/>
								<span class="final_pwck_ck" style="display: none;"></span>
								<span class="pwck_input_re_1" style="display: none;">비밀번호가 일치합니다.</span>
								<span class="pwck_input_re_2" style="display: none;">비밀번호가 일치하지 않습니다.</span>
							</div>
							<div class="form-group">
								<label for="uName">사용자명</label>
								<input type="text" class="form-control" name="username" id="uName" value='<sec:authentication property="principal.member.username"/>' required/>			
							</div>
								
							<button type="button" class="btn btn-success" id="modifyBtn">회원정보 수정</button>
							<a role="button" class="btn btn-info" href="/home/home">홈으로</a>
					</form>
					
				</div>
		</div>
	</div>
</div>

<%@ include file="../include/footer.jsp" %>
<%@ include file="../include/imgModal.jsp" %>


<script>

/*썸네일 클릭시 모달로 보여주기*/
function showImage(fileCallPath) {
	//<a>태그에서 직접 호출시 대비해서 jQuery밖에서 만듬	
	$('.imageModal .modal-body').html("<div class='text-center'><img class='modal_img justify-content-center' src='../upload/display?fileName=" 
				+ encodeURI(fileCallPath)+"&size=1' ></div>");
	$(".imageModal").modal("show");		
}



$(document).ready(function(){
	
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	
	//RegExp는 정규식 처리 코아 객체로 exe,sh,zip,alz를 포함하고 있는 정규식 객체
	let maxSize = 5242880; //5MB
	
	let cloneObj = $(".uploadDiv").clone(); //입력전의 ajax 파일 업로드 객체 복사
	
	let uploadResult = $(".uploadResult #cardRow");
	
	//ajax upload이벤트 처리
	$("input[type='file']").on("change", function(e){
		let formData = new FormData();
		//FormData는 자바스크립트 코아 객체로 <form>태그의 DOM을 나타냄 <form></form>의 DOM
		let inputFile = $("input[name='uploadFile']");  //배열 형식으로 반환	
		let files = inputFile[0].files; //files속성은 input태그에서 선택한 복수개의 파일 정보를 가짐(이름,크기 등의 정보 )
		let username = '<sec:authentication property="principal.username"/>';
		console.log(files);
		
		for(let i = 0; i < files.length; i++) {
			
			if (!checkExtension(files[i].name, files[i].size)) {
				//선택된 파일 files[i]의 name과 size속성
				return false;
			}
			
			formData.append("uploadFile", files[i]);
			//formData DOM객체에 name속성이 uploadFile인 <input>태그를 만들고 선택한 file객체를 가진 엘리먼트를 추가
			formData.append("userid", username); // userid 추가
		}
		
		$.ajax({
			url : '../upload/imgUpload',
			type : 'POST', //필수
			processData : false, //필수
			contentType : false, //필수
			data : formData, //서버로 보내는 데이터로 <form>엘리먼트 DOM
			dataType:'json',
			success : function(result) {
				console.log(result);
				uploadResult.empty(); // 기존 이미지 요소 제거
				showUploadedFile(result);
				$("#profileImage").val(""); //파일업로드창 초기화
			},
			error : function(e) {
				console.log(e);
				alert("전송 실패");
			}
		});
	});
	
	function checkExtension(fileName, fileSize) {
		
		if (fileSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		
		if (regex.test(fileName)) {
			// test는 RegExp코아 객체의 메서드로 정규식에 지정된 단어 포함 여부 체크
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		return true;
	}
	
	function showUploadedFile(uploadResultArr){
		if(!uploadResultArr || uploadResultArr.length === 0) {
			return;
		}
		
		$(uploadResultArr).each(function(i,obj){
			let str = "";
			if(obj.fileType){
				
				let fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				let originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
				originPath = originPath.replace(new RegExp(/\\/g),"/");
				
				
				str += "<div class='card justify-content-center border-0'>";
                str += "<div class='card-body'>";
                str += "<p class='mx-auto' style='width:90%; position: relative;' title='"+ obj.fileName + "'" ;
                str +=  "data-path='"+obj.uploadPath +"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>";
                str += "<a href=\"javascript:showImage(\'" + originPath +"\')\">"+
                    "<div class='rounded-circle mx-auto mb-2' style='overflow:hidden; width: 100px; height: 100px;'>"+
                    "<img src='../upload/display?fileName="+fileCallPath+"' style='object-fit:cover; width: 100%; height: 100%;'></div></a>"+
                    "<span class='badge badge-danger position-absolute' style='top: 10px; right: 0px;' data-file='"+fileCallPath+"' data-type='image'> &times; </span>";
                str += "</p>";
                str += "</div>";
                str += "</div>";
				
			}
			uploadResult.append(str);
		});
		
	}
	
	
	//ajax csrf설정
    let csrfHeaderName = "${_csrf.headerName}";
    let csrfTokenValue = "${_csrf.token}";
    
    $(document).ajaxSend(function(e,xhr,options){
    	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);	
    });
	
	//첨부 파일 삭제 이벤트 처리
	$(".uploadResult").on("click", "span", function(e){
		
		console.log("delete file");
	      
	    let targetFile = $(this).data("file");
		let type = $(this).data("type");
		
		let targetLi = $(this).closest(".card");
		let uuid = targetLi.find("p").data("uuid"); // 수정된 부분
		
		$.ajax({			
			url : '../upload/deleteFileimage',
		    data: {uuid: uuid,fileName: targetFile, type: type},
		    dataType:'text',
		    type: 'POST',
		    //beforeSend추가 부분이나 ajaxSend메서드 사용
		    success: function(result){
		    	updateDefaultImage(); // 기본 이미지 업데이트 함수 호출
		    	targetLi.remove();
		    }
		});
	});
	
	
	(function(){
		let userid = '<c:out value="${currentMember.userid}"/>';
		$.getJSON("getProfileList",{userid: userid},function(arr){
			console.log(arr); //arr은 컨틀로라에서 반환하는 json으로 된 List<MemberProfileDTO>객체
			let str = "";
			let hasImage = false; // 이미지 여부를 확인하는 변수
			
			$(arr).each(function(i, obj){
				if(obj.fileType === true) {
					console.log(obj.fileType);
					let fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName); //섬네일
					
					let originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName; //원본파일 경로
					originPath = originPath.replace(new RegExp(/\\/g),"/"); //\\를 /로 대체 
					
					
					str += "<div class='card justify-content-center border-0'>";
	                str += "<div class='card-body'>";
	                str += "<p class='mx-auto' style='width:90%; position: relative;' title='"+ obj.fileName + "'" ;
	                str +=  "data-path='"+obj.uploadPath +"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>";
	                str += "<a href=\"javascript:showImage(\'" + originPath +"\')\">"+
	                    "<div class='rounded-circle mx-auto mb-2' style='overflow:hidden; width: 100px; height: 100px;'>"+
	                    "<img src='../upload/display?fileName="+fileCallPath+"' style='object-fit:cover; width: 100%; height: 100%;'></div></a>"+
	                    "<span class='badge badge-danger position-absolute' style='top: 10px; right: 0px;' data-file='"+fileCallPath+"' data-type='image'> &times; </span>";
	                str += "</p>";
	                str += "</div>";
	                str += "</div>";
	                
	                hasImage = true; // 이미지가 하나 이상 있는 경우 true로 설정
				}
			});
			
			// 이미지가 없을 경우 기본 이미지를 표시하는 코드 추가
	        if (!hasImage) {
	            str += "<div class='card justify-content-center border-0'>";
	            str += "<div class='card-body'>";
	            str += "<p class='mx-auto' style='width:90%; position: relative;' title='Default Image'>";
	            str += "<div class='rounded-circle mx-auto mb-2' style='overflow:hidden; width: 100px; height: 100px;'>";
	            str += "<img src='../resources/images/default-image.png' style='object-fit:cover; width: 100%; height: 100%;'></div>";
	            str += "</p>";
	            str += "</div>";
	            str += "</div>";
	        }
			
			$(".uploadResult #cardRow").html(str);
		});
	})();
	
	
	function updateDefaultImage() {
	    let defaultImage = "<div class='card justify-content-center border-0'>";
	    defaultImage += "<div class='card-body'>";
	    defaultImage += "<p class='mx-auto' style='width:90%; position: relative;' title='Default Image'>";
	    defaultImage += "<div class='rounded-circle mx-auto mb-2' style='overflow:hidden; width: 100px; height: 100px;'>";
	    defaultImage += "<img src='../resources/images/default-image.png' style='object-fit:cover; width: 100%; height: 100%;'></div>";
	    defaultImage += "</p>";
	    defaultImage += "</div>";
	    defaultImage += "</div>";
	    
	    $(".uploadResult #cardRow").prepend(defaultImage);
	}
	
	
});
</script>


<script>
$(function() {
    let pwCheck = false;
    let pwckCheck = false;
    let pwckcorCheck = false;

    function validatePassword() {
        let pw = $('#uPw').val();
        let pwck = $('#uPwChk').val();
        
        if (pwck === "") {
            $('.final_pwck_ck').css('display', 'none');
            $('.pwck_input_re_1').css('display', 'none');
            $('.pwck_input_re_2').css('display', 'none');
        } else {
            $('.final_pwck_ck').css('display', 'none');
            if (pw === pwck) {
                $('.pwck_input_re_1').css('display', 'block');
                $('.pwck_input_re_2').css('display', 'none');
                pwckcorCheck = true;
            } else {
                $('.pwck_input_re_1').css('display', 'none');
                $('.pwck_input_re_2').css('display', 'block');
                pwckcorCheck = false;
            }
        }
    }

    $('#uPw').on("input", function() {
        pwCheck = $(this).val() !== "";
        validatePassword();
        checkFormValidity(); // 폼 유효성 검사
    });

    $('#uPwChk').on("input", function() {
        pwckCheck = $(this).val() !== "";
        validatePassword();
        checkFormValidity(); // 폼 유효성 검사
    });

    function checkFormValidity() {
        let isFormValid = pwCheck && pwckCheck && pwckcorCheck;
        $("#modifyBtn").prop("disabled", !isFormValid);
    }

    $("#modifyBtn").click(function(e) {
        e.preventDefault();
        
        if (!pwCheck || !pwckCheck || !pwckcorCheck) {
            alert("비밀번호를 입력해 주세요.");
            return;
        }
        
        $.ajax({
            url: "../member/modify",
            type: "POST",
            data: $("#frm1").serialize(),
            dataType: 'text',
            success: function(response) {
                if (response === "fail") {
                    alert("현재 비밀번호가 일치하지 않습니다.");
                } else {
                    $("#uName").val(response);
                    alert("회원 정보가 변경되었습니다. 다시 로그인 해주세요.");
                    window.location.href = "../member/logout";
                }
            },
            error: function() {
                alert("회원 정보 수정에 실패했습니다.");
            }
        });
    });
});
</script>




</body>
</html>