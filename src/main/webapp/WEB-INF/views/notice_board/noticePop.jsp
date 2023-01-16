<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- The Modal -->
<style>
	.modal p{
		word-wrap:break-word;
	}
</style>
<div class="modal" id="noticePop">
	<div class="modal-dialog">
		<div class="modal-content">
		
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title" class="text-center">공지사항</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
							

		<div style="text-align: center;">
			
			<p style="text-align: center;word-wrap:break-word;">
			<c:out value="${notice.subject }"/>
			
			</p>
			
			<div style="float: right;">
				<c:out value="${notice.wdate }"/>
			</div>
			<div style="clear: both;"></div>
		</div>
		<hr>
		<p style="text-align: center;">
		${notice.content }
		</p>
		
		<p style="text-align:center;">
			<!-- 파일명의 확장자를 검사하기 위해 모두 소문자로 바꿈 -->
			<c:set var="fname" value="${fn:toLowerCase(notice.filename) }"/>
			<!-- ------------------------------------- -->
			<!-- ---이미지 보이도록 수정---------------------------------- -->
			<c:if test="${fn:endsWith(fname,'.jpg') or fn:endsWith(fname,'.gif') or fn:endsWith(fname,'.png') }">
				<img width="300px" class="img img-thumbnail"
				src="${pageContext.request.contextPath }/resources/notice_board_upload/${notice.filename}">
			</c:if>
		</p>

	
	<!-- ---파일다운로드를 위한 form text----- -->
<form name="fileF" id="fileF" method="post" action="../../fileDown_notice">
	<input type="hidden" name="fname" value="<c:out value="${notice.filename }"/>"/>
	<input type="hidden" name="origin_fname" value="<c:out value="${notice.originFilename }"/>"/>
</form>
<!-- -------------------------------- -->
				</div>
				<script type="text/javascript">
//파일 다운로드  처리
function down(){
	fileF.submit();
}
</script>
				<label style="text-align: right;" for="undoNotice">
					<input type="checkbox" name="saveId" id="undoNotice" > 하루동안 보이지 않기
				</label>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
		</div>
	</div>
</div>