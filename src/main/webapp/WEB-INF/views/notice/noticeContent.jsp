<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>noticeContent.jsp</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	function noticeDelCheck() {
			let ans = confirm("현 게시물을 삭제하시겠습니까?");
			if(ans){
				location.href="noticeDeleteOk?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}";
			}
		}
  </script>
  <style>
  	th{
  		background-color:#fafafa;
  		font-size:12px;
  	}
  	.text{
  		font-size:12px;
  	}
  	.button {
		  border: none;
		  color: white;
		  text-align: center;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 14px;
		  margin: 4px 0px;
		  cursor: pointer;
		  height:40px;
		  width:120px;
		}
		.button1 {border-radius: 2px; background-color:#4a5164;}
		.button2 {border-radius: 2px; background-color:#3cc2b1;}
		.button3 {border-radius: 2px; background-color:#0a253e;}
  </style>
</head>
<body>
<body>  
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:70%">
<div class="w3-main p-5">
  <h4><b>공지사항</b></h4>
  <br/>
  <table class="table table-bordered text" >
  	<colgroup>
  		<col style="width:130px;">
  		<col style="width:auto;">
  	</colgroup>
	  <tr>
	  	<th class="text-center">제목</th>
	  	<td>${vo.title}</td>
	  </tr>
	  <tr>
	  	<th class="text-center">작성자</th>
	  	<td>${vo.name}</td>
	  </tr>	
	  <tr>
	  	<td colspan="6"><b>작성일</b><font color="#96989a">&nbsp;&nbsp;${fn:substring(vo.WDate,0,19)}</font>&nbsp;&nbsp;&nbsp;&nbsp;<b>조회수</b><font color="#96989a">&nbsp;&nbsp;${vo.readNum}</font></td>
	  </tr>	
	  <tr>
	  	<td class="text-center m-2" colspan="6" ><p><br/>${fn:replace(vo.content,newLine,"<br/>")}<br/><br/><br/></p></td>
	  </tr>	
  </table>
	<div class="text-left">
  	<c:if test="${flag=='s'}">
  		<input type="button" value="목록" onclick="location.href='noticeSearch?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn btn-default"/>
  	</c:if>	
  	<c:if test="${flag!='s'}">
  		<input type="button" value="목록" onclick="location.href='noticeList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-default"/>
  	</c:if>	
	</div>	
	<c:if test="${sLevel==0}">
		<div class="text-right">
  		<input type="button" value="수정" onclick="location.href='noticeUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="button button3"/>
  		<input type="button" value="삭제" onclick="noticeDelCheck()" class="button button2"/>
		</div>
	</c:if>
	<table class="table table-borderless" style="border:hidden;">
		<tr>
			<td>
			<c:if test="${!empty pnVOS[1]}">
				▲ 다음글 : <a href="noticeContent?idx=${pnVOS[1].idx}&pag=${pag}&pageSize=${pageSize}"><b> ${pnVOS[1].title}</b></a><br/>
			</c:if>	
			<c:if test="${!empty pnVOS[0]}">
				<c:if test="${minIdx == vo.idx}">▲ 다음글 : </c:if> 
				<c:if test="${minIdx != vo.idx}">▼ 이전글 : </c:if> 
					<a href="noticeContent?idx=${pnVOS[0].idx}&pag=${pag}&pageSize=${pageSize}"><b> ${pnVOS[0].title}</b></a><br/>
			</c:if>	
			</td>
		</tr>
	</table>
	<br/>
		<input type="hidden" name="noticeIdx" value="${vo.idx}"/>
		<input type="hidden" name="mid" value="${sMid}"/>
		<input type="hidden" name="nickName" value="${sNickName}"/> 
</div>	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>