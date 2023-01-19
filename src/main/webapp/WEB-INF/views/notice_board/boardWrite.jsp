<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		
		if($('#subject').val().length>200){
			alert('제목은 200자 내로 작성해주세요');
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
		
		if($('#content').val().length>2000){
			alert('글내용은 2000자 내로 작성해주세요');
			$('#content').focus();
			return false;
		}
		
		/* if($('#content').val()==''){
			alert('글내용을 입력하세요');
			$('#content').focus();
			return false;
		} */
		
		if($('#bpwd').val()==''){
			alert('글 비밀번호를 입력하세요');
			$('#bpwd').focus();
			return false;
		}
		
		if($('#bpwd').val().length>20){
			alert('글 비밀번호는 20자 내로 작성해주세요');
			$('#bpwd').focus();
			return false;
		}
		
		return true;
	})
})//$() end----------------------------
	
</script>

<div align="center" id="bbs" class="col-md-8 offset-md-2 my-4">
   <h1>공지게시판 글쓰기</h1>
   <p>
   	<a href="write">글쓰기</a>|<a href="list">글목록</a>
   </p>
   
   <form name="bf" id="bf" role="form" action="write" method="POST" enctype="multipart/form-data">
	   <!-- <input> --><!-- 원본글쓰기mode는 write, 답변글쓰기 mode는 rewrite로 감 - 활용할때 사용  -->
	   <table>
	   		<tr>
	   			<td style="width:20%"><b>제목</b></td>
        		<td style="width:80%">
	   				<input type="text" name="subject" id="subject" class="form-control">
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
                  class="form-control"></textarea>
	   				<!-- <input type="text" name="content" id="content" class="form-control"> -->
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
	   				<input type="file" name="mfilename" id="filename" class="form-control">
	   			</td>
	   		</tr>
	   		
	   		<tr>
	   			<td colspan="2">
	   				<button type="submit" id="btnWrite" class="btn btn-success">글쓰기</button>
	   				<button type="reset" id="btnReset" class="btn btn-warning">다시쓰기</button>
	   			</td>
	   		</tr>
	   
	   
	   </table>
   </form>

</div>
<c:import url="/foot"/>