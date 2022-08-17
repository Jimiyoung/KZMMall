<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>adMemQnA</title>
  <meta charset="UTF-8">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
 <style>
  	#title{
  		background-color:#fafafa;
  		font-size:12px;
  		color: #555555;
  	}
  	.text{
  		font-size:12px;
  		text-align: center;
  		color: #555555;
  	}
  </style>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:60%">
<div class="w3-main p-5">
	<h4><b>회원문의글 관리</b></h4>
	<br>
	<div><h5><b>문의</b>  <font size="2em">(총 <font color="fc8404"><b>${pageVO.totRecCnt}</b></font>건)</font></h5></div>
	<table class="table table-hover">
  	<tr id="title">
  		<th class="text-center" style="width:50px">번호</th>
  		<th class="text-center" style="width:300px">제목</th>
  		<th class="text-center" style="width:100px">작성자</th>
  		<th class="text-center" style="width:100px">작성일</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"></c:set>
  	<c:if test="${pageVO.totRecCnt==0}"> 
			<tr><td colspan="5" class="text-center"><font size="2em"><b>작성된 후기가 없습니다.</b></font></td></tr>
		</c:if>
  	<c:forEach var="vo" items="${vos}">
  		<tr class="text">
  			<td>${curScrStartNo}</td>
  			<td class="text-left">
  				<a href="${ctp}/dbShop/dbProductContent?idx=${vo.productIdx}"><font color="#555555"><b>${vo.content}</b></font></a>
					<c:if test="${vo.diffTime <=24}"><font color="red">N</font></c:if>
				</td>
  			<td>${vo.mid}</td>
  			<td>
					<c:if test="${vo.diffTime <=24}">${fn:substring(vo.WDate,11,19)}</c:if>
					<c:if test="${vo.diffTime >24}">${fn:substring(vo.WDate,0,10)}</c:if>
				</td>
  		</tr>
  		<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
  	</c:forEach>
  	<tr><td colspan="5" style="padding:0px"></td></tr>
  </table>
	<div class="text-center">
		<ul class="pagination justify-content-center" >
		  <c:if test="${pageVO.pag > 1}"> 
		  	<li class="page-item"><a href="adMemQnA?pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${pageVO.curBlock > 0}">
		  	<li class="page-item"><a href="adMemQnA?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
		    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
		      <li class="page-item active"><a href="adMemQnA?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
		      <li class="page-item"><a href='adMemQnA?pag=${i}&pageSize=${pageVO.pageSize}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
		    <li class="page-item"><a href="adMemQnA?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▶</a></li>
		  </c:if>
		  <c:if test="${pageVO.pag != pageVO.totPage}">
		  	<li class="page-item"><a href="adMemQnA?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
		  </c:if>
		</ul>
	</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>