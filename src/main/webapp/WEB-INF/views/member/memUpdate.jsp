<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>memUpdate.jsp</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
  	'use strict';
			
  	function fCheck() {
      let regName = /^[가-힣a-zA-Z]+$/;
     	let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
      
      let submitFlag = 0; 
      
	  	let name = myForm.name.value;
	    let tel1 = myForm.tel1.value;
	    let tel2 = myForm.tel2.value;
	    let tel3 = myForm.tel3.value;
	    let tel = myForm.tel1.value + "-" + myForm.tel2.value + "-" + myForm.tel3.value;
	  	let email1 = myForm.email1.value;
    	let email2 = myForm.email2.value;
      let email = email1 + email2;
	    
			if(!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        myForm.name.focus();
        return false;
      }
      else if(!regEmail.test(email)) {
        alert("이메일 형식에 맞지않습니다.");
        myForm.email1.focus();
        return false;
      }
      else if(tel2 != "" || tel3 != "") {
	      if(!regTel.test(tel)) {
	        alert("전화번호 형식에 맞지않습니다.(000-0000-0000)");
	        myForm.tel2.focus();
	        return false;
	      }
	      else {
	    	  submitFlag = 1;
	      }
      }
	    let postcode = myForm.postcode.value + " ";
			let roadAddress = myForm.roadAddress.value + " ";
			let detailAddress = myForm.detailAddress.value + " ";
			let extraAddress = myForm.extraAddress.value + " ";
			myForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress+ "/";
    	if(submitFlag == 1) {
  			myForm.email.value = email;
  			myForm.tel.value = tel;
  			
  			myForm.submit();
    	}
    	else {
    		alert("회원정보수정 실패~~");
    	}
    }
 		
 		function delCheck() {
			let ans = confirm("정말 탈퇴하시겠습니까?")
			if(!ans) return false;
			else location.href="${ctp}/member/memDeleteOk";
		}
  </script>
  <style>
			.button {
			  border: none;
			  color: white;
			  text-align: center;
			  text-decoration: none;
			  display: inline-block;
			  font-size: 12px;
			  margin: 4px 2px;
			  cursor: pointer;
			  height:50px;
			  width:110px;
			}
			.button1 {border-radius:2px; background-color:#4a5164; width:100px; height:27px; font-size: 12px;}
			.button2 {border-radius:2px; background-color:#3cc2b1;}
			.button3 {border-radius:2px; background-color:#0a253e;}
			th{
				text-align:center;
				font-size:0.8em;
				background-color:#fbfafa;
			}
  </style>
</head>
<body>  
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<br/>
<div class="container" style="width:1000px; margin:auto">
<div class="w3-main p-5">
	<form name="myForm" method="post" action="${ctp}/member/memUpdateOk" class="was-validated">
    <h4><b>회원정보수정</b></h4>
    <br/>
    <table class="table table-bordered">
    	<colgroup>
    		<col style="width:150px;">
    		<col style="width:auto;">
    	</colgroup>
    	<tr>
    		<th style="vertical-align: middle;">아이디</th>
    		<td>
    			<input type="text" name="mid" id="mid" value="${vo.mid}" readonly style="width:200px;"/>
    		</td>
    	</tr>
    	<tr>
    		<th style="vertical-align: middle;">비밀번호</th>
    		<td>
    			<input type="password" value="${sPwd}" id="pwd" name="pwd" readonly style="width:200px"/> (영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자)
    		</td>
    	</tr>
    	<tr>
    		<th style="vertical-align: middle;">이름<font color="blue"> *</font></th>
    		<td>
    			<input type="text" id="name"  name="name" value="${vo.name}" required style="width:200px"/>
    		</td>
    	</tr>
    	<tr>
    		<th style="vertical-align: middle;">휴대전화<font color="blue"> *</font></th>
    		<td>
    			<c:set var="tel" value="${fn:split(vo.tel,'-')}"/>
    			<c:set var="tel1" value="${tel[0]}"/>
    			<c:set var="tel2" value="${tel[1]}"/>
    			<c:set var="tel3" value="${tel[2]}"/>
		    	<select name="tel1" style="width:60px; height:26px;">
				  	<option value="010" ${tel1=="010" ? selected : ""}>010</option>
				  	<option value="011" ${tel1=="011" ? selected : ""}>011</option>
				  	<option value="016" ${tel1=="016" ? selected : ""}>016</option>
				  	<option value="017" ${tel1=="017" ? selected : ""}>017</option>
				  	<option value="018" ${tel1=="018" ? selected : ""}>018</option>
				  	<option value="019" ${tel1=="019" ? selected : ""}>019</option>
			  	</select> 
			  	&nbsp;-&nbsp;&nbsp;<input type="text" name="tel2" value="${tel2}" size=4 maxlength=4 style="width:100px;"/>
      		&nbsp;-&nbsp;&nbsp;<input type="text" name="tel3" value="${tel3}" size=4 maxlength=4 style="width:100px;"/>
    		</td>
    	</tr>
    	<tr>
    		<th style="vertical-align: middle;">이메일<font color="blue"> *</font></th>
    		<td>
    			<c:set var="email" value="${fn:split(vo.email,'@')}"/>
    			<c:set var="email1" value="${email[0]}"/>
    			<c:set var="email2" value="${email[1]}"/>
    			<input type="text" value="${email1}" id="email1" name="email1" required style="width:150px"/>&nbsp;@
		    	 <select name="email2" style="width:200px; height:26px;">
					 	<option value="" >직접입력</option>
					 	<option value="@naver.com" <c:if test="${email2=='naver.com'}">selected</c:if>>naver.com</option>
					 	<option value="@daum.net" <c:if test="${email2=='daum.net'}">selected</c:if>>daum.net</option>
					 	<option value="@hanmail.net" <c:if test="${email2=='hanmail.net'}">selected</c:if>>hanmail.net</option>
					 	<option value="@hotmail.com" <c:if test="${email2=='hotmail.com'}">selected</c:if>>hotmail.com</option>
					 	<option value="@gmail.com" <c:if test="${email2=='gmail.com'}">selected</c:if>>gmail.com</option>
					 	<option value="@nate.com" <c:if test="${email2=='nate.com'}">selected</c:if>>nate.com</option>
					 	<option value="@yahoo.com" <c:if test="${email2=='yahoo.com'}">selected</c:if>>yahoo.com</option>
				  </select>
    		</td>
    	</tr>
    	<tr>
    		<th style="vertical-align: middle;">주소<font color="blue"> *</font></th>
    		<td>
					<c:set var="address" value="${fn:split(vo.address,'/')}"/>
					<c:set var="postcode" value="${address[0]}"/>
					<c:set var="roadAddress" value="${address[1]}"/>
					<c:set var="detailAddress" value="${address[2]}"/>
					<c:set var="extraAddress" value="${address[3]}"/>
    			<div class="input-group mb-1">
						<input type="text" name="postcode" id="sample6_postcode" value="${postcode}" style="width:100px; height:26px;">&nbsp;
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="button button1">
					</div>
					<div style="padding:3px 0px">
						<input type="text" name="roadAddress" id="sample6_address" value="${roadAddress}"size="100">
					</div>
					<div class="input-group" style="padding:3px 0px">
						<input type="text" name="detailAddress" id="sample6_detailAddress" size="73" value="${detailAddress}">&nbsp;&nbsp;
						<input type="text" name="extraAddress" id="sample6_extraAddress" value="${extraAddress}">
					</div>
    		</td>
    	</tr>
    </table>
    <div class="text-right"><button type="button" class="btn btn-default btn-sm" onclick="delCheck()">회원탈퇴</button></div>
    <div class="text-center">
	    <button type="button" class="button button3" onclick="fCheck()">회원정보수정</button> &nbsp;
	    <button type="button" class="button button2" onclick="location.href='${ctp}/';">취소</button> &nbsp;
	    <input type="hidden" name="email"/>
	    <input type="hidden" name="tel"/>
	    <input type="hidden" name="address" id="address">
    </div>
  </form>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>