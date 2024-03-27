/*

package com.kuwon.jwbook.like.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;

import com.kuwon.jwbook.like.domain.Like;

@Mapper
public interface LikeRepository {
	public int deleteLikeAll(@Param("postId") int postId);
	public int selectLike(@Param("userId") int userId, @Param("postId") int postId);
	public int insertLike(@Param("userId") int userId, @Param("postId") int postId);
	public int deleteLike(@Param("userId") int userId, @Param("postId") int postId);
	public int selectPostLikeCount(@Param("postId") int postId);
}

*/