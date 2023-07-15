package com.spring.javaweb8S.service;

import java.util.List;

public interface AboutService {

	public List<String> getNicknameListFromEmail(String email);

	public String[] getNicknameListWithEmail(String email);

	public void getBooksletterInsert(String email, String memNickname);

	public String getBooksletterCheck(String email, String memNickname);

}
