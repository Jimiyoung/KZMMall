<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>dbMyOrder.jsp(회원 주문확인)</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script>
    function nWin(orderIdx) {
    	var url = "${ctp}/dbShop/dbOrderBaesong?orderIdx="+orderIdx;
    	window.open(url,"dbOrderBaesong","width=390px,height=430px");
    }
    
    $(document).ready(function() {
    	$("#orderStatus").change(function() {
	    	var orderStatus = $(this).val();
	    	location.href="${ctp}/dbShop/orderStatus?orderStatus="+orderStatus+"&pag=${pageVo.pag}";
    	});
    });
    
    function orderCondition(conditionDate) {
    	location.href="${ctp}/dbShop/orderCondition?conditionDate="+conditionDate+"&pag=${pageVo.pag}";
    }
    
    function myOrderStatus() {
    	var startDateJumun = new Date(document.getElementById("startJumun").value);
    	var endDateJumun = new Date(document.getElementById("endJumun").value);
    	var conditionOrderStatus = document.getElementById("conditionOrderStatus").value;
    	
    	if((startDateJumun - endDateJumun) > 0) {
    		alert("주문일자를 확인하세요!");
    		return false;
    	}
    	
    	startJumun = moment(startDateJumun).format("YYYY-MM-DD");
    	endJumun = moment(endDateJumun).format("YYYY-MM-DD");
    	location.href="${ctp}/dbShop/myOrderStatus?startJumun="+startJumun+"&endJumun="+endJumun+"&conditionOrderStatus="+conditionOrderStatus+"&pag=${pageVo.pag}";
    }
  </script>
  <style>
  	.btn{
	  	width:60px;
	  	padding:2px;
	  	font-size: 12px;
  	}
  	.Status {
		  background-color: #4a5164;
		  color: white;
		  border: none;
		  padding:4px 8px;
		  font-size: 12px;
		}
		td{font-size:0.9em; text-align: center}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:70%">
