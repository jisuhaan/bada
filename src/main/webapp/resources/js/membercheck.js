function check1(){
	
	var f1 = document.form1;
	
	//아이디검증//
	var did = f1.id.value;
	var vid =/^[a-z0-9]{4,20}$/;
	
	if(did==""){
		alert("아이디는 비워둘 수 없습니다.")
		f1.id.select();
		return false;
	}
		
	if(!vid.test(did)){
		alert("아이디는 영소문자, 숫자로만 구성되어야하며 5~20글자까지 지원합니다.")
		f1.id.select();
		return false;
	}
	
	//비번 검증//
	var dpw = f1.pw.value;
	var vpw =/^[A-Za-z0-9]{8,20}$/;
	
	if(dpw==""){
		alert("비밀번호는 비워둘 수 없습니다.")
		f1.pw.select();
		return false;
	}
		
	if(!vpw.test(dpw)){
		alert("비밀번호는 영문(대소문자구분), 숫자로만 구성되어야하며 8~20글자까지 지원합니다.")
		f1.pw.select();
		return false;
	}
	
	//비번확인 검증//
	var dpwre = f1.pwre.value;
	var vpwre =/^[A-Za-z0-9]{8,20}$/;
	
	if(dpwre==""){
		alert("비밀번호 확인란은 비워둘 수 없습니다.")
		f1.pwre.select();
		return false;
	}
		
	if(dpw!=dpwre){
		alert("비밀번호가 일치하지 않습니다.")
		f1.pwre.select();
		return false;
	}
	
	//이름 검증//
	var dname = f1.name.value;
	var vname =/^[가-힣A-Za-z]{2,10}$/;
	
	if(dname==""){
		alert("이름은 비워둘 수 없습니다.")
		f1.name.select();
		return false;
	}
		
	if(!vname.test(dname)){
		alert("이름은 한글 혹은 영어로만 입력하세요.")
		f1.name.select();
		return false;
	}
	
	//전화번호 검증//
	var dtel = f1.tel.value;
	var vtel =/^(01[01]{1})-[\d]{3,4}-[\d]{4}$/;
	
	if(dtel==""){
		alert("전화번호는 비워둘 수 없습니다.")
		f1.tel.select();
		return false;
	}
		
	if(!vtel.test(dtel)){
		alert("전화번호 형식이 잘못되었습니다")
		f1.tel.select();
		return false;
	}
	
	//이메일 검증//
	var dmail = f1.mail.value;
	var vmail =/^[A-Za-z0-9]*@[A-Za-z0-9]*\.[a-z]{2,6}$/;
	
	if(dmail==""){
		alert("메일은 비워둘 수 없습니다.")
		f1.mail.select();
		return false;
	}
		
	if(!vmail.test(dmail)){
		alert("메일 형식이 잘못되었습니다")
		f1.mail.select();
		return false;
	}

	f1.submit();
}
