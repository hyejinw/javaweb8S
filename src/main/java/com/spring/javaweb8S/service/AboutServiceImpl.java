package com.spring.javaweb8S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.AboutDAO;

@Service
public class AboutServiceImpl implements AboutService {
	
	@Autowired
	AboutDAO aboutDAO;

	// 소개 창, 뉴스레터를 위한 기존 등록 이메일 유무 확인 + 해당 별명들 가져오기
	@Override
	public List<String> getNicknameListFromEmail(String email) {
		return aboutDAO.getNicknameListFromEmail(email);
	}

	// 소개 창, 뉴스레터를 위한 기존 등록 이메일 유무 확인 + 해당 별명들 가져오기
	@Override
	public String[] getNicknameListWithEmail(String email) {
		return aboutDAO.getNicknameListWithEmail(email);
	}

	// 소개 창, 뉴스레터 등록
	@Override
	public void getBooksletterInsert(String email, String memNickname) {
		aboutDAO.getBooksletterInsert(email, memNickname);
	}

	// 뉴스레터 이미 구독 중인지 확인
	@Override
	public String getBooksletterCheck(String email, String memNickname) {
		return aboutDAO.getBooksletterCheck(email, memNickname);
	}
	
}
