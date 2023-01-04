<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- ------------------------------ -->
<link href="css/review.css" rel="stylesheet" type="text/css">
<div class="modal" id="reviewModal">
<div style='width:50%;margin:auto'>
	<div class="modal-content">
		<div class="modal-body">
		<form method="post" enctype="multipart/form-data" name="reform2" id="reform2">
			<!-- hidden data------------------------------------ -->
				<input type="text" name="pidx_fk" id="pidx_fk" value="${prod.itemNo}">
				<input type="text" name="userid" id="userid" value="${loginUser.userid}">
				<input type="hidden" name="renum" id="renum" >
			<!-- ---------------------------------------------- -->
	<table class="table">
		<th>
		<h4 class="top">
			<span class="top1">수정하기</span>
		</h4>
		</th>
	<tr>
		<td>상품은 만족하셨나요?</td>   
		<td>
			<div class="star-score space-x-4 mx-auto" id="star">
				<input type="radio" id="5-stars" name="score" value="5" v-model="ratings"/>
				<label for="5-stars" class="star pr-4">★</label>
				<input type="radio" id="4-stars" name="score" value="4" v-model="ratings"/>
				<label for="4-stars" class="star">★</label>
				<input type="radio" id="3-stars" name="score" value="3" v-model="ratings"/>
				<label for="3-stars" class="star">★</label>
				<input type="radio" id="2-stars" name="score" value="2" v-model="ratings"/>
				<label for="2-stars" class="star">★</label>
				<input type="radio" id="1-star" name="score"  value="1" v-model="ratings" />
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
		<td colspan="2" id="prodImage">	</td>
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