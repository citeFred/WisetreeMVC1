<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- The Modal -->
<!-- 모달 윈도는 일반 팝업과 달리
강제성이 높은 경우에 사용한다. 로그인, 약관 동의 등과 같이 필수적인 요소인 경우. -->
<div class="modal" id="loginModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="loginF" method='post'
				action='${pageContext.request.contextPath}/login'>
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title" class="text center">Login</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div class="form-group">
						<label for="userid">ID : </label>
						<input type="text" name="userid" id="userid" placeholder="User ID" required class="form-control">
					</div>
					<div class="form-group">
						<label for="pwd">Password : </label>
						<input type="password" name="pwd" id="pwd" placeholder="Password" required class="form-control">
					</div>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button class="btn btn-success">일반 회원 로그인</button>
					<button class="btn btn-primary" onclick="location.href='/join'">회원가입</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					
			<!-- 카카오 로그인 -->
			<!-- https://velog.io/@ohjs813/Spring-%EC%B9%B4%EC%B9%B4%EC%98%A4-%EB%A1%9C%EA%B7%B8%EC%9D%B8-REST-API -->
			<a class="p-2" href="https://kauth.kakao.com/oauth/authorize?client_id=47aac47d4e40cfe9d963995095181491&redirect_uri=http://localhost:9090/member/kakaologin&response_type=code">
			<!-- REST_API키 및 REDIRECT_URi는 본인걸로 수정하세요 -->
			<!-- 저는 redirect_uri을 http://localhost:8080/member/kakaoLogin로 했습니다. -->
			<!-- 47aac47d4e40cfe9d963995095181491 -->
			<!-- http://localhost:9090/ -->
			<!-- 본인걸로 수정 시 띄어쓰기 절대 하지 마세요. 오류납니다. -->
			
				<img src="/resources/assets/img/kakao_login_medium_wide.png" style="height:60px">
		      		<!-- 이미지는 카카오 개발자센터에서 제공하는 login 이미지를 사용했습니다. -->
		
			</a>
				</div>
			</form>
		</div>
	</div>
</div>