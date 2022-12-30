<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- ------------------------------ -->
<div class="modal" id="reviewModal">
	<div style='width: 50%; margin: auto'>
		<div class="modal-content">
			<div class="modal-body">
				<form method="post" enctype="multipart/form-data" name="reform2" id="reform2">
					<!-- hidden data------------------------------------ -->
					<input type="text" name="pidx_fk" id="pidx_fk" value="${prod.pidx}">
					<input type="text" name="userid" id="userid"
						value="${loginUser.userid}"> <input type="text" name="num"
						id="num">
					<!-- ---------------------------------------------- -->
					<table class="table">
						<tr>
							<th colspan="4" class="text-center">
								<h3>::▶문구상품 리뷰 남기기◀::</h3>
							</th>
						</tr>
						<tr>
							<th>리뷰평가점수</th>
							<td><select name="score">
									<option value="none">=== 별점을 선택해주세요 ===</option>
									<!-- 추후에 이미지 파일로 대체 -->
									<option id="score" value="1">별점 1개</option>
									<option value="2">별점 2개</option>
									<option value="3">별점 3개</option>
									<option value="3">별점 4개</option>
									<option value="3">별점 5개</option>
							</select></td>
							<th>작성자</th>
							<td>${loginUser.name}[${loginUser.userid}]</td>
						</tr>
						<tr>
							<th>상품평</th>
							<td colspan="3"><textarea name="content" id="content"
									rows="2" class="form-control"></textarea></td>
						</tr>
						<tr>
							<th>이미지업로드</th>
							<td colspan="2" id="prodImage"></td>
							<td>
								<button class="btn btn-outline-success">글수정</button>
								<button class="btn btn-outline-danger" data-dismiss="modal">Close</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>