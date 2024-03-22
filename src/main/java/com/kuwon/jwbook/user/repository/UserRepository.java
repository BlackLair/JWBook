package com.kuwon.jwbook.user.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kuwon.jwbook.user.domain.User;

@Mapper
public interface UserRepository {
	// 사용자 아이디 존재 여부 확인
	public int selectUser(@Param("loginId") String loginId);
	// 신규 사용자 생성
	public int insertUser(@Param("loginId") String loginId
						, @Param("password") String password
						, @Param("email") String email);
	// 일치하는 아이디/패스워드 존재 확인
	public User selectUserByLoginIdAndPassword(@Param("loginId") String loginId
											, @Param("password") String password);
}
