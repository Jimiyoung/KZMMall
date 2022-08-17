<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>noticeList.jsp</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	'use strict';
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
  	function searchChange() {
			document.getElementById("searchString").focus();		
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
  <h4><b>공지사항</b></h4>
  	<c:if test="${sLevel == 0}">
	  	<div class="text-right p-0">
				<a href="noticeInput" class="btn btn-default btn-sm">글쓰기</a>
		  </div>
	  </c:if>
  <br/>
  <c:if test="${searchString != null}">
  	<div class="text-left" style="font-size:1em; color:#848684">"<font style="color:blue">${searchString}</font>" 검색 결과입니다</div><br/>
  </c:if>	
  <table class="table table-hover">
  	<tr id="title">
  		<th class="text-center" style="width:50px">번호</th>
  		<th class="text-center" style="width:300px">제목</th>
  		<th class="text-center" style="width:100px">작성자</th>
  		<th class="text-center" style="width:100px">작성일</th>
  		<th class="text-center" style="width:70px">조회수</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"></c:set>
  	<c:forEach var="vo" items="${vos}">
  		<tr class="text">
  			<c:if test="${vo.pin == 1}">
  				<td class="text"><b>공지</b></td>
	  			<td class="text-left">
	  				<a href="noticeContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"><font color="#555555"><b>${vo.title}</b></font></a>
  					<c:if test="${vo.diffTime <=24}"><font color="red">N</font></c:if>
  				</td>
  			</c:if>
  			<c:if test="${vo.pin != 1}">
  				<td>${curScrStartNo}</td>
  				<td class="text-left">
  					<a href="noticeContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"><font color="#555555">${vo.title}</font></a>
  					<c:if test="${vo.diffTime <=24}"><font color="red">N</font></c:if>
  				</td>
  			</c:if>
  			<td>${vo.name}</td>
  			<td>
					<c:if test="${vo.diffTime <=24}">${fn:substring(vo.WDate,11,19)}</c:if>
					<c:if test="${vo.diffTime >24}">${fn:substring(vo.WDate,0,10)}</c:if>
				</td>
  			<td>${vo.readNum}</td>
  		</tr>
  		<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
  	</c:forEach>
  	<tr><td colspan="5" class="padding"></td></tr>
  </table>
</div>
<div class="text-center">
	<ul class="pagination justify-content-center" >
	  <c:if test="${pageVO.pag > 1}"> 
	  	<li class="page-item"><a href="noticeList?pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
	  </c:if>
	  <c:if test="${pageVO.curBlock > 0}">
	  	<li class="page-item"><a href="noticeList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
	      <li class="page-item active"><a href="noticeList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link bg-secondary border-secondary">${i}</a></li>
	    </c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
	      <li class="page-item"><a href='noticeList?pag=${i}&pageSize=${pageVO.pageSize}' class="page-link text-secondary">${i}</a></li>
	    </c:if>
	  </c:forEach>
	  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    <li class="page-item"><a href="noticeList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▶</a></li>
	  </c:if>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	  	<li class="page-item"><a href="noticeList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
	  </c:if>
	</ul>
</div>
<br/>
<div class="text-center">
	<form name="searchForm" method="get" action="noticeSearch">
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