<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>memPwdCheck.jsp</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <style>
			.button {
			  border: none;
			  color: white;
			  text-align: center;
			  text-decoration: none;
			  display: inline-block;
			  font-size: 12px;
			  margin: 4px 0px;
			  cursor: pointer;
			  height:30px;
			  width:100px;
			}
			.button1 {border-radius: 2px; background-color:#4a5164;}
			.button2 {border-radius: 2px; background-color:#3cc2b1;}
  </style>
</head>
<body >  
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:70%">
<div class="w3-main p-5">
	<form method="post" class="was-validated">
    <h4><b>비밀번호 확인</b></h4><br/>
    <div class="text-center" style="width:1000px; height:350px; border:1px solid #d7d5d5; padding:40px">
    	<p class="mt-5 mb-2"  style="font-size:1.1em; font-weight: bold; color:#404040;">비밀번호 확인 후 <br/>회원정보수정이 가능합니다.</p>
				<div class="row">
				 	<div class="col-sm-4"></div>
					<div class="col-sm-4">
				 		<hr/>
				 		<div class="row">
				 			<div class="col-sm-3 text-right p-2" style="font-size:0.8em;">비밀번호</div>
							<div class="col-sm-9 p-1"><input type="password" id="pwd" name="pwd" required/></div>
				 		</div>
				 	</div>
					<div class="col-sm-4"/></div>
				</div>
				<div class="m-4">
					<input type="submit" value="비밀번호 확인" class="button button1"/> &nbsp;
					<input type="reset" value="돌아가기" class="button button2"/> &nbsp;
				</div>
		</div>		
  </form>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>