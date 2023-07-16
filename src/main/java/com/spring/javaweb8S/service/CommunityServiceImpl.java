package com.spring.javaweb8S.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.CommunityDAO;
import com.spring.javaweb8S.vo.MemberVO;

@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	CommunityDAO communityDAO;

	// 커뮤니티 메뉴에서 쓸 회원 정보 가져오기
	@Override
	public MemberVO getMemberInfo(String nickname) {
		return communityDAO.getMemberInfo(nickname);
	}
	
	
}
