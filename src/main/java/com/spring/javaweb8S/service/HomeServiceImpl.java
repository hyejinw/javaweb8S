package com.spring.javaweb8S.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.HomeDAO;
import com.spring.javaweb8S.vo.MagazineVO;

@Service
public class HomeServiceImpl implements HomeService {
	
	@Autowired
	HomeDAO homeDAO;

	// 신규 매거진 리스트
	@Override
	public ArrayList<MagazineVO> getNewMagazines() {
		return homeDAO.getNewMagazines();
	}
	
}
