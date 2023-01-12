<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- The Modal -->
<div class="modal" id="noticePop">
	<div class="modal-dialog">
		<div class="modal-content">
		
		
		
		
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title" class="text center">공지사항</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>




				<!-- Modal body -->
				<div class="modal-body">
					<h2>${notice.subject }</h2>
					<h5>${notice.content }</h5>
				</div>
				
				
				
				<label for="undoNotice">
					<input type="checkbox" name="saveId" id="undoNotice" > 하루동안 보이지 않기
				</label>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
		</div>
	</div>
</div>