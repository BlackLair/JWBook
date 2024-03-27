package com.kuwon.jwbook.like.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kuwon.jwbook.like.repository.LikeRepository;
import com.kuwon.jwbook.timeline.repository.TimelineRepository;

@Service
public class LikeService {
	@Autowired
	LikeRepository likeRepository;
	@Autowired
	TimelineRepository timelineRepository;
	
	// 게시물에 좋아요 남기기
	public Map<String, Object> addLike(int userId, int postId) {
		Map<String, Object> resultMap = new HashMap<>();
		if(timelineRepository.selectPost(postId) == null) { // 없는 게시글에 좋아요 누른 경우
			resultMap.put("result", "not exist");
		}else {
			resultMap.put("result", "success");
			if(likeRepository.selectLike(userId, postId) == 0) // 좋아요하지 않은 경우에만 좋아요 추가
				likeRepository.insertLike(userId, postId);
			resultMap.put("likeCount", likeRepository.selectPostLikeCount(postId));
		}
		return resultMap;
	}
	
	// 게시물 좋아요 취소
	public Map<String, Object> removeLike(int userId, int postId){
		Map <String, Object> resultMap = new HashMap<>();
		likeRepository.deleteLike(userId, postId);
		resultMap.put("result", "success");
		resultMap.put("likeCount", likeRepository.selectPostLikeCount(postId));
		return resultMap;
	}
}
