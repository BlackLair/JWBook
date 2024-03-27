package com.kuwon.jwbook.timeline.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.HtmlUtils;

import com.kuwon.jwbook.common.FileManager;
import com.kuwon.jwbook.like.repository.LikeJpaRepository;
import com.kuwon.jwbook.reply.repository.ReplyJpaRepository;
import com.kuwon.jwbook.timeline.domain.Post;
import com.kuwon.jwbook.timeline.dto.PostDetail;
import com.kuwon.jwbook.timeline.repository.TimelineRepository;
import com.kuwon.jwbook.user.repository.UserRepository;

@Service
public class TimelineService {
	@Autowired
	TimelineRepository timelineRepository;
	@Autowired
	UserRepository userRepository;
	@Autowired
	ReplyJpaRepository replyJpaRepository;
	@Autowired
	LikeJpaRepository likeJpaRepository;
	
	// 타임라인 게시글 불러오기
	public List<PostDetail> getPostList(int userId, int postId){
		List<Post> postList = timelineRepository.selectPostList(postId);
		List<PostDetail> postDetailList = new ArrayList<>();
		for(Post post : postList) { // Entity 클래스의 정보들 중 필요한 정보를 DTO 클래스에 담기
			
			PostDetail postDetail = new PostDetail();
			postDetail.setId(post.getId());
			String htmlContents = HtmlUtils.htmlEscape(post.getContents()); // html injection 방지
			postDetail.setContents(htmlContents);
			postDetail.setImagePath(post.getImagePath());
			postDetail.setUserId(post.getUserId());
			postDetail.setCreatedAt(post.getCreatedAt());
			postDetail.setLikeCount(likeJpaRepository.countByPostId(post.getId()));
			postDetail.setIsLiked(likeJpaRepository.countByUserIdAndPostId(userId, post.getId()) == 1);
			postDetail.setUserIdStr(userRepository.selectLoginIdById(post.getUserId()));
			postDetailList.add(postDetail);
		}
		return postDetailList;
	}
	
	// 게시글 삭제
	@Transactional
	public String removePost(int userId, int postId) {
		Post post = timelineRepository.selectPost(postId);
		if(post == null) { // 이미 존재하지 않는 게시글인 경우
			return "not exist";
		}
		if(post.getUserId() != userId) { // 게시글 작성자와 삭제 요청자가 다른 경우
			return "permission denied";
		}
		if(timelineRepository.deletePost(postId) == 1) {
			likeJpaRepository.deleteByPostId(postId); // 삭제된 게시글의 모든 좋아요 삭제
			replyJpaRepository.deleteByPostId(postId);
			return "success";
		}
		return "not exist";
	}
	
	// 게시글 업로드
	public int addPost(int userId, String contents, MultipartFile file) {
		String imagePath = FileManager.saveFile(userId, file);
		return timelineRepository.insertPost(userId, contents, imagePath);
	}
}
