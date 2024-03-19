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
					<input data-bs-toggle="tooltip" data-bs-placement="bottom" title="아이디는 8~16글자입니다." class="form-control is-invalid" type="text" placeholder="아이디를 입력하세요.">
				</div>
				<button class="btn btn-sm col-2 btn-success" type="button">중복 확인</button>
			</div>

			<div class="div-input-row">
				<label class="col-2 text-center">Password</label>
				<div class="col-8">
					<input data-bs-toggle="tooltip" data-bs-placement="bottom" title="비밀번호는 영문/숫자 조합 8~16글자입니다." class="form-control is-invalid" type="password" placeholder="비밀번호를 입력하세요.">
				</div>
				<div class="col-2"></div>
			</div>
			<div class="div-input-row">
				<label class="col-2 text-center">Confirm<br>Password</label>
				<div class="col-8">
					<input class="form-control is-invalid" type="password" placeholder="비밀번호를 확인해주세요.">
				</div>
				<div class="col-2"></div>
			</div>
			<div class="div-input-row">
				<label class="col-2 text-center">Email</label>
				<div class="col-8">
					<input class="form-control is-invalid" type="text" placeholder="이메일을 입력하세요.">
				</div>
				<div class="col-2"></div>
			</div>
			<div class="div-input-row">
				<div></div>
				<div class="col-8">
					<button id="signUpBtn" type="button" class="form-control background-mint">Sign up</button>
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
		
		$("#signUpBtn").on("click", function(){
			alert();
		});
	});
</script>
</body>
</html>