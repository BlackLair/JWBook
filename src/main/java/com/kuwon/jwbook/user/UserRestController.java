package com.kuwon.jwbook.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kuwon.jwbook.user.service.UserService;

@RestController
public class UserRestController {
	@Autowired
	UserService userService;
	
	@GetMapping("/user/check-duplicated-id")
	public Map<String, Boolean> checkDuplicatedId(@RequestParam("loginId") String loginId){
		Map<String, Boolean> resultMap = new HashMap<>();
		resultMap.put("isDuplicated", userService.isDuplicatedId(loginId));
		return resultMap;
	}
}
