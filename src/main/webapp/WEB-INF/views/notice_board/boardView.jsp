<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>

<c:import url="/top"/>

<div class="container mt-3" style="overflow:auro;">
	<h1 class="text-center">공지게시판 내용 보기</h1>
	
	<c:if test="${board eq null }">
		<div class="alert alert-danger my-5 test-center">
			<h4>존재 하지 않는 글입니다.</h4>
		</div>
	</c:if>
	
	<c:if test="${board ne null }">
	<table class="table mt-4">
		<tr>
			<td>글번호</td>
			<td>
				<c:out value="${board.num }"/>
			</td>
			<td>작성일</td>
			<td>
				<c:out value="${board.wdate }"/>
			</td>
		</tr>
		
		<tr>
			<td>글쓴이</td>
			<td>
				<c:out value="${board.name }"/>
			</td>
			<td>조회수</td>
			<td>
				<c:out value="${board.readnum }"/>
			</td>
		</tr>
		
		<tr>
			<td >제목</td>
			<td colspan="3">
				<c:out value="${board.subject }"/>
			</td>
		</tr>
		<tr>
			<td>글내용</td>
			<td colspan="3">
				${board.content }
			</td>
		</tr>
		
		<tr>
			<td>첨부파일</td>
			<td colspan="3">
			<!-- ---첨부파일이 있다면------------------------ -->
			<c:if test="${board.filename ne null }">
			<a href="#" onclick="down()">
				${board.originFilename }
			</a>
				[ <c:out value="${board.filesize }"/> bytes]
			</c:if>
			<!-- --------------------------------------- -->
			<!-- 파일명의 확장자를 검사하기 위해 모두 소문자로 바꿈 -->
			<c:set var="fname" value="${fn:toLowerCase(board.filename) }"/>
			<!-- ------------------------------------- -->
			<!-- ---이미지 보이도록 수정---------------------------------- -->
			<c:if test="${fn:endsWith(fname,'.jpg') or fn:endsWith(fname,'.gif') or fn:endsWith(fname,'.png') }">
				<img width="80px" class="img img-thumbnail"
				src="${pageContext.request.contextPath }/resources/notice_board_upload/${board.filename}">
			</c:if>
			<!-- ---------------------------------------------------- -->
			
			</td>
		</tr>
		
		<tr>
			<td colspan="4" align=center>
				<c:if test="${loginUser.status eq 9 or k_loginUser.status eq 9}">
				<a href="../write">글쓰기</a> |   
				<%-- ${noticeCon } --%>
					<c:if test="${board.num ne noticeCon}">
						<a href="#" onclick="go(1)">삭제</a> |  
					</c:if>
				
				<a href="#" onclick="go(2)">편집</a> |
				</c:if>
				<a href="../list">목록</a>
				
				<c:if test="${board.num eq noticeCon}">
				<br>
				<a> * 글 삭제를 원하실 경우 공지글을 해제해주세요</a>
				</c:if>
				
			</td>
		</tr>
	
	
	
	</table>
	</c:if>
	
<!-- ---파일다운로드를 위한 form text----- -->
<form name="fileF" id="fileF" method="post" action="../../fileDown_notice">
	<input type="hidden" name="fname" value="<c:out value="${board.filename }"/>"/>
	<input type="hidden" name="origin_fname" value="<c:out value="${board.originFilename }"/>"/>
</form>
<!-- -------------------------------- -->
	
	
<!-- 편집 또는 삭제를 위한 form----------------------------- -->
<form name="frm" id="frm">
	<input type="hidden" name="num" value="<c:out value="${board.num }"/>">
	<input type="hidden" name="mode">
	<div class="row mt-4" id="divPasswd" style="display:none">
		<div class="col-md-3 offset-md-1 text-right mr-2">
			<label for="passwd">글 비밀번호</label>
		</div>
		<div class="col-md-4">
			<input type="password" name="passwd" id="passwd"
			class="form-control" placeholder="Password" required>
		</div>
		<div class="col-md-3">
			<button id="btn" class="btn btn-outline-primary"></button>
		</div>	
	</div>
</form>
	<!-- ------------------------------------------- -->
</div>

<script type="text/javascript">

//파일 다운로드  처리
function down(){
	fileF.submit();
}

function go(flag){
	if(flag==1){
		frm.mode.value='delete';
		$('#btn').text('글삭제')
		$('#passwd').focus();
		frm.action='../delete';
		frm.method='post';
	}else if(flag==2){
		frm.mode.value='edit';
		$('#btn').text('글수정');
		$('#passwd').focus();
		frm.action='../edit';
		frm.method='post';
	}
	$('#divPasswd').show(1000);
}
</script>
<c:import url="/foot"/>