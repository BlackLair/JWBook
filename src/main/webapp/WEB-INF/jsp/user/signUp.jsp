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
			<div class="div-input-row">
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
		</section>
		<aside>
		</aside>
	</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<script>
	$(document).ready(function(){
		var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
		var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
		  return new bootstrap.Tooltip(tooltipTriggerEl)
		});
		
		let isValidId = false;      // 각 입력 양식 유효성 여부
		let isValidPw = false;
		let isValidConfirm = false;
		let isValidEmail = false;
		
		let idFormat = /^[a-z0-9]{8,16}$/; // 8~16자의 영문 또는 숫자
		let passwordFormat = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/;  // 8~16자의 영문/숫자 조합 패스워드 정규식
		let emailFormat = /^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$/; // 이메일 정규식
		
		function isAllValid(){ // 모든 input의 유효성 확인하여 회원가입 버튼 활성화 여부 설정
			if(isValidId && isValidPw && isValidConfirm && isValidEmail){
				$("#signUpBtn").attr("disabled", false);
				return true;
			}
			$("#signUpBtn").attr("disabled", true);
			return false;
		}
		
		function toNoneValid(tag){ // input이 공란일 경우
			tag.removeClass("is-invalid");
			tag.removeClass("is-valid");
		}
		function toValid(tag){  // input 값이 유효한 경우
			tag.removeClass("is-invalid");
			tag.addClass("is-valid");
		}
		function toInvalid(tag){ // input 값이 유효하지 않은 경우
			tag.removeClass("is-valid");
			tag.addClass("is-invalid");
		}
		
		// 아이디 중복 확인 버튼
		$("#checkDuplicatedBtn").on("click", function(){
			let loginId = $("#idInput").val();
			if(loginId == "" || !idFormat.test(loginId)){
				isValidId = false;
				toInvalid($("#idInput"));
				alert("올바른 아이디를 입력하세요.");
				isAllValid();
			}else{
				$.ajax({
					type:"get"
					, url:"/user/check-duplicated-id"
					, data:{"loginId":loginId}
					, success:function(data){
						if(data.isDuplicated){
							isValidId = false;
							toInvalid($("#idInput"));
							alert("이미 사용중인 아이디입니다.");
						}else{
							isValidId = true;
							toValid($("#idInput"));
							alert("사용 가능한 아이디입니다.");
						}
						isAllValid();
					}
					
				});	
			}
		});
		
		// 이메일 유효성 확인
		$("#emailInput").on("input", function(){
			let email = $(this).val();
			if(email == ""){
				isValidEmail = false;
				toNoneValid($(this));
			}
			else if(!emailFormat.test(email)){
				isValidEmail = false;
				toInvalid($(this));
			}else{
				isValidEmail = true;
				toValid($(this));
			}
			isAllValid();
		});
		
		// 패스워드 확인 유효성 확인
		$("#confirmPasswordInput").on("input", function(){
			let password = $("#passwordInput").val();
			let confirm = $(this).val();
			if(confirm == ""){
				isValidConfirm = false;
				toNoneValid($(this));
			}else if(password == confirm){
				isValidConfirm = true;
				toValid($(this));
			}else{
				isValidConfirm = false;
				toInvalid($(this));
			}
			isAllValid();
		});
		
		// 패스워드 유효성 확인
		$("#passwordInput").on("input", function(){
			let password = $(this).val();
			let confirm = $("#confirmPasswordInput").val();
			if(password == ""){
				isValidPw = false;
				toNoneValid($(this));
			}else{
				if(!passwordFormat.test(password)){
					isValidPw = false;
					toInvalid($(this));
				}else{
					isValidPw = true;
					toValid($(this));
				}
			}
			if(confirm != ""){
				if(confirm == password){
					isValidConfirm = true;
					toValid($("#confirmPasswordInput"));
				}else{
					isValidConfirm = false;
					toInvalid($("#confirmPasswordInput"));
				}
			}else{
				isValidConfirm = false;
				toNoneValid($("#confirmPasswordInput"));
			}
			isAllValid();
		});
		
		// 아이디 유효성 확인
		$("#idInput").on("input", function(){
			let id = $(this).val();
			isValidId = false;
			toNoneValid($(this));
			if(!idFormat.test(id)){
				toInvalid($(this));
			}
			isAllValid();
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
					alert(data.result);
				}
			});
		});
	});
</script>
</body>
</html>