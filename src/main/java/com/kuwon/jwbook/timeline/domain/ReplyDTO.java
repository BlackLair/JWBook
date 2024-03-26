package com.kuwon.jwbook.timeline.domain;

public class ReplyDTO {
	private Reply reply;
	private String userIdStr;
	public Reply getReply() {
		return reply;
	}
	public void setReply(Reply reply) {
		this.reply = reply;
	}
	public String getUserIdStr() {
		return userIdStr;
	}
	public void setUserIdStr(String userIdStr) {
		this.userIdStr = userIdStr;
	}
	
	public ReplyDTO(Reply reply, String userIdStr) {
		this.reply = reply;
		this.userIdStr = userIdStr;
	}
}
