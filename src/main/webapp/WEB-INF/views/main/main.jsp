<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>main.jsp</title>
  <meta charset="UTF-8">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<style>
		body {font-family: "Lato", sans-serif}
		.mySlides {display: none}
		</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<div class="w3-content text-center" style="max-width:100%; margin-top:20px">
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide.jsp"/>
	<div class="container-fluid bg-3 text-center" style="max-width:1200px; margin-top:50px">    
	  <div class="row">
	    <div class="col-sm-6 p-0">
	      <a href="https://www.youtube.com/watch?v=rjGaaa64Sv0&feature=youtu.be" target="_blank"><img src="${ctp}/images/cf.jpeg" style="margin-bottom:30px"></a>
	      <div class="row">
		      <div class="col p-0 m-1"><a href="#" ><img src="${ctp}/images/m1.jpeg" style="width:290px"></a></div>
		      <div class="col p-0 m-1"><a href="#" ><img src="${ctp}/images/m2.jpeg" style="width:290px"></a></div>
	    	</div>
	    </div>
	    <div class="col-sm-6">
	    	<jsp:include page="/WEB-INF/views/include/slide6.jsp"/>
	    </div>
	  </div>
	</div><br/>
	<br/>
	<div class="container text-center" style="margin-left:335px;">
		<jsp:include page="/WEB-INF/views/include/slide4.jsp"/>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>