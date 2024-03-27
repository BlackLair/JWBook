package com.kuwon.jwbook.reply;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kuwon.jwbook.reply.service.ReplyService;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/reply")
@RestController
public class ReplyRestController {
	@Autowired
	ReplyService replyService;
	
	// 댓글 업로드
	@PostMapping("/upload")
	public Map<String, String> addReply(@RequestParam("postId") int postId
									, @RequestParam("contents") String contents
									, HttpSession session){
		int userId = (Integer)session.getAttribute("userId");
		Map<String, String> resultMap = new HashMap<>();
		if(replyService.addReply(userId, postId, contents) != null) {
			resultMap.put("result", "success");
		}else {
			resultMap.put("result", "failure");
		}
		return resultMap;
	}
	
	// 댓글 삭제
	@DeleteMapping("/remove")
	public Map<String, String> removeReply(@RequestParam("id") int id
										, HttpSession session){
		int userId = (Integer)session.getAttribute("userId");
		String result = replyService.removeReply(id, userId);
		Map<String, String> resultMap = new HashMap<>();
		resultMap.put("result", result);
		return resultMap;
	}
}
