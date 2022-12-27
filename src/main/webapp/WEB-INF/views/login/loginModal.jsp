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
						<label for="userid">ID : </label> <input type="text" name="userid"
							id="userid" placeholder="User ID" required class="form-control">
					</div>
					<div class="form-group">
						<label for="pwd">Password : </label> <input type="password"
							name="pwd" id="pwd" placeholder="Password" required
							class="form-control">
					</div>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button class="btn btn-success">Google Login</button>
					<button class="btn btn-success">Naver Login</button>
					<button class="btn btn-success">Facebook Login</button><br><br>
					<button class="btn btn-success">일반 Login</button>
					<button class="btn btn-primary" onclick="location.href='/join'">Join a member</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</form>
		</div>
	</div>
</div>