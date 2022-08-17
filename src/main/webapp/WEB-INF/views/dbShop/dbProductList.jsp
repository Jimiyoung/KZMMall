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
  <title>dbProductList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:60%">
<div class="w3-main">
  <div class="row">
    <div class="col text-center" style="margin:30px">
			<br>
    	<h3><b>${productVos[0].mainName}</b></h3>
    </div>
  </div>
  <hr/>
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${productVos}">
      <div class="col-md-3">
        <div class="text-left">
          <a href="${ctp}/dbShop/dbProductContent?idx=${vo.idx}&categorySubCode=${categorySubCode}&categoryMainCode=${categoryMainCode}&pag=1&pageSize=${pageVO.pageSize}">
            <img src="${ctp}/dbShop/product/${vo.FSName}" width="250px" height="250px"/>
            <div style="padding-top:10px"><font size="2">${vo.productName}</font></div>
            <div><font size="2" color="orange"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</font></div>
            <div><font size="2">${vo.detail}</font></div>
          </a>
        </div>
      </div>
      <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt%4 == 0}">
        </div>
        <div class="row mt-5">
      </c:if>
    </c:forEach>
    <div class="container">
      <c:if test="${fn:length(productVos) == 0}"><h3>제품 준비 중입니다.</h3></c:if>
    </div>
  </div>
  <hr/>
</div>
<div class="text-center">
	<ul class="pagination justify-content-center" >
	  <c:if test="${pageVO.pag > 1}"> 
	  	<li class="page-item"><a href="dbProductList?categorySubCode=${categorySubCode}&categoryMainCode=${categoryMainCode}&pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
	  </c:if>
	  <c:if test="${pageVO.curBlock > 0}">
	  	<li class="page-item"><a href="dbProductList?categorySubCode=${categorySubCode}&categoryMainCode=${categoryMainCode}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
	      <li class="page-item active"><a href="dbProductList?categorySubCode=${categorySubCode}&categoryMainCode=${categoryMainCode}&pag=${i}&pageSize=${pageVO.pageSize}" class="page-link bg-secondary border-secondary">${i}</a></li>
	    </c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
	      <li class="page-item"><a href='dbProductList?categorySubCode=${categorySubCode}&categoryMainCode=${categoryMainCode}&pag=${i}&pageSize=${pageVO.pageSize}' class="page-link text-secondary">${i}</a></li>
	    </c:if>
	  </c:forEach>
	  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    <li class="page-item"><a href="dbProductList?categorySubCode=${categorySubCode}&categoryMainCode=${categoryMainCode}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▶</a></li>
	  </c:if>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	  	<li class="page-item"><a href="dbProductList?categorySubCode=${categorySubCode}&categoryMainCode=${categoryMainCode}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
	  </c:if>
	</ul>
</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>