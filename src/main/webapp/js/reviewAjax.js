
$(function(){
	show_reviews(); //목록 메서드 호출
	review_count(); //리뷰 갯수 메서드 호출
//파일 업로드 처리시 ==> FormData객체에 form data를 담아 보내야 한다(업로드)
	$('#rf').submit(function(evt){
		evt.preventDefault(); //서브밋 막기 
		//alert('hi');
		//첨부파일
		const file=$('#mfilename')[0]
		//console.dir(file);
		//첨부파일명
		const fname=file.files[0];
		//alert(fname.name);
		const userid=$('#userid').val();
		const content=$('#content').val();
		const score=$('input[name="score"]:checked').val();
		const pnum_fk=$('#pnum_fk').val();
		
		console.log(userid+"/"+content+"/"+score+"/"+pnum_fk+"/"+fname);
		
		//POST방식으로 전송하려면 FormData에 담아야 함. 
		let fd=new FormData();
		fd.append('mfilename', fname);
		fd.append('userid', userid);
		fd.append('content', content);
		fd.append('score', score);
		fd.append('pnum_fk', pnum_fk);
		fd.append('mode','ajaxMode');
		/*
			processData:false, ==> 기본값 : true ==> true면 enctype="application/x-www-form-urlencoded" 타입으로 전송됨.
			contentType:false, ==> 기본값 : true ==> true면 enctype="application/x-www-form-urlencoded" 타입으로 전송됨.
			따라서 파일 업로드 할때는 enctype="multipart/form-data로 가야하기 때문에 false, false로 설정해야 한다.
		*/
		
		let url="user/reviews";
		$.ajax({
			type:'post',
			url:url,
			data:fd, //위에 담은 FormData객체임
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
		             //$('#reviewList').html("<h1>등록 성공</h1>");
		        	 show_reviews();//전체 리뷰 목록 가져오기
		          }else{
		             alert('등록 실패');
		          }
		       },
		       error: function(err){
		          //alert('err: '+err.status);
		    	  if(err.status==400) {
		    		  alert('로그인 해야 이용가능 합니다.');
		    	  }else {
		    		  alert('err: '+err.status);
		    	  }
		       }
		    });
		   })

//리뷰 수정 처리 (reviewEdit.jsp의 폼 id rf2의 서브밋 버튼 처리)
	$('#rf2').submit(function(evt){
		//서브밋 막기
		evt.preventDefault();
		//사용자가 수정한 값 얻기
		let uid=rf2.userid.value;
		let pnum=rf2.pnum_fk.value;
		let num=rf2.num.value;
		let score=rf2.score.value;
		let content=rf2.content.value;
		
		let jsonData= {
			userid:uid,
			pnum_fk:pnum,
			num:num,
			score:score,
			content:content
		}
		//alert(JSON.stringify(jsonData));
		let data=JSON.stringify(jsonData);
		let url="user/reviews/"+num;
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
				//alert(JSON.stringify(res));
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
				//alert('err: '+err.status);
				if(err.status==400) {
					alert('로그인 해야 이용 가능 합니다.');
				}else {
					alert('err: '+err.status);
				}
			}
		});
		
	});
	
})//$()end------

//리뷰 갯수 가져오기
const review_count=function(){
	let url="reviewCnt";
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false,
		success:function(res){
			//alert(res.count);
			$('#review_cnt').html(res.count);
		},
		error:function(err){
			alert('err: '+err.status);
		}
	});
}


//리뷰목록 가져오기
const show_reviews=function(){
	let url="reviews"
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false,
		success:function(res){
			//alert(JSON.stringify(res));
			showTable(res);
		},
		error:function(err){
			alert('err: '+err.status);
		}
	});
}

const showTable=function(res){
	let str='<table class="table table-striped">';
	$.each(res,function(i, rvo){
		let d=new Date(rvo.wdate); // date 부분에 d.toLocaleString() 로 넣을 수 있다. 하지만 아래 연월일로 사용했다.
		let dstr=d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
		
		str+='<tr><td width="15%">';
		if(rvo.filename==null) {
			str+='<img src="resources/product_images/noimage.png" class="img-thumbnail" style="width:80%;margin:auto">';
		}else {
			str+='<img src="resources/review_images/'+rvo.filename+'" class="img-thumbnail" style="width:80%;margin:auto">';
		}
		str+='</td><td width="60%" class="text-left">';
		str+=rvo.content+"<span class='float-right'>"+rvo.userid+"[ "+dstr+" ]</span>";
		str+='</td>';
		str+='<td width="25%" class="text-left">';
		for(let k=0;k<rvo.score;k++) {
			str+='<img src="resources/review_images/star.png">';
		}
		str+='<div class="mt-4">';
		if(rvo.userid =="${loginUser.userid}") {
		str+='<a href="#reviewList" onclick="reviewEdit('+rvo.num+')">EDIT</a> | ';
		str+='<a href="#reviewList" onclick="reviewDel('+rvo.num+')">DEL</a>';
		}
		str+='</div>';
		str+='</td>';
		str+='</tr>';
	});
	str+='</table>';

	$('#reviewList').html(str);
}

const reviewEdit = function(num){
	//console.log(num);
	let url="user/reviews/"+num;
	//alert(url);
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("Ajax","true");
		},
		success:function(res){
			//alert(JSON.stringify(res));
			rf2.num.value=res.num;//리뷰 글번호
			rf2.content.value=res.content;//리뷰 내용
			let str=''; //별불러오기 
			for(let i=0;i<res.score;i++) {
				str+='<img src="resources/review_images/star.png">';
			}
			$('#star').html(str); //별달기
			
			let imgSrc;
			if(res.filename==null) {
				imgSrc='noimage.png';
			}else {
				imgSrc=res.filename
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


const reviewDel = function(num){
	//alert(num);
	let url="user/reviews/"+num;
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



//파일 업로드가 없는 일반적 form data 전송 시 아래 사용 
 const send=function(){
 	//alert('send');
 	
 	let params=$('#rf').serialize();
 	
 	//alert(params);
 	
 	let url="user/reviews";
 	
 	$.ajax({
 		type:'post',
 		url:url,
 		data:params,
 		cache:false,
 		dataType:'xml',
 		success:function(res){
 			//alert(res); //XMLDocument.. 로온다
 			let result=$(res).find('result').text();
 			//alert(result);
 		},
 		error:function(err){
 			alert('err'+err.status);
 		}
 	});
 }