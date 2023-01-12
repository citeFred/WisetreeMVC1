<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- The Modal -->
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
				
				
	<table class="table mt-4">
		<tr>
			<!-- <td>제목</td> -->
			<td>
				<c:out value="${notice.subject }"/>
			</td>
			<!-- <td>작성일</td> -->
			<td>
				<c:out value="${notice.wdate }"/>
			</td>
		</tr>
		<!-- <tr>
		</tr> -->
		<tr>
			<!-- <td>글내용</td> -->
			<td>
				${notice.content }
			</td>
		</tr>
		
		<tr>
			<td>첨부파일</td>
			<td>
			<!-- ---첨부파일이 있다면------------------------ -->
			<c:if test="${notice.filename ne null }">
			<a href="#" onclick="down()">
				${notice.originFilename }
			</a>
				[ <c:out value="${notice.filesize }"/> bytes]
			</c:if>
			<!-- --------------------------------------- -->
			<!-- 파일명의 확장자를 검사하기 위해 모두 소문자로 바꿈 -->
			<c:set var="fname" value="${fn:toLowerCase(notice.filename) }"/>
			<!-- ------------------------------------- -->
			<!-- ---이미지 보이도록 수정---------------------------------- -->
			<c:if test="${fn:endsWith(fname,'.jpg') or fn:endsWith(fname,'.gif') or fn:endsWith(fname,'.png') }">
				<img width="80px" class="img img-thumbnail"
				src="${pageContext.request.contextPath }/resources/notice_board_upload/${notice.filename}">
			</c:if>
			<!-- ---------------------------------------------------- -->
			
			</td>
		</tr>
	</table>
	
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