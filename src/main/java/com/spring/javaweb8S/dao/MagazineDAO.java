package com.spring.javaweb8S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.SaveVO;

public interface MagazineDAO {

	// 페이징 처리용
	public int magazineListTotRecCnt(@Param("search") String search, @Param("maDate") String maDate);

	public ArrayList<MagazineVO> getMagazineList(@Param("search") String search, @Param("maDate") String maDate, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public ArrayList<String> getMaDate();

	public MagazineVO getMagazineProduct(@Param("idx") int idx);

	public SaveVO getMagazineSave(@Param("nickname") String nickname, @Param("idx") int idx);

	public void setMagazineSave(@Param("vo") SaveVO vo);

	public void setMagazineSaveDelete(@Param("memNickname") String memNickname, @Param("maIdx") int maIdx);

	public CartVO getMagazineCartSearch(@Param("nickname") String nickname, @Param("idx") int idx);

	public void setMagazineCartUpdate(@Param("vo") CartVO vo);

	public void setMagazineCartInsert(@Param("vo") CartVO vo);


}
