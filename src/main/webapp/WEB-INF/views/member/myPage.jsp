<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="/top"/>
<!DOCTYPE html>

<div class="container">
	<h1>Index</h1>
	<p>
	<h2>회원 인증을 받은 사람들만 이용 할 수 있어요</h2>
	<h2>이름 :  ${loginUser.name}</h2>
	<h2>연락처 :  ${loginUser.getAllHp()}</h2>
	<h2>주소 :  ${loginUser.allAddr}</h2>
	<!-- allAddr해도 login.getAllAddr()을 자동으로 불러온다 el표현식에 따라. -->
	</p>
</div>

<c:import url="/foot"/>
