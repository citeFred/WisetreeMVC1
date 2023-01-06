<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap cdn 설정 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>
	$(function() {
		// 이미지 슬라이드 컨트롤를 사용하기 위해서는 carousel를 실행해야한다.
		$('#myCarousel').carousel({
			// 슬리아딩 자동 순환 지연 시간
			// false면 자동 순환하지 않는다.
			interval : 1000,
			// hover를 설정하면 마우스를 가져대면 자동 순환이 멈춘다.
			pause : "hover",
			// 순환 설정, true면 1 -> 2가면 다시 1로 돌아가서 반복
			wrap : true,
			// 키보드 이벤트 설정 여부
			keyboard : true
		});
	});
</script>
<style>
/* 캐러셀(이미지슬라이드) 사이드 흰색 */
a.carousel-control {
	opacity: 0;
}
/* 캐러셀(이미지슬라이드) 이미지 크기변경 */
.carousel-inner {
	width: 1000px;
	height: 300px; /* 이미지 높이 변경 */
}

.carousel-item {
	width: auto;
	height: 500px;
}

.d-block {
	display: block;
	width: auto;
	height: auto;
}
</style>
</head>
<body>
	<!-- carousel를 구성할 영역 설정 -->
	<!-- carousel를 사용하기 위해서는 class에 carousel와 slide 설정한다. -->
	<!-- carousel는 특이하게 id를 설정해야 한다.-->
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
			<!-- li는 이미지 개수만큼 추가하고 data-target은 carousel id를 가르킨다. -->
			<!-- data-slide-to는 순서대로 0부터 올라가고 0은 active를 설정한다. -->
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
			<li data-target="#myCarousel" data-slide-to="3"></li>
			<li data-target="#myCarousel" data-slide-to="4"></li>
		</ol>
		<!-- 실제 이미지 아이템 -->
		<!-- class는 carousel-inner로 설정하고 role은 listbox에서 설정한다. -->
		<div class="carousel-inner" role="listbox">
			<!-- 이미지의 개수만큼 item을 만든다. 중요한 포인트는 carousel-indicators의 li 태그 개수와 item의 개수는 일치해야 한다. -->
			<div class="item active">
				<!-- 아미지 설정- -->
				<img class="d-block w-100" src="resources/carousel_images/11.jpg"
					alt="First slide">
				<div class="carousel-caption" style="color: black;">
					<h3>TEST1</h3>
					<p>테스트입니다.</p>
				</div>
			</div>

			<div class="item">
				<img class="d-block w-100" src="resources/carousel_images/12.jpg"
					alt="Second slide">
				<div class="carousel-caption" style="color: white;">
					<h3>TEST2</h3>
					<p>테스트입니다.</p>
				</div>
			</div>

			<div class="item">
				<img class="d-block w-100" src="resources/carousel_images/13.jpg"
					alt="Third slide">
				<div class="carousel-caption" style="color: white;">
					<h3>TEST3</h3>
					<p>테스트입니다.</p>
				</div>
			</div>

			<div class="item">
				<img class="d-block w-100" src="resources/carousel_images/14.jpg"
					alt="Fourth slide">
				<div class="carousel-caption" style="color: white;">
					<h3>TEST4</h3>
					<p>테스트입니다.</p>
				</div>
			</div>

			<div class="item">
				<img class="d-block w-100" src="resources/carousel_images/15.jpg"
					alt="Third slide">
				<div class="carousel-caption" style="color: white;">
					<h3>TEST5</h3>
					<p>테스트입니다.</p>
				</div>
			</div>
		</div>

		<!-- Left and right controls -->
		<a class="left carousel-control" href="#myCarousel" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#myCarousel"
			data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
</body>
</html>