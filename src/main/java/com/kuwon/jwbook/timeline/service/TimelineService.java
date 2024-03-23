package com.kuwon.jwbook.timeline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kuwon.jwbook.timeline.domain.Post;
import com.kuwon.jwbook.timeline.repository.TimelineRepository;

@Service
public class TimelineService {
	@Autowired
	TimelineRepository timelineRepository;
	
	// 타임라인 게시글 불러오기
	public List<Post> getPostList(){
		List<Post> postList = timelineRepository.selectPostList();
		for(Post post : postList) {
			post.setLikeCount(timelineRepository.selectPostLikeCount(post.getId()));
		}
		return postList;
	}
	
	// 게시글 삭제
	public String removePost(int userId, int postId) {
		Post post = timelineRepository.selectPost(postId);
		if(post == null) {
			return "not exist";
		}
		if(post.getUserId() != userId) {
			return "permission denied";
		}
		if(timelineRepository.deletePost(post.getId()) == 1) {
			return "success";
		}
		return "not exist";
	}
}
