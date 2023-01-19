<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>

<c:import url="/top" />
<script src="https://cdn.ckeditor.com/4.17.2/standard/ckeditor.js"></script>
<!-- id로 유효성 체크 -->
<script>
$(function(){
	
	CKEDITOR.replace('content');
	
	$('#bf').submit(function(){
		if($('#subject').val()==''){
			alert('제목을 입력해세요');
			$('#subject').focus();
			return false;
		}
		if($('#name').val()==''){
			alert('글쓴이를 입력하세요');
			$('#name').focus();
			return false;
		}
		
		if(CKEDITOR.instances.content.getData()==''){
			alert('글내용을 입력하세요');
			CkEDITOR.instances.content.focus();
			return false;
		}
		
		/* if($('#content').val()==''){
			alert('글내용을 입력하세요');
			$('#content').focus();
			return false;
		} */
		
		if($('#bpwd').val()==''){
			alert('비밀번호를 입력하세요');
			$('#bpwd').focus();
			return false;
		}
		return true;
	})
})//$() end----------------------------
	
</script>

<div align="center" id="bbs" class="col-md-8 offset-md-2 my-4">
   <h1>공지게시판 수정</h1>
   <p>
   	<a href="write">글쓰기</a>|<a href="list">글목록</a>
   </p>
   
   <form name="bf" id="bf" role="form" action="update" method="POST" enctype="multipart/form-data">
	   <input type="hidden" name="num" value="<c:out value="${board.num }"/>">
	   <!-- <input> --><!-- 원본글쓰기mode는 write, 답변글쓰기 mode는 rewrite로 감 - 활용할때 사용  -->
	   <table>
	   		<tr>
	   			<td style="width:20%"><b>제목</b></td>
        		<td style="width:80%">
	   				<input type="text" name="subject" id="subject" 
	   				value='<c:out value="${board.subject }"/>'
	   				class="form-control">
	   			</td>
	   		</tr>
	   		
	   		<tr>
	   			<td style="width:20%"><b>글쓴이</b></td>
        		<td style="width:80%">
	   				<input type="text" name="name" id="name" 
	   				value='<c:out value="${loginUser.userid}"/>'
	   				class="form-control" readonly>
	   			</td>
	   		</tr>
	   		
	   		<tr>
	   			<td style="width:20%"><b>글내용</b></td>
        		<td style="width:80%">
        			<textarea name="content" id="content" rows="10" cols="50"
                 	 	class="form-control">${board.content}</textarea>
	   				<%-- <input type="text" name="content" id="content" 
	   				value='<c:out value="${board.content }"/>'
	   				class="form-control"> --%>
	   			</td>
	   		</tr>
	   		
	   		<tr>
	   			<td style="width:20%"><b>공지글 비밀번호</b></td>
        		<td style="width:80%">
    	  		  <div class="col-md-5">
   		 	      <input type="password" name="passwd" id="bpwd" class="form-control">
   			      </div>
	   			</td>
	   		</tr>
	   		
	   		<tr>
	   			<td style="width:20%"><b>첨부파일</b></td>
        		<td style="width:80%">
			   		<!-- 파일명의 확장자를 검사하기 위해 모두 소문자로 바꿈 -->
					<c:set var="fname" value="${fn:toLowerCase(board.filename) }"/>
					<!-- ------------------------------------- -->
					<!-- ---이미지 보이도록 수정---------------------------------- -->
					<c:if test="${fn:endsWith(fname,'.jpg') or fn:endsWith(fname,'.gif') or fn:endsWith(fname,'.png') }">
						<img width="80px" class="img img-thumbnail"
						src="${pageContext.request.contextPath }/resources/notice_board_upload/${board.filename}">
					</c:if>
					<!-- ---------------------------------------------------- -->
					
					<!-- ---기존 파일 표시------------------ -->
					<c:out value="${board.originFilename }"/> [ <c:out value="${board.filesize }"/> bytes] <br>
					<!-- ------------------------------- -->
			
	   				<!-- ---새로 업로드 하는 파일---------------- -->
	   				<input type="file" name="mfilename" id="filename" 
	   				class="form-control">
	   				<!-- ---------------------------------- -->
	   				<!-- ---기존 파일 보내기hidden-------------------- -->
	   				<input type="hidden" name="old_filename" value="<c:out value="${board.filename }"/>">
	   				<!-- ----------------------------------- -->
	   			</td>
	   		</tr>
	   		
	   		<tr>
	   			<td colspan="2">
	   				<button type="submit" id="btnWrite" class="btn btn-success">글수정</button>
	   				<button type="reset" id="btnReset" class="btn btn-warning">다시쓰기</button>
	   			</td>
	   		</tr>
	   
	   
	   </table>
   </form>

</div>
<c:import url="/foot"/>