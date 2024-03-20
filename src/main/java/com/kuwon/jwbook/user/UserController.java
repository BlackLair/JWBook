package com.kuwon.jwbook.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {
	@GetMapping("/signUp-view")
	public String signUp() {
		return "user/signUp";
	}
	
	@GetMapping("/signIn-view")
	public String signIn() {
		return "user/signIn";
	}
}
