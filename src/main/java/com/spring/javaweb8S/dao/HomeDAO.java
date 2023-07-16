package com.spring.javaweb8S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.MagazineVO;

public interface HomeDAO {

	public ArrayList<MagazineVO> getNewMagazines();

	public int getCartNum(@Param("nickname") String nickname);

}
