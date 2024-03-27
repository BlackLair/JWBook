package com.kuwon.jwbook.reply.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kuwon.jwbook.reply.domain.Reply;

@Mapper
public interface ReplyRepository {
	public List<Reply> selectReplyList(@Param("postId") int postId);
	public int insertReply(@Param("userId") int userId, @Param("postId") int postId, @Param("contents") String contents);
	public Reply selectReplyById(@Param("id") int id);
	public int deleteReplyById(@Param("id") int id);
	public int deleteReplyAll(@Param("postId") int postId);
}
