package com.kuwon.jwbook.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.web.multipart.MultipartFile;

public class FileManager {
	public final static String FILE_UPLOAD_PATH = "C:\\Users\\JW K\\Desktop\\megaIT\\springProject\\upload\\jwbook";
	
	// 파일을 지정 위치에 저장 후 클라이언트가 접근할 수 있는 url 문자열 리턴
	public static String saveFile(int userId, MultipartFile file) {
		if(file == null) {
			return null;
		}
		
		// 파일을 저장할 디렉토리 생성
		String directoryName = "/" + userId + "_" + System.currentTimeMillis(); // 생성할 디렉토리명
		String directoryPath = FILE_UPLOAD_PATH + directoryName; // 생성할 디렉토리명 포함 전체 경로
		File directory = new File(directoryPath);
		if(!directory.mkdir()) {
			// 디렉토리 생성 실패
			return null;
		}
		
		// 파일 저장
		String filePath = directoryPath + "/" + file.getOriginalFilename(); // 파일명 포함 전체 경로
		try {
			byte[] bytes = file.getBytes(); // 파일을 바이트 단위로 객체에 저장
			Path path = Paths.get(filePath); // 파일명 포함 경로 가져오기
			Files.write(path, bytes);        // 해당 경로로 파일 저장
		}catch (IOException e) {
			// 파일 저장 실패 시
			e.printStackTrace();
			directory.delete(); // 생성했던 디렉토리 삭제
			return null;
		}
		
		return "/images" + directoryName + "/" + file.getOriginalFilename();
	}
}
