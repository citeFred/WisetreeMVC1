<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="/top" />

<script type="text/javascript">
</script>
<!-- The Modal -->
<script>
var getCookie = function(name) {
    var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
    return value? value[2] : null;
};

var deleteCookie = function(name) {
    document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
}

var setCookie = function(name, value, exp) {
    var date = new Date();
    date.setTime(date.getTime() + exp*(24+9)*60*60*1000);
    document.cookie = name + '=' + value + ';expires=' + date.toGMTString() + ';path=/';
};
$(function(){
	let flag=getCookie("noticePop");
	//alert(flag);
	if(flag==null||flag==undefined||!flag){
		$('#undoNotice').prop("checked",false);
		<c:if test="${notice ne null}">
		$('#noticePop').modal();
		</c:if>
	}else{
		$('#undoNotice').prop("checked",true);
	}
	$('#undoNotice').click(function(){
		if($(this).is(':checked')){
			setCookie("noticePop","${notice.num}",1)
		}else{
			deleteCookie("noticePop");
		}
	});
})
</script>
<br>
<h3 style="text-align: center;"> 상품을 소개합니다! </h3>
<br>
 <!-- Section-->
 <div class="container mt-3" >
	<c:import url="/prodQty">
		<c:param name="quality" value="HIT"/>
	</c:import>
	
	<c:import url="/prodQty">
		<c:param name="quality" value="NEW"/>
	</c:import>
	
	<c:import url="/prodQty">
		<c:param name="quality" value="BEST"/>
	</c:import>
	
</div> 
<!-- noticePop.jsp include -->
<%@ include file="/WEB-INF/views/notice_board/noticePop.jsp" %>
<!-- ---------------------------------- -->
<c:import url="/foot" />
