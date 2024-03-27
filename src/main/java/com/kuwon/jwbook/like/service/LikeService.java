package com.kuwon.jwbook.like.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kuwon.jwbook.like.domain.Like;
import com.kuwon.jwbook.like.repository.LikeJpaRepository;
import com.kuwon.jwbook.timeline.repository.TimelineRepository;

@Service
public class LikeService {
	@Autowired
	TimelineRepository timelineRepository;
	@Autowired
	LikeJpaRepository likeJpaRepository;
	
	// 게시물에 좋아요 남기기
	public Map<String, Object> addLike(int userId, int postId) {
		Map<String, Object> resultMap = new HashMap<>();
		if(timelineRepository.selectPost(postId) == null) { // 없는 게시글에 좋아요 누른 경우
			resultMap.put("result", "not exist");
		}else {
			if(likeJpaRepository.countByUserIdAndPostId(userId, postId) == 0) {// 좋아요하지 않은 경우에만 좋아요 추가
				Like like = Like.builder()
						.userId(userId)
						.postId(postId).build();
				likeJpaRepository.save(like);
				resultMap.put("result", "success");
			}
			resultMap.put("likeCount", likeJpaRepository.countByPostId(postId));
		}
		return resultMap;
	}
	
	// 게시물 좋아요 취소
	@Transactional
	public Map<String, Object> removeLike(int userId, int postId){
		Map <String, Object> resultMap = new HashMap<>();
		likeJpaRepository.deleteByUserIdAndPostId(userId, postId);
		resultMap.put("result", "success");
		resultMap.put("likeCount", likeJpaRepository.countByPostId(postId));
		return resultMap;
	}
}
