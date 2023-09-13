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
<!--BS 4 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!--icon -->
<!--fontawesome icon-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" 
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<!--google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="../css/join.css?after"/> <!--수정시 바로 적용을 위해 after추가 -->
</head>
<body>

<div class="wrapper">
	<div class="wrap">
		<form action="../member/join" method="post" id="frm1" name="frm1">
					
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="form-group">
						<label for="uId">아이디</label>
						<input type="email" class="form-control" name="userid" placeholder="E-Mail주소 입력" 	id="uId" required/>
					</div>
					<div class="form-group">						
						 <button type="button" id="id_chk" class="btn btn-outline-primary">아이디중복체크</button>
						 <input	type="hidden" name="reid" size="20">						 
					</div>
					<div class="form-group">
						<label for="uPw">비밀번호</label>
						<input type="password" class="form-control" name="userpw" id="uPw"	placeholder="비밀번호 입력" required/>
						<span class="final_pw_ck"></span>
					</div>
					<div class="form-group">
						<label for="uPwchk">비밀번호확인</label>
						<input type="password" class="form-control" name="userpwChk" id="uPwChk"	placeholder="비밀번호확인입력" required/>
						<span class="final_pwck_ck"></span>
						<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
						<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
					</div>
					<div class="form-group">
						<label for="uName">사용자명</label>
						<input type="text" class="form-control" name="userName" id="uName" placeholder="사용자명" required/>			
					</div>
					<button type="submit" class="btn btn-success">회원가입</button>&nbsp;&nbsp;
					<button type="button" class="btn btn-danger" id="homeBtn">홈으로</button>&nbsp;&nbsp;
				</form>
	</div>
</div>

<script>
let pwCheck = false;            // 비번
let pwckCheck = false;            // 비번 확인
let pwckcorCheck = false;        // 비번 확인 일치 확인

$(function(){
	
	let pw = $('#uPw').val();
	let pwck = $('#uPwChk').val();
	
	if(pw == "") {
		$('.final_pw_ck').css('display','block');
		pwCheck = false;
	}
	else{
		$('.final_pwck_ck').css('display', 'none');
		pwCheck = true;
	}
	
	if(pwck == ""){
		$('.final_pwck_ck').css('display','block');
		pwckCheck = false;
	}
	else {
		$('.final_pwck_ck').css('display','none');
		pwckCheck = true;
	}
	
	$('#uPwChk').on("input",function(e){
		e.preventDefault();
		let pw = $('#uPw').val();
		let pwck = $('#uPwChk').val();
		$('.final_pwck_ck').css('display','none');
		
		if(pw == pwck) {
			$('.pwck_input_re_1').css('display','block');
			$('.pwck_input_re_2').css('display','none');
			pwckcorCheck = true;
		}
		else {
			$('.pwck_input_re_1').css('display','none');
			$('.pwck_input_re_2').css('display','block');
			pwckcorCheck = false;
		}
		
	});
	
	$("#id_chk").click(function(e){
		e.preventDefault();
		
		if(document.frm1.userid.value == "") {
			alert('아이디를 입력하여 주십시오.');
			document.frm1.userid.focus();
			return false;
		}
		
		let userid = document.frm1.userid.value;
		
		$.ajax({
			url : "../member/idChk?userid=" + userid,
			type : "GET",
			success : function(result) {
				if(result == "success"){
					document.frm1.reid.value = userid;
					alert("사용 가능한 아이디 입니다.");
				}
				else {
					document.frm1.userid.focus();
					document.frm1.userid.value = "";
					alert("다른 아이디를 등록하세요");
				}
			}
		});
	});
	
	
	$("#uPwChk").blur(function(){
		if(document.frm1.userpw.value != document.frm1.userpwChk.value) {
			alert("암호가 일치하지 않습니다.");
			document.frm1.userpw.value = "";
			document.frm1.userpwChk.value = "";
			frm1.userpw.focus();
			return false;
		}
	});
	
	
	$("#frm1").submit(function(){
		if(document.frm1.reid.value != document.frm1.userid.value) {
			alert("체크한 아이디를 다시 수정하셨습니다.");
			return false;
		}
		
		return true;
	});
	
	$("#homeBtn").on("click", function(){
		
		self.location = "/";
	});
	
});
</script>
</body>
</html>