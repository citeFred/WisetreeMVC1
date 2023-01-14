<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="/top" />

	<div class="container" style="text-align: center">

		<div class="row">
			<div class="col-md-12">
				<h1 class="text-center m-4" style="margin: 1em">::: 신규 상품 목록 :::</h1>
	
				<table class="table table-striped" id="products">
					<thead>
						<tr>
							<th>상품번호</th>
							<th>카테고리</th>
							<th data-sort="string">상품명</th>
							<th>이미지</th>
							<th data-sort="string">가 격</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<!-- ------------------------ -->
					<c:if test="${itemList eq null or empty itemList}">
						<tr>
							<td colspan="6">등록된 상품이 없습니다</td>
						</tr>
					</c:if>
					<c:if test="${itemList ne null or not empty itemList}">
						<c:forEach var="prod" items="${itemList}">
						<tr>
							<td>${prod.itemNo}</td>
							<td>
							${prod.up_Name}>${prod.down_Name}
							</td>
							<td>${prod.itemName}</td>
							<td width="15%">
							<a href="prodDetail2?itemNo=${prod.itemNo}" target="_blank">
					
							
							<img src="../resources/product_images/${prod.itemImage1}" 
							style="width:90%;margin:auto" class="img-fluid">
							
							</a>
							</td>
							<td><del>정 가:
							<fmt:formatNumber value="${prod.price}" pattern="###,###" />
							원</del> 
							<br> 
							<b class="text-primary">판매가 :
							<fmt:formatNumber value="${prod.saleprice}" pattern="###,###" />
							원</b><br> 
							<span class="badge badge-danger">${prod.percent} %할인</span>
							</td>
							<td>
						<c:if test="${loginUser.userid eq 'admin'}">
							<a href="javascript:edit('${prod.itemNo}')">수정</a>| 
							<a href="#" onclick="remove('${prod.itemNo}')">삭제</a>| 
						</c:if>
						</tr>
						</c:forEach>
					</c:if>
	
						<!-- ------------------------ -->
					</tbody>
	
				</table>
			</div>
		</div>
	
	</div>
	
	<form name="editform">
		<input type="hidden" name="itemNo" id="itemNo">
	</form>
	<form name="removeform">
		<input type="hidden" name="itemNo" id="itemNo">
	</form>

<script>
function edit(itemNo){
	//alert(itemNo);
	editform.itemNo.value=itemNo;
	editform.action="adminpage/edit";
	editform.submit();
}
function remove(itemNo){
	//alert(itemNo);
	removeform.itemNo.value=itemNo;
	removeform.action="adminpage/remove";
	removeform.submit();
}
</script>
<c:import url="/foot" />