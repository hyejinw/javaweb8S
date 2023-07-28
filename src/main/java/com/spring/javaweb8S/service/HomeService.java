package com.spring.javaweb8S.service;

import java.util.ArrayList;

import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.NoticeVO;

public interface HomeService {

	public ArrayList<MagazineVO> getNewMagazines();

	public int getCartNum(String nickname);

	public ArrayList<NoticeVO> getImportantNotice();

	public ArrayList<NoticeVO> getExtraNotice(int limitNum);

	public String getTotCnt(String nickname);

}
