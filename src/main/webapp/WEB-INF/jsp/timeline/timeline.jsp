<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타임라인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="/static/css/style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
	<div id="wrap" class="bg-success">
		<div class="d-flex">
			<div class="col-3"></div>
			<div id="contentsDiv" style="overflow-y:scroll; width:600px; height:600px" class="contents bg-info">
				
				
				
			</div>
			<aside class="col-3 d-flex flex-column p-3 align-items-center">
				<div class="text-center"><h2>JWBook!</h2></div>
				<div class="text-center">${loginId }님 환영합니다!</div>
				<button type="button" class="form-control btn-info mt-4">좋아요한 글만 보기</button>
				<button onclick="location.href='/user/logout'" type="button" class="form-control btn-danger mt-4">로그아웃</button>
			</aside>
		</div>
	</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<script>

	$(document).ready(function(){
		//$("#contentsDiv").scrollTop(9999);
		$.ajax({
			type:"get"
			, url:"/timeline/post"
			, success:function(data){
				$("#contentsDiv").html(data); 
				$(".btn-delete").on("click", function(){
					let postId = $(this).val();
					$.ajax({
						type:"delete"
						, url:"/timeline/delete"
						, data:{"postId":postId}
						, success:function(data){
							if(data.result == "success"){
								alert("삭제되었습니다.");
								$("div[name=" + postId +"]").remove();
							}else if(data.result == "permission denied"){
								alert("삭제 권한이 없습니다.");
							}else if(data.result == "not exist"){
								alert("존재하지 않는 글입니다.");
								$("div[name=" + postId +"]").remove();
							}
						}
					});
				});
			}
		});
		
	});
</script>
</body>
</html>