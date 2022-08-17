<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>asPwdCheck.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	'use strict';
		function fCheck() {
			let name = myForm.name.value;
			let pwd = myForm.pwd.value;
			
			if(name.trim()==""){
				alert("이름을 입력하세요.");
				document.getElementById("name").focus();
			}
			else if(pwd.trim()==""){
				alert("비밀번호를 입력하세요.");
				document.getElementById("pwd").focus();
			}
			else{
				myForm.submit();
			}
		}
  </script>
  <style>
  	.button {
			  border: none;
			  color: white;
			  text-align: center;
			  text-decoration: none;
			  display: inline-block;
			  font-size: 14px;
			  font-weight:bold;
			  margin: 0px 0px;
			  cursor: pointer;
			  height:35px;
			  width:110px;
				}
		.button1{
				background-color:#3cc2b1;
			}		
		.button2{
				background-color:#cccccc;
			}		
	</style>
</head>
<body>  
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:70%">
<div class="w3-main p-5">
	<div class="text-center" style="width:800px; height:420px; border:1px solid #d7d5d5; margin:auto">
		<div class="text-center" style="margin-top:30px;">
  		<div style="font-size:25px; font-weight:bold; margin:80px 50px 40px 50px" >비밀글 기능으로 보호된 글입니다.</div>
  		<div style="font-size:15px">작성자와 관리자만 열람하실 수 있습니다. 본인이라면 비밀번호를 입력하세요.</div>
		</div>
		<form name="myForm" method="post" class="was-validated">
			<div class="row" style="margin:20px">
	 			<div class="col-sm-4 text-right" style="font-weight:bold; font-size:16px; padding:7px 14px">이름</div>
				<div class="col-sm-4 p-0" ><input type="text" id="name" name="name" style="width:250px; height:35px;"></div>
				<div class="col-sm-4"></div>
	 		</div>
			<div class="row" style="margin:20px">
	 			<div class="col-sm-4 text-right" style="font-weight:bold; font-size:16px; padding:7px 14px">비밀번호</div>
				<div class="col-sm-4 p-0" ><input type="password" id="pwd" name="pwd" style="width:250px; height:35px;"></div>
				<div class="col-sm-4"></div>
	 		</div>
	 		<div class="row">
	 			<div class="col-sm-6 text-right p-2"><input type="button" value="확인" onclick="fCheck()" class="button button1"/></div>
	 		  <div class="col-sm-6 text-left p-2"><input type="button" value="돌아가기" onclick="location.href='${ctp}/as/asList';" class="button button2"/></div>
	 		</div>
 		</form>
 		<input type="hidden" name="idx" value="${idx}"/>
		<input type="hidden" name="pag" value="${pag}"/>
		<input type="hidden" name="pageSize" value="${pageSize}"/>
  </div>
</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>