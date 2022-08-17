<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>memBoard</title>
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
	<h4><b>게시물관리</b></h4>
	<br>
	<div><h5><b>AS</b>  <font size="1.5em">(총 <font color="fc8404"><b>${pageVO.totRecCnt}</b></font>건)</font></h5></div>
	<table class="table table-hover">
  	<tr id="title">
  		<th class="text-center" style="width:50px">번호</th>
  		<th class="text-center" style="width:300px">제목</th>
  		<th class="text-center" style="width:100px">작성자</th>
  		<th class="text-center" style="width:100px">작성일</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"></c:set>
  	<c:forEach var="vo" items="${AsVos}">
  		<tr class="text">
  			<td>${curScrStartNo}</td>
  			<td class="text-left">
  				<a href="${ctp}/as/asContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"><font color="#555555"><b>${vo.title}</b></font></a>
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
		  	<li class="page-item"><a href="memBoard?pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${pageVO.curBlock > 0}">
		  	<li class="page-item"><a href="memBoard?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
		    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
		      <li class="page-item active"><a href="memBoard?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
		      <li class="page-item"><a href='memBoard?pag=${i}&pageSize=${pageVO.pageSize}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
		    <li class="page-item"><a href="memBoard?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▶</a></li>
		  </c:if>
		  <c:if test="${pageVO.pag != pageVO.totPage}">
		  	<li class="page-item"><a href="memBoard?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
		  </c:if>
		</ul>
	</div>
	<div><h5><b>후기</b>  <font size="1.5em">(총 <font color="fc8404"><b>${pageRVO.totRecCnt}</b></font>건)</font></h5></div>
	<table class="table table-hover">
  	<tr id="title">
  		<th class="text-center" style="width:50px">번호</th>
  		<th class="text-center" style="width:300px">제목</th>
  		<th class="text-center" style="width:100px">작성자</th>
  		<th class="text-center" style="width:100px">작성일</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageRVO.curScrStartNo}"></c:set>
  	<c:if test="${pageRVO.totRecCnt==0}"> 
			<tr><td colspan="5" class="text-center"><font size="2em"><b>작성한 후기가 없습니다.</b></font></td></tr>
		</c:if>
  	<c:forEach var="Rvo" items="${ReviewVos}">
  		<tr class="text">
  			<td>${curScrStartNo}</td>
  			<td class="text-left">
  				<a href="${ctp}/dbShop/dbProductContent?idx=${Rvo.productIdx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"><font color="#555555"><b>${Rvo.content}</b></font></a>
					<c:if test="${Rvo.diffTime <=24}"><font color="red">N</font></c:if>
				</td>
  			<td>${Rvo.mid}</td>
  			<td>
					<c:if test="${Rvo.diffTime <=24}">${fn:substring(Rvo.WDate,11,19)}</c:if>
					<c:if test="${Rvo.diffTime >24}">${fn:substring(Rvo.WDate,0,10)}</c:if>
				</td>
  		</tr>
  		<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
  	</c:forEach>
  	<tr><td colspan="5" style="padding:0px"></td></tr>
  </table>
	<div class="text-center">
		<ul class="pagination justify-content-center" >
		  <c:if test="${pageRVO.pag > 1}"> 
		  	<li class="page-item"><a href="memBoard?pag=1&pageSize=${pageRVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${pageRVO.curBlock > 0}">
		  	<li class="page-item"><a href="memBoard?pag=${(pageRVO.curBlock-1)*pageRVO.blockSize + 1}&pageSize=${pageRVO.pageSize}" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(pageRVO.curBlock*pageRVO.blockSize)+1}" end="${(pageRVO.curBlock*pageRVO.blockSize)+pageRVO.blockSize}">
		    <c:if test="${i <= pageRVO.totPage && i == pageRVO.pag}">
		      <li class="page-item active"><a href="memBoard?pag=${i}&pageSize=${pageRVO.pageSize}" class="page-link bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i <= pageRVO.totPage && i != pageRVO.pag}">
		      <li class="page-item"><a href='memBoard?pag=${i}&pageSize=${pageRVO.pageSize}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${pageRVO.curBlock < pageRVO.lastBlock}">
		    <li class="page-item"><a href="memBoard?pag=${(pageRVO.curBlock+1)*pageRVO.blockSize + 1}&pageSize=${pageRVO.pageSize}" class="page-link text-secondary">▶</a></li>
		  </c:if>
		  <c:if test="${pageRVO.pag != pageRVO.totPage}">
		  	<li class="page-item"><a href="memBoard?pag=${pageRVO.totPage}&pageSize=${pageRVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
		  </c:if>
		</ul>
	</div>
