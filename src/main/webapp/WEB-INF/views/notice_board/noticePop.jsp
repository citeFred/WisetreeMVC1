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
					${notice.subject }
				</div>
				
				
				
				
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
		</div>
	</div>
</div>