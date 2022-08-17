<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbOrderProcess.jsp(회원 주문확인)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script>
    'use strict';
    
    $(document).ready(function() {
			document.getElementById("startJumun").value = new Date('${startJumun}').toISOString().substring(0,10);
			document.getElementById("endJumun").value = new Date('${endJumun}').toISOString().substring(0,10);
    });
  
    function nWin(orderIdx) {
    	var url = "${ctp}/dbShop/dbOrderBaesong?orderIdx="+orderIdx;
    	window.open(url,"dbOrderBaesong","width=350px,height=400px");
    }
    
    $(document).ready(function() {
    	$("#orderStatus").change(function() {
	    	let startJumun = document.getElementById("startJumun").value;
	    	let endJumun = document.getElementById("endJumun").value;
	    	let orderStatus = $(this).val();
	    	location.href="${ctp}/dbShop/adminOrderStatus?startJumun="+startJumun+"&endJumun="+endJumun+"&orderStatus="+orderStatus;
    	});
    	
    	$("#orderDateSearch").click(function() {
	    	let startJumun = document.getElementById("startJumun").value;
	    	let endJumun = document.getElementById("endJumun").value;
	    	let orderStatus = $(this).val();
	    	location.href="${ctp}/dbShop/adminOrderStatus?startJumun="+startJumun+"&endJumun="+endJumun+"&orderStatus="+orderStatus;
    	});
    });
    
    function orderProcess(orderIdx) {
    	let orderStatus = document.getElementById("goodsStatus"+orderIdx).value;
    	let ans = confirm("주문상태("+orderStatus+")를 변경하시겠습니까?");
    	if(!ans) {
    		location.reload();
    		return false;
    	}
  		let query = {
  				orderIdx : orderIdx,
  				orderStatus : orderStatus
  		};
  		$.ajax({
  			type  : "post",
  			url   : "${ctp}/dbShop/goodsStatus",
  			data  : query,
  			success : function(data) {
  				location.reload();
  			},
  			error : function() {
  				alert("전송오류!");
  			}
    	});
    }
  </script>
  <style>
  	.S {
		  background-color: #4a5164;
		  color: white;
		  border: none;
		  padding:4px 8px;
		  font-size: 12px;
		}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:65%">
<div class="w3-main p-5">
<c:set var="orderStatus" value="${orderStatus}"/>
  <h4><b>주문/배송 확인</b></h4>
  <br/>
 	<div style="border:5px solid #e8e8e8; height:74px; padding:22px">
	  <div class="row">
	    <div class="col-sm-5" style="text-align:left;  width:400px; font-size:0.9em;">주문/배송일자 조회 : 
			  <input type="date" name="startJumun" id="startJumun"/> ~ <input type="date" name="endJumun" id="endJumun"/>
	      <button type="button" id="orderDateSearch" class="S">조회</button>
	    </div>
	    <div class="col-sm-7" style="text-align:left; font-size:0.9em;">(날짜선택후)주문상태조회 :
	   	 <select name="orderStatus" id="orderStatus">
	        <option value="전체"    ${orderStatus == '전체'    ? 'selected' : ''}>전체</option>
	        <option value="결제완료" ${orderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
	        <option value="배송중"  ${orderStatus == '배송중'   ? 'selected' : ''}>배송중</option>
	        <option value="배송완료" ${orderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
	        <option value="구매완료" ${orderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
	        <option value="반품처리" ${orderStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
	      </select>
	    </div>
	  </div>
	</div>
	<br/><br/>
  <table class="table table-hover">
    <tr style="text-align:center;background-color:#fbfafa; font-size:0.8em;">
      <th style="text-align: center; height:35px;">주문정보</th>
      <th style="text-align: center;">상품</th>
      <th style="text-align: center;">주문내역</th>
      <th style="text-align: center;">주문일시</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
      <tr>
        <td style="text-align:center;">
          <p>주문번호 : ${vo.orderIdx}</p>
          <p>총 주문액 : <fmt:formatNumber value="${vo.totalPrice}"/>원</p>
          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
        </td>
        <td style="text-align:center;"><img src="${ctp}/data/dbShop/product/${vo.thumbImg}" class="thumb" width="100px"/></td>
        <td align="left">
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
        <td style="text-align:center;"><br/>
          주문일자 : ${fn:substring(vo.orderDate,0,10)}<br/><br/>
          <form name="myForm">
	          <div>
	            주문상태:
		          <select name="goodsStatus" id="goodsStatus${vo.orderIdx}" onchange="orderProcess(${vo.orderIdx})">
			          <option value="결제완료" ${vo.orderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
			          <option value="배송중"  ${vo.orderStatus == '배송중' ? 'selected' : ''}>배송중</option>
			          <option value="배송완료"  ${vo.orderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
			          <option value="구매완료"  ${vo.orderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
			          <option value="반품처리"  ${vo.orderStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
		          </select>
	          </div>
	        </form>
        </td>
      </tr>
    </c:forEach>
  </table>
  <hr/>
<p><br/></p>
	<div class="text-center">
		<ul class="pagination justify-content-center">
			<c:if test="${pageVo.totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
			<c:if test="${pageVo.totPage != 0}">
			  <c:if test="${pageVo.pag != 1}">
			    <li class="page-item"><a href="${ctp}/dbShop/adminOrderStatus?startJumun=${startJumun}&endJumun=${endJumun}&&orderStatus=${orderStatus}&pag=1&pageSize=${pageVO.pageSize}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${pageVo.curBlock > 0}">
			    <li class="page-item"><a href="${ctp}/dbShop/adminOrderStatus?startJumun=${startJumun}&endJumun=${endJumun}&&orderStatus=${orderStatus}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*blockSize)+pageVo.blockSize}">
			    <c:if test="${i == pageVo.pag && i <= pageVo.totPage}">
			      <li class="page-item active"><a href='${ctp}/dbShop/adminOrderStatus?startJumun=${startJumun}&endJumun=${endJumun}&&orderStatus=${orderStatus}&pag=${i}&pageSize=${pageVo.pageSize}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pageVo.pag && i <= pageVo.totPage}">
			      <li class="page-item"><a href='${ctp}/dbShop/adminOrderStatus?startJumun=${startJumun}&endJumun=${endJumun}&&orderStatus=${orderStatus}&pag=${i}&pageSize=${pageVo.pageSize}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
			    <li class="page-item"><a href="${ctp}/dbShop/adminOrderStatus?startJumun=${startJumun}&endJumun=${endJumun}&&orderStatus=${orderStatus}&pag=${(pageVo.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVo.pageSize}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pageVo.pag != pageVo.totPage}">
			    <li class="page-item"><a href="${ctp}/dbShop/adminOrderStatus?startJumun=${startJumun}&endJumun=${endJumun}&&orderStatus=${orderStatus}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
			  </c:if>
			</c:if>
		</ul>
	</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>