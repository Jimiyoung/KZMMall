<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine","\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adMemberInfor.jsp</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:60%">
<div class="w3-main p-5">
  <h4><b>회원정보 상세보기</b></h4>
  <br/>
  <table class="table">
    <tr><td>아이디 : ${vo.mid}</td></tr>
    <tr><td>성명 : ${vo.name}</td></tr>
    <tr><td>전화번호 : ${vo.tel}</td></tr>
    <tr><td>이메일 : ${vo.email}</td></tr>
    <tr><td>주소 : ${vo.address}</td></tr>
    <tr><td>적립금 : <fmt:formatNumber value="${vo.point}"/></td></tr>
    <tr>
      <td>레벨 :
        <c:choose>
	        <c:when test="${vo.level == 2}"><c:set var="level" value="정회원"/></c:when>
	        <c:when test="${vo.level == 3}"><c:set var="level" value="우수회원"/></c:when>
	        <c:when test="${vo.level == 0}"><c:set var="level" value="관리자"/></c:when>
	        <c:otherwise><c:set var="level" value="준회원"/></c:otherwise>
	      </c:choose>
	      ${level}
      </td>
    </tr>
    <tr><td>최초가입일 : ${vo.startDate}</td></tr>
    <tr><td>최종방문일 : ${vo.lastDate}</td></tr>
    <tr>
      <td>탈퇴여부 : 
        <c:if test="${vo.userDel ne 'NO'}"><font color="red">탈퇴신청</font></c:if>
        <c:if test="${vo.userDel eq 'NO'}">활동중</c:if>
      </td>
    </tr>
  </table>
  <hr/>
  <a href="${ctp}/admin/adMemberList" class="btn btn-secondary">돌아가기</a>
</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>