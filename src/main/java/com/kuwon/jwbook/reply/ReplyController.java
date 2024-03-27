package com.kuwon.jwbook.reply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kuwon.jwbook.reply.dto.ReplyDetail;
import com.kuwon.jwbook.reply.service.ReplyService;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/reply")
@Controller
public class ReplyController {
	@Autowired
	ReplyService replyService;
	
	// 단일 게시글에 대한 댓글 불러오기
	@GetMapping("/view")
	public String replyView(@RequestParam("postId") int postId, Model model, HttpSession session) {
		List<ReplyDetail> replyDetailList = replyService.getReplyList(postId);
		model.addAttribute("replyDetailList", replyDetailList);
		model.addAttribute("postId", postId);
		return "timeline/reply";
	}
}
