<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>dbReview</title>
  <meta charset="UTF-8">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script>
  	'use strict';
  	function reviewCheck() {
			let content=$("#content").val();
			if(content.trim()==""){
				alert("내용 입력하세요.");
				$("#content").focus();
				return false;
			}
			let query={
				productIdx : ${vo.idx},
				mid : '${sMid}',
				content : content,
			}
			$.ajax({
				type : "post",
				url : "${ctp}/dbShop/dbShopReviewInput",
				data : query,
				success : function(data) {
					alert("후기가 등록되었습니다.");
					location.href="${ctp}/dbShop/dbMyOrder";
				},
				error : function() {
					alert("전송오류");
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
<h4><b>상품 후기 작성</b></h4><br/>
<div class="row" style="border:3px solid #d7d5d5; padding:20px">
	<div class="col-sm-4">
    <img src="${ctp}/dbShop/product/${vo.FSName}" style="width:200px; height:200px;"/>
  </div>
	<div class="col-sm-8" style="padding-left:40px">
	  <div style="width:98%" >
		  <div class="text-left" style="font-size:1.3em; font-weight: 600; padding-top:20px">${vo.detail}</div>
			  <hr/>
			  <div>
			  	<div class="row">
				    <div class="col-sm-3 text-left" style="font-size:1.2em; font-weight: bold;">판매가</div>
				    <div class="col-sm-9 text-left" style="font-size:1.2em; font-weight: bold;"><font color="orange"><fmt:formatNumber value="${vo.mainPrice}"/>원</font></div>
			    </div>
			  </div>
		  </div>
	  <div>
		  <form name="myForm" method="post">  
		    <input type="hidden" name="productIdx" value="${vo.idx}"/>
		    <input type="hidden" name="productName" value="${vo.productName}"/>
		  </form>
	  </div>
	  </div>
	  <br/>
	</div>
  <br/><br/>
  <div class="text-center" >
		<form name="reviewForm" method="post">
			<div class="text-center" style="margin:auto; width:920px; height:200px;border:1px solid #d7d5d5;" >
				<div class="text-center m-3">
					<div class="text-left">작성자 ${idx}: ${sName}</div>
					<div style="margin:15px"><textarea rows="4" name="content" id="content" class="form-control"></textarea></div>
					<div class="text-right" style="margin:2px"><input type="button" value="등록" onclick="reviewCheck()" class="btn btn-default btn-sm"/></div>
				</div>
			</div>
		</form>
	</div>		
	<div class="text-center" style="margin:20px"><input type="button" value="돌아가기" onclick="history.back()" class="btn btn-primary"/></div>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>