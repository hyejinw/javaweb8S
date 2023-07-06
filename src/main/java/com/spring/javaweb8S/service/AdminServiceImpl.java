package com.spring.javaweb8S.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.common.JavawebProvide;
import com.spring.javaweb8S.dao.AdminDAO;
import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.CollectionVO;
import com.spring.javaweb8S.vo.DefaultPhotoVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.OptionVO;
import com.spring.javaweb8S.vo.ProductVO;
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
  		
  		JavawebProvide jp = new JavawebProvide();
  		jp.writeFile(file,saveFileName,"admin/member");
  		
  		vo.setPhotoName(saveFileName);
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
  	return adminDAO.memberDefaultPhotoInsert(vo); 
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

	// 매거진 공개/비공개 변경 
	@Override
	public void setMagazineOpenUpdate(int idx, String maOpen) {
		adminDAO.setMagazineOpenUpdate(idx, maOpen);
	}

	// 매거진 삭제
	@Override
	public void setMagazineDelete(List<String> magazineList) {
		adminDAO.setMagazineDelete(magazineList);
	}

	// 매거진 삭제 전, 서버 삭제용 매거진 이름 가져오기
	@Override
	public List<MagazineVO> getMagazinePhotoName(List<String> magazineList) {
		return adminDAO.getMagazinePhotoName(magazineList);
	}

	// 정기구독만 보기
	@Override
	public ArrayList<MagazineVO> getMagazineTypeList(int startIndexNo, int pageSize, String maType) {
		return adminDAO.getMagazineTypeList(startIndexNo, pageSize, maType);
	}

	// 매거진 등록
	@Override
	public int setMagazineInsert(MultipartFile thumbnailFile, MultipartFile detailFile, MagazineVO vo) {
		
  	try { 
  		String thumbnailFileName = thumbnailFile.getOriginalFilename(); 
  		String detailFileName = detailFile.getOriginalFilename(); 
  		
  		JavawebProvide jp = new JavawebProvide();
  		jp.writeFile(thumbnailFile,thumbnailFileName,"magazine");
  		jp.writeFile(detailFile,detailFileName,"magazine");
  		
  		vo.setMaThumbnail(thumbnailFileName);
  		vo.setMaDetail(detailFileName);
  		
  		// 상품 코드 제작
  		UUID uid = UUID.randomUUID();
  		String code = "BWM" + uid.toString().substring(0,5);
  		vo.setMaCode(code);
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
		return adminDAO.setMagazineInsert(vo);
	}

	// 매거진 정보 가져오기
	@Override
	public MagazineVO getMagazine(int idx) {
		return adminDAO.getMagazine(idx);
	}

	// 매거진 정보 수정
	@Override
	public int setMagazineUpdate(MultipartFile thumbnailFile, MultipartFile detailFile, MagazineVO vo,  MagazineVO originVO) {
		int res = 0;
		
		try { 
			String thumbnailFileName = thumbnailFile.getOriginalFilename(); 
			String detailFileName = detailFile.getOriginalFilename(); 
			
			// 공백이 아닐 경우 변경 처리
			if(!thumbnailFileName.equals("") && !detailFileName.equals("")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String realPath = request.getSession().getServletContext().getRealPath("/resources/data/magazine/");
				
				// 기존에 존재하는 파일은 삭제처리
				File thumbnailFileDelete = new File(realPath + originVO.getMaThumbnail());
				File detailFileDelete = new File(realPath + originVO.getMaDetail());
				thumbnailFileDelete.delete();
				detailFileDelete.delete();
				
				// 새로운 파일 업로드
				JavawebProvide jp = new JavawebProvide();
				jp.writeFile(thumbnailFile,thumbnailFileName,"magazine");
				jp.writeFile(detailFile,detailFileName,"magazine");

				// 새로운 파일명 set
				vo.setMaThumbnail(thumbnailFileName);
				vo.setMaDetail(detailFileName);
			}
			
  		adminDAO.setMagazineUpdate(vo);
			res = 1;
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
		return res;
	}

	// 매거진 검색
	@Override
	public ArrayList<MagazineVO> getMagazineSearchList(String searchString, String search, String startDate, String endDate, int startIndexNo, int pageSize) {
		return adminDAO.getMagazineSearchList(searchString, search, startDate, endDate, startIndexNo, pageSize);
	}

	// 컬렉션 카테고리 등록
	@Override
	public int setColCategoryInsert(MultipartFile thumbnailFile, CollectionVO vo) {

  	try { 
  		String thumbnailFileName = thumbnailFile.getOriginalFilename(); 
  		
  		JavawebProvide jp = new JavawebProvide();
  		jp.writeFile(thumbnailFile,thumbnailFileName,"collection");
  		
  		vo.setColThumbnail(thumbnailFileName);
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
		return adminDAO.setColCategoryInsert(vo);
	}

	// 컬렉션 카테고리 리스트 가져오기
	@Override
	public ArrayList<CollectionVO> getColCategoryList(int startIndexNo, int pageSize) {
		return adminDAO.getColCategoryList(startIndexNo, pageSize);
	}

	// 컬렉션 삭제
	@Override
	public void setColCategoryDelete(List<String> colCategoryList) {
		adminDAO.setColCategoryDelete(colCategoryList);
	}

	// 컬렉션 카테고리 공개/비공개 처리
	@Override
	public void setColCategoryOpenUpdate(int idx, String colOpen) {
		adminDAO.setColCategoryOpenUpdate(idx, colOpen);
	}

	// 컬렉션 카테고리 수정
	@Override
	public void setUpdateColCategory(CollectionVO vo) {
		adminDAO.setUpdateColCategory(vo);
	}

	// 컬렉션 카테고리 썸네일 수정
	@Override
	public int setColCategorythumbUpdate(MultipartFile thumbnailFile, CollectionVO vo) {
int res = 0;
		
		try { 
			String thumbnailFileName = thumbnailFile.getOriginalFilename(); 
			
			// 공백이 아닐 경우 변경 처리
			if(!thumbnailFileName.equals("")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String realPath = request.getSession().getServletContext().getRealPath("/resources/data/collection/");
				
				// 기존에 존재하는 파일은 삭제처리
				File thumbnailFileDelete = new File(realPath + vo.getColThumbnail());
				thumbnailFileDelete.delete();
				
				// 새로운 파일 업로드
				JavawebProvide jp = new JavawebProvide();
				jp.writeFile(thumbnailFile,thumbnailFileName,"collection");

				// 새로운 파일명 set
				vo.setColThumbnail(thumbnailFileName);
			}
			
  		adminDAO.setColCategorythumbUpdate(vo);
			res = 1;
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
		return res;
	}

	// 상품 등록 창, 컬렉션 리스트 가져오기
	@Override
	public ArrayList<CollectionVO> getColCategories() {
		return adminDAO.getColCategories();
	}

	// 상품 등록
	@Override
	public int setProdInsert(MultipartFile thumbnailFile, MultipartFile detailFile, ProductVO vo) {
		
  	try { 
  		String thumbnailFileName = thumbnailFile.getOriginalFilename(); 
  		String detailFileName = detailFile.getOriginalFilename(); 
  		
  		JavawebProvide jp = new JavawebProvide();
  		jp.writeFile(thumbnailFile,thumbnailFileName,"collection");
  		jp.writeFile(detailFile,detailFileName,"collection");
  		
  		vo.setProdThumbnail(thumbnailFileName);
  		vo.setProdDetail(detailFileName);
  		
  		// 상품 코드 제작
  		UUID uid = UUID.randomUUID();
  		String code = "BWP" + uid.toString().substring(0,5);
  		vo.setProdCode(code);
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
		return adminDAO.setProdInsert(vo);
	}

	// 상품 옵션 등록
	@Override
	public int setProdOpInsert(ArrayList<OptionVO> optionList, String prodCode) {
		return adminDAO.setProdOpInsert(optionList, prodCode);
	}

	// 상품 코드 가져오기
	@Override
	public String getProdCode(int colIdx, String prodName, int prodPrice) {
		return adminDAO.getProdCode(colIdx, prodName, prodPrice);
	}

	// 상품 리스트 가져오기
	@Override
	public ArrayList<ProductVO> getColProductList(int startIndexNo, int pageSize) {
		return adminDAO.getColProductList(startIndexNo, pageSize);
	}

	// 상품 공개/비공개 처리
	@Override
	public void setColProdOpenUpdate(int idx, String prodOpen) {
		adminDAO.setColProdOpenUpdate(idx, prodOpen);
	}

	// 상품 정보 창
	@Override
	public ProductVO getProductInfo(int idx) {
		return adminDAO.getProductInfo(idx);
	}

	// 해당 상품의 옵션들 정보
	@Override
	public ArrayList<OptionVO> getProdOption(int idx) {
		return adminDAO.getProdOption(idx);
	}


			

	 
	
}
