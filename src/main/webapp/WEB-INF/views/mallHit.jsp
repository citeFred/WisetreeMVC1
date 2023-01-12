<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="container" style="text-align:center">

<div class = "row">
   <div class = "col-md-12">
      <h1 class = "badge badge-warning">${param.quality}</h1>
   </div>
</div>

<div class = "row">

	<c:if test="${itemList eq null or empty itemList}">
		<div class="col-md-3">
			<h4>상품 준비 중</h4>
		</div>
	</c:if>
	<c:if test="${itemList ne null and not empty itemList}">
	 <c:forEach var="pd" items="${itemList}">
	      <div class = "col-md-3" style="text-align:center">
	         <a href="prodDetail2?itemNo=${pd.itemNo}">
	         <c:if test="${pd.itemImage1 ne null}">
	         <img src="resources/product_images/${pd.itemImage1}"
	          style="width:90%;margin:auto;"
	          class= "img-fluid">
	 		</c:if>
	 		<c:if test="${pd.itemImage1 eq null}">
	         <img src = "product_images/noimage.png" class = "img-fluid" style = "height:220px">
	 		</c:if> 
	         </a>
	         <br><br>
	         <h4> ${pd.itemName} </h4>
	         <%-- <del> 
				<fmt:formatNumber value="${pd.price}" pattern="###,###"/>
	         </del> 원 <br> --%>
	         <span style="color:blue;font-weight:bold"> 
	         	<fmt:formatNumber value="${pd.saleprice}" pattern="###,###"/>
	         </span> 원 <br>
	         <!-- Product actions-->
             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
             	<div class="text-center">
             		<a class="btn btn-outline-dark mt-auto" href="prodDetail2?itemNo=${pd.itemNo}">상세 페이지</a>
             	</div>
             </div>
	        <%--  <span class = "label label-danger">${pd.percent} %</span> <br>
	         <span class = "label label-success">${pd.point}</span> POINT <br> --%>
	      </div> <!--  col-md-3 end -->
	      </c:forEach>
	   </c:if>
      </div> <!--  row end -->
		
	</div><!--  .container end -->
    