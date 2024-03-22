package com.kuwon.jwbook.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kuwon.jwbook.user.domain.User;
import com.kuwon.jwbook.user.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RequestMapping("/user")
@RestController
public class UserRestController {
	@Autowired
	UserService userService;
	
	// 아이디 중복 확인
	@GetMapping("/check-duplicated-id")
	public Map<String, Boolean> checkDuplicatedId(@RequestParam("loginId") String loginId){
		Map<String, Boolean> resultMap = new HashMap<>();
		resultMap.put("isDuplicated", userService.isDuplicatedId(loginId));
		return resultMap;
	}
	
	// 회원 가입 요청 처리
	@PostMapping("/sign-up")
	public Map<String, String> createUser(@RequestParam("loginId") String loginId
										, @RequestParam("password") String password
										, @RequestParam("email") String email){
		Map<String, String> resultMap = new HashMap<>();
		resultMap.put("result",  userService.createUser(loginId, password, email));
		return resultMap;
	}
	
	// 로그인 요청
	@PostMapping("/login")
	public Map<String, String> login(@RequestParam("loginId") String loginId
									, @RequestParam("password") String password
									, HttpServletRequest request){
		User user = userService.getUserByLoginIdAndPassword(loginId, password);
		Map<String, String> resultMap = new HashMap<>();
		if(user != null) {
			resultMap.put("result", "success");
			HttpSession session = request.getSession();
			session.setAttribute("userId", user.getId());
		}else {
			resultMap.put("result", "failure");
		}
		
		return resultMap;
	}
}
