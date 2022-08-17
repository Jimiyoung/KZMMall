<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memIdFind.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	'use strict';
		function idEmailSearch() {
			let name = $("#name").val();
			let email = $("#email").val();
			
			if(name==""){
				alert("이름을 입력하세요.");
				$("#name").focus();
				return false;
			}
			else if(email==""){
				alert("이메일을 입력하세요.");
				$("#email").focus();
				return false;
			}
			else{
				emailForm.submit();
			}
		}
		
		function idTelSearch() {
			let name = $("#nameT").val();
			let tel = $("#tel").val();
			
			if(name==""){
				alert("이름을 입력하세요.");
				$("#nameT").focus();
				return false;
			}
			else if(tel==""){
				alert("휴대폰 번호를 입력하세요.");
				$("#tel").focus();
				return false;
			}
			else{
				telForm.submit();
			}
		}
		
  </script>
  <style>
		.btn1 {padding: 7px 225px;}
	</style>
</head>
<body>  
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:70%">
<div class="w3-main p-5">
	<div class="text-center" style="width:600px; height:420px; margin:auto; border:1px solid #d7d5d5;">
		<div class="text-left" style="margin-left:40px; margin-top:30px;">
  		<h1><b>Forgot ID</b></h1>
		</div>
		<div class="text-center" style="width:580px; padding:20px">
			<ul class="nav nav-tabs">
		    <li class="active"><a data-toggle="tab" href="#emailF">이메일</a></li>
		    <li><a data-toggle="tab" href="#telF">휴대폰번호</a></li>
	 	 </ul>
		 <div class="tab-content">
	    <div id="emailF" class="tab-pane fade in active">
	  		<form name="emailForm" method="post" class="was-validated" action="${ctp}/member/memIdEmailFindOk">
		      <div style="margin:20px">
						<div class="text-left" style="font-size:1em; font-weight: bold; color:#555555">▸ 이름</div>
						<input type="text" id="name" name="name" style="width:480px; height:35px">
					</div>
					<div style="margin:20px">	    
						<div class="text-left" style="font-size:1em; font-weight: bold; color:#555555">▸ 이메일</div>
						<input type="text" id="email" name="email" style="width:480px; height:35px; ">
					</div>
			    <div class="margin:20px">
						<input type="button" value="확인" onclick="idEmailSearch()" class="btn btn-dark btn1"/>
					</div>
	    	</form>
	    </div>
	    <div id="telF" class="tab-pane fade">
	    	<form name="telForm" method="post" class="was-validated" action="${ctp}/member/memIdTelFindOk">
		      <div style="margin:20px">
						<div class="text-left" style="font-size:1em; font-weight: bold; color:#555555">▸ 이름</div>
						<input type="text" id="nameT" name="nameT" style="width:480px; height:35px">
					</div>
					<div style="margin:20px">	    
						<div class="text-left" style="font-size:1em; font-weight: bold; color:#555555">▸ 휴대폰 번호 (***-****-**** 형식으로 입력하세요.)</div>
						<input type="text" id="tel" name="tel" style="width:480px; height:35px; ">
					</div>
			    <div class="margin:20px">
						<input type="button" value="확인" onclick="idTelSearch()" class="btn btn-dark btn1"/>
					</div>
	    	</form>
	    </div>
	  </div>
  </div>
  </div>
</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>