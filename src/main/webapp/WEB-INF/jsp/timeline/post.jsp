<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
				<c:forEach var="post" items="${postList }" varStatus="status">
				<div name="${post.id }" class="post p-1">
					<div class="d-flex bg-white flex-column align-items-center w-100 p-2">
						<div class="post-head w-100 d-flex justify-content-between">
							<div class="w-75 post-article">
								<b>@${post.userIdStr }</b><br>
								${post.contents }
							</div>
							<div class="w-25 d-flex align-items-center justify-content-center">
								<c:if test="${post.userId eq userId }">
								<button type="button" value="${post.id }" class="btn btn-delete btn-danger">Delete</button>
								</c:if>
							</div>
						</div>
						<div class="post-timestamp w-100 text-start text-small text-secondary mt-2">
							<fmt:formatDate value="${post.createdAt }" pattern="yyyy년 M월 d일 HH:mm:ss" />
						</div>
						<img class="mt-2" width="100%" src="${post.imagePath }">
						<div class="w-100 d-flex align-items-center mt-2">
							<c:choose>
								<c:when test="${post.isLiked }">
								<i value="${post.id }" class="btn-like bi bi-hand-thumbs-up-fill" ></i>
								</c:when>
								<c:otherwise>
								<i value="${post.id }" class="btn-like bi bi-hand-thumbs-up"></i>
								</c:otherwise>
							</c:choose>
							<div value="${post.id }" class="div-likeCount ml-4">${post.likeCount }</div>
						</div>
						<div class="div-reply mt-2 w-100">
							<div class="w-100 bg-secondary text-white p-2">
								<div>댓글 1</div>
								<hr class="m-1">
								<div class="singleReply-div w-100 d-flex justify-content-between">
									<div style="font-size:13px"><span class="text-dark fw-bold">@mytestaccount</span> : 이 댓글은 2001년 영국에서 시작되어 세계 곳곳으로 퍼져나간 어쩌구저쩌구로 복붙하여 3곳 이상에 입력하지 않으면 맨발로 레고를 밟을 것이다.</div>
									<button type="button" class="btn btn-sm btn-danger" style="height:30px;" >
										<i class="bi bi-trash-fill text-white"></i>
									</button>
								</div>
								<hr class="m-1">
								<div class="singleReply-div w-100 d-flex justify-content-between align-items-center">
									<div style="font-size:13px"><span class="text-dark fw-bold">@mytestaccount</span> : 이 댓글은 2001년 영.</div>
									<button type="button" class="btn btn-sm btn-danger" style="height:30px;" >
										<i class="bi bi-trash-fill text-white"></i>
									</button>
								</div>
								<hr class="m-1">
								<div class="w-100">
									<form class="d-flex w-100">
										<input type="text" class="form-control border-info bg-dark text-white">
										<button type="button" class="btn btn-info col-1">
											<i class="bi bi-reply-fill"></i>
										</button>
									</form>
								</div>
								
							</div>
							
						</div>
					</div>
				</div>
				</c:forEach>