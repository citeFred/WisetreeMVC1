<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="/top"/>

<div class="container" style="text-align:center">
	<div class="row">
		<div class="col-md-12">
			<h1>상품 리스트 [관리자 페이지]</h1>
			
			<table class="table table-striped" id="items">
				<thead>
					<tr>
						<th>상품번호</th>
						<th>상품명</th>
						<th>이미지</th>
						<th>가 격</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${list}" var="i">
				<tr>
					<td>
					<c:out value="${i.itemNum}"/>
					</td>								
					<td>
					<c:out value="${i.itemName}"/>
					</td>				
					<td width="15%">
					<a target="_blank">
				 	<img src="../resources/item_images/${i.itemImage1}" style="width:90%;margin:auto" class="img-fluid"> 
					</a>
					</td>			
					<td><del>정가 : 
					<fmt:formatNumber value="${i.price}" pattern="###,###"/>
					원</del>
					</td>				
				</tr>
				</c:forEach>
				</tbody>
			</table>
			
		</div>
	</div>
</div>