package com.kuwon.jwbook.reply.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.HtmlUtils;

import com.kuwon.jwbook.reply.domain.Reply;
import com.kuwon.jwbook.reply.dto.ReplyDetail;
import com.kuwon.jwbook.reply.repository.ReplyRepository;
import com.kuwon.jwbook.timeline.repository.TimelineRepository;
import com.kuwon.jwbook.user.repository.UserRepository;

@Service
public class ReplyService {
	@Autowired
	TimelineRepository timelineRepository;
	
	@Autowired
	ReplyRepository replyRepository;
	
	@Autowired
	UserRepository userRepository;
	
	// 게시글의 댓글 목록 가져오기
	public List<ReplyDetail> getReplyList(int postId){
		List<Reply> replyList = replyRepository.selectReplyList(postId);
		List<ReplyDetail> replyDetailList = new ArrayList<ReplyDetail>();
		for(Reply reply : replyList) {
			ReplyDetail replyDetail = new ReplyDetail();
			replyDetail.setUserId(reply.getUserId());
			replyDetail.setUserIdStr(userRepository.selectLoginIdById(reply.getUserId()));
			String htmlContents = HtmlUtils.htmlEscape(reply.getContents()); // html injection 방지
			replyDetail.setContents(htmlContents);
			replyDetail.setPostId(postId);
			replyDetail.setId(reply.getId());
			replyDetailList.add(replyDetail);
		}
		return replyDetailList;
	}
	
	// 댓글 업로드하기
	public int addReply(int userId, int postId, String contents) {
		if(timelineRepository.selectPost(postId) != null) {
			return replyRepository.insertReply(userId, postId, contents);
		}
		return 0;
	}
	// 댓글 삭제하기
	public String removeReply(int id, int userId) {
		Reply reply = replyRepository.selectReplyById(id);
		if(reply == null) {
			return "not exist";
		}
		if(reply.getUserId() != userId) {
			return "permission denied";
		}
		if(replyRepository.deleteReplyById(id) == 1) {
			return "success";
		}
		return "failure";
	}
}
