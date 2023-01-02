<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

$(function(){
	show_reviews();//전체 리뷰 목록 가져오기
	review_count();
	
	$('#reform').submit(function(evt){
		evt.preventDefault();
		//alert('1차확인');
		const file=$('#refilename')[0]
		//alert(file);
		const fname=file.files[0];
		//alert(fname.name);
		const userid=$('#userid').val();
		const content=$('#content').val();
		const score=$('input[name="score"]:checked').val();
		//const score=5;
		//const pidx_fk=$('#pidx_fk').val();
		const pidx_fk=6;
		
		//alert(userid+"/"+content+"/"+score+"/"+pidx_fk+"/"+fname);
		let formD=new FormData();
		formD.append('refilename1', fname);
		formD.append('userid', userid);
		formD.append('content', content);
		formD.append('score', score);
		formD.append('pidx_fk', pidx_fk);
		formD.append('mode','ajaxMode');
		
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
				//alert(res);
// 				let result=$(res).find('result').text();
				let result = res.result;
				
				if(result>0) {
					//$('#revList').html("<h1>등록성공</h1>");
					show_reviews();
				}else {
					alert('성공에서 등록 실패');
				}
			},
			error:function(err){
				alert('err'+err.status+'등록 실패');
				/* if(err.status==400) {
					alert('로그인해야 이용가능 합니다..')
				} */
			}
			
		});
	})//$('#reform') end-----------------------------------
	
	
	//리뷰 수정 처리
	$('#reform2').submit(function(evt){
		evt.preventDefault();
		
		let uid=reform2.userid.value;
		//let pidx=reform2.pidx_fk.value;
		let pidx=6;
		let renum=reform2.renum.value;
		//alert(renum);//---->해결	
		let score=reform2.score.value;
		let content=reform2.content.value;
		
		let jsonData= {
			userid:uid,
			pidx_fk:pidx,
			renum:renum,
			score:score,
			content:content
		}
		
		//alert("jsonData======"+jsonData);
		alert(JSON.stringify(jsonData))
		
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
				alert(JSON.stringify(res));
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

const review_count=function(){
	let url='prdreviews/cnt';
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false,
		success:function(res){
			//alert(res.cnt);
			
			$('#review_cnt').html(res.cnt);
		},
		error:function(err){
			alert(err);
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
		error:function(err){
			alert('err'+err.status);
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
				str+='<img src="resources/review_images/star.jpg">';
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
			alert(JSON.stringify(res));
			//alert(res.renum);
			
			reform2.renum.value=res.renum;
			//alert(reform2.renum.value);//여기까진 확인
			
			reform2.content.value=res.content;
			let str='';
			for(let i=0; i<res.score; i++) {
				str+='<img src="resources/review_images/star.jpg">'
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

</script>