<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<div class="mySlides w3-display-container w3-center">
  <a href="${ctp}/dbShop/dbProductList?categoryMainCode=T"><img src="${ctp}/images/main1.jpg" style="width:100%"></a>
  <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
    <h3>텐트&타프</h3>
  </div>
</div>
<div class="mySlides w3-display-container w3-center">
  <a href="${ctp}/dbShop/dbProductList?categoryMainCode=U"><img src="${ctp}/images/main2.jpg" style="width:100%"></a>
  <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
    <h3>테이블</h3>
  </div>
</div>
<div class="mySlides w3-display-container w3-center">
  <a href="${ctp}/dbShop/dbProductList?categoryMainCode=C"><img src="${ctp}/images/main3.jpg" style="width:100%"></a>
  <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
    <h3>체어</h3>
  </div>
</div>
<div class="mySlides w3-display-container w3-center">
  <a href="${ctp}/dbShop/dbProductList?categoryMainCode=K"><img src="${ctp}/images/main4.jpg" style="width:100%"></a>
  <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
    <h3>키친&바베큐</h3>
  </div>
</div>
<script>
var myIndex = 0;
carousel();

function carousel() {
  var i;
  var x = document.getElementsByClassName("mySlides");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  myIndex++;
  if (myIndex > x.length) {myIndex = 1}    
  x[myIndex-1].style.display = "block";  
  setTimeout(carousel, 4000);    
}

function myFunction() {
  var x = document.getElementById("navDemo");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }
}

</script>

