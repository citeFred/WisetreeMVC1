<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/top"/>

<script>
	function selectDownCategory(up_Code){
		//alert(upCode);
		$.ajax({
			type:'get',
			url:'getDownOption?up_Code='+up_Code,
			dataType:'json',
			cache:false
		})
		.done(function(res){
			//alert(JSON.stringify(res));
			//응답 결과를 받아서 select 태그 만들어서 id가 selectDcg인 곳에 응답html 데이터를 넣기
			let str='<select name="down_Code" id="down_Code">';
				str+='<option value="">::하위 카테고리::</option>';
				$.each(res, function(i, item){
					str+='<option value="'+item.down_Code+'">'+item.down_Name+'</option>';
				})
			
			
				str+='</select>';
				$('#selectDcg').html(str);
		})
		.fail(function(err){
			alert('err');
		})
		
	}
	
	function check(){
/* 		if(!$('#up_Code').val()){
			alert('상위 카테고리를 선택하세요');
			$('#up_Code').focus();
			return false;
		}
		if(!$('#down_Code').val()){
			alert('하위 카테고리를 선택하세요');
			$('#down_Code').focus();
			return false;
		} */
		if(!$('#itemName').val()){
			alert('상품명을 입력하세요');
			$('#itemName').focus();
			return false;
		}
		
		let $price=$('#price').val();
		let pattern=/^[0-9]+$/
		if(!pattern.test($('#count').val())){
			alert('수량은 숫자로 입력해야 해요');
			$('#count').select();
			return false;
		}
		
		if(!pattern.test($price)){
			alert('정가는 숫자로 입력해야 해요');
			$('#price').focus();
			return false;
		}
		if(!pattern.test($('#saleprice').val())){
			alert('판매가는 숫자로 입력해야 해요');
			$('#saleprice').focus();
			return false;
		}
		if(!pattern.test($('#point').val())){
			alert('포인트는 숫자로 입력해야 해요');
			$('#point').focus();
			return false;
		}
		return true;
	}
</script>


   <div class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
           <h1 class="text-center">상품 등록[Admin Page]</h1>
           
           <form name="prodF" id="prodF" method="POST" enctype="multipart/form-data" 
           action onsubmit="return check()">
            <!-- 파일업로드시: enctype="multipart/form-data"-->
            <table class="table table-condensed table-bordered mt-4">
               <thead>
                  <tr>
                     <th colspan="2" class="text-center">
                        <h3>:::Product Register:::</h3>
                     </th>
                  </tr>
               </thead>
               <tbody>
                  <tr>
                     <td width="20%"><b>카테고리</b></td>
                     <td width="80%">
                     <select name="up_Code" id="up_Code"
                        onchange="selectDownCategory(this.value)">
                           <option value="">::상위 카테고리::</option>
                           <c:forEach var="up" items="${upoption}">
                           	<option value="${up.up_Code}">${up.up_Name}</option>
                           </c:forEach>
                           
                     </select>
                     <span id="selectDcg"> 
                     
                                              
                     </span></td>
                  </tr>
                  
                  <tr>
                     <td width="20%"><b>상품명</b></td>
                     <td width="80%"><input type="text" name="itemName" id="itemName">
                     <span style="color: red"> 
                     </span>
               		 </td>
                  </tr>
                  <tr>
                     <td width="20%"><b>제조사</b></td>
                     <td width="80%"><input type="text" name="itemBrand"
                        id="itemBrand"></td>
                  </tr>
                  <tr>
                     <td width="20%"><b>상품스펙</b></td>
                     <td width="80%"><select name="quality" id="quality">
                           <option value="NEW" selected>NEW</option>
                           <option value="HIT">HIT</option>
                           <option value="BEST">BEST</option>
                     </select></td>
                  </tr>
                  <tr>
                     <td>상품이미지</td>
                     <td>
                     <input type="file" name="mitemImage1"><br> 
                     <input type="file" name="mitemImage1"><br> 
                     <input type="file" name="mitemImage1"><br>
                  </td>
                  </tr>

                  <tr>
                     <td width="20%"><b>상품수량</b></td>
                     <td width="80%"><input type="number" name="count" id="count">
                        개
               <span style="color: red"> 
               </span></td>
                        
                  </tr>
                  <tr>
                     <td width="20%"><b>상품정가</b></td>
                     <td width="80%">
                     <input type="text" name="price" id="price">
      
                        원
                     <span style="color: red"> 
                     
               </span>         
                        </td>
                  </tr>
                  <tr>
                     <td width="20%"><b>상품판매가</b></td>
                     <td width="80%"><input type="text" name="saleprice"
                        id="saleprice"> 원
                        <span style="color: red"> 
                     
               </span>   
                        
                        </td>
                  </tr>
                  <tr>
                     <td width="20%"><b>상품설명</b></td>
                     <td width="80%"><textarea name="itemInfo" id="itemInfo"
                           rows="5" cols="60"></textarea></td>
                  </tr>
                  <tr>
                     <td width="20%"><b>포인트</b></td>
                     <td width="80%"><input type="number" name="point" id="point">
                        POINT</td>
                  </tr>
                  <tr>
                     <td colspan="2">
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
    

