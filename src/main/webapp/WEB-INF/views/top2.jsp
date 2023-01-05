<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<script type="text/javascript" src="./js/navigationControl.js"></script>

<head>
<title>Wisetree Store Webpage</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap cdn 설정 -->	
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script	src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- [로그인 상태 탭 1,2] <- 어떠한 로그인도 안된 상태에서는 로그인상태가 둘다 안보이게 -->
<script>

$('.dropdown-toggle').dropdown()
$(function(){
	if(${loginUser eq null and k_loginUser eq null}){
		document.getElementById("normalUserLogined").style.display = "none";
		document.getElementById("kakaoUserLogined").style.display = "none";
	}
})
  $(function(){
      // 이미지 슬라이드 컨트롤를 사용하기 위해서는 carousel를 실행해야한다.
      $('#myCarousel').carousel({
        // 슬리아딩 자동 순환 지연 시간
        // false면 자동 순환하지 않는다.
        interval: 1000,
        // hover를 설정하면 마우스를 가져대면 자동 순환이 멈춘다.
        pause: "hover",
        // 순환 설정, true면 1 -> 2가면 다시 1로 돌아가서 반복
        wrap: true,
        // 키보드 이벤트 설정 여부(?)
        keyboard : true
	  });
	});
</script>

<style>
.fakeimg {
	height: 200px;
	background: #aaa;
}
a.carousel-control {
  opacity: 0;
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
						<a class="nav-link" href="${myctx}/join">Join</a>
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
				
				<!-- [로그아웃 탭] <- 어떠한 형태의 회원이라도 로그인 한 경우 로그아웃 보이게 -->
				<c:if test="${loginUser ne null or k_loginUser ne null}">
					<li class="nav-item">
						<a class="nav-link"	href="${myctx}/logout">Logout</a>
					</li>
				</c:if>
				
				<!-- [상품 추가 탭] <- 로그인된 유저의 상태가 9(관리자 인경우) 상품추가 가 보이게 -->
				<%-- <c:if test="${loginUser.status eq 9 or k_loginUser.status eq 9}"> --%>
					<li class="nav-item">
						<a class="nav-link" href="${myctx}/admin/prodForm">Add Products</a>
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
				
				<!-- 리뷰 쓰기 폼 탭  -->
				<li class="nav-item">
					<a class="nav-link" href="${myctx}/reviewForm">Review Write</a>
				</li>
				
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
		<button class="btn btn-outline-dark" type="button" onclick="location.href='${myctx}/cart'">
				<i class="bi-cart-fill me-1"></i>
				Cart
				<span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
		</button>
		
	</nav>
        <!-- Header-->
        <header class="bg-dark py-2">
            
            <!-- carousel를 구성할 영역 설정 -->
			  <div style="width: 1800px; margin: 50px">
			    <!-- carousel를 사용하기 위해서는 class에 carousel와 slide 설정한다. -->
			    <!-- carousel는 특이하게 id를 설정해야 한다.-->
			    <div id="myCarousel" class="carousel slide" data-ride="carousel" >
			      <ol class="carousel-indicators">
			        <!-- li는 이미지 개수만큼 추가하고 data-target은 carousel id를 가르킨다. -->
			        <!-- data-slide-to는 순서대로 0부터 올라가고 0은 active를 설정한다. -->
			        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			        <li data-target="#myCarousel" data-slide-to="1"></li>
			        <li data-target="#myCarousel" data-slide-to="2"></li>
			        <li data-target="#myCarousel" data-slide-to="3"></li>
			      </ol>
			      <!-- 실제 이미지 아이템 -->
			      <!-- class는 carousel-inner로 설정하고 role은 listbox에서 설정한다. -->
			      <div class="carousel-inner" role="listbox">
			        <!-- 이미지의 개수만큼 item을 만든다. 중요한 포인트는 carousel-indicators의 li 태그 개수와 item의 개수는 일치해야 한다. -->
			        <div class="item active">
			          <!-- 아미지 설정- -->
			          <img src="resources/review_images/별1.png" style="width:100%">
			          <!-- 캡션 설정 (생략 가능) -->
			          <!-- 글자 색은 검은색 -->
			          <div class="carousel-caption" style="color:black;">
			           <h3>TEST1</h3>
			          </div>
			        </div>
			        
			        <div class="item">
			          <img src="resources/review_images/별2.png" style="width:100%">
			          <div class="carousel-caption" style="color:black;">
			          <h3>TEST2</h3>
			          </div>
			        </div>
			        
			        <div class="item">
			          <img src="resources/review_images/별3.png" style="width:100%">
			          <div class="carousel-caption" style="color:black;">
			          <h3>TEST3</h3>
			          </div>
			        </div>
			        
			        <div class="item">
			          <img src="resources/review_images/별4.png" style="width:100%">
			          <div class="carousel-caption" style="color:black;">
			           <h3>TEST4</h3>
			          </div>
			        </div>
			      </div>
			      
			     <!-- Left and right controls -->
				    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
				      <span class="glyphicon glyphicon-chevron-left"></span>
				      <span class="sr-only">Previous</span>
				    </a>
				    <a class="right carousel-control" href="#myCarousel" data-slide="next">
				      <span class="glyphicon glyphicon-chevron-right"></span>
				      <span class="sr-only">Next</span>
				    </a>
			    </div>
			  </div>
               <!--<div class="container px-4 px-lg-5 my-5"> 
                	<div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Shop in style</h1>
                    <p class="lead fw-normal text-white-50 mb-0">With this shop homepage template</p>
                </div>
                </div> -->
            
        </header>