package com.kuwon.jwbook.timeline.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kuwon.jwbook.timeline.domain.Post;
import com.kuwon.jwbook.timeline.domain.Reply;

@Mapper
public interface TimelineRepository {
	public List<Post> selectPostList();
	public int selectPostLikeCount(@Param("postId") int postId);
	public Post selectPost(@Param("id") int id);
	public int insertPost(@Param("userId") int userId, @Param("contents") String contents, @Param("imagePath") String imagePath);
	public int deletePost(@Param("id") int id);
	
	public int deleteLikeAll(@Param("postId") int postId);
	public int selectLike(@Param("userId") int userId, @Param("postId") int postId);
	public int insertLike(@Param("userId") int userId, @Param("postId") int postId);
	public int deleteLike(@Param("userId") int userId, @Param("postId") int postId);
	
	public List<Reply> selectReplyList(@Param("postId") int postId);
	public int insertReply(@Param("userId") int userId, @Param("postId") int postId, @Param("contents") String contents);
	public Reply selectReplyById(@Param("id") int id);
	public int deleteReplyById(@Param("id") int id);
	public int deleteReplyAll(@Param("postId") int postId);
}