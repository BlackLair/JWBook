package com.kuwon.jwbook.common;

import java.util.regex.Pattern;

public class RegExpUtils {
	public static final String REGEXP_idFormat = "^[a-z0-9]{8,16}$";
	public static final String REGEXP_passwordFormat = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,16}$";
	public static final String REGEXP_emailFormat = "^[a-z0-9]+@[a-z]+\\.[a-z]{2,3}$";
	
	// input : 검사할 문자열   format : 정규식
	public static boolean isValid(String input, String regExp) {
		return Pattern.matches(regExp, input);
	}
}
