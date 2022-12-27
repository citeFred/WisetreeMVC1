
$(function(){
	show_reviews(); //리뷰 목록 호출
	review_count(); //리뷰 갯수 호출
	
	$('#reform').submit(function(evt){
		evt.preventDefault(); //서브밋 막기 
		alert('hi');
		const file=$('#refilename')[0]
		const fname=file.files[0];
		const userid=$('#userid').val();
		const content=$('#content').val();
		const score=$('input[name="score"]:checked').val();
		const pidx_fk=$('#pidx_fk').val();
		
		console.log(userid+"/"+content+"/"+score+"/"+pidx_fk+"/"+fname);
		
		let formD=new FormData();
		fd.append('refilename', fname);
		fd.append('userid', userid);
		fd.append('content', content);
		fd.append('score', score);
		fd.append('pidx_fk', pidx_fk);
		fd.append('mode','ajaxMode');
		
		
		let url="user/prdreviews";
		$.ajax({
			type:'post',
			url:url,
			data:formD,
			dataType:'xml',
			processData:false,
			contentType:false,
			cache:false,
			beforeSend:function(xhr){
				xhr.setRequestHeader("Ajax","true");
			},
			success:function(res){
				//alert(res);
		        let result=$(res).find('result').text();
		        if(result>0){
		             $('#reviewList').html("<h1>등록 성공</h1>");
		        	 show_reviews();//리뷰 목록 호출
		          }else{
		             alert('등록 실패');
		          }
		       },
		       error: function(err){
		          alert('err: '+err.status);
		    	  /*if(err.status==400) {
		    		  alert('로그인 해야 이용가능 합니다.');
		    	  }else {
		    		  alert('err: '+err.status);
		    	  }*/
		       }
		    });
		   })//reform end----------------------

//리뷰 수정 처리
//(reviewEdit.jsp의 폼 id reform2의 서브밋 버튼 처리)
	$('#reform2').submit(function(evt){
		evt.preventDefault(); //서브밋 막기
		
		//사용자가 수정한 값 얻기
		let uid=reform2.userid.value;
		let pidx_fk=reform2.pidx_fk.value;
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
		//alert(JSON.stringify(jsonData));
		
		let data=JSON.stringify(jsonData);
		let url="user/prdreviews/"+renum;
		$.ajax({
			type:'put',
			url:url,
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
					//모달윈도 닫기
					$('#reviewModal').modal('hide');
					
					//리뷰목록 가져오기 
					show_reviews();
				}else {
					alert('수정 실패');
				}
			},
			error:function(err){
				alert('err: '+err.status);
				/*if(err.status==400) {
					alert('로그인 해야 이용 가능 합니다.');
				}else {
					alert('err: '+err.status);
				}*/
			}
		});
	});
})//reform2 end------

//리뷰 갯수 가져오기
const review_count=function(){
	let url="prdreviewCnt";
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false,
		success:function(res){
			alert(res.count);
			$('#prdreviewCnt').html(res.count);
		},
		error:function(err){
			alert('err: '+err.status);
		}
	});
}


//리뷰목록 가져오기
const show_reviews=function(){
	let url="prdreviews"
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false,
		success:function(res){
			alert(JSON.stringify(res));
			showTable(res);
		},
		error:function(err){
			alert('err: '+err.status);
		}
	});
}

const showTable=function(res){
	let str='<table class="table table-striped">';
	$.each(res, function(i, revo){
		let dt=new Date(revo.wdate); // 
		let dstr=dt.getFullYear()+"-"+(dt.getMonth()+1)+"-"+dt.getDate();
		
		str+='<tr><td width="15%">';
		if(revo.refilename==null) {
			str+='<img src="resources/product_images/noimage.png" class="img-thumbnail" style="width:80%;margin:auto">';
		}else {
			str+='<img src="resources/review_images/'+revo.refilename+'" class="img-thumbnail" style="width:80%;margin:auto">';
		}
		str+='</td><td width="60%" class="text-left">';
		str+=revo.content+"<span class='float-right'>"+revo.userid+"[ "+dstr+" ]</span>";
		str+='</td>';
		str+='<td width="25%" class="text-left">';
		for(let k=0;k<revo.score;k++) {
			str+='<img src="resources/review_images/star.png">';
		}
		str+='<div class="mt-4">';
		if(revo.userid =="${loginUser.userid}") {
		str+='<a href="#revList" onclick="reviewEdit('+revo.num+')">EDIT</a> | ';
		str+='<a href="#revList" onclick="reviewDel('+revo.num+')">DEL</a>';
		}
		str+='</div>';
		str+='</td>';
		str+='</tr>';
	});
	str+='</table>';

	$('#revList').html(str);
}

const reviewEdit = function(renum){
	console.log(renum);
	let url="user/reviews/"+renum;
	alert(url);
	
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("Ajax","true");
		},
		success:function(res){
			reform2.renum.value=res.renum;//리뷰 글번호
			reform2.content.value=res.content;//리뷰 내용
			let str=''; //별불러오기 
			for(let i=0;i<res.score;i++) {
				str+='<img src="resources/review_images/star.png">';
			}
			$('#star').html(str); //별달기
			
			let imgSrc;
			if(res.refilename==null) {
				imgSrc='noimage.png';
			}else {
				imgSrc=res.refilename
			}
			str='<img src="resources/review_images/'+imgSrc+'" class="img-fluid" style="width:50%;margin:auto">';
			$('#prodImage').html(str); //상품이미지 띄우기
			
			$('#reviewModal').modal();//모달윈도우 띄우기  <=> 모달 창 닫기 $().modal('hide');
		},
		error:function(err){
			if(err.status==400) {
				alert('로그인 해야 이용 가능합니다.');
			}else {
			alert('err: '+err.status);
			}
		}
	});
}


const reviewDel = function(renum){
	alert(renum);
	let url="user/reviews/"+renum;
	
	$.ajax({
		type:'delete',
		url:url,
		dataType:'json',
		cache:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("Ajax","true");
		},
		success:function(res){
			alert(JSON.stringify(res));
			if(res.result>0) {
				show_reviews();// 전체 리뷰 목록 가져오기
			}
		},
		error:function(err){
			if(err.status==400) {
				alert('로그인 해야 이용 가능합니다.');
			}else {
			alert('err: '+err.status);
			}
		}
	});
}

 const send=function(){
 	alert('send');
 	
 	let params=$('#reform').serialize();
 	let url="user/reviews";
 	
 	$.ajax({
 		type:'post',
 		url:url,
 		data:params,
 		cache:false,
 		dataType:'xml',
 		success:function(res){
 			alert(res);
 			let result=$(res).find('result').text();
 			
 		},
 		error:function(err){
 			alert('err'+err.status);
 		}
 	});
 }