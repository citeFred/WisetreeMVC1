<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8"><title>데이터 차트</title>

<!-- DataTables -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script	src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.css" />

<!-- Google Charts -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- <link  type="text/css" href="css/chart.css" rel="stylesheet" >  -->

<style>
 	 .googlechart{
		width:90%;
		margin:0 auto;
		float: left; 
	} 
	/*
	.googlechart div {
 		display:inline-block;   
		width: 900px;
		height: 500px;
	}
	 .googlechart2{
		width:98%;
		margin:0 auto;
	} 
	
	.googlechart2 div {
 		display:inline-block;  
 		float: left; 
		width: 900px;
		height: 500px;
	} */
	.databtn {
		text-align: center;
	}
	.databtn1 {
		display :inline-block;
	}
</style>
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
	/* 더미데이터 */
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
		        "processing": "잠시만 기다려 주세요...",
		        "paginate": {
		            		"next": "다음",
		            		"previous": "이전"
		        }
		}
	});
});
</script>

<script>
	// 구글 시각화 API를 로딩하는 메소드
	google.charts.load('current', {packages: ['corechart']});
	
	// 구글 시각화 API가 로딩이 완료되면,
	// 인자로 전달된 콜백함수를 내부적으로 호출하여 차트를 그리는 메소드
	google.charts.setOnLoadCallback(drawChart);
	
	//----------------------- drawChart------------------------------
	function drawChart() {
		columnChart1();
		stackedColumnChart1();
		lineChart1();
		pieChart1();
	}//----------------------- drawChart------------------------------
	
	
	//----------------------- columnChart1------------------------------
	function columnChart1() {
		// 버튼 클릭 시 ajax를 사용하여 서버로부터 json 배열 객체를 가져왔다고 가정함
		var arr = [
			['2022년 전반기', '파우치', '굿즈'],
			['01월', 1000, 400],
			['02월', 1170, 460],
			['03월', 660, 1120],
			['04월', 530, 540],
			['05월', 2230, 5120],
			['06월', 5030, 3200]
		];

		// 실 데이터를 가진 데이터테이블 객체를 반환하는 메소드
		var dataTable = google.visualization.arrayToDataTable(arr);

		// 옵션객체 준비
		var options = {
				title: '판매 실적',
				width: 800,
				height: 500,
				hAxis: {
					title: '월별 판매 실적',
					titleTextStyle: {
						color: 'red'
					}
				}
		};

		// 차트를 그릴 영역인 div 객체를 가져옴 
		var objDiv = document.getElementById('column_chart_div1');

		// 인자로 전달한 div 객체의 영역에 컬럼차트를 그릴수 있는 차트객체를 반환
		var chart = new google.visualization.ColumnChart(objDiv);

		// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
		chart.draw(dataTable, options);

	} //----------------------- columnChart1------------------------------
	
	
	//------------------------stackedColumnChart1-------------------------------
	function stackedColumnChart1() {
		var arr = [
			['분기', '다이어리', '볼펜 & 만년필', '가방', '굿즈', '남성의류', '여성의류', {role: 'annotation'}],
			['2022 1분기', 1000, 2400, 2000, 3200, 1800, 500, ''],
			['2022 2분기', 3500, 2200, 2300, 3000, 1600, 900, ''],
			['2022 3분기', 2800, 1900, 2900, 3000, 1200, 1300, ''],
			['2022 4분기', 2800, 1900, 2900, 3000, 1200, 1300, '']
		];

		

		var dataTable = google.visualization.arrayToDataTable(arr);

		var options = {
				width: 800,
				height: 500,
				legend: { position: 'top', maxLines: 3 },
				bar: { groupWidth: '75%' },
				isStacked: true

		};

		var objDiv = document.getElementById('stacked_column_chart_div1');
		var chart = new google.visualization.ColumnChart(objDiv);
		chart.draw(dataTable, options);

	}//------------------------stackedColumnChart1-------------------------------
	
	
	//------------------------lineChart1----------------------------------------
	// 꺾은선형 차트 1

	function lineChart1() {
		var arr = [
			['매출년도', '문구류', '의류'],
			['2019', 1000, 400],
			['2020', 1170, 460],
			['2021', 660, 1120],
			['2022', 1030, 540]
		];

		

		var dataTable = google.visualization.arrayToDataTable(arr);

		var options = {
				title: '판매 실적',
				width: 800,
				height: 500,
				curveType: 'function',  // 꺾은선을 곡선으로 표시함
				legend: { position: 'bottom' }
		};



		var objDiv = document.getElementById('line_chart_div1');
		var chart = new google.visualization.LineChart(objDiv);
		chart.draw(dataTable, options);
	}//------------------------lineChart1----------------------------------------
	
	
	//------------------------pieChart1----------------------------------------
	function pieChart1() {
		var arr = [
			['카테고리', '판매량'],
			['다이어리', 100],
			['볼펜', 10],
			['가방', 57],
			['파우치', 33],
			['남성의류', 22],
			['여성의류', 130],
			['굿즈', 200]
		];

		var dataTable = google.visualization.arrayToDataTable(arr);

		var options = {
				title: '카테고리별 판매량',
				width: 800,
				height: 500
		};

		var objDiv = document.getElementById('pie_chart_div1');
		var chart = new google.visualization.PieChart(objDiv);
		chart.draw(dataTable, options);

		// select(선택) 이벤트 핸들러(처리)용 함수를 무명함수로 정의
		var selectHandler = function () {
		var selectedItem = chart.getSelection()[0];
	    var value = dataTable.getValue(selectedItem.row, 0);
	    alert('선택한 항목은 ' + value + ' 입니다.');



		    // 예) 70점대에 해당하는 학생 리스트 보기 페이지로 요청
	        // location.href = 'score.jsp?score='+value;

		};

// 		function selectHandler() {
// 			var selectedItem = chart.getSelection()[0];
// 	        var value = dataTable.getValue(selectedItem.row, 0);
// 	        alert('선택한 항목은 ' + value + ' 입니다.');

			// 예) 70점대에 해당하는 학생 리스트 보기 페이지로 요청
	        // location.href = 'score.jsp?score=value'
// 		}

		// 적용할 차트, 적용할 이벤트명, 이벤트 핸들러 함수를 인자로 이벤트 리스너에 등록
		google.visualization.events.addListener(chart, 'select', selectHandler);
	};//------------------------pieChart1----------------------------------------
	
	//------------------------버튼 클릭시 함수호출----------------------------------------
	$(document).ready(function () {
		$('#databtn').click(function () {
			drawChart();
		});
	});
	//------------------------버튼 클릭시 함수호출----------------------------------------
</script>

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
		
		<tfoot>
			<tr>
				<th>판매월</th>
				<th>상품명</th>
				<th>판매대수</th>
				<th>총 판매금액</th>
			</tr>
		</tfoot>
	</table>
	<div class="databtn">
		<button type="button" class="btn btn-navy navbar-btn databtn1" >DATA 버튼</button>
	</div>
	<div id="googlechart" class="googlechart">
		<div id="column_chart_div1"></div>
		<div id="stacked_column_chart_div1"></div>
		<div id="line_chart_div1"></div>
		<div id="pie_chart_div1"></div>
	</div>
</body>


<%-- <c:import url="/foot" /> --%>
