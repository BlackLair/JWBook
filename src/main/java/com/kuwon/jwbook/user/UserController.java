package com.kuwon.jwbook.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;

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
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.removeAttribute("loginId");
		request.removeAttribute("userId");
		return "redirect:/user/signIn-view";
	}
}
