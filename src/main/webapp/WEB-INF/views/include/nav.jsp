<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
	<br/>
	<hr style="margin:0px;"/>
	<div style="margin:0px 270px">
	<div class="container text-center" >
  	<a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <a href="${ctp}/dbShop/dbProductList?categoryMainCode=T" class="w3-bar-item w3-button" style="padding:11px"><button class="w3-padding-small w3-button" title="More"><b>텐트&타프</b></button></a>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=001" class="w3-bar-item w3-button">리빙쉘/돔텐트</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=002" class="w3-bar-item w3-button">타프/타프쉘</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=003" class="w3-bar-item w3-button">팝업/그늘막</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <a href="${ctp}/dbShop/dbProductList?categoryMainCode=U" class="w3-bar-item w3-button p-2" style="padding:11px"><button class="w3-padding-small w3-button" title="More"><b>테이블</b></button></a>   
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=004" class="w3-bar-item w3-button">아이언 메쉬 테이블</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=005" class="w3-bar-item w3-button">MDF 테이블</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=006" class="w3-bar-item w3-button">우드 테이블</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=007" class="w3-bar-item w3-button">IMS테이블</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <a href="${ctp}/dbShop/dbProductList?categoryMainCode=C" class="w3-bar-item w3-button p-2" style="padding:11px"><button class="w3-padding-small w3-button" title="More"><b>체어</b></button></a>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=008" class="w3-bar-item w3-button">릴렉스 체어</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=009" class="w3-bar-item w3-button">로우/미니체어</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=010" class="w3-bar-item w3-button">해먹/야전침대</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=011" class="w3-bar-item w3-button">체어 소품</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <a href="${ctp}/dbShop/dbProductList?categoryMainCode=K" class="w3-bar-item w3-button" style="padding:11px"><button class="w3-padding-small w3-button" title="More"><b>키친&바베큐</b></button></a>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=012" class="w3-bar-item w3-button">코펠/식기류</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=013" class="w3-bar-item w3-button">조리도구/버너</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=014" class="w3-bar-item w3-button">아이스 쿨러</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=015" class="w3-bar-item w3-button">주방 소품</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=016" class="w3-bar-item w3-button">화로대/바베큐</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <a href="${ctp}/dbShop/dbProductList?categoryMainCode=M" class="w3-bar-item w3-button" style="padding:11px"><button class="w3-padding-small w3-button" title="More"><b>침낭&매트</b></button></a>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=017" class="w3-bar-item w3-button">침낭</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=018" class="w3-bar-item w3-button">매트</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <a href="${ctp}/dbShop/dbProductList?categoryMainCode=B" class="w3-bar-item w3-button" style="padding:11px"><button class="w3-padding-medium w3-button" title="More"><b>캐리백&캠핑소품&장비</b></button></a>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=019" class="w3-bar-item w3-button">랜턴</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=020" class="w3-bar-item w3-button">캐리백</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=021" class="w3-bar-item w3-button">캠핑소품</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=022" class="w3-bar-item w3-button">캠핑장비</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=023" class="w3-bar-item w3-button">웨건</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <a href="${ctp}/dbShop/dbProductList?categoryMainCode=S" class="w3-bar-item w3-button" style="padding:11px"><button class="w3-padding-small w3-button" title="More"><b>낚시대&릴</b></button></a>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=024" class="w3-bar-item w3-button">선상낚시대</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=025" class="w3-bar-item w3-button">원투낚시대</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=026" class="w3-bar-item w3-button">릴</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <a href="${ctp}/dbShop/dbProductList?categoryMainCode=D" class="w3-bar-item w3-button" style="padding:11px"><button class="w3-padding-small w3-button" title="More"><b>낚시장비</b></button></a>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=027" class="w3-bar-item w3-button">구명조끼</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=028" class="w3-bar-item w3-button">가방</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=029" class="w3-bar-item w3-button">공구</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=030" class="w3-bar-item w3-button">악세사리</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <a href="${ctp}/dbShop/dbProductList?categoryMainCode=Q" class="w3-bar-item w3-button" style="padding:11px"><button class="w3-padding-small w3-button" title="More"><b>낚시소품</b></button></a>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=031" class="w3-bar-item w3-button">낚시줄</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=032" class="w3-bar-item w3-button">봉돌</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=033" class="w3-bar-item w3-button">채비</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <a href="${ctp}/dbShop/dbProductList?categoryMainCode=V" class="w3-bar-item w3-button" style="padding:11px"><button class="w3-padding-meddium w3-button" title="More"><b>해루질용품</b></button></a>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=034" class="w3-bar-item w3-button">조과통/수경</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=035" class="w3-bar-item w3-button">장화/장갑</a>
	        <a href="${ctp}/dbShop/dbProductList?categorySubCode=036" class="w3-bar-item w3-button">뜰채/장비</a>
	      </div>
	    </div>
  </div>
  </div>
  <hr style="margin:0px;"/>
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="#band" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Guest</a>
  <a href="#tour" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Board</a>
  <a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Pds</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Study</a>
</div>