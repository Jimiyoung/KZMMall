<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>asContent.jsp</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
  	'use strict';
  	function asDelCheck() {
			let ans = confirm("현 게시물을 삭제하시겠습니까?");
			if(ans){
				location.href="asDeleteOk?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}";
			}
		}
  	
  	function replyCheck() {
			let content=$("#content").val();
			if(content.trim()==""){
				alert("답변을 입력하세요.");
				$("#content").focus();
				return false;
			}
			let query={
				asIdx : ${vo.idx},
				name : '${sName}',
				content : content,
			}
			$.ajax({
				type : "post",
				url : "${ctp}/as/asReplyInput",
				data : query,
				success : function(data) {
					alert("답변이 등록되었습니다.");
					location.reload();
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
	
	function asReplyDelete(idx) {
		let ans=confirm("답변을 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type : "post",
			url : "${ctp}/as/asReplyDelete",
			data : {idx:idx},
			success : function(data){
				location.reload();
			},
			error:function(){
				alert("전송오류");
			}
		});
	}
	function swCheck(idx) {
		$.ajax({
			type : "post",
			url : "${ctp}/as/swCheck",
			data : {idx : idx},
			success:function(){
				alert("확인 처리되었습니다.");
				location.href="${ctp}/as/asList";
			},
			error : function() {
				alert("전송오류");
			}
		});
	}
  </script>
  <style>
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
			.button4 {border-radius: 2px; background-color:#fd8204;}
			.btnn {
			  border: none;
			  color: white;
			  text-align: center;
			  text-decoration: none;
			  display: inline-block;
			  font-size: 8px;
			  margin: 0px 0px;
			  padding:0px;
			  cursor: pointer;
			  height:20px;
			  width:25px;
			}
			.btn1 {border-radius: 2px; background-color:#b8b7b7;}
			th{background-color:#fafafa;}
  </style>
</head>
<body>  
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:65%">
<div class="w3-main p-5">
  <h4><b>A/S문의내용</b></h4>
  <br/><br/>
	  <table class="table" style="border:2px solid #bcb8b8;margin: auto; width:100%;">
		  <colgroup>
	  		<col style="width:130px">
	  		<col style="width:400px">
	  		<col style="width:120px">
	  		<col style="width:400px">
	  		<col style="width:120px">
	  		<col style="width:400px">
	  	</colgroup> 
	    <tr>
	      <th>이름</th>
	      <td>${vo.name}</td>
	      <th>연락처</th>
	      <td>${vo.tel}</td>
	      <th>이메일</th>
	      <td>${vo.email}</td>
	    </tr>
	    <tr>
	      <th>제품이름</th>
	      <td>${vo.productName}</td>
	      <th>구입처</th>
	      <td>${vo.place}</td>
	      <th>구입날짜</th>
	      <td>${vo.purchaseDate}</td>
	    </tr>
	    <tr>
	      <th>제목</th>
	      <td colspan="5">${vo.title}</td>
	    </tr>
	    <tr>
	      <th>내용</th>
	      <td colspan="5">${fn:replace(vo.content,newLine,"<br/>")}</td>
	    </tr>
	    <tr>
	    	<th>공개여부</th>
	    	<td colspan="5">
		    	<c:if test="${vo.open=='OK'}">공개</c:if>
		    	<c:if test="${vo.open=='NO'}">비공개</c:if>
	    	</td>
	    </tr>
	  </table>
		<br/><br/>	 
		<div class="container p-0 m-0">
			<div class="text-left"><b>답변 <font color="fc8404">${vo.replyCount}</font>개</b></div>
				<div class="text-center" style="width:1030px;  border:1px solid #d7d5d5; background-color:#f8f8f8;margin-top:10px">
				<div style="margin:10px;">
				<c:if test="${vo.replyCount==0}"> 
					<div class="text-left" style="margin:10px"><font size="2.7em"><b>답변 준비중입니다.</b></font></div>
				</c:if>
				<div id="reply">
					<table class="table table-hover text-center">
						<c:forEach var="replyVo" items="${replyVos}">
						<tr style="border-style:hidden">
							<th style="width:100px" class="text-center" >
								<c:if test="${replyVo.level <= 0}"> 
									${replyVo.name}&nbsp;&nbsp;&nbsp; | 
								</c:if>
								<c:if test="${replyVo.level > 0}"> 
								<c:forEach var="i" begin="1" end="${replyVo.level}"> &nbsp;&nbsp;</c:forEach>
									└ ${replyVo.name}							
							</c:if>
							</th>
							<th style="width:150px">${replyVo.WDate}</th>
							<th>
								<c:if test="${sLevel==0}">
									<input type="button" value="삭제" onclick="asReplyDelete(${replyVo.idx})"class="btnn btn1"/>
								</c:if>
							</th>
						</tr>
						<tr style="border-style:hidden">
							<td colspan="5" class="text-left" style="padding-left:20px;">
								${fn:replace(replyVo.content,newLine,"<br/>")}
							</td>
						</tr>	
						<tr>
							<td colspan="5" class="m-0 p-0" style="border-top:none;"><div id="replyBox${replyVo.idx}"></div></td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<c:if test="${sLevel==0}">
		<form name="replyForm" method="post">
			<div class="text-center" style="margin:20px; width:1000px; height:200px;border:1px solid #d7d5d5;" >
				<div class="text-center m-3">
				<div class="text-left">작성자 : ${sName}</div>
				<div style="margin:15px"><textarea rows="4" name="content" id="content" class="form-control"></textarea></div>
				<div class="text-right" style="margin:2px"><input type="button" value="등록" onclick="replyCheck()" class="btn btn-default btn-sm"/></div>
			</div>
			</div>
		</form>	
		</c:if>
	</div>
	<br/><br/><br/>	
  <div class="text-center">
		<c:if test="${sLevel==0}">
			<input type="button" value="확인" onclick="swCheck(${vo.idx})" class="button button4"/>
		</c:if>
    <input type="button" value="목록" onclick="location.href='${ctp}/as/asList';" class="button button2"/>
 		<c:if test="${sMid==vo.mid || sLevel==0}">
	 		<input type="button" value="수정" onclick="location.href='asUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="button button3"/>
			<input type="button" value="삭제" onclick="asDelCheck()" class="button button1"/>
		</c:if>
	</div>
	</div>
	<input type="hidden" name="idx" value="${vo.idx}"/>
	<input type="hidden" name="pag" value="${pag}"/>
	<input type="hidden" name="pageSize" value="${pageSize}"/>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>