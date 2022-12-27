<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!-- functions taglib---------------------------------------- -->
<c:import url="/top"/>
<%-- ${boardArr } --%>
<div class="container mt-3" style="overflow: auto;">
	<h1 class="text-center">Spring Board</h1>
	<p class="text-center my-4">
		<a href="write">글쓰기</a>|<a href="list">글목록</a>
	</p>
	
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
		
			<c:forEach var="board" items="${boardArr }">
					<tr>
						<td><c:out value="${board.num }" /></td>
						<td><c:out value="${board.subject }" /></td>
						<td><c:out value="${board.name }" /></td>
						<td><c:out value="${board.wdate }" /></td>
						<td><c:out value="${board.readnum }" /></td>

					</tr>
				</c:forEach>
		
		
		</tbody>
	
	
	</table>

</div>
<c:import url="/foot"/>