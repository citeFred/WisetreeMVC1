<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="/top"/>
<script>
	const openPop=function(img){
		//alert(img);
		let url='resources/review_images/'+img;
		let obj=new Image();
		obj.src=url;
		let w=obj.width;
		let h=obj.height;
		
		window.open(url, 'imgView', 'width='+w+'px, height='+h+'px, left=100px, top=100px')
	}
	
	const goCart=function(){
		//pnum, oqty가 파라미터로 넘어감
		frm.action="user/cartAdd";
		//frm.method='get'
		frm.submit();
	}
	
	const goOrder=function(){
		//opnumm oqty가 파라미터로 넘어감
		frm.action='user/order';
		frm.submit();
	}
	
	const goWish=function(){
		frm.action='user/wishAdd';
		frm.submit();
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
                     <a href="#" onclick="#">
                     <img src="resources/review_images/noimage.png" class="img-fluid" style="width: 70%;"> <!-- </a> -->
                     </a></td>

                     <td align="left" width="50%" style="padding-left: 40px">
                        <h4>
                           <span class="label label-danger">아주아주 진귀한 볼펜 </span>
                        </h4> 
                        	상품번호: 1 <br> 
                        	상품이름: 슈퍼볼펜 <br> 
                        	정가:<del>
                            <fmt:formatNumber value="1" pattern="###,###" />
                        	</del>원<br> 
                        	판매가:<span style="color: red; font-weight: bold">
                           <fmt:formatNumber value="1" pattern="###,###" />
                     			</span>원<br> 
                     	    할인율:<span style="color: red">10 %</span><br>

                        POINT:<b style="color: green">[100]</b>POINT<br>

                        <!-- form시작---------- -->
                        <form name="frm" id="frm" method="GET">
                           <!-- 상품번호를 hidden으로 넘기자------ -->
                           <input type="text" name="pnum" value="${prod.pidx }">
                           <input type="text" name="opnum" value="${prod.pidx }">
                           <!-- -------------------------------- -->
                           <label for="oqty">상품갯수</label> 
                           <input type="number" name="oqty"
                              id="oqty" min="1" max="50" size="2" value="1">

                        </form> <!-- form end------------ -->

                        <button type="button" onclick="#" class="btn btn-primary">장바구니</button>
                        <button type="button" onclick="#"
                           class="btn btn-warning">주문하기</button>
                        <button type="button" onclick="#" class="btn btn-danger">위시리시트</button>
                     </td>

                  </tr>
                  <tr style="border: 0">
                     <td align="center">
                     	<img src="resources/review_images/noimage.png"
                        class="img img-thumbnail" style="width: 70%;"></td>
                     <td align="center">
                     	<img src="resources/review_images/noimage.png"
                        class="img img-thumbnail" style="width: 70%;"></td>
                  </tr>
                  <tr>
                     <td colspan="2">
                        <p>상품설명</p> 
                        <pre>이것은 아주 진귀한 상품입니다</pre>
                     </td>
                  </tr>
               </tbody>

            </table>
         </div>
      </div><!-- .row end  -->
      
      
      
      <!-- 리뷰 글쓰기 폼 ------------------------------------ -->
      <div class="row mt-4">
      	<div class="col-md-10 offset-md-1">
      		<c:import url="/reviewForm"/>
      	</div>
      </div>
      <div class="row">
      	<div class="col-md-12" id="reviewTitle">
      		<h4>상품 리뷰 목록 <span class="badge bage-success" id="review_cnt"> [리뷰가 &개 있습니다.] </span> </h4>
      	</div>
      </div>
      <!-- 리뷰 목록 ---------------------------------------- -->
      <div class="row">
      	<div class="col-md-12" id="reviewList">
      	
      	</div>
      </div>
      <div class="row">
      	<div class="col-md-10 offset-md-1">
      <!-- 리뷰 수정 모달 ------------------------------------- -->
      <%@ include file="/WEB-INF/views/review/reviewEdit.jsp" %>
      <!-- ------------------------------------------------- -->
	 	</div>
	 </div>
	</div><!-- .container end -->
	
<c:import url="/foot"/>