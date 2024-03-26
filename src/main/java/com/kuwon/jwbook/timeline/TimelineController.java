package com.kuwon.jwbook.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kuwon.jwbook.timeline.domain.ReplyDTO;
import com.kuwon.jwbook.timeline.dto.PostDetail;
import com.kuwon.jwbook.timeline.service.TimelineService;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
	@Autowired
	TimelineService timelineService;
	
	// 타임라인 페이지
	@GetMapping("/view")
	public String timelineView() {
		return "timeline/timeline";
	}
	
	// 타임라인 페이지 내 게시글 불러오기
	@GetMapping("/post")
	public String postView(Model model, HttpSession session) {
		List<PostDetail> postList = timelineService.getPostList((Integer)session.getAttribute("userId"));
		model.addAttribute("postList", postList);
		return "timeline/post";
	}
	
	// 단일 게시글에 대한 댓글 불러오기
	@GetMapping("/reply-view")
	public String replyView(@RequestParam("postId") int postId, Model model, HttpSession session) {
		List<ReplyDTO> replyDTOList = timelineService.getReplyList(postId);
		model.addAttribute("replyDTOList", replyDTOList);
		return "timeline/reply";
	}
}
