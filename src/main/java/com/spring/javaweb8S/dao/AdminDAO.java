package com.spring.javaweb8S.dao;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.CollectionVO;
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
	public int magazineTotRecCntWithPeriod(@Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate, @Param("endDate") String endDate);
	public int magazineTypeTotRecCnt(@Param("maType") String maType);
	public int colCategoryTotRecCnt();
	
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
	
	public void setMagazineOpenUpdate(@Param("idx") int idx, @Param("maOpen") String maOpen);
	
	public void setMagazineDelete(@Param("magazineList") List<String> magazineList);
	
	public ArrayList<MagazineVO> getMagazineTypeList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("maType") String maType);
	
	public int setMagazineInsert(@Param("vo") MagazineVO vo);
	
	public MagazineVO getMagazine(@Param("idx") int idx);

	public void setMagazineUpdate(@Param("vo") MagazineVO vo);
	
	public ArrayList<MagazineVO> getMagazineSearchList(@Param("searchString") String searchString, @Param("search") String search, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public List<MagazineVO> getMagazinePhotoName(@Param("magazineList") List<String> magazineList);

	public int setColCategoryInsert(@Param("vo") CollectionVO vo);
	
	public ArrayList<CollectionVO> getColCategoryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public void setColCategoryDelete(@Param("colCategoryList") List<String> colCategoryList);
	
	public void setColCategoryOpenUpdate(@Param("idx") int idx, @Param("colOpen") String colOpen);
	
	public void setUpdateColCategory(@Param("vo") CollectionVO vo);
	
	public void setColCategorythumbUpdate(@Param("vo") CollectionVO vo);
	





}
