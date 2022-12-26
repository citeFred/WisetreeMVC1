<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/top" />

<script src="https://cdn.ckeditor.com/4.17.2/standard/ckeditor.js"></script>

<script>
$(function() {
	
	CKEDITOR.replace('content');
	
	$('#bf').submit(function() {
		if($('#subject').val()=='') {
			alert('제목 입력');
			$('#subject').focus();
			return false;
		}
		if($('#name').val()=='') {
			alert('작성자 입력');
			$('#name').focus();
			return false;
		}
		if($('#bpwd').val()=='') {
			alert('비밀번호 입력');
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
   <h1>Spring Board [답변 글쓰기]</h1>
   <p>
      <a href="<%=ctx%>/board/write">글쓰기</a>| <a
         href="<%=ctx%>/board/list">글목록</a>
      <p>
         <!--파일 업로드시
   method: POST
   enctype: multipart/form-data 
    
    -->   

   <form name="bf" id="bf" role="form" action="write" method="POST" enctype="multipart/form-data">
   <input type="hidden" name="mode" value="rewrite">
   <!-- 원본글쓰기mode는 write, 답변글쓰기 mode는 rewrite로 감  -->
   <input type="hidden" name="num" value='<c:out value="${num}" />'>     
    <table class="table">
       <tr>
          <td style="width:20%"><b>제목</b></td>
          <td style="width:80%">
          <input type="text" name="subject" id="subject" 
           value='<c:out value="[RE]${subject}"/>' 
          class="form-control">
          </td>
       </tr>
       <tr>
          <td style="width:20%"><b>글쓴이</b></td>
          <td style="width:80%">
          <input type="text" name="name" id="name" class="form-control">
          </td>
       </tr>       
       <tr>
          <td style="width:20%"><b>글내용</b></td>
          <td style="width:80%">
          <textarea name="content" id="content" rows="10" cols="50"
                  class="form-control"></textarea>
          </td>
       </tr>
       <tr>
          <td style="width:20%"><b>비밀번호</b></td>
          <td style="width:80%">
          <div class="col-md-5">
          <input type="password" name="passwd" id="bpwd" class="form-control">
          </div>
          </td>
      </tr>
      <tr>
         <td style="width: 20%"><b>첨부파일</b></td>
         <td style="width: 80%">
         <input type="file" name="mfilename"
            id="filename" class="form-control"></td>
      </tr>
      <tr>
         <td colspan="2">
            <button type="submit" id="btnWrite" class="btn btn-success">답변 글쓰기</button>
            <button type="reset" id="btnReset" class="btn btn-warning">다시쓰기</button>
         </td>
      </tr>
   
      </table>
   

</form>       

</div>
<c:import url="/foot"/>










