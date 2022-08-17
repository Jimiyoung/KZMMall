<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>memPwdChange.jsp</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	'use strict';
  	function fCheck() {
  		let regPwd = /(?=.*[a-zA-Z])(?=.*[~!@#$%^&*()_+|<>?:{}])(?=.*[0-9]).{8,16}/;
  		
  		let pwd = document.getElementById("pwd").value;
  		let newPwd = document.getElementById("newPwd").value;
  		let newPwd2 = document.getElementById("newPwd2").value;
  		
  		if(pwd.trim()==""){
  			alert("현재 비밀번호를 입력해 주세요");
  			document.getElementById("pwd").focus();
  		}
  		else if(newPwd.trim()==""){
  			alert("새 비밀번호를 입력해 주세요.");
  			document.getElementById("newPwd").focus();
  		}
  		else if(newPwd2.trim()==""){
  			alert("새 비밀번호 확인을 입력해 주세요.");
  			document.getElementById("newPwd2").focus();
  		}
  		else if(newPwd != newPwd2){
  			alert("새 비밀번호 확인이 정확하지 않습니다. 다시 입력해주세요.");
  			document.getElementById("newPwd").focus();
  		}
  		else if(pwd == newPwd){
  			alert("새 비밀번호가 현재 비밀번호와 동일합니다. 다시 입력해주세요.");
  			document.getElementById("newPwd").focus();
  		}
  		else if(!regPwd.test(newPwd)){
  			alert("비밀번호는 영문 대/소문자/숫자/특수문자 중 <br/>3가지 이상 조합, 8자~16자로 입력하세요.")
  			document.getElementById("newPwd").focus();
  		}
  		else{
  			myForm.submit();
  		}
  	}
  </script>
</head>
<body >  
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:65%">
<div class="w3-main p-5">
  <h4><b>비밀번호 변경</b></h4>
	<form name="myForm" method="post" class="was-validated">
    <br/>
    <div class="text-center" style="width:1000px; height:500px; border:1px solid #d7d5d5;"><br/>
    	<p class="mt-5" style="font-size:1.3em; font-weight: bold; color:#404040;">비밀번호 변경</p>
				<div style="font-size:0.8em;">
					 회원님의 개인정보를 안전하게 보호하고,<br/>
					 개인정보 도용으로 인한 피해를 예방하기 위해<br/>
					 주기적으로 비밀번호 변경을 권장하고 있습니다.
				</div>    	
				<div class="row">
				 	<div class="col-sm-4"></div>
					<div class="col-sm-4">
				 		<hr/>
				 		<div class="row">
				 			<div class="col-sm-4 text-left p-2" style="font-size:0.8em;">아이디</div>
							<div class="col-sm-8 text-left p-1" style="font-size:0.8em;">${mid}</div>
				 		</div>
				 		<div class="row">
				 			<div class="col-sm-4 text-left p-2" style="font-size:0.8em;">현재 비밀번호</div>
							<div class="col-sm-8 p-1 m-0 text-left" ><input type="password" id="pwd" name="pwd" ></div>
				 		</div>
				 		<div class="row">
				 			<div class="col-sm-4 text-left p-2" style="font-size:0.8em;">새 비밀번호</div>
							<div class="col-sm-8 p-1 m-0 text-left" ><input type="password" id="newPwd" name="newPwd"><p style="font-size:0.8em;">(영문 대/소문자/숫자/특수문자 중 <br/>3가지 이상 조합, 8자~16자)</p></div>
				 		</div>
				 		<div class="row">
				 			<div class="col-sm-4 text-left p-1" style="font-size:0.8em;">새 비밀번호 확인</div>
							<div class="col-sm-8 p-1 text-left"><input type="password" id="newPwd2" name="newPwd2"></div>
				 		</div>
				 	</div>
					<div class="col-sm-4"/></div>
				</div>
				<div class="m-4">
					<input type="button" value="비밀번호 변경하기" onclick="fCheck()" class="btn btn-secondary btn-sm"/> &nbsp;
					<input type="reset" value="다음에 변경하기" class="btn btn-default btn-sm"/> &nbsp;
				</div>
    </div>
  </form>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>