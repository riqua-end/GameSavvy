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
.footer {
   position: fixed;
   right: 0;
   left: 0;
   bottom: 0;
   width: 100%;
}
small {
   text-align: left;
   display: inline-block; /* 이 부분을 추가합니다. */
   margin-left: 20px; /* 왼쪽 여백을 조절할 수 있습니다. */
}
</style>
<!-- RWD -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- MS -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8,IE=EmulateIE9"/> 
</head>
<body>

<div class="footer container">
	<hr></hr>
	<div class="row">
		<div class="col-md-5">
			<small>(주)플레이엑스피  대표:윤석재  사업자등록번호: 406-86-00726</small>
			<p><small>© PlayXP Inc. All Rights Reserved.</small></p>
		</div>
		<div class="col-md-7">
			<a href="#"><small>이용약관</small></a>
  			<a href="#"><small>개인정보취급방침</small></a>
  			<a href="#"><small>책임의한계와법적고지</small></a>
  			<a href="#"><small>블럭자명단</small></a>
  			<a href="#"><small>신고</small></a>
		</div>
	</div>
</div>

</body>
</html>