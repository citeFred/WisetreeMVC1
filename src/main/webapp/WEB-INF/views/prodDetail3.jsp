<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<link href="css/review.css" rel="stylesheet" type="text/css"> 
<c:import url="/top"/>


<!-- <script type="text/javascript" src="jquery/jquery.js"></script>
<script type="text/javascript" src="jquery/jRating.jquery.js"></script>
<link rel="stylesheet" href="jquery/jRating.jquery.css" type="text/css" />
 -->
<script>
	const openPop=function(img){
		//alert(img);
		let url='resources/product_images/'+img;
		let obj=new Image();
		obj.src=url;
		let w=obj.width+30;
		let h=obj.height+30;
		
		window.open(url,'imgView','width='+w+'px, height='+h+'px, left=100px, top=100px')
	}//------------------------------
	
	const goCart=function(){
		frm.action="cart/add";
		//frm.method='get';
		frm.submit();
	}
	const goOrder=function(){
		frm.action='user/order';
		frm.submit();
	}
	const goWish=function(){
		frm.action='user/wishAdd';
		frm.submit();
	}
	function check(){
 		if(!$('#userid').val()){
 			alert('아이디를 입력해주세요');
 			$('#userid').focus();
 			return;
 		} 
 		if(!$('#content').val()){
 			alert('리뷰 내용을 입력해주세요');
 			//-------------------------------
 			$('#content').focus();
 			return;
 		}
 		
 		if(!$('#itemno_fk').val()){
 			alert('아이템을 선택해주세요');
 			$('#itemno_fk').focus();
 			return;
 		}
 		$('#reform').submit();
	}
</script>

<div class="container" style="text-align:center">
		
		<div class="row">
         <div class="col-md-12">
            <table class="table">
               <thead>
                  <tr>
                     <th colspan="2"><h3 style="text-align:center">상품 정보</h3></th>
                  </tr>
               </thead>

               <tbody>
                  <tr>
                     <td align="center" width="50%">
                     <a href="#" onclick="openPop('${prod.itemImage1}')">
                     <%-- ${prod.itemImage} --%>
                     <img 
                           src="resources/product_images/${prod.itemImage1}" class="img-fluid" style="width: 70%;">
                     </a></td>

                     <td align="left" width="50%" style="padding-left: 40px">
                        <h4>
                           <span class="label label-danger">${prod.quality} </span>
                        </h4> 
                        	상품번호: ${prod.itemNo} <br> 
                        	상품이름: ${prod.itemName} <br> 
                        	정가:<del>
                            <fmt:formatNumber value="${prod.price}" pattern="###,###" />
                        	</del>원<br> 
                        	판매가:<span style="color: red; font-weight: bold">
                           <fmt:formatNumber value="${prod.saleprice}" pattern="###,###" />
                     			</span>원<br> 
                     	    할인율:<span style="color: red">${prod.percent} %</span><br>

                        POINT:<b style="color: green">[${prod.point}]</b>POINT<br>

                        <!-- form시작---------- -->
                        <form name="frm" id="frm" method="POST">
                           <!-- 상품번호를 hidden으로 넘기자------ -->
                           <input type="hidden" name="itemNo" value="${prod.itemNo}">
                           <input type="hidden" name="itemName" value="${prod.itemName}">
                           <input type="hidden" name="opnum" value="${prod.itemNo}">
                           <input type="hidden" name="itemImage1" value="${prod.itemImage1}">
                           <!-- -------------------------------- -->
                           <label for="count">상품갯수</label> 
                           <input type="number" name="oqty"
                              id="oqty" min="1" max="50" size="2" value="1">

                        </form> <!-- form end------------ -->

                        <button type="button" onclick="goCart()" class="btn btn-primary">장바구니</button>
                        <button type="button" onclick="goOrder()"
                           class="btn btn-warning">주문하기</button>
                        <button type="button" onclick="goWish()" class="btn btn-danger">위시리시트</button>	
                     </td>

                  </tr>
                  <tr style="border: 0">
           	         <c:if test="${prod.itemImage2 ne null}">
	                     <td align="center">
	                     	<img src="resources/product_images/${prod.itemImage2}" class="img img-thumbnail" style="width: 70%;">
	                     </td>
                     </c:if>    
	                 <c:if test="${prod.itemImage2 eq null}">      
                  		<td align="center">
	                        <img src="resources/product_images/noimage.png" class="img img-thumbnail" style="width: 70%;">
                         </td>
	                 </c:if>       
	                        
                     <c:if test="${prod.itemImage3 ne null}">
	                     <td align="center">
	                     	<img src="resources/product_images/${prod.itemImage3}" class="img img-thumbnail" style="width: 70%;">
	                     </td>
                     </c:if>  
                     <c:if test="${prod.itemImage3 eq null}">    
                     	<td align="center">  
	                        <img src="resources/product_images/noimage.png" class="img img-thumbnail" style="width: 70%;">
                        </td>
	                 </c:if> 
                     
                  </tr>

                  
                  <tr>
                     <td colspan="2">
                        <p>상품설명</p> 
                        <pre>${prod.itemInfo}</pre>
                     </td>
                  </tr>
               </tbody>

            </table>
         </div>
      </div>
     <!-- 리뷰 글쓰기 폼 ------------------------------------ -->
<%-- 	<c:if test="${loginUser ne null or k_loginUser ne null}"> --%>
	<div class="row mt-4">
		<div class="col-md-10 offset-md-1">
			<%@ include file="/WEB-INF/views/review/reviewForm2.jsp"%>
			<%-- <%@ include file="/WEB-INF/views/review/reviewForm2.jsp"%> --%>
			<%-- <c:import url="/reviewForm" /> --%>
		</div>
	</div>
<%-- 	</c:if> --%>

	<!-- 리뷰 목록 ---------------------------------------- -->
	<div class="row">
		<div class="col-md-12" id="reviewTitle">
<%-- 			<c:if test="${empty remap}"> --%>
<!-- 					<h4>등록된 리뷰가 없습니다.</h4> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${not empty remap}"> --%>
			<h4>
				<span class="badge bage-success" id="review_cnt"> </span> 개의 상품평이 있습니다.
			</h4>	
			<h5>
				전체평가 평균<span class="badge bage-success" id="review_avg"> </span> /5
			</h5>
<%-- 			</c:if>  --%>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12" id="revList"></div>
	</div>
	
	<div class="row">
		<div class="col-md-10 offset-md-1">
			<!-- 리뷰 수정 모달 ------------------------------------- -->
			<%@ include file="/WEB-INF/views/review/reviewEdit.jsp"%>
			<!-- ------------------------------------------------- -->
		</div>
	</div>
</div>
<!-- .container end -->
<div class="container mt-3" style="height:600px;overflow: auto;">
	
	
	
</div>
<c:import url="/foot" />