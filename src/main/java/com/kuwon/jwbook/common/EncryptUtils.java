package com.kuwon.jwbook.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EncryptUtils {
	public static String sha256(String message) {
		MessageDigest sha;
		String result = "";
		try {
			sha = MessageDigest.getInstance("SHA-256");
			sha.update(message.getBytes());
			for(byte b : sha.digest()) {
				result += Integer.toHexString(b & 0xff);
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
		return result;
	}
}
