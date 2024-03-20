package com.kuwon.jwbook.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kuwon.jwbook.user.repository.UserRepository;

@Service
public class UserService {
	@Autowired
	UserRepository userRepository;
	
	public boolean isDuplicatedId(String loginId) {
		int count = userRepository.selectUser(loginId);
		if(count > 0) {
			return true;
		}
		return false;
	}
}
