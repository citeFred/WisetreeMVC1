<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Ajax 요청 처리 ---------------- -->
<!-- <script src="../js/reviewAjax.js"></script> -->

<%@ include file="/WEB-INF/views/review/reviewScript.jsp"%>
<link href="css/review.css" rel="stylesheet" type="text/css">
<!-- ------------------------------ -->
<form method="post" enctype="multipart/form-data" name="reform" id="reform">
	<!-- hidden data------------------------------------ -->
	<input type="text" name="itemno_fk" id="itemno_fk" value="${prod.itemNo}">
	<input type="text" name="userid" id="userid" value="${loginUser.userid}">
	<%-- <input type="text" name="score" id="score" value="${revo.score}"> --%>
	<input type="hidden" name="mode" value="ajaxMode">

	<!-- ---------------------------------------------- -->
	<table class="table">
	<tr>
		<th colspan="4" class="text-center">
			<h3>리뷰쓰기</h3>
		</th>
	</tr>
	<tr>
		<th>리뷰평가점수</th>   
		<td>
			<div class="star-score space-x-4 mx-auto">
				<input type="radio" id="5-stars" name="score" value="5" v-model="ratings"/>
				<label for="5-stars" class="star pr-4">★</label>
				<input type="radio" id="4-stars" name="score" value="4" v-model="ratings"/>
				<label for="4-stars" class="star">★</label>
				<input type="radio" id="3-stars" name="score" value="3" v-model="ratings"/>
				<label for="3-stars" class="star">★</label>
				<input type="radio" id="2-stars" name="score" value="2" v-model="ratings"/>
				<label for="2-stars" class="star">★</label>
				<input type="radio" id="1-star" name="score" value="1" v-model="ratings" />
				<label for="1-star" class="star">★</label>
			</div>
		</td>
		
		<th>작성자</th>
		<td>${loginUser.name}[${loginUser.userid}]</td>
	</tr>	
	<tr>
		<th>어떤 점이 좋았나요?</th>
		<td colspan="3">
			<textarea name="content" id="content" rows="2" class="form-control"></textarea>	
		</td>
	</tr>
	<tr>
		<th>사진/동영상 첨부하기 </th>
		<td colspan="2">
			<input type="file" name="refilename" id="refilename"
			 accept="image/*" class="form-control">
		</td>
		<td>
			<button type="button" class="btn btn-secondary" onclick="check()">
				등록
			</button>
		</td>
	</tr>
</table>
</form>