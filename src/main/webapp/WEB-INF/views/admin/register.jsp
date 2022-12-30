<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <c:import url="/top" /> --%>
<script>
	function selectDownOption(code){
		$.ajax({
			type:'get',
			url:'getDownOption?up_Code='+code,
			dataType:'json',
			cache:false
		})
		.done(function(res){
			//alert(JSON.stringify(res));
			//응답 결과를 받아서 select 태그 만들어서 id가 selectDcg인 곳에 응답html 데이터를 넣기
			let str='<select name="down_Code" id="down_Code">';
				str+='<option value="">::하위 카테고리::</option>';
				$.each(res, function(i, getDownOption){
					str+='<option value="'+getDownOption.down_Code+'">'+getDownOption.down_Name+'</option>';
				})
			
			
				str+='</select>';
				$('#selectDcg').html(str);
		})
		.fail(function(err){
			alert('err');
		})
		
	}

</script>
 ${downLists}
<div>
	<div>
		<div>
			<div>
				<h1>상품 등록[관리자 페이지]</h1>
				<form role="form" method="POST" enctype="multipart/form-data"
					action="./register">
					<table>
						<thead>
							<tr>
								<th>"Register Product"</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>카테고리</td>
								<td>
								<select name="up_Code" id="up_Code"
									onchange="selectDownOption(this.value)">
										<option value="">상위 카테고리</option>
										<c:forEach var="up" items="${uplist}">
										<option value="${up.up_Code}">${up.up_Name}</option>
										</c:forEach>
								</select> 
							
								<select name="down_Code" id="down_Code"
									onchange="selectDownOption(this.value)">
										<option value="">하위 카테고리</option>
										<c:forEach var="down" items="${getDownOption}">
										<option value="${down.down_Code}">${down.down_Name}</option>
										</c:forEach>
								</select>
								
							 <span id="selectDcg"> 
                     
                                              
                    		 </span></td>
							</tr>
							<tr>
								<td><b>상품명</b></td>
								<td><input type="text" name="ptname" id="ptname"> <span
									style="color: red"></span></td>
							</tr>

							<tr>
								<td><b>제조사</b></td>
								<td><input type="text" name="pbrand" id="pbrand"></td>
							</tr>

							<tr>
								<td><b>상품품질</b></td>
								<td><select name="quality" id="quality">
										<option value="NEW" selected>신상품</option>
										<option value="HIT">인기상품</option>
										<option value="BEST">품절임박상품</option>
								</select></td>
							</tr>
							<tr>
								<td><b>상품이미지</b></td>
								<td>
								<input type="file" name="file1">
								</td>
							</tr>

							<tr>
								<td><b>상품수량</b></td>
								<td><input type="number" name="count" id="count">개
									<span style="color: red"></span></td>
							</tr>

							<tr>
								<td><b>상품정가</b></td>
								<td><input type="text" name="price" id="price">원 <span
									style="color: red"></span></td>
							</tr>
							<tr>
								<td><b>상품설명</b></td>
								<td><textarea name="pinfo" id="pinfo" rows="5" cols="60">
							</textarea></td>
							</tr>
							<tr>
								<td><b>포인트</b></td>
								<td><input type="number" name="point" id="point">POINT
								</td>
							</tr>
							<tr>
								<td>
									<button type="submit" class="btn btn-success">상품등록</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
