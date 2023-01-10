<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <c:import url="/top" /> --%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<!-- DataTables -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script	src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.css" />

<!-- Google Charts -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link  type="text/css" href="css/chart.css" rel="stylesheet" > 

<!-- carousel -->
<!-- <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> -->

<script>
	jQuery(function($) {
		$("#sellTable").DataTable().destroy();
		$("#sellTable").DataTable({
			// 표시 건수기능 숨기기
			lengthChange : true,
			// 검색 기능 숨기기
			searching : true,
			// 정렬 기능 숨기기
			ordering : true,
			// 정보 표시 숨기기
			info : true,
			// 페이징 기능 숨기기
			paging : true
		});
	});
</script>


<script>
google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ['Year', 'Sales', 'Expenses', 'Profit'],
    ['2014', 1000, 400, 200],
    ['2015', 1170, 460, 250],
    ['2016', 660, 1120, 300],
    ['2017', 1030, 540, 350]
  ]);

  var options = {
    chart: {
      title: '상품 매출 차트',
      subtitle: '판매월, 상품명, 판매대수, 총판매금액: 2022-2023',
      width: '100%'
    }
  };

  var mq = window.matchMedia( "(max-width: 1024.98px)" );
  if (mq.matches) {
      var options = {
        legend: {
          position: 'none'
        }
      }   
    }

  var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

  chart.draw(data, google.charts.Bar.convertOptions(options));
}
</script>

<!-- 
<script>
jQuery(function($){
	$("#sellTable").DataTable().destroy();
	$("#sellTable").DataTable({
		language : lang_kor,
		ajax: { 
			url: "../views/redata.json",
			dataSrc: ''
			},
		columns: [
			{ "data" : "판매월" },
			{ "data" : "상품명" },
			{ "data" : "판매대수" },
			{ "data" : "총 판매금액" }
		],
		"language": {
		        "emptyTable": "데이터가 없어요.",
		        "lengthMenu": "페이지당 _MENU_ 개씩 보기",
		        "info": "현재 _START_ - _END_ / _TOTAL_건",
		        "infoEmpty": "데이터 없음",
		        "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
		        "search": "에서 검색: ",
		        "zeroRecords": "일치하는 데이터가 없어요.",
		        "loadingRecords": "로딩중...",
		        "processing":     "잠시만 기다려 주세요...",
		        "paginate": {
		            "next": "다음",
		            "previous": "이전"
		        }
		}
	});
});
</script> -->


<title>DataTable</title>
</head>
<body>
	<table id="sellTable" class="table table-bordered" style="width: 100%">
		<thead>
			<tr>
				<th>판매월</th>
				<th>상품명</th>
				<th>판매대수</th>
				<th>총 판매금액</th>
			</tr>
		</thead>
		<tbody>
			<tr><td>2022년 01월</td><td>다이어리</td><td>100</td><td>67,000,000</td></tr>
			<tr><td>2022년 02월</td><td>볼펜</td><td>10</td><td>33,000,000</td></tr>
			<tr><td>2022년 03월</td><td>가방</td><td>57</td><td>5,000,000</td></tr>
			<tr><td>2022년 04월</td><td>파우치</td><td>33</td><td>10,000,000</td></tr>
			<tr><td>2022년 05월</td><td>남성의류</td><td>22</td><td>17,000,000</td></tr>
			<tr><td>2022년 06월</td><td>여성의류</td><td>200</td><td>300,000</td></tr>
			<tr><td>2022년 07월</td><td>굿즈</td><td>39</td><td>39,000,000</td></tr>
			<tr><td>2022년 08월</td><td>다이어리</td><td>105</td><td>5,000,000</td></tr>
			<tr><td>2022년 09월</td><td>여성의류</td><td>10</td><td>10,000,000</td></tr>
			<tr><td>2022년 10월</td><td>파우치</td><td>50</td><td>7,000,000</td></tr>
			<tr><td>2022년 11월</td><td>파우치</td><td>30</td><td>300,000</td></tr>
			<tr><td>2022년 12월</td><td>가방</td><td>77</td><td>77,000,000</td></tr>
			<tr><td>2023년 01월</td><td>다이어리</td><td>21</td><td>21,000,000</td></tr>
		</tbody>
		<tfoot>
			<tr>
				<th>판매월</th>
				<th>상품명</th>
				<th>판매대수</th>
				<th>총 판매금액</th>
			</tr>
		</tfoot>
	</table>
	<div class="chart-area">
		<div class="chart">
			<div class="chart-area">
			  <div class="chart">
			    <div id="columnchart_material" style="width: 100%; height: 300px;"></div>
			  </div>
			  <div class="chart-info">
			    <h1>What is Lorem Ipsum?</h1>
			    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
			  </div>
			</div>
		</div>
	</div>
</html>


