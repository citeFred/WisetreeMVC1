<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <c:import url="/top" /> --%>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
<!-- datatables -->
<link rel="stylesheet" href="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.css"/> 
<script src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script>
    
<!-- carousel -->
<!-- <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> -->

    <script>
        jQuery(function($){
        	$("#foo-table").DataTable({
        		// 표시 건수기능 숨기기
        		lengthChange: true,
        		// 검색 기능 숨기기
        		searching: true,
        		// 정렬 기능 숨기기
        		ordering: true,
        		// 정보 표시 숨기기
        		info: true,
        		// 페이징 기능 숨기기
        		paging: true
        	});
        });
    </script>
    <title></title>
</head>
<body>
    <table id="foo-table" class="table table-bordered">
		<thead>
			<tr><th>판매월</th><th>상품명</th><th>판매대수</th><th>총 판매금액</th></tr>
		</thead>
		<tbody>
			<tr><td>2022년 01월</td><td>다이어리</td><td>100</td><td>67,000,000</td></tr>
			<tr><td>2022년 02월</td><td>볼펜</td><td>10</td><td>33,000,000</td></tr>
			<tr><td>2022년 03월</td><td>가방</td><td>57</td><td>5,000,000</td></tr>
			<tr><td>2022년 04월</td><td>파우치</td><td>33</td><td>10,000,000</td></tr>
			<tr><td>2022년 05월</td><td>남성의류</td><td>22</td><td>17,000,000</td></tr>
			<tr><td>2022년 06월</td><td>여성의류</td><td>200</td><td>300,000</td></tr>
			<tr><td>2022년 07월</td><td>다이어리</td><td>105</td><td>5,000,000</td></tr>
			<tr><td>2022년 08월</td><td>여성의류</td><td>10</td><td>10,000,000</td></tr>
			<tr><td>2022년 09월</td><td>파우치</td><td>50</td><td>7,000,000</td></tr>
			<tr><td>2022년 10월</td><td>파우치</td><td>30</td><td>300,000</td></tr>
			<tr><td>2022년 11월</td><td>가방</td><td>77</td><td>77,000,000</td></tr>
			<tr><td>2022년 12월</td><td>다이어리</td><td>21</td><td>21,000,000</td></tr>
			<tr><td>2023년 01월</td><td>굿즈</td><td>39</td><td>39,000,000</td></tr>
		</tbody>
    </table>
</body>
</html>


<c:import url="/foot" />