<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:import url="/top"/>

<div class="container mt-3" style="overflow: auto;">
	<h1 class="text-center">게시글</h1>
	<c:if test="${board eq null}">
		<div class="alert alert-danger my-5 text-center">
			<h4>존재하지 않는 글입니다.</h4>
		</div>
	</c:if>
	<c:if test="${board ne null}">
		<table class="table mt-4">
            <tr>
               <td width="20%">글번호</td>
               <td width="30%"><c:out value="${board.num}"/></td>
               <td width="20%">작성일</td>
               <td width="30%">
               <fmt:formatDate value="${board.wdate}" pattern="yyyy-MM-dd hh:mm:ss" />
               </td>
            </tr>
            <tr>
               <td width="20%">글쓴이</td>
               <td width="30%"><c:out value="${board.name}"/></td>
               <td width="20%">조회수</td>
               <td width="30%"><c:out value="${board.readnum}"/></td>
            </tr>

            <tr>
               <td width="20%">제목</td>
               <td colspan="3" align="left"><c:out value="${board.subject}"/>
               </td>
            </tr>
            <tr height="60">
               <td width="20%">글내용</td>
               <td colspan="3" align="left">
               ${board.content}
               </td>
            </tr>
            <tr>
               <td width="20%">첨부파일</td>
               <td colspan="3">&nbsp;

                     <c:if test="${board.filename ne null}">
                     <%-- <a href="${pageContext.request.contextPath}/upload/${board.filename}" download> --%>
                     <a href="#" onclick="down()">
                     ${board.originFilename}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     </a> <%-- [ <c:out value="${board.filesize}"/> bytes] --%>
                     </c:if>
                     <c:set var="fname" value="${fn:toLowerCase(board.filename)}"/>
                     <c:if test="${fn:endsWith(fname, '.jpg') or fn:endsWith(fname, '.png') or fn:endsWith(fname, '.gif')}">
                        <img width="80px" class="img img-thumbnail"
                           src="${pageContext.request.contextPath}/resources/free_board_upload/${board.filename}">
                     </c:if>
               </td>
            </tr>
<!--             <tr>
            	<td colspan="4" align=center><button id="btnUP" class="btn btn-primary">UP</button>&nbsp;&nbsp;&nbsp;
            	<button id="btnDOWN" class="btn btn-danger">DOWN</button>
            </tr> -->
            <tr>
               <td colspan="4" align=center><a href="../write">글쓰기</a>| <a
                  href="../list">목록</a>| <a href="#" onclick="go(1)">편집</a>| <a
                  href="#" onclick="go(2)">삭제</a>| <a href="javascript:goRe()">답변</a></td>
            </tr>
         </table>
	</c:if>
	<!-- form for file download  -->
	<form name="fileF" id="fileF" method="post" action="../../fileDown" >
		<input type="hidden" name="fname" value="<c:out value="${board.filename}"/>" >
		<input type="hidden" name="origin_fname" value="<c:out value="${board.originFilename}"/>" >
	</form>
	<!-- =============================== -->
	<!-- 편집 또는 삭제 위한 form -->
	<form name="frm" id="frm">
		<input type="hidden" name="num" value="<c:out value="${board.num}"/>">
		<input type="hidden" name="mode" >
		<div class="row mt-4" id="divPasswd" style="display:none">
			<div class="col-md-3 offset-md-1 text-right mr-2">
				<label for="passwd">글 비밀번호</label>
			</div>
			<div class="col-md-4">
				<input type="password" name="passwd" id="passwd" class="form-control" 
				placeholder="Password" required>
			</div>
			<div class="col-md-3">
				<button id="btn" class="btn btn-outline-primary"></button>
			</div>
		</div>
	</form>
	<!-- ---------------------------------------------- -->
	<form name="reF" id="reF" action="../rewrite" method="post">
		<input type="hidden" name="num" value="<c:out value="${board.num}"/>">
		<input type="hidden" name="subject" value="<c:out value="${board.subject}"/>">
	</form>
</div>
<script>
	function goRe() {
		reF.submit();
	}
	
	function down() {
		fileF.submit();
		
	}
	
	function go(flag) {
		if(flag==1) {
			frm.mode.value='edit';
			$('#btn').text('글수정');
			$('#passwd').focus();
			frm.action='../edit';
			frm.method='post';
		} else if(flag==2) {
			frm.mode.value='delete';
			$('#btn').text('글삭제');
			$('#passwd').focus();
			frm.action='../delete';
			frm.method='post';
		}
		$('#divPasswd').show(500);
	}
</script>

<c:import url="/foot" />