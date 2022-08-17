<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>MyPage</title>
  <meta charset="UTF-8">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:60%">
<div class="w3-main p-5">
	<h4><b>마이페이지</b></h4>
	<br/>
	<div style="border:1px solid #d7d5d5; height:90px">
		<div class="row">
			<div class="col-sm-2">
				<img src="${ctp}/images/member.gif" style="margin:10px">
			</div>
			<div class="col-sm-10; text-center" style="padding-top:20px; padding-left:170px;">
				<div>
					<font color="#01253e"><b>${sMid}</b></font>님은 <font color="#fd8103"><b>${sStrLevel}</b></font>입니다.
	      	<p>저희 쇼핑몰을 이용해 주셔서 감사합니다.</p>
	      </div>
			</div>	
		</div>
	</div>
	<br/><br/>
	<div class="text-center" >
		<div class="row">
			<div class="col-sm-2" style="margin-left:-30px"></div>
			<div class="col-sm-3">
				<a href="${ctp}/dbShop/dbMyOrder">
					<div class="text-center" style="border:1px solid #d7d5d5; width:220px">
						<img src="${ctp}/images/order.JPG" style="width:200px">
						<p><font color="#8f9296">고객님께서 주문하신<br>상품의 주문내역을<br/>확인하실 수 있습니다.</font><p>
					</div>
				</a>
			</div>	
			<div class="col-sm-3" style="margin:0px">
				<a href="${ctp}/member/memPwdCheck">
					<div class="text-center" style="border:1px solid #d7d5d5; width:220px">
						<img src="${ctp}/images/profile.JPG" style="width:200px">
						<p><font color="#8f9296">회원이신 고객님의<br>개인정보를 관리하는<br/>공간입니다.</font><p>
					</div>
				</a>
			</div>	
			<div class="col-sm-3">
				<a href="${ctp}/member/memBoard">
					<div class="text-center" style="border:1px solid #d7d5d5; width:220px">
						<img src="${ctp}/images/board.JPG" style="width:200px">
						<p><font color="#8f9296">고객님께서 작성하신<br>게시물을 관리하는<br/>공간입니다.</font><p>
					</div>
				</a>
			</div>
			<div class="col-sm-1"></div>	
		</div>
	</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>