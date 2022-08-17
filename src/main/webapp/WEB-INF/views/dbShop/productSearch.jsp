<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>productSearch</title>
  <meta charset="UTF-8">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:60%">
<div class="w3-main p-5">
	<br/>
  <h4><b>상품검색</b></h4><br/>
  <hr style="margin:10px 0px">
  <div class="text-left" style="font-size:1em; color:#848684">"<font style="color:blue">${searchString}</font>" 검색 결과 : 총 <font style="color:orange"><b>${pageVO.totRecCnt}</b></font>개의 상품이 검색되었습니다.</div>
  <hr style="margin:10px 0px">
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${vos}">
      <div class="col-md-3">
        <div class="text-left">
          <a href="${ctp}/dbShop/dbProductContent?idx=${vo.idx}">
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
      <c:if test="${fn:length(vos) == 0}">
      	<div class="text-center">
      		<b>검색 결과가 없습니다.<br/>정확한 검색어인지 확인하시고 다시 검색해 주세요.</b>
				</div>
			</c:if>
    </div>
  </div>
  <hr/>
</div>
<div class="text-center">
	<ul class="pagination justify-content-center" >
	  <c:if test="${pageVO.pag > 1}"> 
	  	<li class="page-item"><a href="productSearch?searchString=${searchString}&pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
	  </c:if>
	  <c:if test="${pageVO.curBlock > 0}">
	  	<li class="page-item"><a href="productSearch?searchString=${searchString}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
	      <li class="page-item active"><a href="productSearch?searchString=${searchString}&pag=${i}&pageSize=${pageVO.pageSize}" class="page-link bg-secondary border-secondary">${i}</a></li>
	    </c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
	      <li class="page-item"><a href='productSearch?searchString=${searchString}&pag=${i}&pageSize=${pageVO.pageSize}' class="page-link text-secondary">${i}</a></li>
	    </c:if>
	  </c:forEach>
	  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    <li class="page-item"><a href="productSearch?searchString=${searchString}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▶</a></li>
	  </c:if>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	  	<li class="page-item"><a href="productSearch?searchString=${searchString}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
	  </c:if>
	</ul>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>