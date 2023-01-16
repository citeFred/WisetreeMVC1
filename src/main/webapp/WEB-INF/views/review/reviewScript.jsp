<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

$(function(){
// 	if(rearr==null){
// 		alert("등록된 리뷰가 엄슴")
//     }else {
//     	show_reviews();//전체 리뷰 목록 가져오기
// 		review_count();//리뷰 목록 갯수, 별점 평균
// 	}
		show_reviews();//전체 리뷰 목록 가져오기
		review_count();//리뷰 목록 갯수, 별점 평균
	
	
	$('#reform').submit(function(evt){
		evt.preventDefault();
		//check();
		//alert('1차확인');
		const file=$('#refilename')[0]
		//alert(file);
		const fname=file.files[0];
		//alert(fname.name);
		/* web.xml이랑 servlet 경로 D로 바꾸면 파일업로드가 안됨 */
		const userid=$('#userid').val();
		const content=$('#content').val();
		const score=$('input[name="score"]:checked').val();
		//alert(score);
		const itemno_fk=$('#itemno_fk').val();
		//const pidx_fk=6;
		
		//alert(userid+"/"+content+"/"+score+"/"+itemno_fk+"/"+fname);
		let formD=new FormData();
 		formD.append('userid', userid);
		//formD.append('userid', 'abcd');
		formD.append('content', content);
		formD.append('score', score);
		formD.append('itemno_fk', itemno_fk);
		formD.append('mode','ajaxMode');
		formD.append('reviewFile', fname);
		
		//alert(fname.name);
		//alert("formD ====>"+formD)		
		
		
		let url="prdreviews/user";
		$.ajax({
			type:'post',
			url:url,
			data:formD, 
			dataType:'json',
			cache:false,
			processData:false, 
			contentType:false, 
			beforeSend:function(xhr){
				//xhr.setRequestHeader("Ajax","true");
			},
			success:function(res){
				//alert(JSON.stringify(res))
				//alert(res);
// 				let result=$(res).find('result').text();
				let result = res.result;
				
				if(result>0) {
					//$('#revList').html("<h1>등록성공</h1>");
					show_reviews();
					window.location.reload(true)
				}else {
					alert('성공에서 등록 실패');
				}
			},
			error:function(err){
				alert('err'+err.status+'등록 실패');
				/* if(err.status==500) {
					alert('로그인해야 이용가능 합니다..')
				}  */
			}
			
		});
	})//$('#reform') end-----------------------------------
	
	
	//리뷰 수정 처리
	$('#reform2').submit(function(evt){
		evt.preventDefault();
		
		let uid=reform2.userid.value;
		let itemno=reform2.itemno_fk.value;
		//alert("itemno====>"+itemno);
		let renum=reform2.renum.value;
		//alert(renum);//---->해결	
		//let score=reform2.score.value;//-------->해결x
		//-------->값은 변경이 되는데 별이 고정됨
		let score=$('input[name="score"]:checked').val();
		//alert("sco===>"+score)
		let content=reform2.content.value;
		
		let jsonData= {
			userid:uid,
			itemno_fk:itemno,
			renum:renum,
			score:score,
			content:content
		}
		
		// 리뷰수정을 위한 정보들을 다 입력했는지 확인-------->해결o
        if (!userid || !itemno || !renum || !score || !content) {
            alert("모든 정보를 입력해주세요!");
            return false;
        }
		
        //alert(("jsonData======"+jsonData);
		//alert(JSON.stringify(jsonData))
		
		let data=JSON.stringify(jsonData);
		let url="prdreviews/user/"+renum;
		$.ajax({
			type:'put',
			url:url,
			data:data,
			contentType:'application/json; charset=UTF-8',
			dataType:'json',
			cache:false,
			beforeSend:function(xhr){
				//xhr.setRequestHeader("Ajax","true");
			},
			success:function(res){
				//alert(JSON.stringify(res));
				if(res.result>0) {
					$('#reviewModal').modal('hide');
					show_reviews();
				}else {
					alert('수정 실패');
				}
			},
			error:function(err){
				alert('err'+err.status);
				/* if(err.status==400) {
					alert('로그인 해야 이용 가능해요')
				}else {
					alert('err');
				} */
			}
		});
	});//$('#reform2') end-----------------------------------
})//$() end------------------------------------------------

