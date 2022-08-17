<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>memJoin.jsp</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
  	'use strict';
	  	let idCheckSw=0;
			
  	function fCheck() {
  		let regMid = /^[a-z0-9]{4,16}$/;
      let regPwd = /(?=.*[a-zA-Z])(?=.*[~!@#$%^&*()_+|<>?:{}])(?=.*[0-9]).{8,16}/;
      let regName = /^[가-힣a-zA-Z]+$/;
     	let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
      
      let submitFlag = 0;  
      
      let mid = myForm.mid.value;
      
	  	let name = myForm.name.value;
	    let tel1 = myForm.tel1.value;
	    let tel2 = myForm.tel2.value;
	    let tel3 = myForm.tel3.value;
	    let tel = myForm.tel1.value + "-" + myForm.tel2.value + "-" + myForm.tel3.value;
	  	let pwd = myForm.pwd.value;
	  	let pwd2 = myForm.pwd2.value;
	  	let email1 = myForm.email1.value;
    	let email2 = myForm.email2.value;
      let email = email1 + email2;
	    
			if(!regMid.test(mid)) {
        alert("아이디는 영문 소문자와 숫자만 사용가능합니다.(길이는 4~16자 이내로 입력하세요.)");
        myForm.mid.focus();
        return false;
      }
      else if(!regPwd.test(pwd)) {
    	  alert("비밀번호는 대문자, 소문자, 숫자, 특수문자 조합으로 사용가능합니다.(길이는 8~16자 이내로 입력하세요.)");
        myForm.pwd.focus();
        return false;
      }
      else if(pwd != pwd2) {  
    	  alert("비밀번호를 다시 확인하세요.");
        myForm.pwd.value="";
        myForm.pwd2.value="";
        myForm.pwd.focus();
        return false;
      }
      else if(!regName.test(name)) {
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
	    		if(idCheckSw == 0){
	    			alert("아이디 중복체크 버튼을 눌러주세요.");
	    		}
	    		else{
		  			myForm.email.value = email;
		  			myForm.tel.value = tel;
		  			
		  			myForm.submit();
	    		}
	    	}
	    	else {
	    		alert("회원가입 실패~~");
	    	}
	    }
	    function idCheck() {
    	let mid = $("#mid").val();
    	
    	if(mid == "" || $("#mid").val().length<4 || $("#mid").val().length>16) {
    		alert("아이디를 입력하세요!(아이디는 4~16자 이내로 사용하세요.)");
    		myForm.mid.focus();
    		return false;
    	}
    	
    	$.ajax({
    		type : "post",
    		url : "${ctp}/member/memIdCheck",
    		data : {mid:mid},
    		success : function(res) {
					if(res =="1"){
						alert("이미 사용중인 아이디 입니다.");
						$("#mid").focus();
					}
					else{
						alert("사용 가능한 아이디 입니다.");
						idCheckSw = 1; 
					}
				},
				error : function(){
					alert("전송오류");
				}
    	});
    }
  </script>
  <style>
  	th{
  		font-size:12px;
  		text-align: center;
  		background-color:#fbfafa;
  	}
		.button {
		  border: none;
		  color: white;
		  text-align: center;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 14px;
		  margin: 4px 0px;
		  cursor: pointer;
		  height:40px;
		  width:120px;
		}
		.button1 {border-radius: 2px; background-color:#3cc2b1; width:100px; height:27px; font-size: 12px;}
		.button2 {border-radius: 2px; background-color:#0a253e;}
		.button3 {border-radius: 2px; background-color:#4a5164;}
  </style>
</head>
<body >  
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
<div class="container" style="width:1000px; margin:auto">
	<form name="myForm" method="post" class="was-validated">
	<br/><br/>
    <h4><b>회원가입</b></h4>
    <br/>
    <table class="table table-bordered"  >
    	<colgroup>
    		<col style="width:150px;">
    		<col>
    	</colgroup>
    	<tr>
    		<th style="vertical-align: middle;">아이디</th>
    		<td>
	    		<div class="col-sm-3" style="padding:4px 0px">
	    			<input type="text" name="mid" id="mid" required autofocus style="width:200px;"/>
					</div>
					<div class="col-sm-9" style="padding:1px 8px">
						(영문소문자/숫자, 4~16자)&nbsp;&nbsp;<input type="button" value="아이디 중복체크" class="button button1"  onclick="idCheck()" />	    		
	    		</div>
    		</td>
    	</tr>
    	<tr>
    		<th style="vertical-align: middle;">비밀번호</th>
    		<td>
    			<div class="col-sm-3" style="padding:4px 0px">
    				<input type="password" id="pwd" name="pwd" style="width:200px;"/> 
    			</div>
    			<div class="col-sm-9"style="padding:8px">
    				(영문 대/소문자/숫자/특수문자 중 3가지 이상 조합, 8자~16자)
    			</div>
    		</td>
    	</tr>
    	<tr>
    		<th style="vertical-align: middle;">비밀번호 확인</th>
    		<td>
    			<input type="password" id="pwd2" name="pwd2" required style="width:200px;"/>
    		</td>
    	</tr>
    	<tr>
    		<th style="vertical-align: middle;">이름</th>
    		<td>
    			<input type="text" id="name" name="name" required style="width:200px;"/>
    		</td>
    	</tr>
    	<tr>
    		<th style="vertical-align: middle;">휴대전화</th>
    		<td>
		    	<select name="tel1" style="width:60px; height:26px;">
				  	<option value="010" selected>010</option>
				  	<option value="011">011</option>
				  	<option value="016">016</option>
				  	<option value="017">017</option>
				  	<option value="018">018</option>
			   		<option value="019">019</option>
			  	</select>  
     			&nbsp;-&nbsp;&nbsp;<input type="text" name="tel2" size=4 maxlength=4 style="width:100px;"/>
      		&nbsp;-&nbsp;&nbsp;<input type="text" name="tel3" size=4 maxlength=4  style="width:100px;"/>
    		</td>
    	</tr>
    	<tr>
    		<th style="vertical-align: middle;">이메일</th>
    		<td>
    			<input type="text" id="email1" name="email1" style="width:150px;"/>&nbsp;@
		    	 <select name="email2" style="width:200px; height:26px;">
					 	<option value="" selected>직접입력</option>
					 	<option value="@naver.com" >naver.com</option>
				    <option value="daum">daum.net</option>
				    <option value="@hanmail.net">hanmail.net</option>
				    <option value="@hotmail.com">hotmail.com</option>
				    <option value="@gmail.com">gmail.com</option>
				    <option value="@nate.com">nate.com</option>
				    <option value="@yahoo.com">yahoo.com</option>
				  </select>
    		</td>
    	</tr>
    	<tr>
    		<th style="vertical-align: middle;">주소</th>
    		<td>
    			<div class="input-group mb-1">
						<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" style="width:100px; height:26px;">&nbsp;
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호" class="button button1">
					</div>
					<div style="padding:3px 0px">
						<input type="text" name="roadAddress" id="sample6_address" size="100" placeholder="주소">
					</div>
					<div class="input-group" style="padding:3px 0px">
						<input type="text" name="detailAddress" id="sample6_detailAddress" size="73" placeholder="상세주소"> &nbsp;
						<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목">
					</div>
    		</td>
    	</tr>
    </table>
    <div class="text-center">
	    <button type="button" class="button button2" onclick="fCheck()">회원가입</button> &nbsp;
	    <button type="button" class="button button3" onclick="location.href='${ctp}/';">돌아가기</button>
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