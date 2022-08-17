<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>asUpdate.jsp</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
  	'use strict';
    function fCheck() {
    	let tel=myForm.tel.value;
    	let email=myForm.email.value;
    	let productName=myForm.productName.value;
    	let place=myForm.place.value;
    	let purchaseDate=myForm.purchaseDate.value;
    	let title=myForm.title.value;
    	let content=myForm.content.value;
    	let open=myForm.open.value;
    	
    if(tel.trim() == "") {
    		alert("연락처를 입력하세요");
    		myForm.tel.focus();
    		return false;
    	}
    	else if(email.trim() == "") {
    		alert("이메일을 입력하세요");
    		myForm.email.focus();
    		return false;
    	}
    	else if(productName.trim() == "") {
    		alert("제품명을 입력하세요");
    		myForm.productName.focus();
    		return false;
    	}
    	else if(place.trim() == "") {
    		alert("구입처를 입력하세요");
    		myForm.place.focus();
    		return false;
    	}
    	else if(title.trim() == "") {
    		alert("제목을 입력하세요");
    		myForm.title.focus();
    		return false;
    	}
    	else {
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
			  margin: 4px 0px;
			  cursor: pointer;
			  height:40px;
			  width:120px;
			}
			.button1 {border-radius: 2px; background-color:#4a5164;}
			.button2 {border-radius: 2px; background-color:#3cc2b1;}
			.button3 {border-radius: 2px; background-color:#0a253e;}
  </style>
</head>
<body>  
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:70%">
<div class="w3-main p-5">
  <h4><b>A/S문의 수정</b></h4>
  <br/>
  <form name="myForm" method="post">
	  <table class="table" style="background-color:#f8f8f8; ">
	  	<colgroup>
	  		<col style="width:133px">
	  		<col style="width:447px">
	  		<col style="width:133px">
	  		<col style="width:447px">
	  	</colgroup>
	  	<tr>
	  		<th></th><td colspan="3"></td>
	  	</tr>
	    <tr style="border-style:hidden">
	      <th>이름</th>
	      <td><input type="text" name="name" id="name" value="${vo.name}" style="width:350px;" class="form-control" readonly/></td>
	      <th>비밀번호</th>
	      <td><input type="password" name="pwd" id="pwd" value="${vo.pwd}" style="width:350px;" class="form-control" readonly/></td>
	    </tr>
	    <tr style="border-style:hidden">
	      <th>연락처</th>
	      <td><input type="text" name="tel" id="tel" value="${vo.tel}" style="width:350px;" class="form-control" placeholder=" '-'없이 입력하세요." required/></td>
	      <th>이메일</th>
	      <td><input type="text" name="email" id="email" value="${vo.email}" style="width:350px;" class="form-control" required /></td>
	    </tr>
	    <tr style="border-style:hidden">
	      <th>제품이름</th>
	      <td><input type="text" name="productName" id="productName" value="${vo.productName}" style="width:350px;" class="form-control" required/></td>
	      <th>구입처</th>
	      <td><input type="text" name="place" id="place" value="${vo.place}" style="width:350px;" class="form-control" placeholder=" ex) 11번가, G마켓, 쿠팡, 매장"  required /></td>
	    </tr>
	    <tr style="border-style:hidden">
	      <th>구입날짜</th>
	      <td colspan="3"><input type="date" name="purchaseDate" id="purchaseDate" value="${vo.purchaseDate}" style="width:350px;" class="form-control" /></td>
	    </tr>
	    <tr style="border-style:hidden">
	      <th>제목</th>
	      <td colspan="3"><input type="text" name="title" id="title" value="${vo.title}" style="width:890px;" class="form-control" required /></td>
	    </tr>
	    <tr style="border-style:hidden">
	      <th>내용</th>
	      <td colspan="3"><textarea rows="6" name="content" id="CKEDITOR"  class="form-control" required>${vo.content}</textarea></td>
	      <script>
	      	CKEDITOR.replace("content",{
	      		height:500,
	      		width:890,
	      		filebrowserUploadUrl : "${ctp}/imageUpload",
	      		uploadUrl : "${ctp}/imageUpload"
	      	});
	      </script>
	    </tr>
	    <tr style="border-style:hidden">
	    	<th>공개여부</th>
	    	<td>
		    	<div class="form-check-inline">
					  <label class="form-check-label">
					    <input type="radio" class="form-check-input" name="open" value="OK" <c:if test="${vo.open=='OK'}">checked</c:if>>공개
					  </label>
					</div>
					<div class="form-check-inline">
					  <label class="form-check-label">
					    <input type="radio" class="form-check-input" name="open" value="NO" <c:if test="${vo.open=='NO'}">checked</c:if>>비공개
					  </label>
					</div>
	    	</td>
	    </tr>
    	<tr>
  			<th></th><td colspan="3"></td>
  		</tr>
	  </table>
    <div class="text-center">
      <input type="button" value="수정" onclick="fCheck()" class="button button3"/> &nbsp;
      <input type="reset" value="돌아가기" onclick="location.href='${ctp}/as/asContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';"  class="button button2"/> &nbsp;
      <input type="button" value="목록" onclick="location.href='${ctp}/as/asList';" class="button button1"/>
		</div>
  </form>
	<input type="hidden" name="idx" value="${vo.idx}"/>
  <input type="hidden" name="pag" value="${pag}"/>
  <input type="hidden" name="pageSize" value="${pageSize}"/>
</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>