<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- functions taglib---------------------------------------- -->
<c:import url="/top"/>
<%-- ${boardArr } --%>
<div class="container mt-3" style="overflow: auto;">
	<h1 class="text-center">공지게시판</h1>
	
	
	
	
		<c:if test="${loginUser.status eq 9 or k_loginUser.status eq 9}">
	<p class="text-center my-4">
			<a href="write">글쓰기</a>
	</p>
	</c:if>
	
	
	<c:if test="${loginUser.status eq 9 or k_loginUser.status eq 9}">
	<p class="text-right my-4" >
		<a	href="#noticeCon" data-toggle="modal">공지글 설정</a> |
		<a	href="deleteNotice">공지글 해제</a>
	</p>
	</c:if>
	
	
	
	
	
	<table class="table table-condensed table-striped">
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${boardArr eq null or empty boardArr }">
			<tr>
				<td colspan="3"><b>데이터가 없습니다</b></td>
			</tr>
		</c:if>
		<c:if test="${boardArr ne null and not empty boardArr }">
			<c:forEach var="board" items="${boardArr }">
					<tr>
						
						<td><c:out value="${board.num }" /></td>

						<td class="sub">
							<a href="view/<c:out value="${board.num }"/>">
								<c:if test="${fn:length(board.subject)>20 }">
					<c:out value="${fn:substring(board.subject,0,20) }"/>...
				</c:if>
				<c:if test="${fn:length(board.subject)<=20 }">
				<c:out value="${board.subject }"/>
				</c:if>				
							</a>
							<!-- ---첨부파일 있는 글 표시---------------- -->
							<c:if test="${board.filesize>0 }">
								<span class="float-right">
									<img src="../images/attach.jpg" style='width:26px'
									title="<c:out value="board.originFilename"/>"/>
								</span>
							</c:if>
							<!-- ----------------------------------- -->
						</td>
						
						<td><c:out value="${board.name }" /></td>
						<td><c:out value="${board.wdate }" /></td>
						<td><c:out value="${board.readnum }" /></td>

					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	
	
	</table>

</div>

<!-- noticePop.jsp include -->
<%@ include file="/WEB-INF/views/notice_board/noticeControl.jsp" %>
<!-- ---------------------------------- -->

<c:import url="/foot"/>