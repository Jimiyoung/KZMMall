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
		function idSearch() {
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
				myForm.submit();
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
<p><br/></p>
<div class="container text-center" style="width:50%">
	<div class="text-center" style="width:600px; height:420px; border:1px solid #d7d5d5;">
		<div class="text-left" style="margin-left:40px; margin-top:30px;">
  		<h1><b>Forgot ID</b></h1>
		</div>
		<form name="myForm" method="post" class="was-validated">
    <br/>
    <div>
    	<div class="col-sm-1"></div>
    	<div class="col-sm-10 p-0">
    		<div >
					<div class="text-left" style="font-size:1em; font-weight: bold; color:#555555">▸ 이름</div>
					<input type="text" id="name" name="name" style="width:480px; height:35px">
				</div>
				<br/>
				<div>	    
					<div class="text-left" style="font-size:1em; font-weight: bold; color:#555555">▸ 이메일</div>
					<input type="text" id="email" name="email" style="width:480px; height:35px">
				</div>
			</div>
			<div class="col-sm-1"></div>
		</div>	
		<div class="m-9">
			<input type="button" value="확인" onclick="idSearch()" class="btn btn-dark btn1"/>
		</div>
  </form>
		</div>
		<br/>
	  </div>  
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>