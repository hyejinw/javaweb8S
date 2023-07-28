package com.spring.javaweb8S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.NoticeVO;

public interface HomeDAO {

	public ArrayList<MagazineVO> getNewMagazines();

	public int getCartNum(@Param("nickname") String nickname);

	public ArrayList<NoticeVO> getImportantNotice();

	public ArrayList<NoticeVO> getExtraNotice(@Param("limitNum") int limitNum);

	public String getTotCnt(@Param("nickname") String nickname);

}
