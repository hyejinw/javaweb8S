package com.spring.javaweb8S.dao;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.DefaultPhotoVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.ProverbVO;

public interface AdminDAO {

	// 책 등록 및 검색
	public BookVO getBookIsbn(@Param("isbn") String isbn);
	public void setBook(@Param("vo") BookVO vo);

	// 페이징 처리용
	public int proverbTotRecCnt();
	public int bookTotRecCnt();
	public int bookTotRecCntSearch(@Param("search") String search, @Param("searchString") String searchString2);
	public int magazineTotRecCnt();
	
	public ArrayList<DefaultPhotoVO> getDefaultPhoto();

	public int memberDefaultPhotoInsert(@Param("vo") DefaultPhotoVO vo);

	public ArrayList<ProverbVO> getProverb(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setProverb(@Param("vo") ProverbVO vo);

	public int memberDefaultPhotoDelete(@Param("defaultPhotoList") List<String> defaultPhotoList);

	public void setChangeMemberPhotos(@Param("defaultPhotoList") List<String> defaultPhotoList);

	public void setProverbDelete(@Param("proverbList") List<String> proverbList);

	public void setUpdateProverb(@Param("vo") ProverbVO vo);

	public ArrayList<BookVO> getBooks(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public ArrayList<BookVO> getDBBooks(@Param("searchString") String searchString, @Param("search") String search, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public void setBookDelete(@Param("bookList") List<String> bookList);

	public ArrayList<MagazineVO> getMagazineList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);




}
