<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
  <title>dbCartList.jsp(장바구니)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    'use strict';
    
    function onTotal(){
      let total = 0;
      let maxIdx = document.getElementById("maxIdx").value;
      for(let i=1;i<=maxIdx;i++){
        if($("#totalPrice"+i).length != 0 && document.getElementById("idx"+i).checked){  
          total = total + parseInt(document.getElementById("totalPrice"+i).value); 
        }
      }
      document.getElementById("total").value=numberWithCommas(total);
      
      if(total>=50000||total==0){
        document.getElementById("baesong").value=0;
      } else {
        document.getElementById("baesong").value=2500;
      }
      let lastPrice=parseInt(document.getElementById("baesong").value)+total;		
      document.getElementById("lastPrice").value = numberWithCommas(lastPrice);  
      document.getElementById("orderTotalPrice").value = numberWithCommas(lastPrice); 
    }

    function onCheck(){
      let maxIdx = document.getElementById("maxIdx").value;

      let cnt=0;
      for(let i=1;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked==false){
          cnt++;
          break;
        }
      }
      if(cnt!=0){
        document.getElementById("allcheck").checked=false;
      } 
      else {
        document.getElementById("allcheck").checked=true;
      }
      onTotal();		
    }
    
    function allCheck(){
      let maxIdx = document.getElementById("maxIdx").value;
      if(document.getElementById("allcheck").checked){
        for(let i=1;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=true;
          }
        }
      }
      else {
        for(let i=1;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=false;
          }
        }
      }
      onTotal();
    }
    
    function cartDelete(idx){
      let ans = confirm("선택하신 현재상품을 장바구니에서 제거 하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : "post",
        url  : "${ctp}/dbShop/dbCartDelete",
        data : {idx : idx},
        success:function() {
          location.reload();
        },
        error : function() {
        	alert("전송에러!");
        }
      });
    }
    
    function order(){
      let maxIdx = document.getElementById("maxIdx").value;
      for(let i=1;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked){	
          document.getElementById("checkItem"+i).value="1";
        }
      }
      document.myForm.baesong.value=document.getElementById("baesong").value;
      
      if(document.getElementById("lastPrice").value==0){		
        alert("장바구니에서 주문처리할 상품을 선택해주세요!");
        return false;
      } 
      else {
        document.myForm.submit();
      }
    }
    
    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  </script>
  <style>
    .totSubBox {
      border : none;
      width : 95px;
      text-align : center;
      font-weight: bold;
      padding : 5 0px;
      color : brown;
    }
    td {padding : 5px;}
    th {text-align:center;}
    
    .button {
		  border: none;
		  color: white;
		  text-align: center;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 14px;
		  padding:0px;
		  margin:0px;
		  cursor: pointer;
		  height:48px;
		  width:120px;
		}
		.button1 {background-color:#4a5164;}
		.button2 {background-color:#f0f0f0; color:#222222; border:1px solid #d7d5d5;}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:60%">
<div class="w3-main p-5">
  <h4><b>장바구니</b></h4>
	<br/>
	<form name="myForm" method="post">
		<table class="table-bordered text-center" style="margin: auto; width:100%">
		  <tr class="text-dark" bgcolor="#f6f6f6" style="height:40px;">
		    <th><input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/></th>
		    <th style="border-right:hidden; border-left:hidden; font-size:0.9em;">이미지</th>
		    <th style="font-size:0.9em;">상품정보</th>
		    <th style="border-right:hidden; border-left:hidden; font-size:0.9em;">판매가</th>
		    <th style="font-size:0.9em;">수량</th>
		    <th style="border-left:hidden; font-size:0.9em;">선택</th>
		  </tr>
		  <c:set var="maxIdx" value="0"/>
		  <c:forEach var="listVo" items="${cartListVos}">
		    <tr align="center">
		      <td><input type="checkbox" name="idxChecked" id="idx${listVo.idx}" value="${listVo.idx}" onClick="onCheck()" /></td>
		      <td><a href="${ctp}/dbShop/dbShopContent?idx=${listVo.productIdx}"><img src="${ctp}/dbShop/product/${listVo.thumbImg}" width="150px"/></a></td>
		      <td align="left">
		        <p class="contFont"><br/>
		          모델명 : <span style="color:orange;font-weight:bold;"><a href="${ctp}/dbShop/dbShopContent?idx=${listVo.productIdx}">${listVo.productName}</a></span><br/>
		        </p>
		        <c:set var="optionNames" value="${fn:split(listVo.optionName,',')}"/>
		        <c:set var="optionPrices" value="${fn:split(listVo.optionPrice,',')}"/>
		        <p style="font-size:12px">
		          - 주문 내역
		          <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
		          <c:forEach var="i" begin="0" end="${fn:length(optionNames)-1}">
		            &nbsp;&nbsp;ㆍ${optionNames[i]} / <fmt:formatNumber value="${optionPrices[i]}"/>원<br/>
		          </c:forEach> 
		        </p>
		      </td>
		      <td><b><fmt:formatNumber value="${listVo.totalPrice}" pattern='#,###원'/></b></td>
		      <td>
		        <div class="text-center">
		          <c:forEach var="i" begin="0" end="${fn:length(optionNames)-1}">
		          <c:set var="optionNums" value="${fn:split(listVo.optionNum,',')}"/>
		          	${optionNums[i]}개<br/>
		          </c:forEach> 
			        <input type="hidden" id="totalPrice${listVo.idx}" value="${listVo.totalPrice}"/>
		        </div>
		      </td>
		      <td>
		        <button type="button" onClick="cartDelete(${listVo.idx})" class="btn btn-danger btn-sm m-1" style="border:0px;">삭제</button>
		        <input type="hidden" name="checkItem" value="0" id="checkItem${listVo.idx}"/>	
		        <input type="hidden" name="idx" value="${listVo.idx }"/>
		        <input type="hidden" name="thumbImg" value="${listVo.thumbImg}"/>
		        <input type="hidden" name="productName" value="${listVo.productName}"/>
		        <input type="hidden" name="mainPrice" value="${listVo.mainPrice}"/>
		        <input type="hidden" name="optionName" value="${optionNames}"/>
		        <input type="hidden" name="optionPrice" value="${optionPrices}"/>
		        <input type="hidden" name="optionNum" value="${optionNums}"/>
		        <input type="hidden" name="totalPrice" value="${listVo.totalPrice}"/>
		        <input type="hidden" name="mid" value="${sMid}"/>
		      </td>
		    </tr>
		    <c:set var="maxIdx" value="${listVo.idx}"/>	
		  </c:forEach>
		</table>
	  <input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
	  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
    <input type="hidden" name="baesong"/>
	</form>
	<br/>
  <div class="text-center">
   <c:if test="${empty cartListVos}">장바구니가 비어 있습니다.<br/><br/><br/></c:if>
   <c:if test="${!empty cartListVos}">
	  <p class="text-center"><b>실제 주문총금액</b>(구매하실 상품에 체크해 주세요. 총주문금액이 산출됩니다.)</p>
		<table class="text-center" style="border:2px solid #bcb8b8;margin: auto; width:100%">
		  <tr style="height:60px;" bgcolor="#fbfafa" >
		    <th>총 상품금액</th>
		    <th></th>
		    <th>배송비</th>
		    <th></th>
		    <th>결제예정금액</th>
		  </tr>
		  <tr style="border:1px solid #8f8d8d; height:80px">
		    <td><input type="text" id="total" value="0" class="totSubBox" readonly/></td>
		    <td>+</td>
		    <td><input type="text" id="baesong" value="0" class="totSubBox" readonly/></td>
		    <td>=</td>
		    <td><input type="text" id="lastPrice" value="0" class="totSubBox" readonly/></td>
		  </tr>
		</table>
		<br/>
		</c:if>
	<div class="text-center">
	  <button class="button button1" onClick="order()">주문하기</button> &nbsp;
	  <button class="button button2" onClick="location.href='${ctp}/';">쇼핑계속하기</button>
	</div>
</div>
</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>