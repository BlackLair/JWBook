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
		<div class="mt-3 bg-warning d-flex">
			<div class="col-3"></div>
			<div id="uploadDiv">
				<div class="h4">새 게시글 작성</div>
				<input type="file" class="form-control">
				<textarea id="contentsTextarea" type="text" class="form-control mt-3" placeholder="내용을 입력해주세요."></textarea>
			</div>
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
				$(".btn-like").on("click", function(){ // 좋아요 버튼 누름
					let postId = $(this).attr("value");
					if($(this).hasClass("bi-hand-thumbs-up")){ // 좋아요하기
						$.ajax({
							type:"get"
							, url:"/timeline/like"
							, data:{"postId":postId}
							, context:this
							, success:function(data){
								if(data.result == "success"){ // 좋아요 성공
									$(".div-likeCount[value=" + postId + "]").text(data.likeCount);
									$(this).removeClass("bi-hand-thumbs-up");
									$(this).addClass("bi-hand-thumbs-up-fill");
								}else if(data.result == "not exist"){ // 존재하지 않는 게시물
									alert("존재하지 않는 게시물입니다.");
									$("div[name=" + postId + "]").remove();
								}
							}
							, error:function(){
								alert("좋아요 에러");
							}
						});
					}else{  // 좋아요 취소하기
						$.ajax({
							type:"delete"
							, url:"/timeline/unlike"
							, data:{"postId":postId}
							, context:this
							, success:function(data){
								if(data.result == "success"){
									$(".div-likeCount[value=" + postId + "]").text(data.likeCount);
									$(this).removeClass("bi-hand-thumbs-up-fill");
									$(this).addClass("bi-hand-thumbs-up");
								}
							}
						});
					}
				});
				
				$(".btn-delete").on("click", function(){ // 게시글 삭제 버튼
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