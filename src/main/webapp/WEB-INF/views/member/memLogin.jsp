<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memLogin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
		.btn1 {padding: 20px 20px;}
	</style>
</head>
<body>  
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container" style="width:50%;">
	<div class="text-center" style="width:600px; height:420px; margin:auto; border:1px solid #d7d5d5;">
		<div class="text-left" style="margin-left:25px; margin-top:10px;">
  		<h1><b>MEMBER LOGIN</b></h1>
    	<span style ="font-size:0.9em">쇼핑몰의 회원이 되시면 다양한 혜택을 누리실 수 있습니다.</span>
		</div>
		<form name="myForm" method="post" class="was-validated">
    <br/>
    <br/>
    <div class="row">
	    <div class="col-sm-8">
		    <div class="row text-left">
					<div class="col-sm-4 text-right p-2" style="font-size:1em; font-weight: bold">아이디</div>
						<div class="col-sm-8 p-1">
							<c:if test="${imsiSession==null}">
								<input type="text" id="mid" name="mid" value="${mid}" style="width:300px">
							</c:if>
							<c:if test="${imsiSession!=null}">
								<input type="password" id="mid" name="mid" value="${imsiSession}" style="width:300px">
							</c:if>
						</div>
					</div>
					<div class="row text-left">
						<div class="col-sm-4 text-right p-2" style="font-size:1em; font-weight: bold">비밀번호</div>
						<div class="col-sm-8 p-1 m-0" ><input type="password" id="pwd" name="pwd" style="width:300px"></div>
					</div>
		   </div>
			 <div class="col-sm-4">
				 <button type="submit" class="btn btn-default btn1">로그인</button> &nbsp;
			</div>
		</div>
		<br/>
		<div class="row">
			<div class="col-sm-6">
	    	<p><input type="checkbox" name="idCheck" checked/>아이디 저장</p>
	    </div>
	    <div class="col-sm-6">
	    	<p><a href="${ctp}/member/memIdFind">아이디 찾기</a> | <a href="${ctp}/member/memPwdFind">비밀번호 찾기</a></p>
	    </div>
	  </div>  
    <div class="text-left" style="margin-left:130px">
    	<a href="https://kauth.kakao.com/oauth/authorize?client_id=7a0facc66af4650a6ccb4638ae35d584&redirect_uri=http://192.168.50.133:9090/javagreenS_jmy/kakao/kakaoMain&response_type=code">
  	 	 <img src="${ctp}/images/kakao_login_narrow.png" class="text-center" style="height:30px;"/>
  	  </a>
    </div>
  </form>
  <hr/>
  <div class="row" style="margin:30px">
  	<div class="col-sm-8" >
			<div class="text-left" style="margin-left:20px">
			  <div style ="font-size:1.1em; font-weight: bold;">회원가입</div><br/>
			  <div class="mb-2"style ="font-size:1em">아직 회원이 아니십니까?</div>
			  <div class="mb-2"style ="font-size:1em">회원을 위한 다양한 혜택이 준비되어 있습니다.</div>
			</div>
		</div>
		<div class="col-sm-4 text-right">
			<div class="mt-3" > 
	  		<button type="button" class="btn btn-default btn1" onclick="location.href='${ctp}/member/memJoin';" >회원가입</button>
	  	</div>
	  </div>	
	  </div>	
  
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>