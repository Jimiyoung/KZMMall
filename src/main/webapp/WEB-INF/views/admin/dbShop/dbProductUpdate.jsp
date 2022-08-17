<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbProductUpdate.jsp(상품수정)</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
    'use strict';
		let cnt = 1;
		
		function fileAppend() {
			cnt++;
			let fileBox ="";
			fileBox += '<div id="fBox'+cnt+'" class="form-group">';
			fileBox += '<input type="file" name="fName'+cnt+'" id="fName'+cnt+'"  class="form-control-file border" style="width:85%; float:left;"/>';
			fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-danger form-control ml-2" style="width:10%;"/>';
			fileBox += '</div>';
			$("#fileInsert").append(fileBox);
		}
		function deleteBox(cnt) {
			$("#fBox"+cnt).remove();	
		}
  	
	    
    function fCheck() {
    	let categoryMainCode = myForm.categoryMainCode.value;
    	let categorySubCode = myForm.categorySubCode.value;
    	let productName = myForm.productName.value;
			let mainPrice = myForm.mainPrice.value;
			let detail = myForm.detail.value;
			let file = myForm.file.value;												
			let ext = file.substring(file.lastIndexOf(".")+1);  
			let uExt = ext.toUpperCase();
			let regExpPrice = /^[0-9|_]*$/;   
			
			if(categorySubCode == "") {
				alert("상품 소분류(세분류)를 입력하세요!");
				return false;
			}
			else if(product == "") {
				alert("상품명(모델명)을 입력하세요!");
				return false;
			}
			else if(file == "") {
				alert("상품 메인 이미지를 등록하세요");
				return false;
			}
			else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
				alert("업로드 가능한 파일이 아닙니다.");
				return false;
			}
			else if(mainPrice == "" || !regExpPrice.test(mainPrice)) {
				alert("상품금액은 숫자로 입력하세요.");
				return false;
			}
			else if(detail == "") {
				alert("상품의 초기 설명을 입력하세요");
				return false;
			}
			else if(document.getElementById("file").value != "") {
				var maxSize = 1024 * 1024 * 10;  
				var fileSize = document.getElementById("file").files[0].size;
				if(fileSize > maxSize) {
					alert("첨부파일의 크기는 10MB 이내로 등록하세요");
					return false;
				}
				else {
					myForm.submit();
				}
			}
    }
    
    function categoryMainChange() {
    	var categoryMainCode = myForm.categoryMainCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/dbShop/categorySubName",
				data : {
					categoryMainCode : categoryMainCode,
				},
				success:function(data) {
					var str = "";
					str += "<option value=''>소분류</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].categorySubCode+"'>"+data[i].categorySubName+"</option>";
					}
					$("#categorySubCode").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
    
	function fSNameDelete(idx,fSName) {
		let ans = confirm("첨부파일을 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type  : "post",
			url   : "${ctp}/fSNameDelete",
			data  : {
				idx : idx,
				fSName : fSName
			},
			success:function(data) {
				if(data == "fSNameDeleteOk") {
					alert("첨부파일 삭제 완료!");
					location.reload();
				}
				else {
					alert("첨부파일 삭제 실패~~");
				}
			},
			error : function() {
				alert("전송오류~~");
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
  <div id="product">
    <h3>상품수정</h3>
    <form name="myForm" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="categoryMainCode">대분류</label>
        <select id="categoryMainCode" name="categoryMainCode"  class="form-control" onchange="categoryMainChange()">
          <option value="">대분류를 선택하세요</option>
          <c:forEach var="mainVo" items="${mainVos}">
          	<option value="${mainVo.categoryMainCode}">${mainVo.categoryMainName}</option>
          </c:forEach>
        </select>
      </div>
      <div class="form-group">
        <label for="categorySubCode">소분류</label>
        <select id="categorySubCode" name="categorySubCode" class="form-control">
          <option value="">소분류명</option>
		  	  <c:forEach var="subVo" items="${subVos}">
		  	    <option value=""></option>
		  	  </c:forEach>
        </select>
      </div>
      <div class="form-group">
        <label for="productName">상품(모델)명</label>
        <input type="text" name="productName" value="${vo.productName}" id="productName" class="form-control" placeholder="상품 모델명을 입력하세요" required />
      </div>
      <div class="form-group">
        <label for="file">메인이미지</label>
      </div>
      <div class="form-group">
      	<label for="mainPrice">상품기본가격</label>
      	<input type="text" name="mainPrice" value="${vo.mainPrice}" id="mainPrice" class="form-control" required />
      </div>
      <div class="form-group">
      	<label for="detail">상품기본설명</label>
      	<input type="text" name="detail" value="${vo.detail}" id="detail" class="form-control" required />
      </div>
      <div class="form-group">
      	<label for="content">상품상세설명</label>
      	<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required>${vo.content}</textarea>
      </div>
      <script>
		    CKEDITOR.replace("content",{
		    	uploadUrl:"${ctp}/dbShop/imageUpload",     
		    	filebrowserUploadUrl: "${ctp}/dbShop/imageUpload",  
		    	height:460
		    });
		  </script>
		  <input type="button" value="상품등록" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;
    </form>
  </div>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>