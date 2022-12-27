<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(function(){
	//show_reviews();
	
	//review_count();
	//리뷰 작성
	$('#reform').submit(function(ev){
		ev.preventDefault();
		const file=$('#refilename')[0]
		const fname=file.files[0];
		const userid=$('#userid').val();
		const content=$('#content').val();
		const score=$('input[name="score"]:checked').val();
		const pidx_fk=$('#pidx_fk').val();
		
		console.log(userid+"/"+content+"/"+score+"/"+pidx_fk+"/"+fname);
		
		let formD=new FormData();
		
		formD.append('refilename', fname);
		formD.append('userid', userid);
		formD.append('content', content);
		formD.append('score', score);
		formD.append('pidx_fk', pidx_fk);
		formD.append('mode','ajaxMode');
		
		let url="prdreviews/cre";
		$.ajax({
			type:'POST',
			url:url,
			data:formD, 
			dataType:'xml',
			cache:false,
			processData:false, 
			contentType:false, 
			beforeSend:function(xhr){
				xhr.setRequestHeader("Ajax","true");
			},
			success:function(res){
				//alert(res);
				let result=$(res).find('result').text();
				if(result>0) {
					$('#reviewList').html("<h1>등록성공</h1>");
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
	})//reform end------------------

const review_count=function(){
	let url='prdreviewCnt';
	$.ajax({
		type:'GET',
		url:url,
		dataType:'json',
		cache:false,
		success:function(res){
			alert(res.count);
			$('#prdreviewCnt').html(res.count);
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
		type:'GET',
		url:url,
		dataType:'json',
		cache:false,
		success:function(res){
			alert(JSON.stringify(res));
			//alert(res.length);
			//showTable(res);
		},
		error:function(err){
			alert('err'+err.status);
		}
	});
}

//파일 업로드 없이 글등록
 const send=function(){
 	let params=$('#reform').serialize();
 	let url="prdreviews/cre";
 	
 	$.ajax({
 		type:'post',
 		url:url,
 		data:params,
 		cache:false,
 		dataType:'xml',
 		success:function(res){
 			alert(res);//XMLDocument
 			
 			let result=$(res).find('result').text();
 			alert(result);
 		},
 		error:function(err){
 			alert('err'+err.status);
 		}
 	});
 }

</script>