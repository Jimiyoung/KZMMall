<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbOrder.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
	  $(document).ready(function(){
		  $(".nav-tabs a").click(function(){
		    $(this).tab('show');
		  });
		  $('.nav-tabs a').on('shown.bs.tab', function(event){
		    var x = $(event.target).text();         
		    var y = $(event.relatedTarget).text(); 
		  });
		});
  
    function order() {
		  var paymentCard = document.getElementById("paymentCard").value;
    	var payMethodCard = document.getElementById("payMethodCard").value;
		  var paymentBank = document.getElementById("paymentBank").value;
    	var payMethodBank = document.getElementById("payMethodBank").value;
    	if(paymentCard == "" && paymentBank == "") {
    		alert("결제방식과 결제번호를 입력하세요.");
    		return false;
    	}
    	if(paymentCard != "" && payMethodCard == "") {
    		alert("카드번호를 입력하세요.");
    		document.getElementById("payMethodCard").focus();
    		return false;
    	}
    	else if(paymentBank != "" && payMethodBank == "") {
    		alert("입금자명을 입력하세요.");
    		return false;
    	}
    	var ans = confirm("결제하시겠습니까?");
    	if(ans) {
    		if(paymentCard != "" && payMethodCard != "") {
    			document.getElementById("payment").value = "C"+paymentCard;
    			document.getElementById("payMethod").value = payMethodCard;
    		}
    		else {
    			document.getElementById("payment").value = "B"+paymentBank;
    			document.getElementById("payMethod").value = payMethodBank;
    		}
	    	myForm.action = "${ctp}/dbShop/payment";
	    	myForm.submit();
    	}
    }
  </script>
  <style>
    td {padding: 5px}
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
<div class="container" style="width:70%">
<div class="w3-main p-5">
  <h4><b>주문서작성</b></h4>
	<br/>
	<table class="table-bordered text-center" style="margin:auto; width:100%">
	  <tr class="text-dark text-center" bgcolor="#f6f6f6" style="height:40px;" >
	    <th style="border-right:hidden; font-size:0.9em; text-align:center" >이미지</th>
	    <th style="font-size:0.9em; text-align:center">상품정보</th>
	    <th style="border-right:hidden; border-left:hidden; font-size:0.9em; text-align:center">판매가</th>
	    <th style="font-size:0.9em; text-align:center">수량</th>
	    <th style="border-left:hidden; font-size:0.9em; text-align:center">합계</th>
	  </tr>
	  <c:set var="orderTotalPrice" value="0"/>
	  <c:forEach var="vo" items="${sOrderVos}"> 
	    <tr align="center">
	      <td><img src="${ctp}/dbShop/product/${vo.thumbImg}" width="170px"/></td>
	      <td align="left">
	        <p><br/>주문번호 : ${vo.orderIdx}</p>
	        <p><br/>
	          모델명 : <span style="color:orange;font-weight:bold;">${vo.productName}</span><br/>
	        	<b><fmt:formatNumber value="${vo.mainPrice}"/>원</b>
	        </p><br/>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <p>
	          - 주문 옵션 내역 : 총 ${fn:length(optionNames)}개<br/>
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	            &nbsp; &nbsp;ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 
	          </c:forEach> 
	        </p>
	      </td>
	      <td>
	      	<b>총 : <fmt:formatNumber value="${vo.totalPrice}" pattern='#,###원'/></b>
	      </td>	
	      <td>
	       <div class="text-center">
	          <c:forEach var="i" begin="0" end="${fn:length(optionNames)-1}">
	          <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	          	${optionNums[i]}개<br/>
	          </c:forEach> 
		        <input type="hidden" id="totalPrice${listVo.idx}" value="${listVo.totalPrice}"/>
	        </div>
	      </td>
	      <td>
	      	합계
	    	</td>
	    </tr>
	    <c:set var="orderTotalPrice" value="${orderTotalPrice + vo.totalPrice}"/>
	  </c:forEach>
	</table>
	<p><br/></p>
	<hr style="border:solid 1px #868686;">
	<br/>
	<form name="myForm" method="post">
	<div class="row">
		<div class="col-sm-6"><h5 class="text-left"><b>배송정보</b></h5></div>
		<div class="col-sm-6 text-right"><h5 class="text-right"><font color="red">*</font>필수입력사항</h5></div>
	</div>	
	  <table class="table table-bordered text-center" >
	    <tr class="text-center">
			  <th style="font-size:0.8em; width:15%; padding:11px 0px 10px 18px" bgcolor="#fbfafa">받으시는 분<font color="red"> *</font></th>
			  <td style="font-size:0.8em;"><input type="text" name="buyer_name" value="${memberVo.name}" class="form-control"/></td>
			</tr>
	    <tr>
			  <th style="font-size:0.8em; padding:11px 0px 10px 18px"  bgcolor="#fbfafa">주소<font color="red"> *</font></th>
			  <c:set var="addr" value="${fn:split(memberVo.address,'/')}"/>
			  <td class="text-left">
			    <input type="text" name="buyer_postcode" value="${addr[0]}"/><br/>
			    <input type="text" name="buyer_addr" value="${addr[1]} ${addr[2]} ${addr[3]}" class="form-control"/>
			  </td>
			</tr>
	    <tr>
			  <th style="font-size:0.8em; padding:11px 0px 10px 18px"  bgcolor="#fbfafa">휴대전화<font color="red"> *</font></th>
			  <td><input type="text" name="buyer_tel" value="${memberVo.tel}" class="form-control"/></td>
			</tr>
			<tr>
			  <th style="font-size:0.8em; padding:11px 0px 10px 18px"  bgcolor="fbfafa">이메일<font color="red"> *</font></th>
			  <td><input type="text" name="buyer_email" value="${memberVo.email}" class="form-control"/></td>
			</tr>
	    <tr>
			  <th style="font-size:0.8em; padding:11px 0px 10px 18px"  bgcolor="#fbfafa">배송메세지</th>
			  <td><input type="text" name="message" class="form-control"/></td>
			</tr>
		</table>
		<hr/>
		<div>
	  <p><b>결제 예정 금액</b></p>
		<table class="text-center" style="border:2px solid #bcb8b8;margin: auto; width:100%">
		  <tr style="height:60px;" bgcolor="#fbfafa" >
		    <th class="text-center" style="font-size:0.8em;">총 주문 금액</th>
		    <th></th>
		    <th class="text-center" style="font-size:0.8em;">배송비</th>
		    <th></th>
		    <th class="text-center" style="font-size:0.8em;">총 결제예정 금액</th>
		  </tr>
		  <tr style="border:1px solid #8f8d8d; height:80px">
		    <td style="font-weight: bold; font-size:20px"><fmt:formatNumber value="${orderTotalPrice}" pattern='#,###원'/></td>
		    <td>+</td>
		    <td style="font-weight: bold; font-size:20px"><fmt:formatNumber value="${sOrderVos[0].baesong}" pattern='#,###원'/></td>
		    <td>=</td>
		    <td style="font-weight: bold; font-size:20px"><font color="orange"><b><fmt:formatNumber value="${orderTotalPrice + sOrderVos[0].baesong}" pattern='#,###'/></b></font>원</td>
		  </tr>
		</table>
		<br/>
		</div>
		<ul class="nav nav-tabs" role="tablist">
      <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#card">카드결제</a></li>
	    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#bank">은행결제</a></li>
	    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#telCheck">상담사연결</a></li>
	  </ul>
	
	  <div class="tab-content">
	    <div id="card" class="container tab-pane active"><br>
	      <h3>카드결제</h3>
	      <p>
	        <select name="paymentCard" id="paymentCard">
	          <option value="">카드선택</option>
	          <option value="국민">국민</option>
	          <option value="현대">현대</option>
	          <option value="신한">신한</option>
	          <option value="농협">농협</option>
	          <option value="BC">BC</option>
	          <option value="롯데">롯데</option>
	          <option value="삼성">삼성</option>
	        </select>
	      </p>
				<p>카드번호 : <input type="text" name="payMethodCard" id="payMethodCard"/></p>
	    </div>
	    <div id="bank" class="container tab-pane fade"><br>
	      <h3>은행결제</h3>
	      <p>
	        <select name="paymentBank" id="paymentBank">
	          <option value="">은행선택</option>
	          <option value="국민">국민(111-111-111)</option>
	          <option value="신한">신한(222-222-222)</option>
	          <option value="우리">우리(333-333-333)</option>
	          <option value="농협">농협(444-444-444)</option>
	          <option value="신협">신협(555-555-555)</option>
	        </select>
	      </p>
				<p>입금자명 : <input type="text" name="payMethodBank" id="payMethodBank"/></p>
	    </div>
	    <div id="telCheck" class="container tab-pane fade"><br>
	      <h3>전화상담</h3>
	      <p>콜센터(☎) : 02-1234-1234</p>
	    </div>
	  </div>
		<hr/>
		<div align="center">
		  <button type="button" class="button button1" onClick="order()">결제하기</button> &nbsp;
		</div>
		<input type="hidden" name="orderVos" value="${orderVos}"/>
	  <input type="hidden" name="orderIdx" value="${orderIdx}"/>  						
	  <input type="hidden" name="orderTotalPrice" value="${orderTotalPrice}"/>	
	  <input type="hidden" name="mid" value="${sMid}"/>
	  <input type="hidden" name="payment" id="payment"/>			
	  <input type="hidden" name="payMethod" id="payMethod"/>	
	  <input type="hidden" name="name" value="${cartVo.productName}"/>	
	</form>
</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>