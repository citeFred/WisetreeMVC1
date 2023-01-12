<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<!-- <script type="text/javascript" src="./js/navigationControl.js"></script> -->

<head>
<title>Wisetree Store Webpage</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script	src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>

<!-- JS -->
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<!-- [로그인 상태 탭 1,2] <- 어떠한 로그인도 안된 상태에서는 로그인상태가 둘다 안보이게 -->
<script>

$('.dropdown-toggle').dropdown()
$(function(){
	if(${loginUser eq null and k_loginUser eq null}){
		document.getElementById("normalUserLogined").style.display = "none";
		document.getElementById("kakaoUserLogined").style.display = "none";
	}
})
$(document).ready(function(){
	$(".slide_div").slick(
			{
				dots: true,
				autoplay : true,
				autoplaySpeed: 5000,
			}
	
	);
});
</script>
<style>
.fakeimg {
	height: 200px;
	background: #aaa;
}
.slick-prev{
	left: 140px;
    z-index: 1;
}
.slick-next{
	right: 150px;
    z-index: 1;
}
.slide_div img{
	margin: auto;
	height: 320px;
	width:  1111px;
}
.slide_div_wrap{
	padding: 0 0 0 0;
    background: #e6e9f6;
    height: 350px;
	width:  100%;
}
.image_wrap img{
	max-width: 85%;
    height: auto;
    display: block;
	margin: auto;    
}
/* 홈페이지 메인 제품 목록  */
.content_area{
 	height: 350px;
	width:  100%;
    min-height: 100px;
    text-align: center;
    margin: auto;    
}

</style>
</head>

<body>

	<!-- context명 세팅 == href= 의 시작점 "wisetree"  -->
	<c:set var="myctx" value="${pageContext.request.contextPath}" />

<!-- 	<div class="jumbotron text-center" style="margin-bottom: 0">
		<h1>Goods Store Web Page</h1>
		<p>World variety goods!</p>
	</div> -->

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="${myctx}/index">GOODS STORE</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"	data-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<!-- 메뉴 네비게이션 -->
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="navbar-nav">
				<!-- [회원가입 폼 탭] <- 일반로그인, 카카오로그인 되지 않은 경우 보이게 -->
				<c:if test="${loginUser eq null and k_loginUser eq null}">
					<li class="nav-item">
						<a class="nav-link" href="${myctx}/agreement">Join</a>
					</li>
				</c:if>
				<!-- [회원 목록 탭] <- 로그인된 유저의 상태status가 9(admin)인경우에만 보이게 -->
				<c:if test="${loginUser.status eq 9 or k_loginUser.status eq 9}">
					<li class="nav-item">
						<a class="nav-link"	href="${myctx}/admin/userList">[Admin 전용]Users List</a>
					</li>
				</c:if>

				<!-- [로그인 모달윈도 탭] <- 어떠한 로그인도 안된 상태에서는 로그인 창이 보이게 -->
				<c:if test="${loginUser eq null and k_loginUser eq null}">
					<li class="nav-item">
						<!-- FOOT.jsp에서 MODAL 임포트함. -->
						<a class="nav-link"	href="#loginModal" data-toggle="modal">Login</a>
					</li>
				</c:if>

				<!-- [로그아웃 탭] <- 어떠한 형태의 회원이라도 로그인 한 경우 로그아웃 보이게 -->
				<c:if test="${loginUser ne null or k_loginUser ne null}">
					<li class="nav-item">
						<a class="nav-link"	href="${myctx}/logout">Logout</a>
					</li>
				</c:if>
				
				<!-- [상품 추가 탭] <- 로그인된 유저의 상태가 9(관리자 인경우) 상품추가 가 보이게 -->
				<%-- <c:if test="${loginUser.status eq 9 or k_loginUser.status eq 9}"> --%>
					<li class="nav-item">
						<a class="nav-link" href="${myctx}/adminpage/prodForm">Add Products</a>
					</li>
				<!-- [상품 목록 탭] <- 로그인된 유저의 상태가 9(관리자 인경우) 상품추가 가 보이게 -->
					<li class="nav-item">
						<a class="nav-link"	href="${myctx}/prodList">Products List</a>
					</li>
				<%-- </c:if> --%>
				
				<!-- 장바구니 목록 탭  -->
				<li class="nav-item">
					<a class="nav-link" href="${myctx}/cart/cartList">My Cart</a>
				</li>
				
				<!-- 공지사항 목록 탭  -->
				<li class="nav-item">
					<a class="nav-link" href="${myctx}/notice_board/list">Notice List</a>
				</li>
				
				<!-- 공지사항 쓰기 폼 탭  -->
				<li class="nav-item">
					<a class="nav-link" href="${myctx}/notice_board/write">Notice Write</a>
				</li>
				
				<!-- 리뷰 목록 탭  -->
				<li class="nav-item">
					<a class="nav-link" href="${myctx}/review">Review List</a>
				</li>
				
				<%-- <!-- 리뷰 쓰기 폼 탭  -->
				<li class="nav-item">
					<a class="nav-link" href="${myctx}/reviewForm">Review Write</a>
				</li> --%>
				
				<!-- 게시판 목록 탭  -->
				<li class="nav-item">
					<a class="nav-link" href="${myctx}/free_board/list">Board List</a>
				</li>
				
				<!-- 게시판 목록 탭  -->
				<li class="nav-item">
					<a class="nav-link" href="${myctx}/free_board/write">Board Write</a>
				</li>

					
			</ul>
		</div>
		
		<div>
			<ul class="navbar-nav">
				<!-- [일반 로그인 상태 탭-1] <- 일반회원 로그인 상태에서는 카카오 로그인상태가 안보이게 -->
				<c:if test="${loginUser ne null or k_loginUser eq null}">
				<div id="normalUserLogined">
					<li class="nav-item bg-primary">
						<a class="nav-link text-white" href="#">${loginUser.userid }님 로그인중..</a>
				</div>
				</c:if>
				
				<!-- [카카오 로그인 상태 탭-2] <- 카카오회원 로그인 상태에서는 일반 로그인상태가 안보이게 -->
				<c:if test="${loginUser eq null or k_loginUser ne null}">
				<div id="kakaoUserLogined">
					<li class="nav-item bg-primary">
						<a class="nav-link text-white" href="#">${k_loginUser.k_name}님 로그인중..</a>
				</div>
				</c:if>
			
				<button class="btn btn-outline-dark" type="button" onclick="location.href='${myctx}/cart'">
						<i class="bi-cart-fill me-1"></i>
						Cart
						<span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
				</button>
			</ul>
		</div>
	</nav>
        <!-- Header-->
        <!-- <header class="bg-dark py-1 px-1"> -->
           <!-- <div class="container px-1 px-lg-1 my-1"> -->
					<div class="content_area">
						<div class="slide_div_wrap">
							<div class="slide_div">
								<div>
									<a>
										<img src="../resources/carousel_images/main1.gif">
									</a>
								</div>
								<div>
									<a>
										<img src="../resources/carousel_images/main2.jpg">
									</a>
								</div>
								<div>
									<a>
										<img src="../resources/carousel_images/main3.jpg">
									</a>
								</div>
								<div>
									<a>
										<img src="../resources/carousel_images/main4.jpg">
									</a>
								</div>
								</div>
							</div>
						</div>
               <!--  </div> -->
        </header>