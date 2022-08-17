<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbShopContent.jsp(상품정보 상세보기)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script>
  	'use strict';
    
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
    
  	function dbShopDelCheck() {
			let ans = confirm("현 게시물을 삭제하시겠습니까?");
			if(ans){
				location.href="dbShopDeleteOk?idx=${productVo.idx}&pag=${pag}&pageSize=${pageSize}";
			}
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:60%">
	<div class="w3-main p-5">
	  <div class="row">
	    <div class="col p-3 text-center" style="border:1px solid #ccc">
			  <div>
			    <img src="${ctp}/dbShop/product/${productVo.FSName}" width="100%"/>
			  </div>
			</div>
			<div class="col p-3 text-right">
			  <div id="iteminfor">
			    <h3>${productVo.detail}</h3>
			    <h3><font color="orange"><fmt:formatNumber value="${productVo.mainPrice}"/>원</font></h3>
			    <h3>${productVo.productName}</h3>
			  </div>
			  <div class="form-group">
			    <form name="optionForm">  
			      <select size="1" class="form-control" id="selectOption">
			        <option value="" disabled selected>상품옵션선택</option>
			        <option value="0:기본품목_${productVo.mainPrice}">기본품목</option>
			        <c:forEach var="vo" items="${optionVos}">
			          <option value="${vo.idx}:${vo.optionName}_${vo.optionPrice}">${vo.optionName}</option>
			        </c:forEach>
			      </select>
			    </form>
			  </div>
			  <br/>
			  <div class="text-right p-2">
			  	<input type="button" value="수정하기" onclick="location.href='dbProductUpdate?idx=${productVo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-success"/>
			    <input type="button" value="돌아가기" onclick="history.back()" class="btn btn-primary"/>
			    <input type="button" value="삭제" onclick="dbShopDelCheck()" class="btn btn-danger"/>
			  </div>
			</div>
	  </div>
	  <br/><br/>
	  <div id="content" class="text-center"><br/>
	    ${productVo.content}
	  </div>
	  <input type="hidden" name="idx" value="${vo.idx}"/>
	</div> 
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>