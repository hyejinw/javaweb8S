package com.spring.javaweb8S.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.OrderDAO;
import com.spring.javaweb8S.vo.MemberVO;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrderDAO orderDAO;

	@Override
	public MemberVO getMemberInfo(String memNickname) {
		return orderDAO.getMemberInfo(memNickname);
	}
}
