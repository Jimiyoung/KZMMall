<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script src="https://www.w3schools.com/lib/w3.js"></script>
<div>
	<div class="nature"><a href="${ctp}/dbShop/dbProductContent?idx=56"><img src="${ctp}/images/t2.jpg" width="107%"></a></div>
	<div class="nature"><a href="${ctp}/dbShop/dbProductContent?idx=50"><img src="${ctp}/images/t1.jpg" width="107%"></a></div>
	<div class="nature"><a href="${ctp}/dbShop/dbProductContent?idx=81"><img src="${ctp}/images/t3.jpg" width="107%"></a></div>
</div>
<script>
w3.slideshow(".nature", 2000);
</script>
