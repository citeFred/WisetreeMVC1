<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:import url="/top"/>

<style>
#boardBody>tr>td:nth-child(5n+2) {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
</style>
<script>
	function check() {
		if(!searchF.findType.value) {
			alert('검색 유형 선택하기');
			return false;
		}
		if(!searchF.findKeyword.value) {
			alert('검색어 입력하기');
			searchF.findKeyword.focus();
			return false;
		}
		return true;
	}
</script>

<div class="container mt-3" style="height:600px;overflow: auto;">
	<h1 class="text-center">자유게시판</h1>
	<p class="text-center my-4">
		<a href="write">글쓰기 /</a><a href="list"> 글목록</a>
	</p>
	<!-- 검색 폼 -->
	<form>
		<div class="row py-3">
			<div class="col-md-9 text-center">
				<form name="searchF" action="list" onsubmit="return check()">
				
					<input type="hidden" name="pageSize" value="${pageSize}">
					<input type="hidden" name="cpage" value="${paging.cpage}">
					
					<select name="findType" style="padding:3px">
						<option value="">---검색 유형---</option>
						<option value="1">제목</option>
						<option value="2">작성자</option>
						<option value="3">내용</option>
					</select>
					<input type="text" name="findKeyword" placeholder="검색어 입력" autofocus="autofocus">
					<button class="btn btn-outline-primary">검 색</button>
				</form>
			</div>
			<div class="col-md-3 text-right">
				<form name="pageSizeF" action="list">
					
					<input type="hidden" name="findType" value="${paging.findType}">
					<input type="hidden" name="findKeyword" value="${paging.findKeyword}">
					<input type="hidden" name="cpage" value="${paging.cpage}">
					
					<select name="pageSize" style="padding:3px" onchange="submit()">
						<option value="">---페이지 사이즈---</option>
						<c:forEach var="ps" begin="5" end="20" step="5">
							<option value="${ps}" <c:if test="${pageSize eq ps}">selected</c:if> >페이지 사이즈 ${ps}</option>
						</c:forEach>
					</select>
				</form>
			</div>
		</div>
	</form>
	<!-- ----------------- -->
	<table class="table table-condensed table-striped">
		<thead>
			<tr>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody id="boardBody">
		<c:if test="${boardArr eq null or empty boardArr}">
			<tr>
				<td colspan="4"><b>No Data</b></td>
			</tr>
		</c:if>
		<c:if test="${boardArr ne null and not empty boardArr}">
			<c:forEach var="board" items="${boardArr}">
			<tr>
				<td>
					<c:forEach var="k" begin="1" end="${board.lev}">
						&nbsp;&nbsp;&nbsp;
					</c:forEach>
					<c:if test="${board.lev>0}">
						<img src="../images/re.png">
					</c:if>
					<a href="view/<c:out value="${board.num}"/>">
					<c:if test="${fn:length(board.subject)>30}">
						<c:out value="${fn:substring(board.subject, 0,30)}" /> ...
					</c:if>
					<c:if test="${fn:length(board.subject)<=30 }">
						<c:out value="${board.subject}" />
					</c:if>
					</a>
					
					<c:if test="${board.filesize>0}">
						<span class="float-right"><img src="../images/attach.jpg" style="width:16px"
						title="<c:out value="${board.originFilename}"/>"></span>
					</c:if>
				</td>
				<td>
					<c:out value="${board.name}" />
				</td>
				<td>
					<c:out value="${board.wdate}" />
				</td>
				<td>
					<c:out value="${board.readnum}" />
				</td>
			</tr>
			</c:forEach>
		</c:if>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="3" class="text-center">
				${pageNavi}
				</td>
				<td colspan="2" class="text-right">
				총 게시글 수 : <c:out value="${paging.totalCount}"/><br>
				<span class="text-danger"><c:out value="${paging.cpage}"/></span> / 
				<c:out value="${paging.pageCount}"/>
			</tr>
		</tfoot>
	</table>
</div>

<c:import url="/foot" />