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

.boxbox {
    width: 100%;
    padding: 25px 25px;
    margin-bottom: -20px;
    background-color: rgb(247, 247, 247);
}
.boxUserProfile {
    min-width: 48px;
    height: 100px;
    display: flex;
    -webkit-box-pack: center;
    justify-content: center;
    -webkit-box-align: center;
    align-items: center;
    padding: 0px 5px;
    border-radius: 100%;
    font-weight: normal;
    font-size: 14px;
    text-align: center;
    border: 1px solid rgb(148, 146, 150);
    background-color: rgb(255, 255, 255);
    color: rgb(148, 146, 150);
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
			<h2 class="text-center">회원정보</h2>
			<div class="boxbox">
				<div class="row">
					<div class="col-md-2">
						<div class="boxUserProfile">프로필</div>
					</div> <!-- col-md-6 -->
					<div class="col-md-4">
						<strong class="boxUserName"><sec:authentication property="principal.member.username"/>님</strong>
					</div> <!-- col-md-6 -->
					<div class="col-md-3">
						<strong class="boxUserName">"정원석""님"</strong>
					</div> <!-- col-md-6 -->
					<div class="col-md-3">
						<strong class="boxUserName">"정원석""님"</strong>
					</div> <!-- col-md-6 -->
				</div> <!-- row -->
			</div> <!-- boxbox -->
			
			
			
		</div> <!-- col-md-9 -->
		<%@include file="../include/right.jsp" %>
	</div> <!-- row -->
</div> <!-- maincontent -->
<%@include file="../include/footer.jsp" %>

</body>
</html>