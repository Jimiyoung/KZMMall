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
		.button {
		  border: none;
		  color: white;
		  text-align: center;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 16px;
		  margin: 6px 0px;
		  cursor: pointer;
		}
		.btn1 {padding: 32px 35px;}
		.btn2 {padding: 6px 35px;}
	</style>
</head>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<body class="w3-content" style="max-width:1500%;">  
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container" style="width:50%">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="container p-3">
			  <form name="myForm" method="post" class="was-validated">
			    <h1 class="m-0"><b>MEMBER LOGIN</b></h1>
			    <span style ="font-size:0.3em">쇼핑몰의 회원이 되시면 다양한 혜택을 누리실 수 있습니다.</span>
			    <div class="row">
				    <div class="col-sm-8"> 
				    <div style="float:left;">
					    <div class="input-group-prepend mt-3 mb-3 ">
					      <span class="input-group-text">&nbsp;아이디&nbsp;&nbsp;</span>
					      <c:if test="${imsiSession==null}">
					      	<input type="text" class="form-control" name="mid" id="mid" value="${mid}" style="width:200px" placeholder="아이디를 입력하세요." required autofocus />
					      </c:if>
					      <c:if test="${imsiSession!=null}">
					      	<input type="text" class="form-control" name="mid" id="mid" value="${imsiSession}" style="width:200px" placeholder="아이디를 입력하세요." required autofocus />
					      </c:if>
					    </div>
					    <div class="input-group-prepend mt-3 mb-3 ">
					      <span class="input-group-text">비밀번호</span>
					      <input type="password" class="form-control" name="pwd" id="pwd" style="width:200px" placeholder="비밀번호를 입력하세요." required />
					    </div>
					  </div>
					  <div style="float:left;">  
				    <div class="col-sm-4"> 
					    <div class="form-group text-center" >
						    <button type="submit" class="btn btn-outline-primary btn1">로그인</button> &nbsp;
						  </div> 
				    </div>
				    </div>
				    </div>
			    </div>
			    <div class = "row" style="font-size:14px">
			    	<span class="col"><input type="checkbox" name="idCheck" checked/>아이디 저장</span>
			    </div>
			    	<span class="col"><a href="${ctp}/member/memIdFind">아이디 찾기</a> | <a href="${ctp}/member/memPwdFind">비밀번호 찾기</a></span>
			  </form>
			  <hr/>
			  <div class="row m-3">
			  <div style="float:left;  width:240px;">
					<div> 
					  <div style ="font-size:1em; font-weight: bold;">회원가입</div>
					  <div class="mb-2"style ="font-size:0.3em">아직 회원이 아니십니까? <br/>회원을 위한 다양한 혜택이 준비되어 있습니다.</div>
					</div>
				</div>
				<div style="float:left; margin-left:20px;">		
					<div class="col-sm-4" style="width:100px;"> 
			  		<button type="button" class="btn btn-outline-success btn2" onclick="location.href='${ctp}/member/memJoin';" >회원가입</button>
			  	</div>
			  </div>	
			  </div>	
			</div>
		</div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>