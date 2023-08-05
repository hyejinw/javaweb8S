package com.spring.javaweb8S.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Service
public class ImageManager {
	
	// 기록 등록 창에서 사진 업로드(CKEditor -> 저장)
	public void imgCheck(String content, String flag) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javawebS/data/ckeditor/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		// <img alt="" src="/javawebS/data/community/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/ask/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 29;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + flag+"/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 설정 폴더 위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	// 파일 복사
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream  fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] bytes = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(bytes)) != -1) {
				fos.write(bytes, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();		
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
	  }
	}


	// 수정창으로 이동시에는 먼저 원본파일에 그림파일이 있다면, 현재폴더(community)의 그림파일들을 ckeditor폴더로 복사시켜둔다.
	public void imgCheckUpdate(String content, String flag, int position) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javawebS/data/notice/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		// <img alt="" src="/javawebS/data/community/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		// <img alt="" src="/javawebS/data/ask/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		// <img alt="" src="/javawebS/data/ckeditor/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/board/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		//int position = 30;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + flag +"/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 board폴더위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
				}
			else {
					nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	
	//실제로 수정하기 버튼을 클릭하게되면, 기존의 community폴더에 저장된, 현재 content의 그림파일 모두를 삭제 시킨다.
	public void imgDelete(String content, String flag, int position) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javawebS/data/community/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/community/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		//int position = 30;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));	// 그림파일명만 꺼내오기
			
			String origFilePath = realPath + flag+"/" + imgFile;
			
			fileDelete(origFilePath);	// 해당 폴더의 그림을 삭제처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	// 실제로 서버의 파일을 삭제처리한다.
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}
	
}
