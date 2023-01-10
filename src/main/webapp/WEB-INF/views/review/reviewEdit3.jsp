<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- ---동적 별점 css-------------------- -->
<!-- <link href="css/review.css" rel="stylesheet" type="text/css"> -->
<!-- 모달창이 원인이다 -> 에딧2만 라이브러리를 따로 쓰던가 -> 사진으로 대체하고 시간낭비 X  -->
<!-- ------------------------------ -->

<script type="text/javascript" src="../jquery/jquery.js"></script>
<script type="text/javascript" src="../jquery/jRating.jquery.js"></script>
<link rel="stylesheet" href="../jquery/jRating.jquery.css" type="text/css" />

<script type="text/javascript">
$(document).ready(function(){
      // simple jRating call
      $(".basic").jRating();
      // more complex jRating call
      $(".basic").jRating({
         step:true,
         length : 20,// nb of stars
         onSuccess :function(){
           alert('Success : your rate has been saved :)');
         }
       });
      // you can rate 3 times ! After, jRating will be disabled
      $(".basic").jRating({
         canRateAgain :true,
         nbRates : 3
       });
});
</script>


<script>
function deselect(){
	//name이 score인 라디오버튼 일괄 해제
	$('#reform2 #5-star').prop("checked", false);
// 	document.getElementById('#5-star').checked=false;
	alert($("#reform2 input:radio[name='score']").is(":checked"))
	
}
</script>
<div class="modal" id="reviewModal">
<div style='width:50%;margin:auto'>
	<div class="modal-content">
		<div class="modal-body">
		<form method="post" enctype="multipart/form-data" name="reform2" id="reform2">
			<!-- hidden data------------------------------------ -->
				<input type="text" name="itemno_fk" id="itemno_fk" value="${prod.itemNo}">
				<input type="text" name="userid" id="userid" value="${loginUser.userid}">
				<input type="text" name="renum" id="renum" value="${result.revo} ">
				<input type="hidden" name="score" id="score" >
			<!-- ---------------------------------------------- -->
	<table class="table">
	<tr>
		<th colspan="4" class="text-center">
		<h3>수정하기</h3>
		</th>
	</tr>
	<tr>
		<td>상품은만족하셨나요?</td>   
		<td>
			 <div class="score">
   			<!-- in this exemple, 12 is the average and 1 is the id of the line to up
   			<a href="https://www.jqueryscript.net/time-clock/">date</a> in DB -->
  				 <div class="basic" data-average="12" data-id="1"></div>
			</div>



			<div>
			<button type="button" class="btn btn-secondary" onclick="deselect()">선택해제</button>
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
		<th>사진/동영상</th>
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