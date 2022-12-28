/**
 *  리뷰 글쓰기
 * */

$(function(){
	//show_reviews(); //리뷰 목록 호출
	//review_count(); //리뷰 갯수 호출
	
	$('#reform').submit(function(evt){
		evt.preventDefault(); //서브밋 막기 
		alert('1차');
		const file=$('#refilename')[0]
		const fname=file.files[0];
		const userid=$('#userid').val();
		const content=$('#content').val();
		//const score=$('input[name="score"]:checked').val();
		const score=5;
		const pidx_fk=$('#pidx_fk').val();
		
		console.log(userid+"/"+content+"/"+score+"/"+pidx_fk+"/"+fname);
		
		let formD=new FormData();
		formD.append('refilename', fname);
		formD.append('userid', userid);
		formD.append('content', content);
		formD.append('score', score);
		formD.append('pidx_fk', pidx_fk);
		formD.append('mode','ajaxMode');
		
		console.log("formD ====>"+formD)
		
		$.ajax({
			type:'post',
			url:'prdreviews/user',
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
					//show_reviews();//전체 리뷰 목록 가져오기
				}else {
					alert('등록 실패');
				}
			},
			error:function(err){
				alert('ERR'+err.status);
				/*if(err.status==400) {
					alert('로그인해야 이용가능 합니다..')
				}*/
			}
		});
	})

	/**
	 *  리뷰 수정
	 * */
	
	//(reviewEdit.jsp의 폼 id reform2의 서브밋 버튼 처리)
	$('#reform2').submit(function(evt){
		evt.preventDefault();
		
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
		alert(JSON.stringify(jsonData));
		let data=JSON.stringify(jsonData);
		
		$.ajax({
			type:'put',
			url:'user/prdreviews/'+renum,
			data:data,
			contentType:'application/json; charset=UTF-8',
			dataType:'json',
			cache:false,
			beforeSend:function(xhr){
				xhr.setRequestHeader("Ajax","true");
			}
			.done(function(res){
				alert(JSON.stringify(res));
				if(res.result>0) {
					$('#reviewModal').modal('hide');
					show_reviews();
				}else {
					alert('수정 실패');
				}
			})
			.fail(function(err){
				alert('err');
			})
		});
	})
})

	/**
	 *  리뷰 보여주기
	 * */
	const show_reviews=function(){
		$.ajax({
			type:'get',
			url:'prdreviews',
			dataType:'json',
			cache:false,
		})
		.done(function(res) { 
			alert(JSON.stringify(res));
			alert(res.length);
			showTable(res);
		})
		.fail(function(err) { 
			alert('err'+err.status);
		});
	}
	
	/**
	 * 리뷰 목록 테이블화
	 * */
	const showTable=function(res){
		let str='<table class="table table-striped">';
		$.each(res, function(i, revo){
			let wd=new Date(revo.wdate); // 
			let dstr=wd.getFullYear()+"-"+(wd.getMonth()+1)+"-"+wd.getDate();
			
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
			if(revo.userid =="hong") {
			str+='<a href="#revList" onclick="reviewEdit('+revo.renum+')">EDIT</a> | ';
			str+='<a href="#revList" onclick="reviewDel('+revo.renum+')">DEL</a>';
			}
			str+='</div>';
			str+='</td>';
			str+='</tr>';
		});
		str+='</table>';

		$('#revList').html(str);
	}
	
	/**
	 * 리뷰 갯수
	 * */
	const review_cnt=function(){
		$.ajax({
			type:'get',
			url:'prdreview/cnt',
			dataType:'json',
			cache:false,
		})
		.done(function(res) {
			alert(res.count);
			$('#review_cnt').html(res.count);
		})
		.fail(function(err) { 
			alert(err);
		});
	}
	
	/**
	 * 특정 리뷰 조회 
	 */
	const reviewEdit = function(renum){
		console.log(renum);
		
		$.ajax({
			type:'get',
			url:'prdreviews/'+renum,
			dataType:'json',
			cache:false,
			beforeSend:function(xhr){
				xhr.setRequestHeader("Ajax","true");
			}
		})
		.done(function(res) { 
			alert(JSON.stringify(res));
			
			reform2.renum.value=res.renum;//리뷰 글번호
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
					$('#reviewModal').modal();
		})
		.fail(function(err) { 
			alert('err');
		});
	}



const reviewDel = function(renum){
	alert(renum);
	
	$.ajax({
		type:'delete',
		url:'user/reviews/'+renum,
		dataType:'json',
		cache:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("Ajax","true");
		}
	})
	.done(function(res) { 
		alert(JSON.stringify(res));
		
		if(res.result>0) {
			show_reviews();
		}
	})
	.fail(function(err) { 
		if(err.status==400) {
			alert('로그인 해야 이용 가능해요');
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
 	})
 	.done(function(res) {
 		alert(res);
 	
		let result=$(res).find('result').text();
		alert(result);
 	})
 	.fail(function(err) {
 		alert('err'+err.status);
 	});
 }