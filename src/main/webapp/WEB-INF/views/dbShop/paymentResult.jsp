<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>paymentResult.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
	  function nWin(orderIdx) {
	  	var url = "${contextPath}/dbShop/dbOrderBaesong?orderIdx="+orderIdx;
	  	window.open(url,"dbOrderBaesong","width=350px,height=400px");
	  }
  </script>
  <style>
  	th{
  		font-size:0.9em;
  		text-align:center;
  	}
  	.button {
			  border: none;
			  color: white;
			  text-align: center;
			  text-decoration: none;
			  display: inline-block;
			  font-size: 12px;
			  margin: 4px 2px;
			  cursor: pointer;
			  height:50px;
			  width:110px;
			}
			.button1 {border-radius:2px; background-color:#4a5164; width:100px; height:27px; font-size: 12px;}
			.button2 {border-radius:2px; background-color:#3cc2b1;}
			.button3 {border-radius:2px; background-color:#0a253e;}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:70%">
<div class="w3-main p-5">
  <div class="text-center" style="margin:40px">
  	<h4><b>주문해 주셔서 감사합니다.</b></h4>
	</div>
  <div style="font-size:1.1em; margin:10px"><b>주문내역</b></div>
  <table class="table table-bordered">
    <tr class="text-dark text-center" bgcolor="#f6f6f6">
      <th>상품이미지</th>
      <th>주문일시</th>
      <th>주문내역</th>
      <th>비고</th>
    </tr>
    <c:forEach var="vo" items="${sOrderVos}">
      <tr>
        <td style="text-align:center;">
          <img src="${ctp}/dbShop/product/${vo.thumbImg}" width="150px"/>
        </td>
        <td style="text-align:center;"><br/>
          <p>주문번호 : ${vo.orderIdx}</p>
          <p>총 주문액 : <fmt:formatNumber value="${vo.totalPrice}"/>원</p>
          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
        </td>
        <td align="left">
	        <p><br/>모델명 : <span style="color:orange;font-weight:bold;">${vo.productName}</span><br/> &nbsp; &nbsp; <fmt:formatNumber value="${vo.mainPrice}"/>원</p><br/>
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
        <td style="text-align:center;vertical-align:middle;">결제완료<br/>(배송준비중)</td>
      </tr>
    </c:forEach>
  </table>
  <br/>
  <div style="font-size:1.1em; margin:10px"><b>주문상세정보</b></div>
  	<table class="table">
  		<tr>
  			<th>주문 물품명</th>
  			<td>${sPayMentVo.name}</td>
  		</tr>
  		<tr>
  			<th>주문금액</th>
  			<td>${sPayMentVo.amount}(실제구매금액:${orderTotalPrice})</td>
  		</tr>
  		<tr>
  			<th>주문자 메일주소</th>
  			<td>${sPayMentVo.buyer_email}</td>
  		</tr>
  		<tr>
  			<th>주문자 성명</th>
  			<td>${sPayMentVo.buyer_name}</td>
  		</tr>
  		<tr>
  			<th>주문자 전화번호</th>
  			<td>${sPayMentVo.buyer_tel}</td>
  		</tr>
  		<tr>
  			<th>주문자 주소</th>
  			<td>${sPayMentVo.buyer_tel}</td>
  		</tr>
  		<tr>
  			<th>주문자 우편번호</th>
  			<td>${sPayMentVo.buyer_postcode}</td>
  		</tr>
  		<tr>
  			<th>결제 고유ID</th>
  			<td>${sPayMentVo.imp_uid}</td>
  		</tr>
  		<tr>
  			<th>결제 상점 거래 ID</th>
  			<td>${sPayMentVo.merchant_uid}</td>
  		</tr>
  		<tr>
  			<th>결제 금액</th>
  			<td>${sPayMentVo.paid_amount}</td>
  		</tr>
  		<tr>
  			<th>카드 승인번호</th>
  			<td>${sPayMentVo.apply_num}</td>
  		</tr>
  		<tr><td colspan="2" class="p-0"></td></tr>
  	</table>
  <p class="text-center">
    <input type="button" value="계속쇼핑하기" onclick="location.href='${ctp}/';" class="button button3"/>
    <input type="button" value="구매내역보기" onclick="location.href='${ctp}/dbShop/dbMyOrder';" class="button button2"/>
  </p>
</div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>