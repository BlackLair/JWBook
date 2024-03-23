<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JWBook 회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="/static/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap" class="bg-success d-flex">
		<section class="bg-info d-flex flex-column justify-content-center align-items-center">
			<div class="div-input-row">
				<div></div>
				<h2 class="text-center">Welcome to JWBook!</h2>
				<div></div>
			</div>
			<div class="div-input-row mt-5">
				<label class="col-2 text-center">ID</label>
				<div class="col-8">
					<input id="idInput" data-bs-toggle="tooltip" data-bs-placement="bottom" title="아이디는 영문 또는 숫자 8~16자입니다." class="form-control" type="text" placeholder="아이디를 입력하세요.">
				</div>
				<button id="checkDuplicatedBtn" class="btn btn-sm col-2 btn-success" type="button">중복 확인</button>
			</div>

			<div class="div-input-row">
				<label class="col-2 text-center">Password</label>
				<div class="col-8">
					<input id="passwordInput" data-bs-toggle="tooltip" data-bs-placement="bottom" title="비밀번호는 영문/숫자 조합 8~16글자입니다." class="form-control" type="password" placeholder="비밀번호를 입력하세요.">
				</div>
				<div class="col-2"></div>
			</div>
			<div class="div-input-row">
				<label class="col-2 text-center">Confirm<br>Password</label>
				<div class="col-8">
					<input id="confirmPasswordInput" data-bs-toggle="tooltip" data-bs-placement="bottom" title="비밀번호를 재입력하세요." class="form-control" type="password" placeholder="비밀번호를 확인해주세요.">
				</div>
				<div class="col-2"></div>
			</div>
			<div class="div-input-row">
				<label class="col-2 text-center">Email</label>
				<div class="col-8">
					<input id="emailInput" class="form-control" type="text" placeholder="이메일을 입력하세요.">
				</div>
				<div class="col-2"></div>
			</div>
			<div class="div-input-row">
				<div></div>
				<div class="col-8">
					<button id="signUpBtn" type="button" class="form-control background-mint" disabled="disabled">Sign up</button>
				</div>
				<div></div>
			</div>
			<div class="div-input-row">
				<div></div>
				<div class="col-8 mt-5">
					<div class="text-small text-white">이미 회원이신가요?</div>
					<button id="signInBtn" type="button" class="btn w-100 btn-light">Sign in</button>
				</div>
				<div></div>
			</div>
		</section>
		<aside>
		</aside>
	</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<script>
	$(document).ready(function(){
		// input 툴팁 스크립트
		var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
		var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
		  return new bootstrap.Tooltip(tooltipTriggerEl)
		});
		
		let isValidId = false;      // 각 입력값 유효성 여부
		let isValidPw = false;
		let isValidConfirm = false;
		let isValidEmail = false;
		
		let idFormat = /^[a-z0-9]{8,16}$/; // 8~16자의 영문 또는 숫자 아이디 정규식
		let passwordFormat = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/;  // 8~16자의 영문/숫자 조합 패스워드 정규식
		let emailFormat = /^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$/; // 이메일 정규식
		
		// 모든 input의 유효성 확인하여 회원가입 버튼 활성화 여부 설정
		function checkAllValid(){ 
			if(isValidId && isValidPw && isValidConfirm && isValidEmail){
				$("#signUpBtn").attr("disabled", false);
				return true;
			}
			$("#signUpBtn").attr("disabled", true);
			return false;
		}
		
		// input 태그의 유효성에 따라 디자인 변경
		function setValid(tag, status){
			if(status == "valid"){
				tag.removeClass("is-invalid");
				tag.addClass("is-valid");
			}else if(status == "invalid"){
				tag.removeClass("is-valid");
				tag.addClass("is-invalid");
			}else{                         // none : 공란이거나 id의 중복 확인이 되기 전 상태
				tag.removeClass("is-valid");
				tag.removeClass("is-invalid");
			}
			checkAllValid();
		}
		
		// 아이디 중복 확인 버튼
		$("#checkDuplicatedBtn").on("click", function(){ 
			let loginId = $("#idInput").val();
			if(loginId == "" || !idFormat.test(loginId)){
				isValidId = false;
				setValid($("#idInput"), "invalid");
				alert("올바른 아이디를 입력하세요.");
			}else{
				$.ajax({
					type:"get"
					, url:"/user/check-duplicated-id"
					, data:{"loginId":loginId}
					, success:function(data){
						if(data.isDuplicated){
							isValidId = false;
							setValid($("#idInput"), "invalid");
							alert("이미 사용중인 아이디입니다.");
						}else{
							isValidId = true;
							setValid($("#idInput"), "valid");
							alert("사용 가능한 아이디입니다.");
						}
						isAllValid();
					}, error:function(request, status, error){
						alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"
								+"error:"+error);
					}
				});	
			}
		});
		
		// 이메일 유효성 확인
		$("#emailInput").on("input", function(){
			let email = $(this).val();
			if(email == ""){
				isValidEmail = false;
				setValid($(this), "none");
			}
			else if(!emailFormat.test(email)){
				isValidEmail = false;
				setValid($(this), "invalid");
			}else{
				isValidEmail = true;
				setValid($(this), "valid");
			}
		});

		// 패스워드 유효성 확인
		$("#passwordInput").on("input", function(){
			let password = $(this).val();
			let confirm = $("#confirmPasswordInput").val();
			if(password == ""){
				isValidPw = false;
				setValid($(this), "none");
			}else{
				if(!passwordFormat.test(password)){
					isValidPw = false;
					setValid($(this), "invalid");
				}else{
					isValidPw = true;
					setValid($(this), "valid");
				}
			}
			if(confirm != ""){
				if(confirm == password){
					isValidConfirm = true;
					setValid($("#confirmPasswordInput"), "valid");
				}else{
					isValidConfirm = false;
					setValid($("#confirmPasswordInput"), "invalid");
				}
			}else{
				isValidConfirm = false;
				setValid($("#confirmPasswordInput"), "none");
			}
		});
		
		// 패스워드 확인 유효성 확인
		$("#confirmPasswordInput").on("input", function(){
			let password = $("#passwordInput").val();
			let confirm = $(this).val();
			if(confirm == ""){
				isValidConfirm = false;
				setValid($(this), "none");
			}else if(password == confirm){
				isValidConfirm = true;
				setValid($(this), "valid");
			}else{
				isValidConfirm = false;
				setValid($(this), "invalid");
			}
		});
		
		// 아이디 유효성 확인
		$("#idInput").on("input", function(){
			let id = $(this).val();
			isValidId = false;
			setValid($(this), "none");
			if(!idFormat.test(id)){
				setValid($(this), "invalid");
			}
		});
		
		// 회원가입 버튼
		$("#signUpBtn").on("click", function(){
			let loginId = $("#idInput").val();
			let password = $("#passwordInput").val();
			let email = $("#emailInput").val();
			$.ajax({
				type:"post"
				, url:"/user/sign-up"
				, data:{"loginId":loginId, "password":password, "email":email}
				, success:function(data){
					if(data.result == "success"){
						alert("회원가입이 완료되었습니다.");
						location.href = "/user/signIn-view";
					}else{
						alert("회원가입에 실패했습니다.");
					}
				}
				, error:function(request, status, error){
					alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"
							+"error:"+error);
				}
			});
		});
		
		// 로그인 화면 이동 버튼
		$("#signInBtn").on("click", function(){
			location.href = "/user/signIn-view";
		});
	});
</script>
</body>
</html>