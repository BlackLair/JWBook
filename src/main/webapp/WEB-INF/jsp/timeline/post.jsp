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
						<div value="${post.id }" class="div-reply mt-2 w-100">
							<%-- 댓글 내용 동적으로 추가 --%>
						</div>
					</div>
				</div>
				</c:forEach>