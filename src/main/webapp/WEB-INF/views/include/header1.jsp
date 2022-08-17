<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	body {font-family: Arial;}
	* {box-sizing: border-box;}
	.openBtn {
	  background: white;
	  border: none;
	  padding: 15px;
	  font-size: 20px;
	  cursor: pointer;
	}
	.overlay {
	  height: 100%;
	  width: 100%;
	  display: none;
	  position: fixed;
	  z-index: 1;
	  top: 0;
	  left: 0;
	  background-color: rgb(0,0,0);
	  background-color: rgba(0,0,0, 0.9);
	}
	.overlay-content {
	  position: relative;
	  top: 46%;
	  width: 80%;
	  text-align: center;
	  margin-top: 30px;
	  margin: auto;
	}
	.overlay .closebtn {
	  position: absolute;
	  top: 20px;
	  right: 45px;
	  font-size: 60px;
	  cursor: pointer;
	  color: white;
	}
	.overlay .closebtn:hover {color: #ccc;}
	.overlay input[type=text] {
	  padding: 15px;
	  font-size: 17px;
	  border: none;
	  float: left;
	  width: 80%;
	  background: white;
	}
	.overlay input[type=text]:hover {background: #f1f1f1;}
	.overlay button {
	  float: left;
	  width: 20%;
	  padding: 15px;
	  background: #ddd;
	  font-size: 17px;
	  border: none;
	  cursor: pointer;
	}
	.overlay button:hover {background: #bbb;}
</style>
<script>
	function openSearch() {
	  document.getElementById("myOverlay").style.display = "block";
	}

	function closeSearch() {
	  document.getElementById("myOverlay").style.display = "none";
	}
	function Productsearch() {
		let searchString=$("#searchString").val();
		
		if(searchString.trim()==""){
			alert("검색어를 입력하세요!~~");
			searchForm.searchString.focus();
		}
		else{
			searchForm.submit();
		}
	}
</script>
	<div class="container text-right" style="height:30px">
		<div class="mt-3">
			<div class="row">
			<div class="col-sm-2" style="margin-top:5px; padding:0px">
				<c:if test="${sLevel!=null}">
					<font color="#7e7d7d">*&nbsp;<font color="black"><b>${sName}</b></font>님 반갑습니다!&nbsp;*</font>
				</c:if>
			</div>
			<div class="col-sm-10" style="padding:0px">
		    <c:if test="${empty sLevel}">
		    	<a href="${ctp}/member/memLogin" class="w3-bar-item w3-button w3-padding-s w3-hide-small">로그인</a>
		    	<a href="${ctp}/member/memJoin" class="w3-bar-item w3-button w3-hide-small">회원가입</a>
		    </c:if>
		    <c:if test="${!empty sLevel}">
		    	<a href="${ctp}/member/memLogout" class="w3-bar-item w3-button w3-padding-s w3-hide-small">로그아웃</a>
		    	<a href="${ctp}/member/memPwdChange" class="w3-bar-item w3-button w3-padding-s w3-hide-small">비밀번호 변경</a>
		    	<a href="${ctp}/member/memPwdCheck" class="w3-bar-item w3-button w3-padding-s w3-hide-small">정보수정</a>
			  	<a href="${ctp}/dbShop/dbMyOrder" class="w3-bar-item w3-button w3-padding-s w3-hide-small">주문조회</a>
		      <a href="${ctp}/member/myPage" class="w3-bar-item w3-button">마이페이지</a>
	      </c:if>
		  	<div class="w3-dropdown-hover w3-hide-small">
		      <button class="w3-padding-s w3-button" title="More">고객센터 <i class="fa fa-caret-down"></i></button>     
		      <div class="w3-dropdown-content w3-bar-block w3-card-4">
		        <a href="${ctp}/notice/noticeList" class="w3-bar-item w3-button">- 공지사항</a>
		        <a href="${ctp}/as/asList" class="w3-bar-item w3-button">- A/S문의</a>
		      </div>
		    </div>
		    <c:if test="${sLevel==0}">
			  	<div class="w3-dropdown-hover w3-hide-small">
			      <button class="w3-padding-s w3-button" title="More" style="background-color:#c2e0dc">관리자 <i class="fa fa-caret-down"></i></button>     
			      <div class="w3-dropdown-content w3-bar-block w3-card-4">
			        <a href="${ctp}/dbShop/adminOrderStatus" class="w3-bar-item w3-button">주문관리</a>
			        <a href="${ctp}/admin/adMemberList" class="w3-bar-item w3-button">회원관리</a>
			        <a href="${ctp}/admin/adMemQnA" class="w3-bar-item w3-button">문의글관리</a>
			        <a href="${ctp}/admin/googleChartRecently" class="w3-bar-item w3-button">쇼핑몰분석</a>
			        <a href="${ctp}/member/qrCode" class="w3-bar-item w3-button">QR코드생성</a>
			      </div>
			    </div>
			  	<div class="w3-dropdown-hover w3-hide-small">
			      <button class="w3-padding-s w3-button" title="More" style="background-color:#cbe2f1">상품 <i class="fa fa-caret-down"></i></button>     
			      <div class="w3-dropdown-content w3-bar-block w3-card-4">
			        <a href="${ctp}/dbShop/dbCategory" class="w3-bar-item w3-button">상품분류</a>
			        <a href="${ctp}/dbShop/dbOption" class="w3-bar-item w3-button">옵션등록</a>
			        <a href="${ctp}/dbShop/dbProduct" class="w3-bar-item w3-button">상품등록</a>
			        <a href="${ctp}/dbShop/dbShopList" class="w3-bar-item w3-button">상품등록조회</a>
			      </div>
			    </div>
		    </c:if>
	    </div>
	    </div>
	  </div>
	</div>
	<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
	  <a href="#band" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Guest</a>
	  <a href="#tour" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Board</a>
	  <a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Pds</a>
	  <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Study</a>
	</div>
	<hr/>
	<div class="container" >
		<div class="text-center">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<a href="${ctp}/"><img src="${ctp}/images/logo.gif"></a>
	    </div>
	    <div class="col-sm-2 text-center mt-2">
		    <div id="myOverlay" class="overlay">
			  <span class="closebtn" onclick="closeSearch()" title="Close Overlay">×</span>
			  <div class="overlay-content">
			    <form name="search" method="get" action="${ctp}/dbShop/productSearch">
			      <input type="text" name="searchString" id="searchString">
			      <button type="submit" onclick="Productsearch()"><i class="fa fa-search"></i></button>
			    </form>
			  </div>
			</div>
			<button class="openBtn" onclick="openSearch()"><i class="fa fa-search"  style="margin-top:5px;"></i></button>
		  <a href="${ctp}/dbShop/dbCartList"><img src="${ctp}/images/cart.gif" style="width:20px;margin-top:-5px">
			  <c:if test="${sMid==null }">
			  	<div style="margin-top:-37px;margin-left:52px;"><font color="#5ac2b0"><b>0</b></font></div>
			  </c:if>
			<div style="margin-top:-37px;margin-left:52px;"><font color="#5ac2b0"><b>${sCount}</b></font></div></a>
		</div>
	</div>
	</div>
</div>  
