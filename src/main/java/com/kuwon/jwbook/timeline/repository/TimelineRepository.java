package com.kuwon.jwbook.timeline.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kuwon.jwbook.timeline.domain.Post;

@Mapper
public interface TimelineRepository {
	public List<Post> selectPostList(@Param("postId") int postId);
	public Post selectPost(@Param("id") int id);
	public int insertPost(@Param("userId") int userId, @Param("contents") String contents, @Param("imagePath") String imagePath);
	public int deletePost(@Param("id") int id);


}