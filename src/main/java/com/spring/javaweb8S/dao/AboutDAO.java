package com.spring.javaweb8S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface AboutDAO {

	public List<String> getNicknameListFromEmail(@Param("email") String email);

	public String[] getNicknameListWithEmail(@Param("email") String email);

	public void getBooksletterInsert(@Param("email") String email, @Param("memNickname") String memNickname);

	public String getBooksletterCheck(@Param("email") String email, @Param("memNickname") String memNickname);

}
