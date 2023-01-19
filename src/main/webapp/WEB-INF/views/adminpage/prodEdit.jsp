<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>

<c:import url="/top"/>

<script>
/*  function selectDownCategory(up_Code){
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
		
	}  */
	
/* 		if(!$('#up_Code').val()){
			alert('상위 카테고리를 선택하세요');
			$('#up_Code').focus();
			return false;
		}
		if(!$('#down_Code').val()){
			alert('하위 카테고리를 선택하세요');
			$('#down_Code').focus();
			return false;
		} 
		if(!$('#itemName').val()){
			alert('상품명을 입력하세요');
			$('#itemName').focus();
			return;
		}
		
		let $price=$('#price').val();
		let pattern=/^[0-9]+$/
		if(!pattern.test($('#count').val())){
			alert('수량은 숫자로 입력해야 해요');
			$('#count').select();
			return;
		}
		
		if(!pattern.test($price)){
			alert('정가는 숫자로 입력해야 해요');
			$('#price').focus();
			return;
		}
		if(!pattern.test($('#saleprice').val())){
			alert('판매가는 숫자로 입력해야 해요');
			$('#saleprice').focus();
			return;
		}
		if(!pattern.test($('#point').val())){
			alert('포인트는 숫자로 입력해야 해요');
			$('#point').focus();
			return;
		}
		return true;
	}
	*/
</script>


   <div class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
           <h1 class="text-center">상품 수정[Admin Page]</h1>
           

           
           <form name="peditF" id="peditF" action="prodEdit" method="POST" enctype="multipart/form-data">
           
            <!-- 파일업로드시: enctype="multipart/form-data"-->
            <table class="table table-condensed table-bordered mt-4">
               <thead>
                  <tr>
                     <th colspan="2" class="text-center">
                        <h3>:::Product Edit:::</h3>
                        
                     </th>
                  </tr>
               </thead>
               <tbody>
                  <tr>
                     <td width="20%"><b>카테고리</b></td>
                    
                     <td width="80%">
                     <b>
                     	<input type="text" name="up_Name" id="up_Name" readonly value="${itemvo.up_Name}">
                     	<input type="hidden" name="up_Code" id="up_Code" value="${itemvo.up_Code}">
                        <input type="text" name="down_Name" id="down_Name" readonly value="${itemvo.down_Name}">
                        <input type="hidden" name="down_Code" id="down_Code" value="${itemvo.down_Code}">
                     </b>
                     <br>

                  </td>
                  </tr>
                  
                  <tr>
                     <td width="20%"><b>상품번호</b></td>
                     <td width="80%">
                     	<input class="form-control" style="width: 50%;" type="text" name="itemNo" id="itemNo" value="${itemvo.itemNo } "readonly>
                     <span style="color: red"> 
                     </span>
               		 </td>
                  </tr>
                  
                  <tr>
                     <td width="20%"><b>상품명</b></td>
                     <td width="80%">
                     	<input type="text" style="width: 50%;" name="itemName" id="itemName" value="${itemvo.itemName }">
                     <span style="color: red"> 
                     </span>
               		 </td>
                  </tr>
                  <tr>
                     <td width="20%"><b>제조사</b></td>
                     <td width="80%">
                     <input type="text" name="itemBrand" id="itemBrand" value="${itemvo.itemBrand }"></td>
                  </tr>
                  <tr>
                     <td width="20%"><b>상품스펙</b></td>
                     <td width="80%">
                     <b>${itemvo.quality}</b>
                 
                  </tr>
            <!--       <tr>
                     <td>상품이미지</td>
                     <td>
                     <IMG SRC="" WIDTH="150PX" >
                     <br>
                     <input type="file" name="itemImage1"><br> 
                     <input type="file" name="itemImage1"><br> 
                     <input type="file" name="itemImage1"><br>
                     </td>
                  </tr> -->
                  
            <tr>
	   			<td style="width:20%"><b>상품이미지</b></td>
        		<td style="width:80%">
        		
        		<!-- ---새파일 업로드------------------ -->
        		     <input type="file" name="mitemImage1"><br> 
                     <input type="file" name="mitemImage1"><br> 
                     <input type="file" name="mitemImage1"><br>
        		<!-- ---기존 파일 표시------------------ -->
					기존 첨부 파일 명 : <br>
					<c:out value="${itemvo.itemImage1}"/> <br>
					<c:out value="${itemvo.itemImage2}"/> <br>
					<c:out value="${itemvo.itemImage3}"/> <br>
	   				<!-- ---기존 파일 보내기hidden-------------------- -->
	   				<input type="hidden" name="old_filename1" value="<c:out value="${itemvo.itemImage1 }"/>">
	   				<input type="hidden" name="old_filename2" value="<c:out value="${itemvo.itemImage2 }"/>">
	   				<input type="hidden" name="old_filename3" value="<c:out value="${itemvo.itemImage3 }"/>">
	   				<!-- ----------------------------------- -->
	   			</td>
	   		</tr>

                  <tr>
                     <td width="20%"><b>상품수량</b></td>
                     <td width="80%"><input type="number" name="count" id="count" value="${itemvo.count}">
                        개
               <span style="color: red"> 
               </span></td>
                        
                  </tr>
                  <tr>
                     <td width="20%"><b>상품정가</b></td>
                     <td width="80%">
                     <input type="text" name="price" id="price" value="${itemvo.price }">
      
                        원
                     <span style="color: red"> 
                     
               </span>         
                        </td>
                  </tr>
                  <tr>
                     <td width="20%"><b>상품판매가</b></td>
                     <td width="80%"><input type="text" name="saleprice"
                        id="saleprice" value="${itemvo.saleprice }"> 원
                        <span style="color: red"> 
                     
               </span>   
                        
                        </td>
                  </tr>
                  <tr>
                     <td width="20%"><b>상품설명</b></td>

                     <td width="80%">
                     <textarea name="itemInfo" id="itemInfo" rows="5" cols="60">${itemvo.itemInfo }</textarea></td>
                  </tr>
                  <tr>
                     <td width="20%"><b>포인트</b></td>
                     <td width="80%">
                     <input type="number" name="point" id="point" value="${itemvo.point }">
                        POINT</td>
                  </tr>
                  <tr>
                     <td colspan="2">
                        <button type="submit" class="btn btn-success" >상품정보수정</button>
                     </td>
                  </tr>
               </tbody>
            </table>
         </form>
           
        </div>
      </div>
    </div>
  </div>
    
