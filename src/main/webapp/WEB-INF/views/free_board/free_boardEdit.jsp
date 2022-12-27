<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:import url="/top" />

<script src="https://cdn.ckeditor.com/4.17.2/standard/ckeditor.js"></script>

<script>
$(function() {
	
	CKEDITOR.replace('content');
	
	$('#bf').submit(function() {
		if($('#subject').val()=='') {
			alert('제목을 입력해주세요.');
			$('#subject').focus();
			return false;
		}
		if($('#name').val()=='') {
			alert('작성자를 입력해주세요.');
			$('#name').focus();
			return false;
		}
		if($('#bpwd').val()=='') {
			alert('비밀번호를 입력해주세요.');
			$('#bpwd').focus();
			return false;
		}
		
		return true;
	})
})
</script>

<%
   String ctx = request.getContextPath();
%>
<div align="center" id="bbs" class="col-md-8 offset-md-2 my-4">
   <h1>게시글 수정</h1>
   <p>
      <a href="<%=ctx%>/free_board/write">글쓰기</a> / <a
         href="<%=ctx%>/free_board/list">글목록</a>
      <p>

   <form name="bf" id="bf" role="form" action="write" method="POST" enctype="multipart/form-data">

   <input type="hidden" name="mode" value="edit">
   <input type="hidden" name="num" value="<c:out value="${board.num}"/>" >
       
    <table class="table">
       <tr>
          <td style="width:20%; text-align: center;"><b>제목</b></td>
          <td style="width:80%">
          <input type="text" name="subject" id="subject" 
          value='<c:out value="${board.subject}"/>' 
           class="form-control">
          </td>
       </tr>
       <tr>
          <td style="width:20%; text-align: center;"><b>글쓴이</b></td>
          <td style="width:80%">
          <input type="text" name="name" id="name" 
          value='<c:out value="${board.name}"/>' 
           class="form-control">
          </td>
       </tr>       
       <tr>
          <td style="width:20%; text-align: center;"><b>글내용</b></td>
          <td style="width:80%">
          <textarea name="content" id="content" rows="10" cols="50"
                  class="form-control">${board.content}</textarea>
          </td>
       </tr>
       <tr>
          <td style="width:20%; text-align: center;"><b>비밀번호</b></td>
          <td style="width:80%">
          <div class="col-md-5">
          <input type="password" name="passwd" id="bpwd" class="form-control">
          </div>
          </td>
      </tr>
      <tr>
         <td style="width: 20%; text-align: center;"><b>첨부파일</b></td>
         <td style="width: 80%">
         	<c:set var="fname" value="${fn:toLowerCase(board.filename)}"/>
                     <c:if test="${fn:endsWith(fname, '.jpg') or fn:endsWith(fname, '.png') or fn:endsWith(fname, '.gif')}">
                        <img width="80px" class="img img-thumbnail"
                           src="${pageContext.request.contextPath}/resources/board_upload/${board.filename}">
                     </c:if>
         
         <c:out value="${board.originFilename}"/> [<c:out value="${board.filesize}"/>  bytes] <br>

         <input type="file" name="mfilename" id="filename" class="form-control">
         <!-- 예전에 업로드한 파일 hidden으로 보내기 -->
         <input type="hidden" name="old_filename" value="<c:out value="${board.filename}"/>">
         </td>
      </tr>
      <tr>
         <td colspan="2" style="text-align: center;">
            <button type="submit" id="btnWrite" class="btn btn-primary">글수정하기</button>
            <button type="reset" id="btnReset" class="btn btn-danger">다시쓰기</button>
         </td>
      </tr>
   
      </table>
   

</form>       

</div>
<c:import url="/foot"/>










