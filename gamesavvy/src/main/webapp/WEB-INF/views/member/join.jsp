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

<div id="main">
	<div id="content">
		<div class="form">
			<h5 class="main_title">회원가입</h5>
			<p class="sub">
				<span style="color: red">*</span> 필수입력사항
			</p>
			
			<form action="../member/join" method="post" id="frm1" name="frm1">
				<!-- 회원 가입시 csrf 토큰 값 히든으로 보내주기 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<div class="form-group">
					<div class="row mb-3" id="font_size">
						<label for="uId" class="col-sm-2 col-form-label" id="fst" style="padding-top:29px;">아이디<span style="color: red">*</span></label>
					
						<div class="col-sm-6" id="sst" style="padding-top:19px;">
							<input type="text" class="form-control" name="userid" placeholder="아이디 입력" 	id="uId" required/>
							<button type="button" id="id_chk" class="btn btn-outline">아이디중복체크</button>
						 	<input	type="hidden" name="reid">
						</div>
					</div>	
				</div>
				<div class="form-group">
					<div class="row mb-3" id="font_size">
						<label for="uPw"class="col-sm-2 col-form-label" id="fst">비밀번호<span style="color: red">*</span></label>
						
						<div class="col-sm-6" id="sst">
							<input type="password" class="form-control" name="userpw" id="uPw"	placeholder="비밀번호 입력" required/>
							<span class="final_pw_ck"></span>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="row" id="font_size">
						<label for="uPwchk" class="col-sm-2 col-form-label" id="fst">비밀번호확인<span style="color: red">*</span></label>
						
						<div class="col-sm-6" id="sst">
							<input type="password" class="form-control" name="userpwChk" id="uPwChk"	placeholder="비밀번호확인입력" required/>
						</div>
					</div>
					<span class="final_pwck_ck"></span>
					<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
					<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
				</div>
				<div class="form-group">
					<div class="row mb-3" id="font_size">
						<label for="uName" class="col-sm-2 col-form-label" id="fst">닉네임<span style="color: red">*</span></label>
						
						<div class="col-sm-6" id="sst">
							<input type="text" class="form-control" name="username" id="uName" placeholder="닉네임" required/>
						</div>
					</div>				
				</div>
				
				<div class="form-group">
					<div class="row mb-3 address_search" id="font_size" style="padding-bottom: 40px;">
						<label for="address" class="col-sm-2 col-form-label" id="fst">주소<span
							style="color: red">*</span></label>
						<!-- 주소 검색 버튼 추가 -->
						<button type="button" id="address" class="btn btn-outline" onclick="toggleAddressInput()">
							<span id="addressNo">주소 검색</span>
						</button>
						<div class="address-inputs">
							<input type="text" class="form-control memAdd" id="memAdd1" name="address" readonly placeholder="우편번호">
							<input type="button" class="btn btn-outline daumButton" onclick="DaumPostcode()" value="재검색">
							<input type="text" class="form-control memAdd" id="memAdd2" name="address" readonly placeholder="주소">
							<input type="text" class="form-control memAdd" id="memAdd3" name="address" placeholder="상세주소" required>
						</div>
					</div>
				</div>
				
				<div class="boder_btom"></div>
				
				<div id="formSubmit" class="form_footer">
					<button type="submit" class="btn btn-success">회원가입</button>&nbsp;&nbsp;
					<button type="button" class="btn btn-danger" id="homeBtn">홈으로</button>&nbsp;&nbsp;
				</div>
			</form>
		</div>
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

<!-- 다음api -->
<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
<script>
	function DaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				let fullAddr = ''; // 최종 주소 변수
				let extraAddr = ''; // 조합형 주소 변수

				// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					fullAddr = data.roadAddress;

				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					fullAddr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
				if (data.userSelectedType === 'R') {
					//법정동명이 있을 경우 추가한다.
					if (data.bname !== '') {
						extraAddr += data.bname;
					}
					// 건물명이 있을 경우 추가한다.
					if (data.buildingName !== '') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
					fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')'
							: '');
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('memAdd1').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('memAdd2').value = fullAddr;

				// 커서를 상세주소 필드로 이동한다.
				document.getElementById('memAdd3').focus();
			}
		}).open();
	};
</script>
<script>
	function toggleAddressInput() {

		new daum.Postcode({
			oncomplete : function(data) {
				// 검색 결과로 받은 데이터를 해당 필드에 입력합니다.
				document.getElementById('memAdd1').value = data.zonecode; // 우편번호
				document.getElementById('memAdd2').value = data.address; // 주소
				document.getElementById('memAdd3').value = ''; // Reset 상세주소 필드

				// Daum 우편번호 검색 API의 메소드인 'DaumPostcode()'를 호출하여 우편번호 검색 모달을 띄웁니다.
				let addressInputs = document
						.querySelector('.address-inputs');
				addressInputs.style.display = 'block';

				// Hide the "주소 검색" button
				let addressButton = document.getElementById('address');
				addressButton.style.display = 'none';
			}
		}).open();
	}
</script>	
</body>
</html>