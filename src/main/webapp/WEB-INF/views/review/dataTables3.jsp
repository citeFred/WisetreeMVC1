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

<!-- 기본테이블 -->
<!-- <script>
	jQuery(function($) {
		$("#sellTable").DataTable().destroy();
		$("#sellTable").DataTable({
			data: data,
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
</script> -->


<!-- 임시 데이터 테이블 -->

<script>
jQuery(function($){
	var data = [
	    {
	        "판매월": "2022년 01월",
	        "상품명": "다이어리",
	        "판매대수": "100",
	        "총 판매금액": "67,000,000"
	      },
	      {
	        "판매월": "2022년 02월",
	        "상품명": "볼펜",
	        "판매대수": "10",
	        "총 판매금액": "33,000,000"
	      },
	      {
	        "판매월": "2022년 03월",
	        "상품명": "가방",
	        "판매대수": "57",
	        "총 판매금액": "3,000,000"
	      },
	      {
	        "판매월": "2022년 04월",
	        "상품명": "파우치",
	        "판매대수": "33",
	        "총 판매금액": "10,000,000"
	      },
	      {
	        "판매월": "2022년 05월",
	        "상품명": "남성의류",
	        "판매대수": "22",
	        "총 판매금액": "17,000,000"
	      },
	      {
	        "판매월": "2022년 06월",
	        "상품명": "여성의류",
	        "판매대수": "200",
	        "총 판매금액": "300,000,000"
	      },
	      {
	        "판매월": "2022년 07월",
	        "상품명": "굿즈",
	        "판매대수": "39",
	        "총 판매금액": "39,000,000"
	      },
	      {
	        "판매월": "2022년 08월",
	        "상품명": "다이어리",
	        "판매대수": "105",
	        "총 판매금액": "5,000,000"
	      },
	      {
	        "판매월": "2022년 09월",
	        "상품명": "여성의류",
	        "판매대수": "10",
	        "총 판매금액": "10,000,000"
	      },
	      {
	        "판매월": "2022년 10월",
	        "상품명": "파우치",
	        "판매대수": "50",
	        "총 판매금액": "7,000,000"
	      },
	      {
	        "판매월": "2022년 11월",
	        "상품명": "파우치",
	        "판매대수": "30",
	        "총 판매금액": "300,000"
	      },
	      {
	        "판매월": "2022년 12월",
	        "상품명": "가방",
	        "판매대수": "77",
	        "총 판매금액": "77,000,000"
	      },
	      {
	        "판매월": "2023년 01월",
	        "상품명": "다이어리",
	        "판매대수": "21",
	        "총 판매금액": "21,000,000"
	      }
	  ]

	$("#sellTable").DataTable().destroy();
	$("#sellTable").DataTable({
		data : data,
		columns: [
			{ data : "판매월" },
			{ data : "상품명" },
			{ data : "판매대수" },
			{ data : "총 판매금액" }
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
</script>

<!-- 동적으로 데이터 추가삭제 차트  -->
    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);
	  
	  var count = 0;
	  var data;
	  var chart;
      var options;
	  
      function drawChart() {
	  data = new google.visualization.DataTable();
	  data.addColumn('string', '판매월');
	  data.addColumn('number', '판매대수');
	  data.addColumn('number', '총판매금액');
	  data.addRow(['판매월', 1, 1]);
	  
        options = {
          chart: {
            title: 'Analysis of Dialogue System',
            subtitle: '',
          }
        };

        chart = new google.charts.Bar(document.getElementById('barchart_div'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
      
      function addData(){
	    count++;
		data.addRow(['판매월 ' + count + '월', Number(document.getElementById('sendInput').value), Number(document.getElementById('responseInput').value)]);
		chart.draw(data, options)
      }
      function removeData(){
		data.removeRow(0);
		chart.draw(data, opstions)
      }
    </script>


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
		<!-- <tbody>
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
		</tbody> -->
		<tfoot>
			<tr>
				<th>판매월</th>
				<th>상품명</th>
				<th>판매대수</th>
				<th>총 판매금액</th>
			</tr>
		</tfoot>
	</table>
	<div id="materialchart_div">
		<div id="barchart_div" style="width: 800px; height: 500px;"></div>
	    send:<br>
	    <input id="sendInput" type="text"><br>
	    response:<br>
	    <input id="responseInput" type="text"><br><br>
	    <button onclick="addData();">add</button> <button onclick="removeData();">remove</button>
    </div>
	</body>
</html>


