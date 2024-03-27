package com.kuwon.jwbook.reply.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;

import com.kuwon.jwbook.reply.domain.Reply;

public interface ReplyJpaRepository extends JpaRepository<Reply, Integer> {
	public List<Reply> findByPostId(@Param("postId") int postId);
	public void deleteByPostId(@Param("postId") int postId);
}
