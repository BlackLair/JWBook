package com.kuwon.jwbook.timeline;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kuwon.jwbook.timeline.service.TimelineService;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/timeline")
@RestController
public class TimelineRestController {
	@Autowired
	TimelineService timelineService;
	
	// 게시물 등록
	@PostMapping("/upload")
	public Map<String, String> uploadPost(@RequestParam(value="imageFile", required=false) MultipartFile file
										, @RequestParam("contents") String contents
										, HttpSession session){
		int userId = (Integer)session.getAttribute("userId");
		int count = timelineService.addPost(userId, contents, file);
		Map<String, String> resultMap = new HashMap<>();
		if(count == 1) {
			resultMap.put("result", "success");
		}else {
			resultMap.put("result", "failure");
		}
		return resultMap;
	}
	
	
	// 게시글 삭제
	@DeleteMapping("/delete")
	public Map<String, String> deletePost(@RequestParam("postId") int postId, HttpSession session){
		Integer userId = (Integer) session.getAttribute("userId");
		Map<String, String> resultMap = new HashMap<String, String>();
		if(userId != null) {
			resultMap.put("result", timelineService.removePost((Integer)session.getAttribute("userId"), postId));
		}else {
			resultMap.put("result", "permission denied");
		}
		return resultMap;
	}
}
