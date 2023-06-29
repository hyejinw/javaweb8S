package com.spring.javaweb8S.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.dao.AdminDAO;
import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.DefaultPhotoVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.ProverbVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	// 프로필 기본 사진 가져오기
	@Override
	public ArrayList<DefaultPhotoVO> getDefaultPhoto() {
		return adminDAO.getDefaultPhoto();
	}
	
	// 프로필 기본 사진 추가
  @Override 
  public int memberDefaultPhotoInsert(MultipartFile file, DefaultPhotoVO vo) {
  
  	try { 
  		String saveFileName = file.getOriginalFilename(); 
  		writeFile(file,saveFileName);
  		vo.setPhotoName(saveFileName);
  
  	} catch (IOException e) { 
  		e.printStackTrace(); } 
  	return adminDAO.memberDefaultPhotoInsert(vo); 
  }
 
	
  // 파일 업로드 private void writeFile(MultipartFile fName, String saveFileName)
  private void writeFile(MultipartFile fName, String saveFileName) throws IOException {
  	byte[] data = fName.getBytes();
	  
	  HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest(); 
	  String realPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/member/");
	  
	  FileOutputStream fos = new FileOutputStream(realPath + saveFileName);
	  fos.write(data); fos.close(); 
	}

  // 책 명언 리스트
	@Override
	public ArrayList<ProverbVO> getProverb(int startIndexNo, int pageSize) {
		return adminDAO.getProverb(startIndexNo, pageSize);
	}

	// 책 명언 추가
	@Override
	public void setProverb(ProverbVO vo) {
		adminDAO.setProverb(vo);
		
	}

	// 기본 이미지 삭제
	@Override
	public int memberDefaultPhotoDelete(List<String> defaultPhotoList) {
		return adminDAO.memberDefaultPhotoDelete(defaultPhotoList);
	}

  // 삭제된 기본 이미지 사용 회원, 프로필 'defaultImage.png'로 변경
	@Override
	public void setChangeMemberPhotos(List<String> defaultPhotoList) {
		adminDAO.setChangeMemberPhotos(defaultPhotoList);
	}

	// 책 명언 삭제
	@Override
	public void setProverbDelete(List<String> proverbList) {
		adminDAO.setProverbDelete(proverbList);
	}

	// 책 명언 수정
	@Override
	public void setUpdateProverb(ProverbVO vo) {
		adminDAO.setUpdateProverb(vo);
		
	}

	// DB 저장된 책 리스트 가져오기
	@Override
	public ArrayList<BookVO> getBooks(int startIndexNo, int pageSize) {
		return adminDAO.getBooks(startIndexNo, pageSize);
	}

	// DB 저장된 책에서 검색
	@Override
	public ArrayList<BookVO> getDBBooks(String searchString, String search, int startIndexNo, int pageSize) {
		return adminDAO.getDBBooks(searchString, search, startIndexNo, pageSize);
	}

	// DB 저장된 책 삭제
	@Override
	public void setBookDelete(List<String> bookList) {
		adminDAO.setBookDelete(bookList);
		
	}

	// 매거진 리스트 가져오기
	@Override
	public ArrayList<MagazineVO> getMagazineList(int startIndexNo, int pageSize) {
		return adminDAO.getMagazineList(startIndexNo, pageSize);
	}
			

	 
	
}
