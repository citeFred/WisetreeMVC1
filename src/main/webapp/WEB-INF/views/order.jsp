<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Ordered</title>
</head>
<body>

     <section class="py-5">
		<div class="container">
		<h3>${loginUser.userid} 님의 주문 내역입니다.</h3>
		<hr>
		
		주소 : ${loginUser.addr1} ${loginUser.addr2} <br>
		우편번호 :  ${loginUser.post} <br>
		연락처 : ${loginUser.hp1}- ${loginUser.hp2}- ${loginUser.hp3}
		<br>
		<hr>
		---------- 주문 상품 내역 ---------- <br>
		<c:forEach var="vo" items="${cartArr}" varStatus="state">
			
			<tr>
				<td>상품명 : ${vo.itemName}</td><br>
				<td>주문수량 : ${vo.oqty} 개</td><br>
				<td>상품가격 : ${vo.saleprice} 원</td>
				<br>
			</tr>
			</c:forEach>
			<br>
		---------- ---------- ---------- <br><br>
		<hr>
		<h4>총 금액 : ${sum} 원</h4> 
		<br><br>
		<%-- ${cartArr},${sum},${loginUser.userid} --%>
		<button class="btn btn-outline-primary" type="button" >결제하기</button>
		<button class="btn btn-outline-danger" type="button" onclick="location.href='../index'" >결제취소</button>
		</div>
	</section>
</body>
</html>