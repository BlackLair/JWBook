package com.kuwon.jwbook.like.repository;



import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.kuwon.jwbook.like.domain.Like;

public interface LikeJpaRepository extends JpaRepository<Like, Integer> {
	public int countByUserIdAndPostId(@Param("userId") int userId, @Param("postId") int postId);
	public int countByPostId(@Param("postId") int postId);
	public void deleteByUserIdAndPostId(@Param("userId") int userId, @Param("postId") int postId);
	public void deleteByPostId(@Param("postId")int postId);
}
