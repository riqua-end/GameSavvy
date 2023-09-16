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
.boxMember {
    display: grid;
    grid-template-columns: 372px auto;
    width: 1050px;
    margin: 0px auto;
    gap: 4px;
}
.boxMember1 {
    padding: 30px;
    grid-row: 1 / 3;
    display: flex;
    flex-direction: column;
    background: rgb(255, 255, 255);
}

.boxMember2 {
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
}

.boxMember3 {
    display: flex;
    flex-direction: column;
    -webkit-box-pack: center;
    justify-content: center;
    min-width: 50%;
    min-height: 48px;
    margin-left: 20px;
}

.boxUserName {
    display: block;
    overflow: hidden;
    font-weight: 500;
    font-size: 20px;
    color: rgb(51, 51, 51);
    line-height: 28px;
    white-space: nowrap;
    text-overflow: ellipsis;
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
			
			<div class="boxMember">
				<div class="boxMember1">
					<div class="boxMember2">
						<div class="boxMember3">
							<strong class="boxUserName">
							"정원석"
							"님"
							</strong>
						</div>
					</div>
				</div>
			</div>
			</div>
			
		</div> <!-- col-md-8 -->
		
		<%@include file="../include/right.jsp" %>
		
	</div> <!-- row -->
</div> <!-- maincontent -->
<%@include file="../include/footer.jsp" %>

</body>
</html>