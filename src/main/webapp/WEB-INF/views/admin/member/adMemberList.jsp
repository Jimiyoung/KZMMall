<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adMemberList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    function levelCheck(obj) {
    	var ans = confirm("회원등급을 변경하시겠습니까?");
    	if(!ans) {
    		location.reload();
    		return false;
    	}
    	var str = $(obj).val();
    	var query = {
    			idx : str.substring(1),
    			level : str.substring(0,1)
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/admin/adMemberLevel",
    		data : query,
    		success:function() {
    			alert("회원등급 변경완료!");
    		},
    		error:function() {
    			alert("처리 실패!!");
    		}
    	});
    }
    
    function memberReset(idx) {
    	var ans = confirm("정말로 탈퇴처리 하시겠습니까?");
    	if(!ans) return false;
		  
		  $.ajax({
			  type : "post",
			  url  : "${ctp}/admin/adMemberReset",
			  data : {idx : idx},
			  success:function() {
				  alert("삭제되었습니다.");
				  location.reload();
			  },
			  error : function() {
				  alert("전송실패!");
			  }
		  });
	  }
    
    function levelSearch() {
    	var level = adminForm.level.value;
    	location.href = "${ctp}/admin/adMemberList?level="+level;
    }
    
    function midSearch() {
    	var mid = adminForm.mid.value;
    	if(mid == "") {
    		alert("아이디를 입력하세요?");
    		adminForm.mid.focus();
    	}
    	else {
    		location.href = "${ctp}/admin/adMemberList?mid="+mid;
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:60%">
<div class="w3-main p-5">
<h4><b>${title} 회원 리스트 (총 : <font color="red">${totRecCnt}</font>건)</b></h4><br/>
  <form name="adminForm">      
	  <table class="table table-borderless m-0">
	    <tr>
	      <td style="text-align:left">
	        <input type="text" name="mid" value="${mid}" placeholder="검색할아이디입력"/>
	        <input type="button" value="개별검색" onclick="midSearch()"/>
	        <input type="button" value="전체보기" onclick="location.href='${ctp}/admin/adMemberList';" class="btn btn-secondary btn-sm"/>
	      </td>
	      <td style="text-align:right">회원등급  
	      	<c:choose>
	          <c:when test="${level==99}"><c:set var="title" value="전체"/></c:when>
	          <c:when test="${level==3}"><c:set var="title" value="VIP"/></c:when>
	          <c:when test="${level==2}"><c:set var="title" value="GOLD"/></c:when>
	          <c:when test="${level==1}"><c:set var="title" value="일반회원"/></c:when>
	        </c:choose>
	        <c:if test="${!empty mid}"><c:set var="title" value="${mid}"/></c:if>
	        <select name="level" onchange="levelSearch()">
	          <option value="99"<c:if test="${level==99}">selected</c:if>>전체회원</option>
	          <option value="3" <c:if test="${level==3}">selected</c:if>>VIP</option>
	          <option value="2" <c:if test="${level==2}">selected</c:if>>GOLD</option>
	          <option value="1" <c:if test="${level==1}">selected</c:if>>일반회원</option>
	        </select>
	      </td>
	    </tr>
	  </table>
  </form>
  <table class="table table-hover">
    <tr class="text-center" style="background-color:#fbfafa; font-size:0.8em;">
      <th style="text-align:center;">번호</th>
      <th style="text-align:center;">아이디</th>
      <th style="text-align:center;">성명</th>
      <th style="text-align:center;">가입일</th>
      <th style="text-align:center;">최종접속일</th>
      <th style="text-align:center;">등급</th>
      <th style="text-align:center;">탈퇴유무</th>
    </tr>
    <c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
    <c:forEach var="vo" items="${vos}">
    	<tr class="text-center">
    	  <td>${curScrStartNo}</td>
    	  <td><a href="${ctp}/admin/adMemberInfor?idx=${vo.idx}">${vo.mid}</a></td>
    	  <td>
    	    ${vo.name}
    	  </td>
    	  <td>${vo.startDate}</td>
    	  <td>${vo.lastDate}</td>
    	  <td>
  	      <select name="level" onchange="levelCheck(this)">
  	        <option value="1${vo.idx}" <c:if test="${vo.level==1}">selected</c:if>>일반회원</option>
  	        <option value="2${vo.idx}" <c:if test="${vo.level==2}">selected</c:if>>GOLD</option>
  	        <option value="3${vo.idx}" <c:if test="${vo.level==3}">selected</c:if>>VIP</option>
  	        <option value="0${vo.idx}" <c:if test="${vo.level==0}">selected</c:if>>관리자</option>
  	      </select>
    	  </td>
    	  <td>
	    	  <c:if test="${vo.userDel == 'OK'}"><font color="red">탈퇴신청</font></c:if>
	  	    <c:if test="${vo.userDel != 'OK'}">활동중</c:if>
	  	    <c:if test="${vo.applyDiff >= 30 and vo.userDel == 'OK'}"><font color="red"><a href="javascript:memberReset(${vo.idx})" title="30일경과">*</a></font></c:if>
    	  </td>
    	</tr>
    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
    <tr><td colspan="10" class="p-0"></td></tr>
  </table>
  <br/>
  
<c:if test="${pageVo.totPage == 0}"><p style="text-align:center"><font color="red"><b>자료가 없습니다.</b></font></p></c:if>
<c:if test="${pageVo.totPage != 0}">
	<div style="text-align:center">
	  <c:if test="${pageVo.pag != 1}"><a href="${ctp}/admin/adMemberList?pag=1&level=${level}">◁◁</a></c:if> &nbsp;&nbsp;
	  <c:if test="${pageVo.pag > 1}"><a href="${ctp}/admin/adMemberList?pag=${pageVo.pag-1}&level=${level}">◀</a></c:if>
	  &nbsp;&nbsp; ${pageVo.pag}Page / ${pageVo.totPage}pages &nbsp;&nbsp;
	  <c:if test="${pageVo.pag < pageVo.totPage}"><a href="${ctp}/admin/adMemberList?pag=${pageVo.pag+1}&level=${level}">▶</a></c:if> &nbsp;&nbsp;
	  <c:if test="${pageVo.pag != pageVo.totPage}"><a href="${ctp}/admin/adMemberList?pag=${pageVo.totPage}&level=${level}">▷▷</a></c:if>
	</div>
</c:if>
</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>