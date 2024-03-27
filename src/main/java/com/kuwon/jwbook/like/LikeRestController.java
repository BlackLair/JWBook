package com.kuwon.jwbook.like;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kuwon.jwbook.like.service.LikeService;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/like")
@RestController
public class LikeRestController {
	@Autowired
	LikeService likeService;
	
	// 게시글 좋아요
	@GetMapping("/add")
	public Map<String, Object> addLike(@RequestParam("postId") int postId, HttpSession session){
		int userId = (Integer)session.getAttribute("userId");
		return likeService.addLike(userId, postId);
	}
	
	// 게시글 좋아요 취소
	@DeleteMapping("/remove")
	public Map<String, Object> removeLike(@RequestParam("postId") int postId, HttpSession session){
		int userId = (Integer)session.getAttribute("userId");
		return likeService.removeLike(userId, postId);
	}

}
