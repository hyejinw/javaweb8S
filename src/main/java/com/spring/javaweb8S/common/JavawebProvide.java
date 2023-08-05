package com.spring.javaweb8S.common;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

public class JavawebProvide {
	
	// 중복 방지(아직 미사용)
	public String fileUpload(MultipartFile fName, String urlPath) {
		
		SimpleDateFormat format = new SimpleDateFormat("yyMMdd");
		Date today = new Date();
		String str = format.format(today);
		UUID uid = UUID.randomUUID();
		
		String oFileName = fName.getOriginalFilename();
		String saveFileName = str + uid.toString().substring(0,5) + "_" + oFileName;
		try {
			writeFile(fName, saveFileName, urlPath);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return saveFileName;
	}
	
  // 파일 업로드
  public void writeFile(MultipartFile fName, String saveFileName, String path) throws IOException {
  	byte[] data = fName.getBytes();
	  
	  HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest(); 
	  String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+path+"/");
	  
	  FileOutputStream fos = new FileOutputStream(realPath + saveFileName);
	  fos.write(data); 
	  fos.close(); 
	}

}
