		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

$(function(){
	show_reviews();//전체 리뷰 목록 가져오기
	review_count();
	$('#reform').submit(function(evt){
		evt.preventDefault();
		alert('1차확인');
		const file=$('#refilename')[0]
		const fname=file.files[0];
		const userid=$('#userid').val();
		const content=$('#content').val();
		const score=$('input[name="score"]:checked').val();
		//const score=5;
		const pidx_fk=$('#pidx_fk').val();
		
		console.log(userid+"/"+content+"/"+score+"/"+pidx_fk+"/"+fname);
		
		let formD=new FormData();
		formD.append('refilename', fname);
		formD.append('userid', userid);
		formD.append('content', content);
		formD.append('score', score);
		formD.append('pidx_fk', pidx_fk);
		formD.append('mode','ajaxMode');
		
		$.ajax({
			type:'post',
			url:"prdreviews/user",
			data:formD,
			dataType:'xml',
			cache:false,
			processData:false, 
			contentType:false, 
			beforeSend:function(xhr){
				xhr.setRequestHeader("Ajax","true");
			},
			success:function(res){
				alert(res);
				let result=$(res).find('result').text();
				if(result>0) {
					$('#revList').html("<h1>등록성공</h1>");
					show_reviews();//전체 리뷰 목록 가져오기
				}else {
					alert('등록 실패');
				}
			},
			error:function(err){
				alert('err'+err.status);
				/* if(err.status==400) {
					alert('로그인해야 이용가능 합니다..')
				} */
			}
			
		});
	})//$('#reform') end-----------------------------------
	
	
	//리뷰 수정 처리
	$('#reform2').submit(function(evt){
		evt.preventDefault();
		//사용자가 수정한 값 얻기
		let uid=reform2.userid.value;
		let pidx=reform2.pidx_fk.value;
		let renum=reform2.renum.value;
		let score=reform2.score.value;
		let content=reform2.content.value;
		
		let jsonData= {
			userid:uid,
			pidx_fk:pidx,
			renum:renum,
			score:score,
			content:content
		}
		
		let data=JSON.stringify(jsonData);
		$.ajax({
			type:'put',
			url:"prdreviews/user/"+renum,
			data:data,
			contentType:'application/json; charset=UTF-8',
			dataType:'json',
			cache:false,
			beforeSend:function(xhr){
				xhr.setRequestHeader("Ajax","true");
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
				alert('err');
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
	
	$.ajax({
		type:'get',
		url:"prdreview/cnt",
		dataType:'json',
		cache:false,
		success:function(res){
			alert(res.count);
			$('#review_cnt').html(res.count);
		},
		error:function(err){
			alert(err);
		}
	});
}



//리뷰목록 가져오기
const show_reviews=function(){
	$.ajax({
		type:'get',
		url:"prdreviews",
		dataType:'json',
		cache:false,
		success:function(res){
			alert(JSON.stringify(res));
			alert(res.length);
			//reviewTable(res);
		},
		error:function(err){
			alert('err'+err.status);
		}
	});
}//---------------------------------------------------

const reviewTable=function(res){
	let str='<table class="table table-striped">';
	$.each(res, function(i, revo){
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
			if(revo.userid=="hong") {
				str+='<a href="#revList" onclick="reviewEdit('+revo.renum+')">EDIT</a> | ';
				str+='<a href="#revList" onclick="reviewDel('+revo.renum+')">DEL</a>';
			}
			str+='</div>';
			str+='</td>';
			str+='</tr>';
		});
		str+='</table>';
		$('#revList').html(str);
}//---------------------------------------------------

const reviewEdit=function(renum){
	console.log(renum);
	
	$.ajax({
		type:'get',
		url:"prdreviews/"+renum,
		dataType:'json',
		cache:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("Ajax","true");
		},
		success:function(res){
			alert(JSON.stringify(res));
			reform2.renum.value=res.renum;//리뷰글번호
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
			str='<img src="resources/review_images/'+imgSrc+'" class="img-fluid" style="width:50%;margin:auto">'
			$('#prodImage').html(str);
			
			$('#reviewModal').modal();//모달창 띄우기 <==> 모달창 닫기 $().modal('hide');
		},
		error:function(err){
			alert('err');
			/* if(err.status==400) {
				alert('로그인 해야 이용 가능해요');
			} */
		}
	});
}//---------------------------------------------------

const reviewDel = function(num){
	$.ajax({
		type:'delete',
		url:"prdreviews/user/"+renum,
		dataType:'json',
		cache:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("Ajax","true");
		},
		success:function(res){
			alert(JSON.stringify(res));
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

 const send=function(){
	alert('send');
	
	
 	let params=$('#reform').serialize();
 	$.ajax({
 		type:'post',
 		url:"prdreviews/user",
 		data:params,
 		cache:false,
 		dataType:'xml',
 		success:function(res){
 			alert(res);
 			
 			let result=$(res).find('result').text();
 			alert(result);
 		},
 		error:function(err){
 			alert('err'+err.status);
 		}
 	});
 }//---------------------------------------------------

</script>