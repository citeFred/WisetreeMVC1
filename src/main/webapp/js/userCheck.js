let win=null;
function open_idcheck(){
	win=window.open("idCheck.do","idCheck","width=400, height=400, left=200, top=200");	
}//-------------------------------

//회원 가입 시 아이디 유효성 체크(onkeyup, onclick 동일)
function ajax_idcheck(uid){
	if(!uid){
		uid=$('#userid').val();
		if(!uid){
		alert('아이디를 입력하세요');
		$('#userid').focus();
		return;
		}
		if(!isUserid(mf.userid)){
			alert('아이디는 영문자로 시작하고 영문, 숫자, _! 포함 4~8자리여야 해요');
			mf.userid.select();
			return;
		}
	}
	$.ajax({
		type:'GET',
		url:'idcheck?userid='+uid,
		dataType:'json',
		cache:false,
		success:function(res){
			//alert(JSON.stringify(res));
			if(res.result=='ok'){
				$('#id_result').html(uid+"는 사용 가능합니다.").css('color','green')
				$('#id_flag').val("Y");
			}else{
				$('#id_result').html(uid+"는 이미 사용중 입니다.").css('color','red')
				$('#id_flag').val("N");
			}
		},
		error:function(err){
			alert('err: '+err.status);
		}
	})
}//------------------------

function setId(uid){
	//alert(uid);
	//uid값을 부모창(window)의 userid의 value값에 전달하자
	//부모창 (opener==> window객체)
	//window > document > forms
	opener.document.mf.userid.value=uid;
	
	//팝업창 닫기==>self (window객체)
	self.close();
}//-----------------------------

function id_check(){
	if(!idf.userid.value){
		alert('아이디를 입력해야 해요');
		idf.userid.focus();
		return;
	}
	if(!isUserid(idf.userid)){
		alert('아이디는 영문자로 시작해야되고 영문자,숫자,_,!로 4~8자까지 가능해요');
		mf.id_flag.value="N";
		idf.userid.select();
		return;
	}
	if(mf.id_flag.value=="N"){
		alert('아이디 중복체크를 해야 합니다.');
		mf.userid.focus();
		return;
	}
	idf.submit();	
} //-----------------------------------------
 
 
 
 
 
 function member_check(){
	/*
	if(!isDate(mf.birth)){
		alert('날짜 형식에 맞아야 합니다.');
		mf.birth.select();
		return;
	}
		*/

	if(!isKor(mf.name)){
		alert('이름은 한글이름만 가능합니다');
		mf.name.select();
		return;
	}
	if(!isUserid(mf.userid)){
		alert('아이디는 영문자,숫자,_,!로 4~8자까지 가능해요');
		mf.userid.select();
		return;
	}
	if(!isPasswd(mf.pwd)){
		alert('비밀번호는 영문자,숫자,!,. 로 4~8자리까지 가능해요');
		mf.pwd.select();
		return;
	}
	if(mf.pwd.value!=mf.pwd2.value){
		alert('비밀번호와 비밀번호 확인이 달라요');
		mf.pwd2.select();
		return;
	}
	if(!isEmail(mf.email)){
		alert('이메일 형식에 맞아야 합니다');
		mf.email.select();
		return;
	}
	if(!isMobile(mf.hp1, mf.hp2, mf.hp3)){
		alert('핸드폰 형식에 맞지 않아요. (010|011)-(숫자3~4자리)-(숫자4자리)');
		mf.hp1.select();
		return;
	}	
	mf.submit();
}//-----------------------
/** 
	asdf-12cd@naver.com
	adff.my@daum.net
	asdf12@google.co.kr
*/
function isEmail(input){
	let val=input.value;
	let pattern=/^[\w-_]+(\.[\w]+)*@([a-zA-Z]+\.)+[a-z]{2,3}$/;
	let b=pattern.test(val);
	//alert('email '+b);
	return b;
}

function isDate(input){
	let val=input.value;
	let pattern=/^\d{4}[-\/](0[1-9]|1[012])[-\/](0[1-9]|[12][0-9]|3[01])$/;
	let b=pattern.test(val);
	//alert(b);
	return b;
}//------------------------

/** 
	\b : 단어의 경계를 나타내며, 해당 패턴이 정확하게 일치해야 함을 의미
	(010|011) : 010 또는 011이 와야 함을 의미
	\d{3,4} : 숫자가 3개이상 4개 이하 나와야 함을 의미
	\d{4}: 숫자가 4자 나와야 함을 의미
*/
function isMobile(input1,input2, input3){
	let val=input1.value+"-"+input2.value+"-"+input3.value;
	//alert(val);
	let pattern=/\b(010|011)[-]\d{3,4}[-]\d{4}\b/;
	let b=pattern.test(val);
	//alert('hp '+b);
	return b;
}

/*
\w : 알파벳대소문자,숫자 
\. : 마침표
! : 느낌표
{4,8}: 4~8자리
*/
function isPasswd(input){
	let val=input.value;
	let pattern=/^[\w!\.]{4,8}$/;
	let b=pattern.test(val);
	//alert('pwd '+b);
	return b;
}

/* 
^ : 시작을 의미
$ : 끝을 의미
a-z: 알파벳 소문자
A-Z: 알파벳 대문자
0-9: 아라비아 숫자
_ : _
! : !
+ : 패턴문자가 1개 이상 올 수 있음을 의미
{4}: 4자리까지만 가능
{4,}: 4자리 이상 가능
{4,8}: 4~8자리까지 가능
*/
function isUserid(input){
	let val=input.value;
	//let pattern=/^[abc]+$/; //a or b or c
	let pattern=/^[a-zA-Z]{1}[a-zA-Z0-9_!]{3,7}$/;
	let b=pattern.test(val);
	//alert(b);
	return b;
}

/**
^ : 시작을 의미
$ : 끝을 의미
가-힣 : 한글을 의미
+ : 패턴이 한 번 이상 반복된다는 의미 
*/
function isKor(input){
	let val=input.value;
	//let pattern=new RegExp(/multi/g);// multi문자열이 있는지 여부를 체크하는 패턴
	//let pattern=/multi/g
	let pattern=/^[가-힣]+$/;
	let b=pattern.test(val); //정규식 패턴에 맞으면 true를 반환하고, 틀리면 false를 반환한다
	//alert(b);
	return b;
}
