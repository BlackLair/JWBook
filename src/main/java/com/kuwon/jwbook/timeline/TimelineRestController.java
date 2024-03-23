package com.kuwon.jwbook.timeline;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kuwon.jwbook.timeline.service.TimelineService;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/timeline")
@RestController
public class TimelineRestController {
	@Autowired
	TimelineService timelineService;
	
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
