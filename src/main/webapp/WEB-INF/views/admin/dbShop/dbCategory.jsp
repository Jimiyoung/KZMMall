<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>Category.jsp(상품 분류)</title>
  <meta charset="UTF-8">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<script>
  	'use strict';
  
    // 대분류 등록하기 
    function categoryMainCheck() {
    	let categoryMainCode = categoryMainForm.categoryMainCode.value;
    	let categoryMainName = categoryMainForm.categoryMainName.value;
    	if(categoryMainCode == "" || categoryMainName == "") {
    		alert("대분류명(코드)을 입력하세요");
    		categoryMainForm.categoryMainName.focus();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categoryMainInput",
    		data : {
    			categoryMainCode : categoryMainCode,
    			categoryMainName : categoryMainName
    		},
    		success:function(res) {
    			if(res == "0") {
    				alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요.");
    			}
    			else {
    				alert("대분류가 등록되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert('전송오류!');
    		}
    	});
    }
    
    // 소분류 등록하기 
    function categorySubCheck() {
    	let categoryMainCode = categorySubForm.categoryMainCode.value;
    	let categorySubCode = categorySubForm.categorySubCode.value;
    	let categorySubName = categorySubForm.categorySubName.value;
    	if(categoryMainCode == "") {
    		alert("대분류명을 선택하세요");
    		return false;
    	}
    	if(categorySubCode == "") {
    		alert("소분류코드를 입력하세요");
    		categorySubForm.categorySubCode.focus();
    		return false;
    	}
    	if(categorySubName == "") {
    		alert("소분류명을 입력하세요");
    		categorySubForm.categorySubName.focus();
    		return false;
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categorySubInput",
    		data : {
    			categoryMainCode : categoryMainCode,
    			categorySubCode : categorySubCode,
    			categorySubName : categorySubName
    		},
    		success:function(data) {
    			if(data == "0") {
    				alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요.");
    			}
    			else {
    				alert("소분류가 등록되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert('전송오류!');
    		}
    	});
    }
    
    // 대분류 삭제
    function delCategoryMain(categoryMainCode) {
    	let ans = confirm("대분류항목을 삭제하시겠습니까?");
    	if(!ans) return false;
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/delCategoryMain",
    		data : {categoryMainCode : categoryMainCode},
    		success:function(data) {
    			if(data == "0") {
    				alert("하위항목이 있기에 삭제할 수 없습니다.\n하위항목을 먼저 삭제하세요.");
    			}
    			else {
    				alert("대분류 항목이 삭제 되었습니다.");
    				location.reload();
    			}
    		}
    	});
    }
    
    // 소분류 삭제
    function delCategorySub(categorySubCode) {
    	let ans = confirm("소분류항목을 삭제하시겠습니까?");
    	if(!ans) return false;
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/delCategorySub",
    		data : {categorySubCode : categorySubCode},
    		success:function(data) {
    			if(data == "0") {
    				alert("하위항목이 있기에 삭제할 수 없습니다.\n하위항목을 먼저 삭제하세요.");
    			}
    			else {
    				alert("소분류 항목이 삭제 되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert('전송오류!');
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header1.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="width:60%">
	<div class="w3-main p-5">
	<h4><b>상품 분류 등록하기</b></h4>
  <hr/>
  <form name="categoryMainForm">
  	<h5><b>대분류(항목분류) 관리(코드는 영문대문자1자리)</b></h5>
  	대분류코드(A,B,C,...)
  	<input type="text" name="categoryMainCode" size="2"/>, &nbsp;
  	대분류명
  	<input type="text" name="categoryMainName" size="8"/> &nbsp;
  	<input type="button" value="대분류등록" onclick="categoryMainCheck()" class="btn btn-default btn-sm"/>
	  <table class="table table-hover m-3 text-center">
	    <tr class="text-center">
	      <th class="text-center">대분류코드</th>
	      <th class="text-center">대분류명</th>
	      <th class="text-center">삭제</th>
	    </tr>
	    <c:forEach var="mainVo" items="${mainVos}" varStatus="st">
	    	<tr>
	    	  <td>${mainVo.categoryMainCode}</td>
	    	  <td>${mainVo.categoryMainName}</td>
	    	  <td><input type="button" value="삭제" onclick="delCategoryMain('${mainVo.categoryMainCode}')" class="btn btn-danger btn-sm"/></td>
	    	</tr>
	    </c:forEach>
	  </table>
  </form>
  <hr/>
  <form name="categorySubForm">
  	<h5><b>소분류 관리(코드는 숫자 3자리)</b></h5>
  	<select name="categoryMainCode">
  	  <option value="">대분류명</option>
  	  <c:forEach var="mainVo" items="${mainVos}">
  	    <option value="${mainVo.categoryMainCode}">${mainVo.categoryMainName}</option>
  	  </c:forEach>
  	</select>
  	소분류코드(001,002,..)
  	<input type="text" name="categorySubCode" size="1"/> , &nbsp;
  	소분류명
  	<input type="text" name="categorySubName" size="3"/> &nbsp;
  	<input type="button" value="소분류등록" onclick="categorySubCheck()" class="btn btn-default btn-sm"/>
	  <table class="table table-hover m-3">
	    <tr class="text-center">
	      <th class="text-center">소분류코드명</th>
	      <th class="text-center">소분류명</th>
	      <th class="text-center">대분류명</th>
	      <th class="text-center">삭제</th>
	    </tr>
	    <c:forEach var="subVo" items="${subVos}" varStatus="st">
	    	<tr class="text-center">
	    	  <td>${subVo.categorySubCode}</td>
	    	  <td>${subVo.categorySubName}</td>
	    	  <td>${subVo.categoryMainName}</td>
	    	  <td><input type="button" value="삭제" onclick="delCategorySub('${subVo.categorySubCode}')" class="btn btn-danger btn-sm"/></td>
	    	</tr>
	    </c:forEach>
	  </table>
  </form>
  <hr/>
</div>
<br/>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>