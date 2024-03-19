package com.kuwon.jwbook.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {
	@GetMapping("/user/signUp-view")
	public String signUp() {
		return "user/signUp";
	}
}