<div class="w3-main p-5">
<c:set var="conditionOrderStatus" value="${conditionOrderStatus}"/>
<c:set var="orderStatus" value="${orderStatus}"/>
<div>
  <c:set var="condition" value="전체 조회"/>
  <c:if test="${conditionDate=='1'}"><c:set var="condition" value="오늘날짜조회"/></c:if>
  <c:if test="${conditionDate=='7'}"><c:set var="condition" value="1주일 이내 조회"/></c:if>
  <c:if test="${conditionDate=='30'}"><c:set var="condition" value="1개월 이내 조회"/></c:if>
  <c:if test="${conditionDate=='90'}"><c:set var="condition" value="3개월 이내 조회"/></c:if>
  <h4><b>주문조회</b>(${condition})</h4><br/>
  <div style="border:5px solid #e8e8e8; height:74px; padding:20px">
    <div class="row">
      <div class="col-sm-5" style="text-align:left;  width:400px; font-size:0.9em;">주문조회 : 
			  <c:choose>
			    <c:when test="${conditionDate == '1'}"><c:set var="conditionDate" value="1" /></c:when>
			    <c:when test="${conditionDate == '7'}"><c:set var="conditionDate" value="7"/></c:when>
			    <c:when test="${conditionDate == '30'}"><c:set var="conditionDate" value="30"/></c:when>
			    <c:when test="${conditionDate == '90'}"><c:set var="conditionDate" value="90"/></c:when>
			    <c:otherwise><c:set var="conditionDate" value="99999"/></c:otherwise>
			  </c:choose>
			  <div class="btn-group">
	        <input type="button" class="btn btn-default" value="오늘" onclick="orderCondition(1)"/>
	        <input type="button" class="btn btn-default" value="1주일" onclick="orderCondition(7)"/>
	        <input type="button" class="btn btn-default" value="1개월" onclick="orderCondition(30)"/>
	        <input type="button" class="btn btn-default" value="3개월" onclick="orderCondition(90)"/>
	        <input type="button" class="btn btn-default" value="전체조회" onclick="orderCondition(99999)"/>
        </div>
      </div>
      <div class="col-sm-7" style="text-align:left; font-size:0.9em;">
     	 <select name="conditionOrderStatus" id="conditionOrderStatus" style="height:22px">
          <option value="전체" ${conditionOrderStatus == '전체' ? 'selected' : ''}>전체</option>
          <option value="결제완료" ${conditionOrderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
          <option value="배송중"  ${conditionOrderStatus == '배송중' ? 'selected' : ''}>배송중</option>
          <option value="배송완료"  ${conditionOrderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
          <option value="구매완료"  ${conditionOrderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
          <option value="반품처리"  ${conditionOrderStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
        </select>
        <c:if test="${startJumun == null}">
          <c:set var="startJumun" value="<%=new java.util.Date() %>"/>
	        <c:set var="startJumun"><fmt:formatDate value="${startJumun}" pattern="yyyy-MM-dd"/></c:set>
        </c:if>
        <c:if test="${endJumun == null}">
          <c:set var="endJumun" value="<%=new java.util.Date() %>"/>
	        <c:set var="endJumun"><fmt:formatDate value="${endJumun}" pattern="yyyy-MM-dd"/></c:set>
        </c:if>
        <input type="date" name="startJumun" id="startJumun" value="${startJumun}"/>~<input type="date" name="endJumun" id="endJumun" value="${endJumun}"/>
        <input type="button" value="조회"  class="Status" onclick="myOrderStatus()"/>
      </div>
    </div>
  </div>
  <br/>
  <br/>
  <div><b>주문 상품 정보</b></div>
  <br/>
  <table class="table table-hover" >
    <tr style="text-align:center; background-color:#fbfafa; font-size:0.8em;">
      <th style="text-align: center;">주문일자<br/>주문번호</th>
      <th	style="vertical-align: middle; text-align: center; height:55px;">이미지</th>
      <th style="vertical-align: middle; text-align: center;">상품정보</th>
      <th style="vertical-align: middle; text-align: center;">상품구매금액</th>
      <th style="vertical-align: middle; text-align: center;">주문처리상태</th>
    </tr>
    <tr>
    	<c:if test="${productVos.length == 0}">오늘 구매하신 상품이 없습니다.</c:if>
    </tr>
    <c:forEach var="vo" items="${vos}">
      <tr>
        <td style="vertical-align:middle;">
        	주문일자 : ${fn:substring(vo.orderDate,0,10)}<br/>
          <p>주문번호 : ${vo.orderIdx}</p>
          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
        </td>
        <td style="vertical-align:middle;">
        	<a href="${ctp}/dbShop/dbProductContent?idx=${vo.productIdx}"><img src="${ctp}/data/dbShop/product/${vo.thumbImg}" class="thumb" width="100px"/></a>
        </td>
        <td class="text-left" style="vertical-align:middle;">
	        <p>모델명 : <span style="color:orange;font-weight:bold;">${vo.productName}</span><br/> &nbsp; &nbsp; <fmt:formatNumber value="${vo.mainPrice}"/>원</p>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p>
	          - 주문 내역
	          <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	           &nbsp; &nbsp; ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
	          </c:forEach>
	        </p>
	      </td>
        <td style="vertical-align:middle;"><p>총 주문액 : <fmt:formatNumber value="${vo.totalPrice}"/>원</p></td>
        <td style="vertical-align:middle;">
        	<font color="brown">${vo.orderStatus}</font><br/> 
        	<c:if test="${vo.orderStatus eq '결제완료'}">(배송준비중)</c:if><br/>
        	<c:if test="${vo.diffTime > 6 && vo.diffTime < 13}">
        		<a href="${ctp}/dbShop/dbReview?idx=${vo.productIdx}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}"><input type="button" class="btn btn-secondary" value="후기작성" style="margin:7px"></a>
        	</c:if>
        </td>
      </tr>
    </c:forEach>
  </table>
	<div class="text-center">
		<ul class="pagination justify-content-center">
			<c:if test="${pageVo.totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
			<c:if test="${pageVo.totPage != 0}">
			  <c:if test="${pageVo.pag != 1}">
			    <li class="page-item"><a href="${ctp}/dbShop/orderCondition?conditionDate=${conditionDate}&pag=1&pageSize=${pageVo.pageSize}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${pageVo.curBlock > 0}">
			    <li class="page-item"><a href="${ctp}/dbShop/orderCondition?conditionDate=${conditionDate}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}">
			    <c:if test="${i == pageVo.pag && i <= pageVo.totPage}">
			      <li class="page-item active"><a href="${ctp}/dbShop/orderCondition?conditionDate=${conditionDate}&pag=${i}&pageSize=${pageVo.pageSize}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pageVo.pag && i <= pageVo.totPage}">
			      <li class="page-item"><a href='${ctp}/dbShop/orderCondition?conditionDate=${conditionDate}&pag=${i}&pageSize=${pageVo.pageSize}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
			    <li class="page-item"><a href="${ctp}/dbShop/orderCondition?conditionDate=${conditionDate}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pageVo.pag != pageVo.totPage}">
			    <li class="page-item"><a href="${ctp}/dbShop/orderCondition?conditionDate=${conditionDate}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
			  </c:if>
			</c:if>
		</ul>
	</div>
<p><br/></p>
</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>