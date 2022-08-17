<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>asList.jsp</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	'use strict';
  	function pageCheck() {
			let pageSize = $("#pageSize").val();
			location.href="asList.no?pag=${pag}&pageSize="+pageSize;
		}
  	function searchCheck() {
			let searchString=$("#searchString").val();
			
			if(searchString.trim()==""){
				alert("검색어를 입력하세요!");
				searchForm.searchString.focus();
			}
			else{
				searchForm.submit();
			}
		}
  </script>
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
</head>
<body>  
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:60%">
<div class="w3-main p-5">
  <h4><b>A/S문의</b></h4>
  <br/>
  <table class="table table-hover" style="align:center; valign:middle">
  	<tr id="title">
  		<th class="text-center" style="width:50px">번호</th>
  		<th class="text-center" style="width:20px"> </th>
  		<th class="text-center" style="width:300px">제목</th>
  		<th class="text-center" style="width:50px">작성자</th>
  		<th class="text-center" style="width:100px">작성일</th>
  		<th class="text-center" style="width:100px">진행현황</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"></c:set>
  	<c:forEach var="vo" items="${vos}">
  		<tr class="text">
				<td>${curScrStartNo}</td>
				<td>
					<c:if test="${vo.open=='OK'}"> </c:if>
					<c:if test="${vo.open=='NO'}"><img src="${ctp}/images/lock.jpg" style="width:13px; height:17px"/></c:if>
				</td>
				<td class="text-left">
					<c:if test="${sLevel=='0'}">
						<a href="asContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"><font color="#555555">${vo.title}</font></a>
					</c:if>
					<c:if test="${sLevel!='0'}">
						<c:if test="${vo.open=='OK'}">
							<a href="asContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"><font color="#555555">${vo.title}</font></a>
						</c:if>
						<c:if test="${vo.open=='NO'}">
							<a href="asPwdCheck?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"><font color="#555555">${vo.title}</font></a>
						</c:if>
					</c:if>
					<c:if test="${vo.diffTime <=24}"><img src="${ctp}/images/n.jpg"></c:if>
				</td>
				<td>${vo.name}</td>
  			<td>
					<c:if test="${vo.diffTime <=24}">${fn:substring(vo.WDate,11,19)}</c:if>
					<c:if test="${vo.diffTime >24}">${fn:substring(vo.WDate,0,10)}</c:if>
				</td>
				<td>
					<c:if test="${vo.sw=='OK'}"><img src="${ctp}/images/swOK.jpg" style="width:60px"/></c:if> 
					<c:if test="${vo.sw=='NO'}"><img src="${ctp}/images/swNO.jpg" style="width:60px"/></c:if>
				</td>	
  		</tr>
  		<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
  	</c:forEach>
  	<tr><td colspan="6" class="padding"></td></tr>
  </table>
	<div class="text-right p-0">
		<a href="asInput" class="btn btn-default btn-sm">글쓰기</a>
	</div>
</div>
<div class="text-center">
	<ul class="pagination justify-content-center" >
	  <c:if test="${pageVO.pag > 1}"> 
	  	<li class="page-item"><a href="asList?pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
	  </c:if>
	  <c:if test="${pageVO.curBlock > 0}">
	  	<li class="page-item"><a href="asList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
	      <li class="page-item active"><a href="asList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link bg-secondary border-secondary">${i}</a></li>
	    </c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
	      <li class="page-item"><a href='asList?pag=${i}&pageSize=${pageVO.pageSize}' class="page-link text-secondary">${i}</a></li>
	    </c:if>
	  </c:forEach>
	  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    <li class="page-item"><a href="asList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▶</a></li>
	  </c:if>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	  	<li class="page-item"><a href="asList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
	  </c:if>
	</ul>
</div>
<div class="text-center">
	<form name="searchForm" method="get" action="asSearch">
		<b>검색 : </b>
		<select name="search" onchange="searchChange()">
			<option value="title">글제목</option>
			<option value="content">글내용</option>
			<option value="name">작성자</option>
		</select>
		<input type="text" name="searchString" id="searchString"/>
		<input type="button" value="검색" onclick="searchCheck()"/>
		<input type="hidden" name="pag" value="${pageVO.pag}"/>
		<input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
	</form>
</div>
<br/>
<br/>
<br/>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>