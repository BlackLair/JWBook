package com.kuwon.jwbook.timeline.dto;

import java.util.Date;

// 화면 상 게시글 구성을 위한 DTO
public class PostDetail {
	private int id;
	private String contents;
	private String imagePath;
	private Date createdAt;
	
	private int likeCount;
	
	private int userId;
	private String userIdStr;
	private boolean isLiked;
	
	public int getId() {
		return id;
	}
	public void setId(int postId) {
		this.id = postId;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserIdStr() {
		return userIdStr;
	}
	public void setUserIdStr(String userIdStr) {
		this.userIdStr = userIdStr;
	}
	public boolean getIsLiked() {
		return isLiked;
	}
	public void setIsLiked(boolean isLiked) {
		this.isLiked = isLiked;
	}
	
	
	
}
