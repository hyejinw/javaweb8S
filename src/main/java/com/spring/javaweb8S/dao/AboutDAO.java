package com.spring.javaweb8S.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.NoticeVO;
import com.spring.javaweb8S.vo.ProductVO;

public interface AboutDAO {

	// 페이징 처리
	public int AskSearchTotRecCnt(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString);
	public int noticeListTotRecCnt(@Param("search") String search, @Param("searchString") String searchString);
	
	
	public List<String> getNicknameListFromEmail(@Param("email") String email);

	public String[] getNicknameListWithEmail(@Param("email") String email);

	public void getBooksletterInsert(@Param("email") String email, @Param("memNickname") String memNickname);

	public String getBooksletterCheck(@Param("email") String email, @Param("memNickname") String memNickname);

	public ProductVO getProductInfo(@Param("originIdx") String originIdx);

	public MagazineVO getMagazineInfo(@Param("originIdx") String originIdx);

	public String[] getMagazineTitle(@Param("maType") String maType);

	public String[] getProductName();

	public int setAskInsert(@Param("vo") AskVO vo);

	public ArrayList<AskVO> getAskSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString);

	public AskVO getAskDetail(@Param("idx") int idx);

	public String getAskProdName(@Param("originIdx") int originIdx, @Param("category") String category);

	public int setAskUpdate(@Param("vo") AskVO vo);
	
	public ArrayList<NoticeVO> getNoticeSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);
	
	public NoticeVO getNoticeInfo(@Param("idx") int idx);
	
	public void setNoticeViewUpdate(@Param("idx") int idx);



}
