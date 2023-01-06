<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap cdn 설정 -->
<!-- CSS -->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>

<!-- JS -->
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script>
$(document).ready(function(){
	$(".slide_div").slick();
});
</script>
<style>
.slick-prev{
	left: 160px;
    z-index: 1;
}
.slick-next{
	right: 160px;
    z-index: 1;
}
.slide_div img{
	margin: auto;
}
.slide_div_wrap{
	padding: 15px 0 15px 0;
    background: #e6e9f6;
}
.image_wrap img{
	max-width: 85%;
    height: auto;
    display: block;
	margin: auto;    
}
</style>
</head>
<body>

<div class="content_area">
	<div class="slide_div_wrap">
					<div class="slide_div">
						<div>
							<a>
								<img src="../resources/carousel_images/do1.jpg">
							</a>
						</div>
						<div>
							<a>
								<img src="../resources/carousel_images/do2.jpg">
							</a>
						</div>
						<div>
							<a>
								<img src="../resources/carousel_images/do3.jpg">
							</a>
						</div>	
					</div>	
				</div>
	</div>
</body>
</html>