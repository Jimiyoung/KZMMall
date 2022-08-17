<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
.carousel-inner > .item > img,
.carousel-inner > .item > a > img {
  width: 100%;
}
</style>
<div class="container col-sm-6">
  <br>
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <div class="w3-container" style="width: 1200px">
    <div>
    	<a href="#myCarousel" role="button" data-slide="prev">
	    	<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		    <span class="sr-only">Previous</span>
	    </a>
	  </div>  
    <div class="w3-center carousel-inner " role="listbox" style="width: 600px">
      <div class="item active" style="text-align:left">
	      <a href="${ctp}/dbShop/dbProductContent?idx=56">
	        <img src="${ctp}/images/a1.jpg">
	        <h4><b>KZM CAMPING TOOL CASE</b></h4>
	        <h6>_</h6>
	        <h3><b>여러 사이즈의 팩, 망치 등을 보관할 수 있는 툴 케이스</b></h3>
	        <h5>컨버스 원단으로 제작되어 감성적인 디자인은 물론 강한 내구성을 가지고 있으며</h5>
	        <h5>용품을 종류, 크기별로 나눠 넣을 수 있어 실용적인 툴 케이스입니다.</h5>
        </a>
      </div>
      <div class="item" style="text-align:left">
        <img src="${ctp}/images/a3.jpg">
        <h4><b>KZM CAMPING SPINNER</b></h4>
        <h6>_</h6>
        <h3><b>감성적인 분위기의 유니크한 윈드 콘 스피너 </b></h3>
        <h5>감성적인 분위기를 연출하기 좋은 유니크한 디자인의 스피너로</h5>
        <h5>분위기 있는 나만의 공간을 만들기에 좋습니다.</h5>
      </div>
      <div class="item" style="text-align:left">
        <img src="${ctp}/images/a2.jpg">
        <h4><b>KZM CAMPING KITCHEN ITEM</b></h4>
        <h6>_</h6>
        <h3><b>바람을 효과적으로 차단해주는 비엔토 윈드 쉴드</b></h3>
        <h5>감성적인 디자인과 스틸 재질의 강한 내구성을 가지고 있으며</h5>
        <h5>바람을 효과적으로 차단해 버너 사용의 효율을 높여줍니다.</h5>
      </div>
    </div>
    <div>
	    <a href="#myCarousel" role="button" data-slide="next">
	      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	      <span class="sr-only">Next</span>
  	  </a>
	  </div>  
    </div>
  </div>
</div>