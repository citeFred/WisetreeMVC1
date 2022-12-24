<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/top"/>
<style>
	.txt0{
		color:gray;
	}
	.txt-1{
		color:blue;
	}
	.txt-2{
		color:tomato;
	}
</style>
<div class="container mt-3" style="height:600px;overflow:auto;">
	<h1 class="text-center">Users [Admin Page]</h1>
	<div>
<%-- 	${userArr} --%>
		<table class="table table-bordered mt-3">
			<tr>
				<th>IDX</th>
				<th>Name</th>
				<th>ID</th>
				<th>Contact</th>
				<th>Status</th>
				<th>EDIT | DEL</th>
			</tr>
			<!-- ------------------------- -->
			<c:forEach var="user" items="${userArr}">
			<tr>
				<td>${user.idx}</td>
				<td>${user.name}</td>
				<td>${user.userid}</td>
				<td>${user.allHp}</td>
       		    <td class="txt${user.status}">${user.statusStr}</td>
				<td>
				<a href="javascript:userEdit('${user.idx}')" >EDIT</a> | 
				<a href="#" onclick="userDel('${user.idx}')">DEL</a>
				</td>
			</tr>
			</c:forEach>
			<!-- ------------------------- -->
		</table>
	</div>
</div>
<script type="text/javascript">
function userDel(vidx){
	//alert(vidx);
	$('#idx').val(vidx);
	//attr() => 정적인 속성을 추가 할 때 사용
	//prop() => 기능적인 속성을 추가 할 때 사용
	$('#frm').prop('action','userDel')
	$('#frm').submit();
}

function userEdit(vidx){
	//alert(vidx);
	$('#idx').val(vidx);
	$('#frm').prop('action','userEdit')
	$('#frm').submit();
}
</script>
<form name="frm" id="frm" method="post">
<!-- idx Hidden Data -->
	<input type="text" name=idx id="idx">
<!-- ----------------- -->
</form>
<c:import url="/foot"/>
