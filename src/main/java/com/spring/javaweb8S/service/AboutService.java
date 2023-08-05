package com.spring.javaweb8S.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.NoticeVO;
import com.spring.javaweb8S.vo.ProductVO;

public interface AboutService {

	public List<String> getNicknameListFromEmail(String email);

	public String[] getNicknameListWithEmail(String email);

	public void getBooksletterInsert(String email, String memNickname);

	public String getBooksletterCheck(String email, String memNickname);

	public ProductVO getProductInfo(String originIdx);

	public MagazineVO getMagazineInfo(String originIdx);

	public String[] getMagazineTitle(String maType);

	public String[] getProductName();

	public int setAskInsert(AskVO vo);

	public ArrayList<AskVO> getAskSearch(int startIndexNo, int pageSize, String sort, String search, String searchString);

	public AskVO getAskDetail(int idx);

	public String getAskProdName(int originIdx, String category);

	public int setAskUpdate(AskVO vo);

	public ArrayList<NoticeVO> getNoticeSearch(int startIndexNo, int pageSize, String search, String searchString);

	public NoticeVO getNoticeInfo(int idx);

	public void setNoticeViewUpdate(int idx);

}
