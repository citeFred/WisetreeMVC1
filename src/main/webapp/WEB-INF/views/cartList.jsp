<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="/top" />

<div class="py-5">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1 class="text-center">${loginUser.name}[${loginUser.userid}]님의
					장바구니</h1>

			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<!-- 주문 폼 시작-------------------------- -->
				<form name="orderF" id="orderF" action="orderList" method="post">

					<table class="table table-striped">
						<thead>
							<tr class="info text-center">
								<th>상품번호</th>
								<th>상품명</th>
								<th>수량</th>
								<th>단가</th>
								<th>금액</th>
								<th>삭제</th>
							</tr>
						</thead>


						<tbody>
							<c:choose>
								<c:when test="${sum eq null or empty sum}">
									<tr>
										<td colspan="6"><b>장바구니에 담긴 상품이 없습니다</b></td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="vo" items="${cartArr}" varStatus="state">
										<!--    state.index:인덱스값(0~3)
                	 state.count:반복문 횟수(1~4) -->

										<tr>
											<td><label> <%--   <input type="checkbox" name="ItemNo" id="ItemNo${state.index}"
                       value="${vo.ItemNo}">
                       ${vo.ItemNo}
                      </label> --%> <input type="checkbox" name="ItemNo"
													value="${vo.pnum_fk}"> ${vo.pnum_fk}
											</label></td>
											<td>
												<h4>${vo.itemName}</h4> <br> 
												<a
												href="../prodDetail?ItemNo=${vo.pnum_fk}" target="_blank">
													<img src="../resources/product_images/${vo.itemImage1}"
													class="img-thumbnail" style="width: 140px">
												</a>
											</td>
											<td><input type="number" name="oqty"
												id="oqty${state.index}" value="${vo.oqty}" min="1"
												max="50" size="3">
												<button type="button" class="btn btn-success"
													onclick="cartEdit('${vo.cartNum}','${state.index}')">
													수정</button></td>
											<td>${vo.price}</td>
											<td>${vo.saleprice}</td>
											<td><a href="#" onclick="cartDel('${vo.cartNum}')">삭제</a>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							<!-- -------------------- -->

						</tbody>

						<tr>
							<td colspan="3">
								<h5>
									장바구니 총 액: <span class="text-danger"> <fmt:formatNumber
											value="${sum}" pattern="###,###" /> 원
									</span>
								</h5>


							</td>
							<td colspan="3">
								<button type="submit" id="orderBtn"
									class="btn btn-outline-info">주문하기</button> <!-- form tag안에 버튼이 있으면 default 로 submit ==> order.jsp -->
								<button type="button" class="btn btn-outline-warning"
									onclick="location.href='../index'">계속쇼핑</button>
									
							</td>
						</tr>
					</table>
				</form>
				<!-- ----------------------------------- -->
			</div>
		</div>
		<!-- 삭제form------------------------- -->
		<form name="df" action="cartDel">
			<input type="hidden" name="cartNum">
		</form>
		<!-- --------------------------------- -->

		<!-- 수정form ------------------------- -->
		<form name="ef" action="cartEdit">
			<input type="hidden" name="cartNum">
			<input type="hidden" name="oqty">
		</form>
		<!-- --------------------------------- -->

		<script>
			function cartEdit(cnum, i) {
				alert(cnum+"/"+i);
				let oqty = $('#oqty' + i).val();
				alert(oqty);
				ef.cartNum.value = cnum;
				ef.oqty.value = oqty;
				ef.method = 'post';
				ef.submit();

			}

			function cartDel(cnum) {
				alert(cnum);
				df.cartNum.value = cnum;
				df.method = 'post';
				df.submit();
			}
			
		</script>

	</div>
</div>
<c:import url="/foot" />
