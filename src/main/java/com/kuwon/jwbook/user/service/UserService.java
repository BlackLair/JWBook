package com.kuwon.jwbook.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kuwon.jwbook.common.EncryptUtils;
import com.kuwon.jwbook.common.RegExpUtils;
import com.kuwon.jwbook.user.repository.UserRepository;

@Service
public class UserService {
	@Autowired
	UserRepository userRepository;
	// 아이디 중복 검사
	public boolean isDuplicatedId(String loginId) {
		int count = userRepository.selectUser(loginId);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	// 회원가입
	public String createUser(String loginId, String password, String email) {
		
		// 파라미터 유효성 검사
		if(isDuplicatedId(loginId)
		|| !RegExpUtils.isValid(loginId, RegExpUtils.REGEXP_idFormat)
		|| !RegExpUtils.isValid(password, RegExpUtils.REGEXP_passwordFormat)
		|| !RegExpUtils.isValid(email, RegExpUtils.REGEXP_emailFormat)) {
			return "parameter error";
		}
		// 계정 생성
		String encryptPassword = EncryptUtils.sha256(password);
		if(userRepository.insertUser(loginId, encryptPassword, email) == 1) {
			return "success";
		}else {
			return "unknown error";
		}
	}
}
