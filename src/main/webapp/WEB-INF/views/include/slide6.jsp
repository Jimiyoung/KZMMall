<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
.my {display:none;}
</style>
<div class="w3-content w3-display-container">
	<div class="my">
		<div style="text-align:left">
			<a href="${ctp}/dbShop/dbProductContent?idx=203">
  			<img src="${ctp}/images/a1.jpg" style="width:570px">
			</a>
  		<br/>
      <h4><b>KZM CAMPING TOOL CASE</b></h4>
      <h6>_</h6>
      <h4><b>여러 사이즈의 팩, 망치 등을 보관할 수 있는 툴 케이스</b></h4>
      <h5>컨버스 원단으로 제작되어 감성적인 디자인은 물론 강한 내구성을 가지고 있으며</h5>
      <h5>용품을 종류, 크기별로 나눠 넣을 수 있어 실용적인 툴 케이스입니다.</h5>
    </div>
	</div>
	<div class="my">
		<div style="text-align:left">
			<a href="${ctp}/dbShop/dbProductContent?idx=229">
		 	  <img src="${ctp}/images/a3.jpg" style="width:570px">
	 	  </a>  
	 	  <br/>
      <h4><b>KZM CAMPING SPINNER</b></h4>
      <h6>_</h6>
      <h4><b>감성적인 분위기의 유니크한 윈드 콘 스피너 </b></h4>
      <h5>감성적인 분위기를 연출하기 좋은 유니크한 디자인의 스피너로</h5>
      <h5>분위기 있는 나만의 공간을 만들기에 좋습니다.</h5>
    </div>
	</div>
	<div class="my">
		<div style="text-align:left">
			<a href="${ctp}/dbShop/dbProductContent?idx=145">
		    <img src="${ctp}/images/a2.jpg" style="width:570px">
			</a>  
	    <br/>
	    <h4><b>KZM CAMPING KITCHEN ITEM</b></h4>
	    <h6>_</h6>
	    <h4><b>바람을 효과적으로 차단해주는 비엔토 윈드 쉴드</b></h4>
	    <h5>감성적인 디자인과 스틸 재질의 강한 내구성을 가지고 있으며</h5>
	    <h5>바람을 효과적으로 차단해 버너 사용의 효율을 높여줍니다.</h5>
	  </div>
	</div>
  <button class="w3-button w3-black w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
  <button class="w3-button w3-black w3-display-right" onclick="plusDivs(1)">&#10095;</button>
</div>

<script>
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("my");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  x[slideIndex-1].style.display = "block";  
}
</script>

