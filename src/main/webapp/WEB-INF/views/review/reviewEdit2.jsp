<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- ---동적 별점 css-------------------- -->
<link href="css/review.css" rel="stylesheet" type="text/css">
<!-- ------------------------------ -->
<div class="modal" id="reviewModal">
<div style='width:50%;margin:auto'>
	<div class="modal-content">
		<div class="modal-body">
		<form method="post" enctype="multipart/form-data" name="reform2" id="reform2">
			<!-- hidden data------------------------------------ -->
				<input type="text" name="itemno_fk" id="itemno_fk" value="${prod.itemNo}">
				<input type="text" name="userid" id="userid" value="${loginUser.userid}">
				<input type="text" name="score" id="score" value="${revo1.score}">
				<input type="hidden" name="renum" id="renum" >
			<!-- ---------------------------------------------- -->
	<table class="table">
	<tr>
		<th colspan="4" class="text-center">
		<h3>수정하기</h3>
		</th>
	</tr>
	<tr>
		<td>상품은 만족하셨나요?</td>   
		<td>
			<input type="text" name="score" id="score">
			<div class="star-score space-x-4 mx-auto" id="star">
				<input type="radio" id="5-stars" name="score" value="5" />
				<label for="5-stars" class="star pr-4">★</label>
				<input type="radio" id="4-stars" name="score" value="4" />
				<label for="4-stars" class="star">★</label>
				<input type="radio" id="3-stars" name="score" value="3" />
				<label for="3-stars" class="star">★</label>
				<input type="radio" id="2-stars" name="score" value="2" />
				<label for="2-stars" class="star">★</label>
				<input type="radio" id="1-star" name="score"  value="1" />
				<label for="1-star" class="star">★</label>
			</div>
		</td>
	</tr>
	<tr>
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
		<td colspan="2" id="prodImage">	
		 <input type="file" name="refilename" id="refilename"
		 accept="image/*" class="form-control">
		</td>
	</tr>
	<tr>
		<td>
			<button class="btn btn-outline-danger" data-dismiss="modal">취소</button>
			<button class="btn btn-outline-success">등록</button>
			
		</td>
	</tr>
</table>
</form>
		</div>
	</div>
	</div>
</div>