<div><h5><b>문의</b>  <font size="1.5em">(총 <font color="fc8404"><b>${pageQVO.totRecCnt}</b></font>건)</font></h5></div>
	<table class="table table-hover">
  	<tr id="title">
  		<th class="text-center" style="width:50px">번호</th>
  		<th class="text-center" style="width:300px">제목</th>
  		<th class="text-center" style="width:100px">작성자</th>
  		<th class="text-center" style="width:100px">작성일</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageQVO.curScrStartNo}"></c:set>
  	<c:if test="${pageQVO.totRecCnt==0}"> 
			<tr><td colspan="5" class="text-center"><font size="2em"><b>작성된 후기가 없습니다.</b></font></td></tr>
		</c:if>
  	<c:forEach var="Qvo" items="${QnAVos}">
  		<tr class="text">
  			<td>${curScrStartNo}</td>
  			<td class="text-left">
  				<a href="${ctp}/dbShop/dbProductContent?idx=${Qvo.productIdx}&pag=${pageQVO.pag}&pageSize=${pageQVO.pageSize}"><font color="#555555"><b>${Qvo.content}</b></font></a>
					<c:if test="${Qvo.diffTime <=24}"><font color="red">N</font></c:if>
				</td>
  			<td>${Qvo.mid}</td>
  			<td>
					<c:if test="${Qvo.diffTime <=24}">${fn:substring(Qvo.WDate,11,19)}</c:if>
					<c:if test="${Qvo.diffTime >24}">${fn:substring(Qvo.WDate,0,10)}</c:if>
				</td>
  		</tr>
  		<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
  	</c:forEach>
  	<tr><td colspan="5" style="padding:0px"></td></tr>
  </table>
	<div class="text-center">
		<ul class="pagination justify-content-center" >
		  <c:if test="${pageQVO.pag > 1}"> 
		  	<li class="page-item"><a href="memBoard?pag=1&pageSize=${pageQVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${pageQVO.curBlock > 0}">
		  	<li class="page-item"><a href="memBoard?pag=${(pageQVO.curBlock-1)*pageQVO.blockSize + 1}&pageSize=${pageQVO.pageSize}" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(pageQVO.curBlock*pageQVO.blockSize)+1}" end="${(pageQVO.curBlock*pageQVO.blockSize)+pageQVO.blockSize}">
		    <c:if test="${i <= pageQVO.totPage && i == pageQVO.pag}">
		      <li class="page-item active"><a href="memBoard?pag=${i}&pageSize=${pageQVO.pageSize}" class="page-link bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i <= pageQVO.totPage && i != pageQVO.pag}">
		      <li class="page-item"><a href='memBoard?pag=${i}&pageSize=${pageQVO.pageSize}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${pageQVO.curBlock < pageQVO.lastBlock}">
		    <li class="page-item"><a href="memBoard?pag=${(pageQVO.curBlock+1)*pageQVO.blockSize + 1}&pageSize=${pageQVO.pageSize}" class="page-link text-secondary">▶</a></li>
		  </c:if>
		  <c:if test="${pageQVO.pag != pageQVO.totPage}">
		  	<li class="page-item"><a href="memBoard?pag=${pageQVO.totPage}&pageSize=${pageQVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
		  </c:if>
		</ul>
	</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>