<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>qrcode.jsp</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script>
    'use strict';
    
    function qrCreate() {
    	let moveUrl = myForm.moveUrl.value;
    	
    	let idxArr = moveUrl.split('&');
    	let idx = idxArr[0].substring(idxArr[0].indexOf('=')+1);
    	
    	$.ajax({
  			url  : "${ctp}/member/qrCode",
  			type : "post",
  			data : {moveUrl : moveUrl,
  				idx : idx},
  			success : function(data) {
 					alert("qr코드 생성완료 : "+data);
 					$("#qrCodeView").show();
 					$("#qrView").html(data);
 					var qrImage = '<img src="${ctp}/qrCode/'+data+'.png"/>';
 					$("#qrImage").html(qrImage);
				}
			});
    	
		}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:60%">
<div class="w3-main p-5">
  <form name="myForm">
	  <h4><b>QR코드 생성하기</b></h4>
	  <hr/>
	  <div>
	    <h4>QR코드 체크시 확인할 상품 주소를 입력후 QR코드를 생성해 주세요.</h4>
	  </div>
	  <p>
	    이동할 주소1 : <input type="text" name="moveUrl" size="100"/>
	    <input type="button" value="qr코드 생성" onclick="qrCreate()" class="btn btn-primary btn-sm"/>
	  </p>
	  <hr/>
	  <div id="qrCodeView" style="display:none">
	    <h3>생성된 QR코드 확인하기</h3>
	    <div>
		  - 생성된 qr코드명 : <span id="qrView"></span><br/>
		  <span id="qrImage"></span>
		  </div>
	  </div>
  </form>
</div>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>