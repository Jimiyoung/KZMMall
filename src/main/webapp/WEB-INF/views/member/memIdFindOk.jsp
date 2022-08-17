<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memIdFindOk.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
		.btn1 {padding: 7px 90px;}
		.btn2 {padding: 7px 70px;}
	</style>
</head>
<body>  
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:70%">
<div class="w3-main p-5">
<br/>
	<div class="text-center" style="width:600px; height:420px; margin:auto;border:1px solid #d7d5d5;">
		<div class="text-left" style="margin-left:40px; margin-top:30px;">
  		<h1><b>Forgot ID</b></h1>
  		<span style ="font-size:0.9em">저희 쇼핑몰를 이용해주셔서 감사합니다.</span>
  		<span style ="font-size:0.9em">다음정보로 가입된 아이디입니다.</span>
		</div>
    <div>
    	<div class="col-sm-1"></div>
    	<div class="col-sm-10 p-0">
    	<hr/>
    		<div class="text-left" style="font-size:1em; color:#555555">
					<div>이름:${vo.name}</div>
					<div>이메일:${vo.email}</div>
					<div>아이디:<b>${vo.mid}</b> (가입일:${fn:substring(vo.startDate,0,10)})</div>
					<div>고객님 즐거운 쇼핑 하세요!</div>
				</div>
				<hr/>
				<div class="text-left" style ="font-size:0.9em">
					고객님의 아이디 찾기가 성공적으로 이루어졌습니다.<br/>
					항상 고객님의 즐겁고 편리한 쇼핑을 위해<br/>
					최선의 노력을 다하는 쇼핑몰이 되도록 하겠습니다.
				</div>	
				<br/>
			</div>
			<div class="col-sm-1"></div>
		</div>	
		<div class="col-sm-6">
			<input type="button" value="로그인" onclick="location.href='${ctp}/member/memLogin'" class="btn btn-secondary btn1"/>
		</div>
		<div class="col-sm-6">
			<input type="button" value="비밀번호찾기" onclick="location.href='${ctp}/member/memPwdFind'" class="btn btn-dark btn2"/>
		</div>
		</div>
		<br/>
  </div>  
</div>  
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>