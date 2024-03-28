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
	<div id="wrap" class="bg-secondary">
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
		<div class="mt-3 d-flex">
			<div class="col-3"></div>
			<div id="uploadDiv">
				<div class="h5">게시글 작성</div>
				<input id="fileInput" type="file" accept="image/*" class="form-control">
				<div class="d-flex w-100 mt-3">
					<textarea id="contentsTextarea" type="text" class="form-control" placeholder="내용을 입력해주세요."></textarea>
					<button id="uploadBtn" type="button" class="btn btn-info col-2">
						<i class="bi bi-send-fill h2"></i>
					</button>
				</div>
			</div>
		</div>
	</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<script>
	let lastLoadedPostId = 2100000000; // 가장 최근 로딩된 게시물들 중 가장 마지막 게시글 아이디
	let prevLastLoadedPostId = lastLoadedPostId; // 가장 최근 로딩 직전 게시물들 중 가장 오래된 게시글 아이디
	$(document).ready(function(){
		$("#contentsDiv").scroll(function(){
			let scrollPos = $(this).scrollTop();
			let scrollHeight = $(this).prop("scrollHeight");
			let clientHeight = $(this).prop("clientHeight");
			if(scrollPos == scrollHeight - clientHeight){
				loadPost();
			}
		});
		function setPostUIEvent(){ // 게시글 목록 view의 각 UI들에 이벤트를 등록한다.
			$(".btn-like").off("click"); // 스크롤 내려서 게시물 로드 시 이벤트 중복 등록 방지
			$(".btn-like").on("click", function(){ // 좋아요 버튼 누름
				let postId = $(this).attr("value");
				if($(this).hasClass("bi-hand-thumbs-up")){ // 좋아요하기
					$.ajax({
						type:"get"
						, url:"/like/add"
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
						, url:"/like/remove"
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
			$(".btn-deletePost").off("click"); // 스크롤 내려서 게시물 로드 시 이벤트 중복 등록 방지
			$(".btn-deletePost").on("click", function(){ // 게시글 삭제 버튼
				let postId = $(this).val();
				$.ajax({
					type:"delete"
					, url:"/timeline/delete"
					, data:{"postId":postId}
					, success:function(data){
						if(data.result == "success"){
							alert("게시글이 삭제되었습니다.");
							$("div[name=" + postId +"]").hide(0, function(){
								$("div[name=" + postId + "]").remove();
							});
						}else if(data.result == "permission denied"){
							alert("삭제 권한이 없습니다.");
						}else if(data.result == "not exist"){
							alert("존재하지 않는 글입니다.");
							$("div[name=" + postId +"]").remove();
						}
					}
					, complete:function(){
						let scrollHeight = $("#contentsDiv").prop("scrollHeight");
						let clientHeight = $("#contentsDiv").prop("clientHeight");
						if(scrollHeight == clientHeight){
							loadPost(lastLoadedPostId);
						}
					}
				});
			});
		}
		function setReplyUIEvent(postId){
			$(".form-addReply[value=" + postId + "]").on("submit", function(e){
				e.preventDefault();
				let contents = $(".input-reply[name=" + postId + "]").val();
				if(contents == ""){
					alert("댓글 내용을 입력하세요.");
					return;
				}
				$.ajax({
					type:"post"
					, url:"/reply/upload"
					, data:{"postId":postId, "contents":contents}
					, success:function(data){
						if(data.result == "success"){
							loadReply(postId);
						}else{
							alert("댓글 작성 실패");
						}
					}
					, error:function(){
						alert("댓글 작성 에러");
					}
				});
			});
			$(".btn-deleteReply[value=" + postId + "]").on("click", function(){
				let replyId = $(this).attr("id");
				$.ajax({
					type:"delete"
					, url:"/reply/remove"
					, data:{"id":replyId}
					, success:function(data){
						if(data.result == "success"){
							alert("댓글이 삭제되었습니다.");
						}else if(data.result == "permission denied"){
							alert("댓글 삭제 권한이 없습니다.");
						}else if(data.result == "not exist"){
							alert("댓글이 존재하지 않습니다.");
						}else{
							alert("댓글 삭제 실패");
						}
						loadReply(postId);
					}
					, error:function(){
						alert("댓글 삭제 에러");
					}
				});
			});
		}
		function loadReply(postId){
			$.ajax({
				type:"get"
				, url:"/reply/view"
				, data:{"postId":postId}
				, success:function(data){
					$(".div-reply[value=" + postId + "]").html(data);
				}
				, complete:function(){
					setReplyUIEvent(postId);
				}
			});
		}
		
		function loadPost(){ // 게시글 목록을 불러온다.
			$.ajax({
				type:"get"
				, url:"/timeline/post"
				, data:{"postId":lastLoadedPostId}
				, success:function(data){
					$("#contentsDiv").append(data);
					
					$(".post").each(function(index, item){
						let postId = $(this).attr("name");
						if(postId < prevLastLoadedPostId){
							loadReply(postId);	
						}
						lastLoadedPostId = postId;
					});
				}
				, complete:function(){
					prevLastLoadedPostId = lastLoadedPostId;
					setPostUIEvent(); // 각 게시글의 UI에 이벤트 등록
				}
			});
		}
		$("#uploadBtn").on("click", function(){ // 게시물 업로드
			let file = $("#fileInput")[0].files[0];
			let contents = $("#contentsTextarea").val();
			if(contents == ""){ // 내용이 없는 경우
				alert("내용을 입력해주세요.");
				return;
			}
			let formData = new FormData();
			formData.append("contents", contents);
			formData.append("imageFile", file);
			$.ajax({
				type:"post"
				, url:"/timeline/upload"
				, data:formData
				, enctype:"multipart/form-data"
				, processData:false
				, contentType:false
				, success:function(data){
					if(data.result == "success"){
						$("#contentsDiv").html("");
						lastLoadedPostId = 2100000000;
						loadPost();
						$("#contentsDiv").scrollTop(0);
						$("#fileInput").val("");
						$("#contentsTextarea").val("");
					}else{
						alert("업로드에 실패했습니다.");
					}
				}
				, error:function(){
					alert("에러 발생");
				}
			});
		});
		loadPost(2100000000);
		
	});
</script>
</body>
</html>