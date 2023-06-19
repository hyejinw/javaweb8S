package com.spring.javaweb8S.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.BookVO;

public interface AdminDAO {

	public BookVO getBookList(@Param("isbn") String isbn);

	public void setBook(@Param("vo") BookVO vo);

	
}
