<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="/top" />
<h3>메인화면 INDEX 테스트</h3>
 <!-- Section-->
 <div class="container mt-3" >
	<c:import url="/prodQty">
		<c:param name="quality" value="HIT"/>
	</c:import>
	
	<c:import url="/prodQty">
		<c:param name="quality" value="NEW"/>
	</c:import>
	
	<c:import url="/prodQty">
		<c:param name="quality" value="BEST"/>
	</c:import>
	
</div> 
<c:import url="/foot" />
