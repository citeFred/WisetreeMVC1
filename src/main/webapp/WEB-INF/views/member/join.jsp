<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="/top" />
<script type="text/javascript" src="./js/userCheck.js"></script>
<script type="text/javascript" src="./js/addressApi.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<div class="container" style="height: 750px; overflow: auto;">
	<h1 class="text-center mt-1">회원가입</h1>
	<form name="mf" action="join" method="post">
		<!-- id중복체크용 hidden data--------------- -->
		<input type="hidden" name="id_flag" id="id_flag" value="N">
		<!-- ------------------------- -->
				
		<table class="table">
			<tr>
				<td width="20%" class="m1">
					<b>이름</b>
				</td>
				<td width="80%" class="m2">
					<input type="text" name="name" id="name" placeholder="Name"> <br>
				<span class='ck'>*이름은 한글만 가능해요</span>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>아이디</b>
				</td>
				<td width="80%" class="m2">
					<!-- <input type="text" name="userid" id="userid" onkeyup="ajax_idcheck(this.value)"	placeholder="User ID"> -->
					<input type="text" name="userid" id="userid" placeholder="User ID" onkeyup="ajax_idcheck(this.value)">
 					<button class="btn btn-outline-success" type="button" onclick="ajax_idcheck()">아이디 중복 체크</button> <br>
				<span class='ck' id="id_result">*아이디는 영문자, 숫자, _, !만 사용 가능해요</span> 
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>비밀번호</b></td>
				<td width="80%" class="m2">
				<input type="password" name="pwd" id="pwd" placeholder="Password"> <br>
				<span class='ck'>*비밀번호는 문자,숫자,!,. 포함해서 4~8자리 이내</span></td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>비밀번호 확인</b></td>
				<td width="80%" class="m2">
				<input type="password" name="pwd2" id="pwd2" placeholder="Re Password"></td>
			</tr>
			
			<tr>
				<td width="20%" class="m1"><b>이메일주소</b></td>
				<td width="80%" class="m2">
					<input type="text" name="email"	id="email" placeholder="Email"><br> 
					<span class='ck' id="email_result">*이메일은 Abcd@abc.com 형식만 사용 가능해요</span> 
				</td>
			</tr>
			
			<tr>
				<td width="20%" class="m1"><b>연락처</b></td>
				<td width="80%" class="m2">
					<input type="text" name="hp1" id="hp1" placeholder="HP1" maxlength="3">- 
					<input type="text" name="hp2" id="hp2" placeholder="HP2" maxlength="4">-
					<input type="text" name="hp3" id="hp3" placeholder="HP3" maxlength="4"> <br>
				<span class='ck'>*앞자리(010|011)중에 하나-(숫자3~4자리)-(숫자4자리) 가능해요</span></td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>우편번호</b></td>
				<td width="80%" class="m2">
					<input type="text" name="post" id="post" placeholder="우편번호 찾기를 눌러주세요." onclick="execPostCode();" readonly>
					<!-- 다음카카오 우편번호 API를 활용한 우편번호 검색입력 기능 추가 -->
					<button class="btn btn-outline-success" type="button" onclick="execPostCode();">우편번호 찾기</button></td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>주소</b></td>
				<td width="80%" class="m2">
					<input type="text" name="addr1"	id="addr1" placeholder="Address1" onclick="execPostCode();" readonly><br> 
					<input type="text" name="addr2" id="addr2" placeholder="상세 주소를 입력해 주세요.">
				</td>
			</tr>
			<tr>
				<td colspan="2" class="m3 text-center">
					<!-- <button class="btn btn-outline-primary" type="button" onclick="member_check()">회원가입</button> -->
					<button class="btn btn-outline-primary" type="button" onclick="member_check()">회원가입</button>
					<button class="btn btn-outline-danger" type="reset">다시쓰기</button>
				</td>
			</tr>
		</table>
	</form>

</div>
<c:import url="/foot" />
