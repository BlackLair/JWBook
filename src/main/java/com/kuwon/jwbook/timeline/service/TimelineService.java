package com.kuwon.jwbook.timeline.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kuwon.jwbook.common.FileManager;
import com.kuwon.jwbook.timeline.domain.Post;
import com.kuwon.jwbook.timeline.repository.TimelineRepository;

@Service
public class TimelineService {
	@Autowired
	TimelineRepository timelineRepository;
	
	// 타임라인 게시글 불러오기
	public List<Post> getPostList(int userId){
		List<Post> postList = timelineRepository.selectPostList();
		for(Post post : postList) {
			post.setLikeCount(timelineRepository.selectPostLikeCount(post.getId()));
			post.setIsLiked(timelineRepository.selectLike(userId, post.getId()) == 1 );
		}
		return postList;
	}
	
	// 게시글 삭제
	public String removePost(int userId, int postId) {
		Post post = timelineRepository.selectPost(postId);
		if(post == null) { // 이미 존재하지 않는 게시글인 경우
			return "not exist";
		}
		if(post.getUserId() != userId) { // 게시글 작성자와 삭제 요청자가 다른 경우
			return "permission denied";
		}
		if(timelineRepository.deletePost(postId) == 1) {
			timelineRepository.deleteLikeAll(postId); // 삭제된 게시글의 모든 좋아요 삭제
			return "success";
		}
		return "not exist";
	}
	
	// 게시글 업로드
	public int addPost(int userId, String contents, MultipartFile file) {
		String imagePath = FileManager.saveFile(userId, file);
		return timelineRepository.insertPost(userId, contents, imagePath);
	}
	
	
	// 게시물에 좋아요 남기기
	public Map<String, Object> addLike(int userId, int postId) {
		Map<String, Object> resultMap = new HashMap<>();
		if(timelineRepository.selectPost(postId) == null) { // 없는 게시글에 좋아요 누른 경우
			resultMap.put("result", "not exist");
		}else {
			resultMap.put("result", "success");
			if(timelineRepository.selectLike(userId, postId) == 0) // 좋아요하지 않은 경우에만 좋아요 추가
				timelineRepository.insertLike(userId, postId);
			resultMap.put("likeCount", timelineRepository.selectPostLikeCount(postId));
		}
		return resultMap;
	}
	
	// 게시물 좋아요 취소
	public Map<String, Object> removeLike(int userId, int postId){
		Map <String, Object> resultMap = new HashMap<>();
		timelineRepository.deleteLike(userId, postId);
		resultMap.put("result", "success");
		resultMap.put("likeCount", timelineRepository.selectPostLikeCount(postId));
		return resultMap;
	}
}