//리뷰 수정 요청
const reviewEdit=function(renum){
	console.log(renum);// --> renum은 들어오는거 확인
	
	let url="prdreviews/user/"+renum; //"prdreviews/user/11
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false,
		beforeSend:function(xhr){
			//xhr.setRequestHeader("Ajax","true");
		},
		success:function(res){
			//alert((JSON.stringify(res));
			//alert(res.renum);
			
			reform2.renum.value=res.renum;
			//alert(reform2.renum.value);//여기까진 확인
			
			reform2.content.value=res.content;
			
			
			//alert($('#'+res.score+"-stars").val())
			//$('#reform2 #'+res.score+"-stars").prop("checked", true);
			//alert($('#reform2 #'+res.score+"-stars").is(":checked"))
			
			//.prop("checked",true);
			let str='';
			
			for(let i=0; i<res.score; i++) {
				str+='<img src="resources/review_images/star.png">'
			}
			$('#star').html(str);
			let imgSrc;
			if(res.refilename==null) {
				imgSrc='noimage.png';
			}else{
				imgSrc=res.refilename
			}
			str='<img src="resources/review_images/'+imgSrc+'"class="img-fluid" style="width:50%; margin:auto">'
			$('#prodImage').html(str);
			
			$('#reviewModal').modal();
			//모달창 띄우기 <==> 모달창 닫기 $().modal('hide');
		},
		error:function(err){
			alert('수정안됨');
				/* if(err.status==400) {
					alert('로그인 해야 이용 가능해요');
				} */
		}
	});
}//---------------------------------------------------
const review_count=function(){
	let url='prdreviews/cnt';
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false,
		success:function(res){
			console.log(res.cnt);
			console.log(res.avg);
			$('#review_avg').html(res.avg);
			$('#review_cnt').html(res.cnt);
		},
		error:function(request,status,err){
			//alert("등록된 리뷰가 없습니다");
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"err:"+err);
		}
	});
}



//리뷰목록 가져오기
const show_reviews=function(){
	let url="prdreviews";
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false,
		success:function(res){
			//alert(JSON.stringify(res));
		 	//alert(res.length);
			showTable(res);
		},
		error:function(request,status,err){
			//alert("등록된 리뷰가 없습니다");
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"err:"+err);
		}
	});
}//---------------------------------------------------

const showTable=function(res){
	let str='<table class="table table-striped">';
	$.each(res,function(i, revo){
			let wd = new Date(revo.wdate);
			let wdstr=wd.getFullYear()+"-"+(wd.getMonth()+1)+"-"+wd.getDate();
			
			str+='<tr><td width="15%">';
			if(revo.refilename==null) {
				str+='<img src="resources/review_images/noimage.png" class="img-thumbnail" style="width:80%;margin:auto">';
			}else {
				str+='<img src="resources/review_images/'+revo.refilename+'" class="img-thumbnail" style="width:80%;margin:auto">';
			}
			str+='</td><td width="60%" class="text-left">';
			str+=revo.content+" <span class='float-right'>"+revo.userid+"[ "+wdstr+" ]</span>";
			str+='</td>';
			str+='<td width="25%" class="text-left">';
			for(let k=0; k<revo.score; k++) {
				str+='<img src="resources/review_images/star.png">';
			}
			str+='<div class="mt-4">';
			if(revo.userid=="${loginUser.userid}") {
				str+='<a href="#revList" onclick="reviewEdit('+revo.renum+')">수정버튼</a> | ';
				str+='<a href="#revList" onclick="reviewDel('+revo.renum+')">삭제버튼</a>';
			}
			str+='</div>';
			str+='</td>';
			str+='</tr>';
			
		});
		str+='</table>';
		$('#revList').html(str);
}//---------------------------------------------------


const reviewDel = function(renum){
	let url="prdreviews/user/"+renum;
	$.ajax({
		type:'delete',
		url:url,
		dataType:'json',
		cache:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("Ajax","true");
		},
		success:function(res){
			//alert(JSON.stringify(res));
			if(res.result>0) {
				show_reviews();//전체 리뷰목록 가져옴;
			}
		},
		error:function(err){
			if(err.status==400) {
				alert('로그인 해야 이용 가능해요');
			}
		}
	});
}//--------------------------------------------------

//파일 업로드 없는 일반적 form data 전송시
const send=function(){
 	let params=$('#reform').serialize();
 	let url="prdreviews/user";
 	
 	$.ajax({
 		type:'post',
 		url:url,
 		data:params,
 		cache:false,
 		dataType:'xml',
 		success:function(res){
 			//alert(res);//XMLDocument
 			let result=$(res).find('result').text();
 			alert(result);
 		},
 		error:function(err){
 			alert('err'+err.status);
 		}
 	});
 }//---------------------------------------------------
 //--------------------------------
function check(){
	 		if(!$('#userid').val()){
	 			alert('아이디를 입력해주세요');
	 			$('#userid').focus();
	 			return;
	 		} 
	 		if(!$('#content').val()){
	 			alert('리뷰 내용을 입력해주세요');
	 			//-------------------------------
	 			$('#content').focus();
	 			return;
	 		}
	 		
	 		if(!$('#itemno_fk').val()){
	 			alert('아이템을 선택해주세요');
	 			$('#itemno_fk').focus();
	 			return;
	 		}
	 		$('#reform').submit();
	 		/* if(!$('#score').val()){
 			alert('별점을 남겨주세요');
 			$('#score').focus();
 			return;
 			} */
 			
	 		/* 
	 		
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
	 		} */
	 		
	 	}
</script>