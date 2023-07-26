package com.spring.javaweb8S.service;

import java.util.ArrayList;

import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.SaveVO;

public interface MagazineService {

	public ArrayList<MagazineVO> getMagazineList(String search, String maDate, int startIndexNo, int pageSize);

	public ArrayList<String> getMaDate();

	public MagazineVO getMagazineProduct(int idx);

	public SaveVO getMagazineSave(String nickname, int idx);

	public void setMagazineSave(SaveVO vo);

	public void setMagazineSaveDelete(String memNickname, int maIdx);

	public CartVO getMagazineCartSearch(String memNickname, int maIdx);

	public void setMagazineCartUpdate(CartVO vo);

	public void setMagazineCartInsert(CartVO vo);

	public void setMaSaveNumUpdate(int maIdx, int maSaveNum);

	public ArrayList<AskVO> getMagazineAsk(int idx, String category);

}
