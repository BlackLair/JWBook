<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
							
							<div class="w-100 bg-secondary text-white p-2">
								<div>댓글 ${replyDTOList.size() }</div>
								<hr class="m-1">
								<c:forEach var="replyDTO" items="${replyDTOList }">
								<div style="min-height:30px;" class="singleReply-div w-100 d-flex justify-content-between">
									<div style="font-size:13px"><span class="text-dark fw-bold">@${replyDTO.userIdStr }</span> : ${replyDTO.reply.contents }</div>
									<c:if test="${userId eq replyDTO.reply.userId }">
									<button type="button" class="btn btn-sm btn-danger" style="height:30px;" >
										<i class="bi bi-trash-fill text-white"></i>
									</button>
									</c:if>
								</div>
								<hr class="m-1">
								</c:forEach>
								<div class="w-100">
									<form class="d-flex w-100">
										<input type="text" class="form-control border-info bg-dark text-white">
										<button type="button" class="btn btn-info col-1">
											<i class="bi bi-reply-fill"></i>
										</button>
									</form>
								</div>
							</div>
							