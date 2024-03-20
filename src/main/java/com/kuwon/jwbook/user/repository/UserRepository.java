package com.kuwon.jwbook.user.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserRepository {
	public int selectUser(@Param("loginId") String loginId);
}
