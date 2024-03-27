<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
							<div class="w-100 bg-secondary text-white p-2">
								<div>댓글 ${replyDetailList.size() }</div>
								<hr class="m-1">
								<c:forEach var="replyDetail" items="${replyDetailList }">
								<div style="min-height:30px;" class="singleReply-div w-100 d-flex justify-content-between">
									<div style="font-size:13px"><span class="text-dark fw-bold">@${replyDetail.userIdStr }</span> : ${replyDetail.contents }</div>
									<div style="height:30px; width:30px;">
										<c:if test="${userId eq replyDetail.userId }">
										<button type="button" id="${replyDetail.id }" value="${replyDetail.postId }" class="btn btn-deleteReply btn-sm btn-danger" style="height:30px; width:30px;" >
											<i class="bi bi-trash-fill text-white"></i>
										</button>
										</c:if>
									</div>
								</div>
								<hr class="m-1">
								</c:forEach>
								<div class="w-100">
									<form value="${postId }" class="form-addReply d-flex w-100">
										<input type="text" name="${postId }" class="input-reply form-control border-info bg-dark text-white" >
										<button type="submit" class="btn btn-addReply btn-info col-1">
											<i class="bi bi-reply-fill"></i>
										</button>
									</form>
								</div>
							</div>