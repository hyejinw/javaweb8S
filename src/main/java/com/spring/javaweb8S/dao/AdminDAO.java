package com.spring.javaweb8S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.DefaultPhotoVO;

public interface AdminDAO {

	public BookVO getBookList(@Param("isbn") String isbn);

	public void setBook(@Param("vo") BookVO vo);

	public ArrayList<DefaultPhotoVO> getDefaultPhoto();

	public int memberDefaultPhotoInsert(@Param("vo") DefaultPhotoVO vo);


}
