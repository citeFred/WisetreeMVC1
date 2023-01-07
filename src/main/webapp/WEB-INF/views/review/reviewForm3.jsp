<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Ajax 요청 처리 ---------------- -->
<!-- <script src="../js/reviewAjax.js"></script> -->

<%@ include file="/WEB-INF/views/review/reviewScript.jsp"%>

<script src="/js/starrr.js"></script>
<link rel="stylesheet" href="/css/starrr.css" >
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css">

<!-- <link rel="stylesheet"  href="css/review.css"type="text/css"> -->

<script>
	$(document).ready(function(e) {

		var grade = 0;
		var mno = [[${dto.mno}]];
		$('.starrr').starrr({
			rating: grade,
			change: function(e, value){
				if (value) {
					console.log(value);
					grade = value;
				}
			}
	});
</script>

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
			  <div class="form-group">
	              <label >Grade <span class="grade"></span></label>
	              <div class='starrr'></div>
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
		<th>사진/동영상 첨부하기</th>
		<td colspan="2">
			<input type="file" name="refilename" id="refilename"
			 accept="image/*" class="form-control">
		</td>
		<td>
			<button type="submit" class="btn btn-secondary">
				등록
			</button>
		</td>
	</tr>
</table>
</form>